#!/usr/bin/env node
import { createHash } from 'node:crypto';
import { copyFileSync, existsSync, readFileSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { DatabaseSync } from 'node:sqlite';

const backupRoot = resolve(process.argv[2] || '');
const destination = resolve(process.argv[3] || '');
const sourceDatabase = resolve(backupRoot, 'database', 'production-data.sqlite');
if (!process.argv[2] || !process.argv[3] || !existsSync(sourceDatabase)) {
  console.error('Usage: node scripts/restore-portable-backup.mjs <backup-directory> <destination.sqlite>');
  process.exit(1);
}
if (existsSync(destination)) {
  console.error(`Refusing to overwrite existing database: ${destination}`);
  process.exit(1);
}

const projectRoot = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const assets = JSON.parse(readFileSync(resolve(backupRoot, 'assets', 'manifest.json'), 'utf8'));
copyFileSync(sourceDatabase, destination);
const db = new DatabaseSync(destination);
const tables = db.prepare("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'").all().map((row) => row.name);
const quote = (value) => `"${String(value).replaceAll('"', '""')}"`;
const fileTables = tables.filter((table) => db.prepare(`PRAGMA table_info(${quote(table)})`).all().some((column) => column.name === 'file_data'));
const updateStatements = new Map(fileTables.map((table) => [table, db.prepare(`UPDATE ${quote(table)} SET object_key=?,file_data=? WHERE id=?`)]));

db.exec('BEGIN IMMEDIATE');
try {
  for (const asset of assets) {
    const assetPath = resolve(projectRoot, asset.repositoryPath);
    if (!existsSync(assetPath)) throw new Error(`Missing asset: ${asset.repositoryPath}`);
    const bytes = readFileSync(assetPath);
    const sha256 = createHash('sha256').update(bytes).digest('hex');
    if (sha256 !== asset.sha256) throw new Error(`Checksum mismatch: ${asset.repositoryPath}`);
    if (String(asset.objectKey).startsWith('static:')) continue;
    for (const table of asset.sourceTables) {
      const statement = updateStatements.get(table);
      if (statement) statement.run(`d1:${asset.id}`, bytes, asset.id);
    }
  }
  db.exec('COMMIT');
} catch (error) {
  db.exec('ROLLBACK');
  throw error;
}
const integrity = db.prepare('PRAGMA integrity_check').get().integrity_check;
const primaryCount = db.prepare('SELECT COUNT(*) AS count FROM art_submission_files').get().count;
const primaryBlobCount = db.prepare('SELECT COUNT(*) AS count FROM art_submission_files WHERE file_data IS NOT NULL OR object_key LIKE \'static:%\'').get().count;
db.close();
if (integrity !== 'ok' || primaryCount !== primaryBlobCount) throw new Error(`Restore verification failed: integrity=${integrity}, files=${primaryBlobCount}/${primaryCount}`);
console.log(JSON.stringify({ destination, integrity, restoredAssets: assets.length, primaryFiles: primaryCount }, null, 2));
