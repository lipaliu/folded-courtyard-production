#!/usr/bin/env node
import { createHash } from 'node:crypto';
import { copyFileSync, existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import { dirname, extname, join, relative, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { spawnSync } from 'node:child_process';
import { DatabaseSync } from 'node:sqlite';

const sourcePath = resolve(process.argv[2] || '');
const outputRoot = resolve(process.argv[3] || '');
if (!process.argv[2] || !process.argv[3] || !existsSync(sourcePath)) {
  console.error('Usage: node scripts/export-portable-backup.mjs <full.sqlite> <output-directory>');
  process.exit(1);
}
if (existsSync(outputRoot)) {
  console.error(`Refusing to overwrite existing backup directory: ${outputRoot}`);
  process.exit(1);
}

const projectRoot = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const databaseDir = join(outputRoot, 'database');
const uploadDir = join(outputRoot, 'assets', 'uploads');
const scriptDir = join(outputRoot, 'script-versions');
const planDir = join(outputRoot, 'plan');
mkdirSync(databaseDir, { recursive: true });
mkdirSync(uploadDir, { recursive: true });
mkdirSync(scriptDir, { recursive: true });
mkdirSync(planDir, { recursive: true });

const portableDbPath = join(databaseDir, 'production-data.sqlite');
copyFileSync(sourcePath, portableDbPath);
const db = new DatabaseSync(portableDbPath);
const tableNames = db.prepare("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name NOT IN ('_cf_KV') ORDER BY name").all().map((row) => row.name);
const quote = (value) => `"${String(value).replaceAll('"', '""')}"`;
const fileTables = tableNames.filter((table) => db.prepare(`PRAGMA table_info(${quote(table)})`).all().some((column) => column.name === 'file_data'));
const preferredFileTables = ['art_submission_files', ...fileTables.filter((table) => table !== 'art_submission_files')];
const assets = new Map();

for (const table of preferredFileTables) {
  const columns = new Set(db.prepare(`PRAGMA table_info(${quote(table)})`).all().map((column) => column.name));
  if (!['id', 'item_id', 'object_key', 'file_name', 'content_type', 'byte_size', 'uploaded_by', 'file_data'].every((name) => columns.has(name))) continue;
  const rows = db.prepare(`SELECT id,item_id,object_key,file_name,content_type,byte_size,uploaded_by,sort_order,created_at,file_data FROM ${quote(table)}`).all();
  for (const row of rows) {
    const existing = assets.get(row.id);
    const bytes = row.file_data ? Buffer.from(row.file_data) : null;
    if (!existing) {
      assets.set(row.id, { ...row, bytes, sourceTables: [table] });
    } else {
      existing.sourceTables.push(table);
      if (!existing.bytes && bytes) existing.bytes = bytes;
    }
  }
}

const mimeExtensions = { 'image/jpeg': '.jpg', 'image/png': '.png', 'image/webp': '.webp' };
const assetManifest = [];
for (const asset of assets.values()) {
  let repositoryPath = '';
  let bytes = asset.bytes;
  if (String(asset.object_key).startsWith('static:')) {
    repositoryPath = String(asset.object_key).slice('static:'.length).replace(/^\/+/, '');
    repositoryPath = `public/${repositoryPath}`.replace('public/reference-assets', 'public/reference-assets');
    const staticPath = resolve(projectRoot, repositoryPath);
    if (!existsSync(staticPath)) throw new Error(`Static asset missing: ${repositoryPath}`);
    bytes = readFileSync(staticPath);
  } else {
    if (!bytes) throw new Error(`Image bytes missing for ${asset.id} (${asset.object_key})`);
    const extension = mimeExtensions[asset.content_type] || extname(asset.file_name) || '.bin';
    const storedName = `${String(asset.id).replace(/[^\p{L}\p{N}._-]+/gu, '-')}${extension.toLowerCase()}`;
    repositoryPath = relative(projectRoot, join(uploadDir, storedName));
    writeFileSync(join(uploadDir, storedName), bytes);
  }
  assetManifest.push({
    id: asset.id,
    itemId: asset.item_id,
    objectKey: asset.object_key,
    originalFileName: asset.file_name,
    contentType: asset.content_type,
    expectedBytes: asset.byte_size,
    actualBytes: bytes.length,
    uploadedBy: asset.uploaded_by,
    sortOrder: asset.sort_order,
    createdAt: asset.created_at,
    repositoryPath,
    sha256: createHash('sha256').update(bytes).digest('hex'),
    sourceTables: [...new Set(asset.sourceTables)],
  });
}
assetManifest.sort((a, b) => String(a.id).localeCompare(String(b.id)));
writeFileSync(join(outputRoot, 'assets', 'manifest.json'), `${JSON.stringify(assetManifest, null, 2)}\n`);

const scriptVersions = db.prepare(`SELECT id,episode,version_no AS versionNo,file_name AS fileName,source_text AS sourceText,
  change_summary AS changeSummary,work_date AS workDate,submitted_by AS submittedBy,scene_count AS sceneCount,
  item_count AS itemCount,is_final AS isFinal,finalized_at AS finalizedAt,finalized_by AS finalizedBy,created_at AS createdAt
  FROM script_versions ORDER BY episode,version_no,created_at`).all();
const safeName = (value) => String(value).normalize('NFKC').replace(/[^\p{L}\p{N}._-]+/gu, '-').replace(/^-+|-+$/g, '') || 'script';
const scriptIndex = scriptVersions.map((version) => {
  const textFile = `${safeName(version.episode)}-v${version.versionNo}-${safeName(version.id)}.txt`;
  writeFileSync(join(scriptDir, textFile), `${version.sourceText.trim()}\n`);
  const { sourceText, ...metadata } = version;
  return { ...metadata, textFile, sha256: createHash('sha256').update(sourceText).digest('hex') };
});
writeFileSync(join(scriptDir, 'index.json'), `${JSON.stringify(scriptIndex, null, 2)}\n`);

const exportRows = (table) => tableNames.includes(table) ? db.prepare(`SELECT * FROM ${quote(table)}`).all() : [];
writeFileSync(join(planDir, 'production-plan.json'), `${JSON.stringify({
  planBatches: exportRows('plan_batches'),
  productionItems: exportRows('production_items'),
  dailySceneAssignments: exportRows('daily_scene_assignments'),
  dailyReports: exportRows('daily_reports'),
  scenes: exportRows('scenes'),
}, null, 2)}\n`);

const sourceCounts = Object.fromEntries(tableNames.map((table) => [table, db.prepare(`SELECT COUNT(*) AS count FROM ${quote(table)}`).get().count]));
const excludedAuthentication = {
  memberAccounts: sourceCounts.member_accounts || 0,
  memberSessions: sourceCounts.member_sessions || 0,
  reason: 'The GitHub repository is public; password hashes, salts and live sessions are intentionally excluded.',
};

db.exec('PRAGMA foreign_keys=OFF');
if (tableNames.includes('member_sessions')) db.exec('DELETE FROM member_sessions');
if (tableNames.includes('member_accounts')) db.exec('DELETE FROM member_accounts');
for (const table of fileTables) db.exec(`UPDATE ${quote(table)} SET file_data=NULL`);
db.exec('VACUUM');
const integrity = db.prepare('PRAGMA integrity_check').get().integrity_check;
db.close();
if (integrity !== 'ok') throw new Error(`Portable database integrity check failed: ${integrity}`);

const dump = spawnSync('sqlite3', [portableDbPath, '.dump'], { maxBuffer: 32 * 1024 * 1024 });
if (dump.status !== 0) throw new Error(dump.stderr.toString() || 'sqlite3 dump failed');
writeFileSync(join(databaseDir, 'production-data.sql'), dump.stdout);

const backupManifest = {
  formatVersion: 1,
  project: '折叠庭院的她',
  exportedAt: new Date().toISOString(),
  source: { provider: 'Cloudflare D1', database: 'folded-courtyard-production-db' },
  counts: {
    tables: tableNames.length,
    scriptVersions: scriptVersions.length,
    artFiles: assetManifest.length,
    uploadedFiles: assetManifest.filter((asset) => !String(asset.objectKey).startsWith('static:')).length,
    staticFiles: assetManifest.filter((asset) => String(asset.objectKey).startsWith('static:')).length,
    productionItems: sourceCounts.production_items || 0,
    dailyReports: sourceCounts.daily_reports || 0,
  },
  excludedAuthentication,
  sourceTableCounts: sourceCounts,
  files: {
    database: 'database/production-data.sqlite',
    sql: 'database/production-data.sql',
    assets: 'assets/manifest.json',
    scriptVersions: 'script-versions/index.json',
    plan: 'plan/production-plan.json',
  },
};
writeFileSync(join(outputRoot, 'manifest.json'), `${JSON.stringify(backupManifest, null, 2)}\n`);
writeFileSync(join(outputRoot, 'README.md'), `# 折叠庭院的她｜可迁移制作数据备份\n\n` +
  `本备份包含 ${scriptVersions.length} 个剧本版本、${assetManifest.length} 张图片、全部美术拆解/定稿/审核记录、大计划、每日任务和历史归档表。\n\n` +
  `- \`database/production-data.sqlite\`：不含图片二进制的完整业务数据库。\n` +
  `- \`database/production-data.sql\`：同一数据库的通用 SQL 导出。\n` +
  `- \`assets/uploads\`：后台上传的图片原文件。\n` +
  `- \`assets/manifest.json\`：每张图的工作项、上传人、原文件名、哈希和存储路径。\n` +
  `- \`script-versions\`：各版本剧本文本和版本/定稿信息。\n` +
  `- \`plan/production-plan.json\`：大计划、每日任务、小结与场次安排。\n\n` +
  `## 恢复\n\n` +
  `在仓库根目录运行：\n\n` +
  `\`\`\`bash\nnode scripts/restore-portable-backup.mjs ${relative(projectRoot, outputRoot)} /tmp/folded-courtyard-restored.sqlite\n\`\`\`\n\n` +
  `恢复脚本会验证全部图片 SHA-256 后，将上传图重新写入 SQLite BLOB；静态参考图继续读取仓库的 \`public/reference-assets\`。\n\n` +
  `## 安全说明\n\n` +
  `GitHub 仓库是公开的，因此本备份不含密码哈希、密码盐和登录会话。成员姓名与岗位仍由业务表保存；迁移后账号需重新注册或由管理员在私密环境单独迁移。\n`);

console.log(JSON.stringify({ outputRoot, ...backupManifest.counts, integrity }, null, 2));
