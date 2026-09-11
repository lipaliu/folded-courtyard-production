#!/usr/bin/env node
import fs from 'node:fs/promises';
import path from 'node:path';
import mammoth from 'mammoth';

const [baseManifestPath, outlinePath, episodeGuidePath, outputPath] = process.argv.slice(2);
if (!baseManifestPath || !outlinePath || !episodeGuidePath || !outputPath) {
  console.error('Usage: build-pitch-manifest.mjs <base.json> <outline.docx> <episodes.docx> <output.json>');
  process.exit(2);
}

const readDocxParagraphs = async (filePath) => {
  const result = await mammoth.extractRawText({ path: path.resolve(filePath) });
  return result.value.replaceAll('\r', '').split('\n').map((line) => line.trim()).filter(Boolean);
};

const chineseNumber = (value) => {
  const digits = { 一: 1, 二: 2, 三: 3, 四: 4, 五: 5, 六: 6, 七: 7, 八: 8, 九: 9 };
  if (/^\d+$/.test(value)) return Number(value);
  if (value === '十') return 10;
  if (value.includes('十')) {
    const [left, right] = value.split('十');
    return (left ? digits[left] : 1) * 10 + (right ? digits[right] || 0 : 0);
  }
  return digits[value] || 0;
};

const base = JSON.parse(await fs.readFile(path.resolve(baseManifestPath), 'utf8'));
const outline = (await readDocxParagraphs(outlinePath)).filter((line) => !line.endsWith('故事大纲'));
const guideLines = (await readDocxParagraphs(episodeGuidePath)).filter((line) => !line.endsWith('《折叠庭院的她》分集'));
const episodeGuide = [];
for (const line of guideLines) {
  const heading = line.match(/^第([一二三四五六七八九十百\d]+)集[：:]?$/);
  if (heading) {
    const episode = chineseNumber(heading[1]);
    episodeGuide.push({ episode, title: `第${heading[1]}集`, paragraphs: [] });
  } else if (episodeGuide.length) {
    episodeGuide.at(-1).paragraphs.push(line);
  }
}

base.project.updatedAt = new Date().toISOString().slice(0, 10);
base.project.status = '在线提报 · 团队协作';
base.chapters = { storyOutline: outline, episodeGuide };
const sourceRows = [
  { fileName: path.basename(outlinePath), kind: '故事大纲', version: 'v1', intakeDate: base.project.updatedAt, note: 'Chapter 01完整展示' },
  { fileName: path.basename(episodeGuidePath), kind: '分集', version: 'v1', intakeDate: base.project.updatedAt, note: 'Chapter 02完整展示' },
];
for (const row of sourceRows) {
  const index = base.sources.findIndex((item) => item.fileName === row.fileName);
  if (index >= 0) base.sources[index] = { ...base.sources[index], ...row };
  else base.sources.unshift(row);
}

await fs.writeFile(path.resolve(outputPath), `${JSON.stringify(base, null, 2)}\n`, 'utf8');
console.log(`Built ${path.resolve(outputPath)} with ${outline.length} outline paragraphs and ${episodeGuide.length} episode chapters`);
