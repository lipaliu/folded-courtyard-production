import { test } from 'node:test';
import assert from 'node:assert/strict';
import { DatabaseSync } from 'node:sqlite';
import { readFileSync } from 'node:fs';
import vm from 'node:vm';
import ts from 'typescript';
function load(path, dependencies = {}) {
  const exports = {};
  vm.runInNewContext(ts.transpileModule(readFileSync(new URL(path, import.meta.url), 'utf8'), { compilerOptions: { module: ts.ModuleKind.CommonJS, target: ts.ScriptTarget.ES2022 } }).outputText, { exports, require: name => dependencies[name], Request, Response });
  return exports;
}
const roles = load('../lib/team-roles.ts');
function fixture() {
  const db = new DatabaseSync(':memory:');
  for (const path of ['0000_nostalgic_micromacro.sql', '0002_organic_slipstream.sql', '0007_old_stick.sql', '0012_selected_art_file.sql', '0023_art_favorites.sql']) db.exec(readFileSync(new URL('../drizzle/' + path, import.meta.url), 'utf8'));
  db.exec(`ALTER TABLE script_analyses ADD COLUMN is_active INTEGER DEFAULT 1;
    ALTER TABLE script_analysis_items ADD COLUMN is_active INTEGER DEFAULT 1;
    ALTER TABLE art_submission_details ADD COLUMN reuse_source_item_id TEXT DEFAULT '';
    INSERT INTO script_analyses(id,episode,scene_no,scene_title,script_text,created_at,updated_at) VALUES('s1','第2集',1,'家','原文','',''),('s2','第2集',2,'采访棚','原文','',''),('s3','第1集',1,'家','原文','','');
    INSERT INTO script_analysis_items(id,analysis_id,category,name,updated_at) VALUES('source','s1','服装','衣服',''),('target','s2','服装','衣服',''),('other-ep','s3','服装','衣服','');
    INSERT INTO art_submission_files(id,item_id,object_key,file_name,content_type,byte_size,uploaded_by,created_at) VALUES('image','source','static:/ref.jpg','原图.jpg','image/jpeg',100,'原上传人','');
    INSERT INTO art_submission_details(item_id,selected_file_id,status,updated_at) VALUES('source','image','已锁定',''),('target','','待上传','');`);
  const DB = { prepare(sql) { let args = []; return { sql, bind(...values) { args = values; return this; }, async first() { return db.prepare(sql).get(...args) || null; }, async all() { return { results: db.prepare(sql).all(...args) }; }, async run() { return db.prepare(sql).run(...args); } }; }, async batch(rows) { return Promise.all(rows.map(row => row.run())); } };
  const api = (path, user) => load(path, { 'cloudflare:workers': { env: { DB } }, '@/lib/auth': { requireMember: async () => user }, '@/lib/team-roles': roles });
  return { db, api };
}
const req = body => new Request('https://test/api', { method: 'PATCH', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(body) });
test('all member roles can browse art without gaining editing rights', () => {
  for (const role of roles.TEAM_ROLES) assert.equal(roles.roleCanBrowseArt(role), true);
  assert.equal(roles.roleCanBrowseArt('unknown'), false);
  for (const role of ['编剧','导演','剪辑','AIGC抽卡师']) assert.equal(roles.canEditArtCategory({role,isAdmin:false}, '场景'), false);
});
test('stars are persistent per-person preferences, not final approval', async () => {
  const {db,api} = fixture();
  const favorites = api('../app/api/art-favorites/route.ts', {id:'alice',role:'编剧',isAdmin:false});
  assert.equal((await favorites.PATCH(req({fileId:'image',favorite:true}))).status,200);
  assert.equal((await favorites.PATCH(req({fileId:'image',favorite:true}))).status,200);
  assert.deepEqual((await (await favorites.GET(new Request('https://test'))).json()).fileIds,['image']);
  const bob = api('../app/api/art-favorites/route.ts', {id:'bob',role:'主美',isAdmin:false});
  assert.deepEqual((await (await bob.GET(new Request('https://test'))).json()).fileIds,[]);
  assert.equal(db.prepare("SELECT selected_file_id FROM art_submission_details WHERE item_id='source'").get().selected_file_id,'image');
  assert.equal((await favorites.PATCH(req({fileId:'missing',favorite:true}))).status,404);
  assert.equal((await api('../app/api/art-favorites/route.ts', null).PATCH(req({fileId:'image',favorite:true}))).status,401);
  await favorites.PATCH(req({fileId:'image',favorite:false}));
  assert.equal(db.prepare('SELECT COUNT(*) AS n FROM art_file_favorites').get().n,0);
  db.close();
});
test('cross-scene move preserves the image and author, invalidates old final, and rejects another episode', async () => {
  const {db,api} = fixture();
  const route = api('../app/api/art-submissions/route.ts', {id:'lipa',name:'Lipa',role:'执行制片人',isAdmin:true});
  assert.equal((await route.PATCH(req({itemId:'other-ep',moveFileId:'image'}))).status,400);
  const result = await route.PATCH(req({itemId:'target',moveFileId:'image'}));
  assert.equal(result.status,200);
  assert.equal((await result.json()).details.length,2);
  const file = db.prepare("SELECT * FROM art_submission_files WHERE id='image'").get();
  assert.equal(file.item_id,'target'); assert.equal(file.object_key,'static:/ref.jpg'); assert.equal(file.uploaded_by,'原上传人');
  assert.equal(db.prepare("SELECT selected_file_id FROM art_submission_details WHERE item_id='source'").get().selected_file_id,'');
  assert.equal(db.prepare("SELECT status FROM art_submission_details WHERE item_id='target'").get().status,'已上传');
  assert.equal((await route.PATCH(req({itemId:'source',selectedFileId:'image'}))).status,400);
  assert.equal((await route.PATCH(req({itemId:'target',selectedFileId:'image'}))).status,200);
  assert.equal(db.prepare("SELECT selected_file_id FROM art_submission_details WHERE item_id='target'").get().selected_file_id,'image');
  db.close();
});
