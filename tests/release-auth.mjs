// Runs the real authentication and release handlers against an isolated SQLite database.
// No live credentials, accounts or tasks are used.
import { DatabaseSync } from 'node:sqlite';
import { readFileSync } from 'node:fs';
import { resolve,dirname } from 'node:path';
import vm from 'node:vm';
import assert from 'node:assert/strict';
import ts from 'typescript';
const db=new DatabaseSync(':memory:');
db.exec(readFileSync('drizzle/0006_graceful_fenris.sql','utf8'));
const DB={prepare(sql){let args=[];return {bind(...values){args=values;return this},async first(){return db.prepare(sql).get(...args)||null},async all(){return {results:db.prepare(sql).all(...args)}},async run(){return {meta:{changes:db.prepare(sql).run(...args).changes}}}}},async batch(items){return Promise.all(items.map(x=>x.run()))}};
const context=vm.createContext({crypto,TextEncoder,Uint8Array,btoa,atob,Request,Response,URL,console});
const cache=new Map();
async function mod(file){file=resolve(file);if(cache.has(file))return cache.get(file);const code=ts.transpileModule(readFileSync(file,'utf8'),{compilerOptions:{module:ts.ModuleKind.ESNext,target:ts.ScriptTarget.ES2022}}).outputText;const m=new vm.SourceTextModule(code,{context,identifier:file});cache.set(file,m);await m.link(async spec=>spec==='cloudflare:workers'?new vm.SyntheticModule(['env'],function(){this.setExport('env',{DB})},{context}):mod(resolve(dirname(file),spec+'.ts')));return m;}
const auth=await mod('lib/auth.ts');await auth.evaluate();
const store=await mod('lib/release-store.ts');await store.evaluate();
const {hashPassword,verifyPassword,createSession,getSiteUser}=auth.namespace;
const {releaseRequest}=store.namespace;
const credentials=await hashPassword('Temporary-test-only');assert(await verifyPassword('Temporary-test-only',{passwordHash:credentials.hash,passwordSalt:credentials.salt,passwordIterations:credentials.iterations}));
for(const [id,admin] of [['alice',0],['bob',0],['admin',1]]) db.prepare('INSERT INTO member_accounts(id,username,password_hash,password_salt,password_iterations,name,role,is_admin,active,created_at,updated_at) VALUES(?,?,?,?,?,?,?,?,1,?,?)').run(id,id,credentials.hash,credentials.salt,credentials.iterations,id,'剪辑',admin,'','');
db.exec(readFileSync('drizzle/0025_release_workspace.sql','utf8'));db.exec(readFileSync('drizzle/0025_release_workspace.sql','utf8'));
assert.equal(db.prepare('SELECT COUNT(*) n FROM release_tasks').get().n,280);
const cookie={};for(const name of ['alice','bob','admin'])cookie[name]=(await createSession(name)).split(';')[0];
const origin='https://folded-courtyard-production-web.pages.dev';
function req(user,method='GET',body,id,foreign=false){return new Request(origin+'/api/release/calendar'+(id?'/'+id:''),{method,headers:{...(user?{cookie:cookie[user]}:{}),origin:foreign?'https://evil.example':origin,'content-type':'application/json'},...(body?{body:JSON.stringify(body)}:{})})}
assert.equal((await releaseRequest(req(null))).status,401);
assert.equal((await getSiteUser(req('alice'))).id,'alice'); // Same session used by creative workspace.
const task={title:'test task',date:'2026-09-18',account:'virtual_yoyo',kind:'发布'};
assert.equal((await releaseRequest(req('alice','POST',{changes:task},null,true))).status,403);
assert.equal((await releaseRequest(req('alice','POST',{changes:{...task,ownerId:'bob'}}))).status,400);
let response=await releaseRequest(req('alice','POST',{changes:task}));assert.equal(response.status,201);let e=(await response.json()).entry;assert.equal(e.ownerId,'alice');
assert.equal((await releaseRequest(req('bob','PUT',{revision:e.revision,changes:{title:'hijack'}},e.id),e.id)).status,403);
assert.equal((await releaseRequest(req('bob','DELETE',{revision:e.revision},e.id),e.id)).status,403);
response=await releaseRequest(req('alice','PUT',{revision:e.revision,changes:{title:'updated'}},e.id),e.id);assert.equal(response.status,200);e=(await response.json()).entry;
assert.equal((await releaseRequest(req('alice','PUT',{revision:1,changes:{title:'stale'}},e.id),e.id)).status,409);
response=await releaseRequest(req('alice','DELETE',{revision:e.revision},e.id),e.id);assert.equal(response.status,200);e=(await response.json()).entry;
assert(!(await (await releaseRequest(req('alice'))).json()).entries.some(x=>x.id===e.id));
response=await releaseRequest(req('alice','PUT',{revision:e.revision,restore:true},e.id),e.id);assert.equal(response.status,200);e=(await response.json()).entry;
response=await releaseRequest(req('admin','PUT',{revision:e.revision,changes:{ownerId:'bob'}},e.id),e.id);assert.equal(response.status,200);e=(await response.json()).entry;
assert.equal((await releaseRequest(req('alice','PUT',{revision:e.revision,changes:{title:'not mine anymore'}},e.id),e.id)).status,403);
assert.equal((await releaseRequest(req('bob','PUT',{revision:e.revision,changes:{title:'mine now'}},e.id),e.id)).status,200);
db.prepare('UPDATE member_accounts SET active=0 WHERE id=?').run('bob');assert.equal((await releaseRequest(req('bob'))).status,401);
const data=await (await releaseRequest(req('alice'))).json();assert(!JSON.stringify(data).includes(credentials.hash));assert.equal(data.members.length,1);
console.log('PASS: shared creative login session; 280 seeds idempotent; authentication; own-task create/update/remove/restore; cross-user and CSRF rejection; reassignment; revision conflicts; disabled accounts; no credentials in API');
if(process.argv.includes('--serve')) {
 const {createServer}=await import('node:http');
 const {existsSync}=await import('node:fs');
 createServer(async(incoming,out)=>{
  const chunks=[];for await(const c of incoming)chunks.push(c);
  const url=new URL(incoming.url,'http://127.0.0.1:8772');
  const request=new Request(url,{method:incoming.method,headers:incoming.headers,...(!['GET','HEAD'].includes(incoming.method)?{body:Buffer.concat(chunks)}:{})});
  let response;
  if(url.pathname==='/api/auth/login') {
   const body=await request.json();const account=await auth.namespace.getAccountByUsername(body.username);
   response=account&&await verifyPassword(body.password,account)?Response.json({ok:true},{headers:{'Set-Cookie':await createSession(account.id)}}):Response.json({error:'登录失败'},{status:401});
  } else if(url.pathname==='/api/auth/logout') {await auth.namespace.deleteSession(request);response=Response.json({ok:true},{headers:{'Set-Cookie':auth.namespace.clearSessionCookie()}})}
  else if(url.pathname.startsWith('/api/release/calendar'))response=await releaseRequest(request,url.pathname.split('/')[4]);
  else {
   const path=resolve('public','.'+url.pathname);const ext=path.split('.').pop();
   if(!path.startsWith(resolve('public')+'/')||!existsSync(path)){out.writeHead(404).end();return}
   response=new Response(readFileSync(path),{headers:{'Content-Type':({html:'text/html; charset=utf-8',js:'text/javascript; charset=utf-8',css:'text/css; charset=utf-8',png:'image/png',jpg:'image/jpeg'})[ext]||'application/octet-stream'}});
  }
  out.writeHead(response.status,Object.fromEntries(response.headers));out.end(Buffer.from(await response.arrayBuffer()));
 }).listen(8772,'127.0.0.1',()=>console.log('Isolated UI fixture http://127.0.0.1:8772/release/calendar.html'));
}
