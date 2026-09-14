import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import vm from 'node:vm';
import { test } from 'node:test';
import { DatabaseSync } from 'node:sqlite';
import ts from 'typescript';

function load(path, dependencies = {}) {
  const exports = {};
  const code = ts.transpileModule(readFileSync(new URL(path, import.meta.url), 'utf8'), { compilerOptions: { module: ts.ModuleKind.CommonJS, target: ts.ScriptTarget.ES2022 } }).outputText;
  vm.runInNewContext(code, { exports, require: (name) => dependencies[name], Request, Response });
  return exports;
}
const structure = load('../lib/art-structure.ts');
const script = load('../lib/script-import.ts');
const asset = (id, scene, name, category = '人物') => ({ id, analysisId: scene, name, category, detail: '助理向陆文川汇报顾丽乔身份', visualBrief: '', sortOrder: 1 });
test('reuse uses role name, not another character mentioned in the plot', () => {
  const scenes = [{ id: 's1', episode: '第1集', sceneNo: 1 }, { id: 's2', episode: '第1集', sceneNo: 2 }];
  const items = [asset('heroine', 's1', '顾丽乔｜人物造型'), asset('assistant', 's1', '助理｜人物造型'), asset('later', 's2', '助理病房状态')];
  const files = new Map([['heroine', [{ id: 'wrong' }]], ['assistant', [{ id: 'correct' }]]]);
  const reuse = structure.buildReuseMap(scenes, items, files);
  assert.equal(reuse.get('later').files[0].id, 'correct');
  assert.equal(structure.buildReuseMap(scenes, items, files, [{ itemId: 'later', fileId: 'correct' }]).has('later'), false);
  assert.equal(files.get('assistant').length, 1);
});
test('scene, heroine styling and clothes, hero styling and clothes, ensemble order', () => {
  const items = [asset('hc', 's1', '陆文川｜服装', '服装'), asset('extra', 's1', '配角与群演｜整体参考', '服装'), asset('f', 's1', '顾丽乔｜人脸、妆造、梳发'), asset('scene', 's1', '医院', '场景'), asset('fc', 's1', '顾丽乔｜服装', '服装'), asset('h', 's1', '陆文川｜人脸、妆造、梳发')];
  assert.deepEqual(items.sort(structure.compareArtItems).map((item) => item.id), ['scene', 'f', 'fc', 'h', 'hc', 'extra']);
});
test('script creates a single scene slot, two slots per lead and one ensemble slot, no keyword props', () => {
  const items = script.buildArtItems('医院 内 夜', ['顾丽乔', '陆文川', '助理', '护士', '群演'], ['她拿起手机、酒瓶，门窗和灯架都在病床边。']);
  assert.equal(items.length, 6);
  assert.equal(items.filter((item) => item.category === '场景').length, 1);
  assert.equal(items.filter((item) => item.category === '道具').length, 0);
  assert.equal(items.filter((item) => item.name.includes('整体参考')).length, 1);
});
test('script accepts common writer scene-heading formats', () => {
  const scenes = script.parseScriptDocument(`第2集\n第1场：酒店标间 深夜 内\n人物：顾丽乔、群演\n顾丽乔推门。\n\n2\n医院走廊 日 外\n人物：陆文川\n陆文川赶来。\n\n场次3 监控室 夜 内\n人物：助理\n助理查看监控。`, '第二集.docx');
  assert.equal(scenes.length, 3);
  assert.equal(scenes.map((scene) => scene.location).join('|'), '酒店标间 深夜 内|医院走廊 日 外|监控室 夜 内');
  assert.equal(scenes[0].episode, '第2集');
  assert.ok(scenes[0].items.some((item) => item.name === '顾丽乔｜服装'));
  assert.ok(scenes[1].items.some((item) => item.name === '陆文川｜服装'));
});
test('script accepts unnumbered scene headings followed by main characters', () => {
  const scenes = script.parseScriptDocument(`《折叠庭院的她》\n第二集：我要他们不得不看我\n\n顾丽乔家 夜 内\n主要角色：顾丽乔、郑允书\n顾丽乔对着镜子尝试复刻异能。\n\n南庭影视城·民国街道片场 日 外\n主要角色：顾丽乔、群头、化妆师\n顾丽乔穿着旗袍走进片场。`, '《折叠庭院的她》第二集.docx');
  assert.equal(scenes.length, 2);
  assert.equal(scenes.map((scene) => scene.sceneNo).join(','), '1,2');
  assert.equal(scenes.map((scene) => scene.location).join('|'), '顾丽乔家 夜 内|南庭影视城·民国街道片场 日 外');
  assert.equal(scenes[0].episode, '第2集');
  assert.ok(scenes[0].items.some((item) => item.name === '顾丽乔｜服装'));
  assert.ok(scenes[0].items.some((item) => item.name === '配角与群演｜整体参考'));
});
test('script never blocks intake only because the writer omitted scene formatting', () => {
  const scenes = script.parseScriptDocument(`第二集\n顾丽乔回到家。\n她发现所有人只关注她的流量。`, '第二集无场头版.docx');
  assert.equal(scenes.length, 1);
  assert.equal(scenes[0].sceneNo, 1);
  assert.equal(scenes[0].location, '未标场次（系统自动补为第1场）');
  assert.ok(scenes[0].scriptText.includes('顾丽乔回到家'));
});
test('removing a reused image persists an exclusion and never deletes the source', async () => {
  const statements = [];
  const roles = load('../lib/team-roles.ts');
  const api = load('../app/api/art-submissions/route.ts', {
    'cloudflare:workers': { env: { DB: {
      prepare(sql) { return { bind(...args) { this.args = args; return this; }, async first() { return sql.includes('SELECT f.id') ? { id: 'image', itemId: 'source', category: '人物', objectKey: 'd1:image' } : { category: '人物' }; }, sql }; },
      async batch(rows) { statements.push(...rows); },
    } } },
    '@/lib/auth': { requireMember: async () => ({ name: 'Lipa', role: '执行制片人', isAdmin: true }) },
    '@/lib/team-roles': roles,
  });
  const response = await api.DELETE(new Request('https://test/api/art-submissions', { method: 'DELETE', body: JSON.stringify({ fileId: 'image', itemId: 'target' }) }));
  assert.equal(response.status, 200);
  assert.ok(statements.some((row) => row.sql.includes('art_reference_exclusions')));
  assert.equal(statements.some((row) => row.sql.includes('DELETE FROM art_submission_files')), false);
});
test('regrouping archives definitions but preserves all images and attribution', () => {
  const db = new DatabaseSync(':memory:');
  db.exec(`
    CREATE TABLE script_analyses(id TEXT PRIMARY KEY, episode TEXT, is_active INTEGER);
    CREATE TABLE script_analysis_items(id TEXT PRIMARY KEY,analysis_id TEXT,category TEXT,name TEXT,detail TEXT,visual_brief TEXT,yoyo_approved INTEGER,producer_approved INTEGER,sort_order INTEGER,updated_at TEXT,is_active INTEGER);
    CREATE TABLE art_submission_details(item_id TEXT PRIMARY KEY,assigned_to TEXT,due_at TEXT,handoff_to TEXT,done_definition TEXT,status TEXT,submission_note TEXT,review_note TEXT,selected_file_id TEXT,submitted_at TEXT,reviewed_at TEXT,updated_at TEXT);
    CREATE TABLE art_submission_files(id TEXT PRIMARY KEY,item_id TEXT,uploaded_by TEXT,file_name TEXT);
    CREATE TABLE production_items(episode TEXT,category TEXT,planned_qty INTEGER);
    INSERT INTO script_analyses VALUES('s1','第1集',1);
    INSERT INTO script_analysis_items VALUES('lead','s1','人物','顾丽乔｜人物造型','','',0,0,1,'',1),('extra','s1','人物','助理｜人物造型','','',0,0,2,'',1),('wardrobe','s1','服装','本场服装1','','',0,0,3,'',1),('prop','s1','道具','手机','','',0,0,4,'',1);
    INSERT INTO art_submission_files VALUES('one','extra','小王','1.jpg'),('two','wardrobe','小李','2.jpg');
  `);
  db.exec(readFileSync(new URL('../drizzle/0014_simplify_art_structure.sql', import.meta.url), 'utf8'));
  assert.equal(db.prepare('SELECT COUNT(*) AS n FROM art_submission_files').get().n, 2);
  assert.equal(db.prepare("SELECT uploaded_by FROM art_submission_files WHERE id='one'").get().uploaded_by, '小王');
  assert.equal(db.prepare("SELECT item_id FROM art_submission_files WHERE id='one'").get().item_id, 's1-overall-cast');
  assert.equal(db.prepare("SELECT is_active FROM script_analysis_items WHERE id='prop'").get().is_active, 0);
  assert.equal(db.prepare("SELECT name FROM script_analysis_items WHERE id='wardrobe'").get().name, '历史服装备选（待确认角色）');
  assert.equal(db.prepare('SELECT COUNT(*) AS n FROM art_structure_backup_0914').get().n, 4);
  db.close();
});
test('tomorrow art depends on the joint script review and old rolling plan resumes the 16th', () => {
  const calendar = load('../lib/work-calendar.ts');
  const plan = load('../lib/plan-data.ts', { '@/lib/work-calendar': calendar });
  const art = plan.initialItems.filter((row) => row.workDate === '2026-09-15' && ['主美', '服化道副导演'].includes(row.owner));
  assert.equal(art.length, 2);
  assert.ok(art.every((row) => row.episode === '第2集' && row.dependsOnId === 'review-scripts-2026-09-15'));
  assert.equal(plan.initialItems.find((row) => row.id === '2026-09-12-gen').workDate, '2026-09-16');
});
test('final-script scene alignment moves hospital and hotel files without losing authors', () => {
  const db = new DatabaseSync(':memory:');
  db.exec(`
    CREATE TABLE script_analyses(id TEXT PRIMARY KEY,episode TEXT,scene_no INTEGER,scene_title TEXT,script_text TEXT,scene_summary TEXT,location TEXT,created_at TEXT,updated_at TEXT,script_version_id TEXT,is_active INTEGER);
    CREATE TABLE script_analysis_items(id TEXT PRIMARY KEY,analysis_id TEXT,category TEXT,name TEXT,detail TEXT,visual_brief TEXT,yoyo_approved INTEGER,producer_approved INTEGER,sort_order INTEGER,updated_at TEXT,is_active INTEGER);
    CREATE TABLE art_submission_details(item_id TEXT PRIMARY KEY,assigned_to TEXT,due_at TEXT,handoff_to TEXT,done_definition TEXT,status TEXT,submission_note TEXT,review_note TEXT,selected_file_id TEXT,submitted_at TEXT,reviewed_at TEXT,updated_at TEXT);
    CREATE TABLE art_submission_files(id TEXT PRIMARY KEY,item_id TEXT,object_key TEXT,file_name TEXT,content_type TEXT,byte_size INTEGER,uploaded_by TEXT,sort_order INTEGER,created_at TEXT);
    CREATE TABLE art_reference_exclusions(item_id TEXT,file_id TEXT,removed_by TEXT,created_at TEXT,PRIMARY KEY(item_id,file_id));
    CREATE TABLE production_items(episode TEXT,category TEXT,planned_qty INTEGER,updated_at TEXT);
    CREATE TABLE activity_log(id INTEGER PRIMARY KEY AUTOINCREMENT,item_type TEXT,item_id TEXT,action TEXT,operator TEXT,created_at TEXT);
    INSERT INTO script_analyses VALUES
      ('ep1-v3-s4','第1集',4,'东方庭院·临水巷道　日　内','','','东方庭院·临水巷道　日　内','','','v',1),
      ('ep1-v3-s5','第1集',5,'影视城监控室　夜　内','','','影视城监控室　夜　内','','','v',1),
      ('ep1-v3-s6','第1集',6,'医院病房　深夜　内','','','医院病房　深夜　内','','','v',1),
      ('ep1-v3-s7','第1集',7,'群演酒店标间　深夜　内','','','群演酒店标间　深夜　内','','','v',1);
    INSERT INTO script_analysis_items VALUES
      ('ep1-v3-s4-auto-7','ep1-v3-s4','场景','影视城监控室　夜　内｜场景图','','',0,0,0,'',1),
      ('ep1-v3-s4-overall-cast','ep1-v3-s4','服装','配角与群演｜整体参考','','',0,0,800,'',1),
      ('ep1-v3-s5-auto-7','ep1-v3-s5','场景','医院病房　深夜　内｜场景图','','',0,0,0,'',1),
      ('ep1-v3-s5-auto-1','ep1-v3-s5','人物','陆文川｜人脸、妆造、梳发','','',0,0,10,'',1),
      ('ep1-v3-s5-hero-wardrobe','ep1-v3-s5','服装','陆文川｜服装','','',0,0,21,'',1),
      ('ep1-v3-s5-overall-cast','ep1-v3-s5','服装','配角与群演｜整体参考','','',0,0,800,'',1),
      ('ep1-v3-s6-auto-9','ep1-v3-s6','场景','群演酒店标间　深夜　内｜场景图','','',0,0,0,'',1),
      ('ep1-v3-s6-auto-1','ep1-v3-s6','人物','顾丽乔｜人脸、妆造、梳发','','',0,0,10,'',1),
      ('ep1-v3-s6-heroine-wardrobe','ep1-v3-s6','服装','顾丽乔｜服装','','',0,0,11,'',1),
      ('ep1-v3-s6-overall-cast','ep1-v3-s6','服装','配角与群演｜整体参考','','',0,0,800,'',1),
      ('ep1-v3-s7-i01','ep1-v3-s7','场景','医院单人病房','','',0,0,0,'',1),
      ('ep1-v3-s7-i02','ep1-v3-s7','人物','陆文川病后状态','','',0,0,1,'',1),
      ('ep1-v3-s7-i03','ep1-v3-s7','服装','陆文川病服','','',0,0,2,'',1),
      ('ep1-v3-s7-overall-cast','ep1-v3-s7','服装','配角与群演｜整体参考','','',0,0,800,'',1);
    INSERT INTO art_submission_details SELECT id,'','','','','待上传','','','','','','' FROM script_analysis_items;
    INSERT INTO art_submission_files VALUES
      ('hospital-a','ep1-v3-s7-i01','a','a.jpg','image/jpeg',1,'罗新姗',1,''),
      ('hospital-b','ep1-v3-s7-i01','b','b.jpg','image/jpeg',1,'玉冰',2,''),
      ('wardrobe','ep1-v3-s7-i03','c','c.jpg','image/jpeg',1,'罗新姗',1,''),
      ('hotel','ep1-v3-s6-auto-9','d','d.jpg','image/jpeg',1,'王承恺',1,'');
    INSERT INTO production_items VALUES('第1集','美术清单',0,'');
  `);
  db.exec(readFileSync(new URL('../drizzle/0017_align_final_script_scenes.sql', import.meta.url), 'utf8'));
  assert.equal(db.prepare("SELECT analysis_id FROM script_analysis_items WHERE id='ep1-v3-s6-auto-9'").get().analysis_id, 'ep1-v3-s7');
  assert.equal(db.prepare("SELECT analysis_id FROM script_analysis_items WHERE id='ep1-v3-s5-auto-7'").get().analysis_id, 'ep1-v3-s6');
  assert.equal(db.prepare("SELECT item_id FROM art_submission_files WHERE id='hospital-a'").get().item_id, 'ep1-v3-s5-auto-7');
  assert.equal(db.prepare("SELECT uploaded_by FROM art_submission_files WHERE id='hospital-a'").get().uploaded_by, '罗新姗');
  assert.equal(db.prepare("SELECT item_id FROM art_submission_files WHERE id='hotel'").get().item_id, 'ep1-v3-s6-auto-9');
  assert.equal(db.prepare("SELECT COUNT(*) AS n FROM art_submission_files").get().n, 4);
  assert.equal(db.prepare("SELECT COUNT(*) AS n FROM script_analysis_items WHERE analysis_id='ep1-v3-s4' AND is_active=1").get().n, 5);
  assert.equal(db.prepare("SELECT is_active FROM script_analysis_items WHERE id='ep1-v3-s7-i01'").get().is_active, 0);
  assert.equal(db.prepare('SELECT COUNT(*) AS n FROM art_scene_alignment_files_backup_0914').get().n, 4);
  db.close();
});
test('first-scene historical wardrobe is assigned to Gu Liqiao without losing attribution', () => {
  const db = new DatabaseSync(':memory:');
  db.exec(`
    CREATE TABLE script_analyses(id TEXT PRIMARY KEY,episode TEXT,is_active INTEGER);
    CREATE TABLE script_analysis_items(id TEXT PRIMARY KEY,analysis_id TEXT,category TEXT,name TEXT,detail TEXT,visual_brief TEXT,yoyo_approved INTEGER,producer_approved INTEGER,sort_order INTEGER,updated_at TEXT,is_active INTEGER);
    CREATE TABLE art_submission_details(item_id TEXT PRIMARY KEY,status TEXT,review_note TEXT,selected_file_id TEXT,updated_at TEXT);
    CREATE TABLE art_submission_files(id TEXT PRIMARY KEY,item_id TEXT,object_key TEXT,file_name TEXT,content_type TEXT,byte_size INTEGER,uploaded_by TEXT,sort_order INTEGER,created_at TEXT);
    CREATE TABLE art_reference_exclusions(item_id TEXT,file_id TEXT,removed_by TEXT,created_at TEXT,PRIMARY KEY(item_id,file_id));
    CREATE TABLE production_items(episode TEXT,category TEXT,planned_qty INTEGER,updated_at TEXT);
    CREATE TABLE activity_log(id INTEGER PRIMARY KEY AUTOINCREMENT,item_type TEXT,item_id TEXT,action TEXT,operator TEXT,created_at TEXT);
    INSERT INTO script_analyses VALUES('ep1-v3-s1','第1集',1);
    INSERT INTO script_analysis_items VALUES
      ('ep1-v3-s1-auto-10','ep1-v3-s1','服装','历史服装备选（待确认角色）','','',1,0,850,'',1),
      ('ep1-v3-s1-heroine-wardrobe','ep1-v3-s1','服装','顾丽乔｜服装','','',0,0,11,'',1);
    INSERT INTO art_submission_details VALUES
      ('ep1-v3-s1-auto-10','已上传','','old-selected',''),
      ('ep1-v3-s1-heroine-wardrobe','待上传','','','');
    INSERT INTO art_submission_files VALUES
      ('old-selected','ep1-v3-s1-auto-10','a','a.jpg','image/jpeg',1,'玉冰',1,'2026-09-14 09:00'),
      ('other','ep1-v3-s1-auto-10','b','b.jpg','image/jpeg',1,'罗新姗',2,'2026-09-14 10:00');
    INSERT INTO production_items VALUES('第1集','美术清单',2,'');
  `);
  db.exec(readFileSync(new URL('../drizzle/0018_assign_scene1_wardrobe_to_guliqiao.sql', import.meta.url), 'utf8'));
  db.exec(readFileSync(new URL('../drizzle/0019_clarify_guliqiao_scene1_wardrobe.sql', import.meta.url), 'utf8'));
  assert.equal(db.prepare("SELECT is_active FROM script_analysis_items WHERE id='ep1-v3-s1-auto-10'").get().is_active, 0);
  assert.equal(db.prepare("SELECT name FROM script_analysis_items WHERE id='ep1-v3-s1-heroine-wardrobe'").get().name, '顾丽乔｜服装');
  assert.equal(db.prepare("SELECT detail FROM script_analysis_items WHERE id='ep1-v3-s1-heroine-wardrobe'").get().detail, '第一场顾丽乔的服装参考，可上传多套备选并由 Lipa 选择定稿。');
  assert.equal(db.prepare("SELECT COUNT(*) AS n FROM art_submission_files WHERE item_id='ep1-v3-s1-heroine-wardrobe'").get().n, 2);
  assert.equal(db.prepare("SELECT uploaded_by FROM art_submission_files WHERE id='old-selected'").get().uploaded_by, '玉冰');
  assert.equal(db.prepare("SELECT created_at FROM art_submission_files WHERE id='other'").get().created_at, '2026-09-14 10:00');
  assert.equal(db.prepare("SELECT selected_file_id FROM art_submission_details WHERE item_id='ep1-v3-s1-heroine-wardrobe'").get().selected_file_id, 'old-selected');
  assert.equal(db.prepare('SELECT COUNT(*) AS n FROM art_scene1_wardrobe_files_backup_0914').get().n, 2);
  db.close();
});
test('art cards keep review essentials and omit production metadata forms', () => {
  const source = readFileSync(new URL('../components/submission-center.tsx', import.meta.url), 'utf8');
  const dropzone = readFileSync(new URL('../components/art-upload-dropzone.tsx', import.meta.url), 'utf8');
  for (const hidden of ['分配责任人（可多人上传）', '精确截止时间', '下一交接人', '完成定义', '采用说明', 'Lipa审核／打回意见', '保存责任与节点']) assert.equal(source.includes(hidden), false);
  for (const essential of ['上传人：', '选为定稿图', 'ReferenceLightbox', 'ArtUploadDropzone']) assert.equal(source.includes(essential), true);
  assert.equal(dropzone.includes('每张自动署名'), false);
});
