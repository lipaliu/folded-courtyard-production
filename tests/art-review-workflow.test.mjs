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
