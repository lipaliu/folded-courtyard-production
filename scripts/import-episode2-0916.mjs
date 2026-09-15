// Prepare a reviewed, idempotent production import. Does not contact the database.
import { readFileSync, writeFileSync, mkdirSync, copyFileSync } from 'node:fs';
import { execFileSync } from 'node:child_process';
import vm from 'node:vm';
import ts from 'typescript';
import assert from 'node:assert/strict';

const sourcePath = process.argv[2];
if (!sourcePath) throw new Error('Provide the verified episode 2 DOCX path');
const text = execFileSync('textutil', ['-convert', 'txt', '-stdout', sourcePath], { encoding: 'utf8' });
const exports = {};
vm.runInNewContext(ts.transpileModule(readFileSync('lib/script-import.ts', 'utf8'), { compilerOptions: { module: ts.ModuleKind.CommonJS, target: ts.ScriptTarget.ES2022 } }).outputText, { exports });
const scenes = exports.parseScriptDocument(text, '《折叠庭院的她》第二集(2)(1).docx');
assert.equal(scenes.length, 8);
assert.ok(scenes.every(s => s.episode === '第2集'));
const summaries = [
  '顾丽乔在家敷面膜、对镜尝试复刻异能，被郑允书偷拍；两人坐在地毯上讨论，她担忧地摸着白发。',
  '救人视频带来粉丝、同款销量和合作邀约，两人憧憬收入、演戏机会和不再漏水的住处。另附社交账号、购物与私信页面蒙太奇参考。',
  '顾丽乔穿民国旗袍进入片场，群头让座、化妆师补妆，群演围上来求签名与合影。',
  '顾丽乔特地化妆、穿高跟鞋接受采访。记者不断追问救人和事故传闻，她在摄像机红灯下陷入沉默。',
  '顾丽乔逃出采访棚，崴脚断了鞋跟；宾利停在面前，车窗落下，陆文川露面。',
  '车内陆文川用钱和角色询问监控缺失的一分钟，顾丽乔拒绝并离开；陆文川向助理交代融资压力与公关安排。',
  '顾丽乔参加商K聚会寻求机会，却被当作流量和关系利用，忍下羞辱饮酒后又被拉去合影。',
  '顾丽乔醉酒回家，在卫生间呕吐落泪。郑允书担忧陪伴，她望着窗外高楼广告，决意向上爬。',
];
const wardrobes = ['居家穿搭；面膜、白发的造型参考放在人物项。', '居家完整穿搭；是否沿用前场由Lipa确认。', '剧本明确为民国旗袍；上传整套穿搭与细节。', '采访完整穿搭，剧本明确穿高跟鞋。', '延续采访后的穿搭，重点追加断裂鞋跟状态。', '接续采访棚外穿搭，鞋跟已断；不要混入病房服装。', '商K聚会完整穿搭；原文未指定具体颜色和款式，供Lipa选定。', '醉酒回家时的完整穿搭；与前场连续性由Lipa确认。'];
scenes.forEach((scene, index) => {
  scene.sceneSummary = summaries[index];
  scene.items.find(i => i.name === '顾丽乔｜服装').detail = wardrobes[index];
  const hero = scene.items.find(i => i.name === '陆文川｜服装');
  if (hero) hero.detail = index === 5 ? '陆文川车内完整穿搭；剧本明确红底皮鞋一尘不染。' : '陆文川在宾利后座露面时的穿搭，与下一场车内保持连续性。';
  const montage = scene.items.find(i => i.name.startsWith('蒙太奇｜'));
  if (montage) Object.assign(montage, { name: '蒙太奇｜社交账号、购物与邀约私信', detail: 'A：顾丽乔穿裙子的日常照片获赞激增；B：同款裙子购物页面售罄；C：综艺、品牌、直播及MCN邀约私信。', visualBrief: '本场主场景和人物之后，集中上传这组三类屏幕画面参考，可多传图，不另编造实体场景。' });
});
const count = scenes.reduce((sum, scene) => sum + scene.items.length, 0);
const now = new Date().toISOString();
const versionId = 'script-version-ep2-20260916-bingbing';
const q = v => `'${String(v).replaceAll("'", "''")}'`;
const insert = (table, values) => `INSERT OR IGNORE INTO ${table} (${Object.keys(values).join(',')}) VALUES (${Object.values(values).map(q).join(',')});`;
const sql = [
  "CREATE TABLE IF NOT EXISTS production_0916_before_ep2 AS SELECT * FROM production_items WHERE work_date='2026-09-16';",
  insert('script_versions', { id: versionId, episode: '第2集', version_no: 1, file_name: '《折叠庭院的她》第二集(2)(1).docx', source_text: text, change_summary: 'Lipa指示直接录入并拆分，作为9月16日开始出图的当前依据；编剧丙丙继续修改一、二集。', work_date: '2026-09-16', submitted_by: '编剧丙丙', scene_count: scenes.length, item_count: count, created_at: now, is_final: 1, finalized_at: now, finalized_by: 'Lipa' }),
];
for (const scene of scenes) {
  const id = `final-${versionId}-${scene.sceneNo}`;
  sql.push(insert('script_analyses', { id, episode: scene.episode, scene_no: scene.sceneNo, scene_title: scene.sceneTitle, script_text: scene.scriptText, scene_summary: scene.sceneSummary, location: scene.location, created_at: now, updated_at: now, script_version_id: versionId, is_active: 1 }));
  scene.items.forEach((item, index) => {
    const itemId = `${id}-auto-${index + 1}`;
    sql.push(insert('script_analysis_items', { id: itemId, analysis_id: id, category: item.category, name: item.name, detail: item.detail, visual_brief: item.visualBrief, yoyo_approved: 0, producer_approved: 0, sort_order: index, updated_at: now, is_active: 1 }));
    sql.push(insert('art_submission_details', { item_id: itemId, assigned_to: item.category === '人物' ? '主美' : '主美、服化道副导演', due_at: '', handoff_to: 'Lipa', done_definition: item.visualBrief, status: '待上传', submission_note: '', review_note: '', submitted_at: '', reviewed_at: '', updated_at: now }));
  });
  sql.push(insert('daily_scene_assignments', { id: `assignment-0916-${id}`, work_date: '2026-09-16', analysis_id: id, script_version_id: versionId, assigned_by: 'Lipa', created_at: now }));
}
sql.push(`UPDATE production_items SET episode='第1集 / 第2集', title='编剧丙丙修改第一、第二集剧本', note='9月16日：丙丙修改第一、第二集剧本。第二集本次原稿已录入，作为当前出图依据；后续修改稿交Lipa确认。', updated_at=${q(now)} WHERE id='2026-09-12-script' AND work_date='2026-09-16';`);
sql.push(`UPDATE production_items SET episode='第2集', category='美术清单', title='开始上传第2集人物造型、场景与服装参考图', planned_qty=${count}, note='9月16日：主美按第二集已拆好的8场开始上传。可多人、多图上传，Lipa负责选择定稿。', updated_at=${q(now)} WHERE id='2026-09-12-prep' AND work_date='2026-09-16';`);
sql.push(insert('production_items', { id: '2026-09-16-ep2-wardrobe', work_date: '2026-09-16', episode: '第2集', category: '美术清单', title: '开始上传第2集场景与角色服装参考图', owner: '服化道副导演', reviewer: '叶总／Yoyo', status: '未开始', planned_qty: scenes.reduce((sum,s) => sum+s.items.filter(i => ['场景','服装'].includes(i.category)).length,0), completed_qty: 0, due_time: '', note: '9月16日：服化道副导演按第二集8场上传场景与角色服装，支持多人协作，上传后由Lipa选定稿。', sort_order: 3, updated_at: now }));
sql.push(insert('activity_log', { item_type: 'script_version', item_id: versionId, action: '按Lipa指示录入编剧丙丙第二集，8场上传位开放，并更新9月16日日程。', operator: 'Lipa', created_at: now }));
mkdirSync('output/episode2-0916', { recursive: true });
copyFileSync(sourcePath, 'output/episode2-0916/第二集_录入原稿.docx');
writeFileSync('output/episode2-0916/import.sql', sql.join('\n'));
writeFileSync('output/episode2-0916/breakdown.json', JSON.stringify(scenes, null, 2));
console.log(JSON.stringify({ scenes: scenes.map(s => ({ no: s.sceneNo, title: s.sceneTitle, items: s.items.length })), itemCount: count, sql: 'output/episode2-0916/import.sql' }, null, 2));
