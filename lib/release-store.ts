import { env } from 'cloudflare:workers';
import { getSiteUser } from './auth';
import { canEditTask, validateChanges, validWriteOrigin } from './release-policy';
type Row = { id:string; date:string; account:string; owner_id:string; payload:string; revision:number; deleted:number; updated_at:string; owner_name:string|null };
const select=`SELECT t.*, a.name AS owner_name FROM release_tasks t LEFT JOIN member_accounts a ON a.id=t.owner_id`;
const reply=(data:unknown,status=200)=>Response.json(data,{status,headers:{'Cache-Control':'no-store'}});
function entry(row:Row,user:{id:string;name:string;role:string;isAdmin:boolean}) {
  return {...JSON.parse(row.payload),id:row.id,date:row.date,account:row.account,ownerId:row.owner_id,owner:row.owner_name||JSON.parse(row.payload).owner||'',revision:row.revision,canEdit:canEditTask(user,row.owner_id),updated:row.updated_at};
}
export async function releaseRequest(request:Request,id?:string) {
 try {
  const user=await getSiteUser(request);
  if(!user)return reply({error:'请使用创作工作台账号登录'},401);
  if(request.method==='GET') {
   const rows=await env.DB.prepare(select+' WHERE t.deleted=0 ORDER BY t.date,t.account,t.id').all<Row>();
   const members=user.isAdmin?(await env.DB.prepare('SELECT id,name,role FROM member_accounts WHERE active=1 ORDER BY name').all()).results:[{id:user.id,name:user.name,role:user.role}];
   return reply({user,members,entries:rows.results.map(r=>entry(r,user))});
  }
  if(!validWriteOrigin(request))return reply({error:'请从当前工作台提交修改'},403);
  if(!request.headers.get('content-type')?.startsWith('application/json'))return reply({error:'需要 JSON 格式'},415);
  const raw=await request.text();if(raw.length>24000)return reply({error:'内容过长'},413);
  let body;try{body=JSON.parse(raw)}catch{return reply({error:'无法读取修改内容'},400)}
  if(!body||typeof body!=='object'||Array.isArray(body))return reply({error:'修改格式不正确'},400);
  if(request.method==='POST') {
   let changes;try{changes=validateChanges(body.changes,user)}catch(e){return reply({error:(e as Error).message},400)}
   if(!changes.title||!changes.date||!changes.account)return reply({error:'请填写日期、账号和任务名称'},400);
   const ownerId=user.isAdmin?(changes.ownerId||''):user.id;
   if(ownerId && !(await env.DB.prepare('SELECT id FROM member_accounts WHERE id=? AND active=1').bind(ownerId).first()))return reply({error:'负责人账号不存在或已停用'},400);
   const taskId=crypto.randomUUID(),now=new Date().toISOString();
   const payload={kind:'发布',how:'',relay:'',gate:'',quantity:'',clock:'',status:'待确认',memo:'',rhythm:'',codes:[],source:'发行工作台新增任务',...changes,owner:''};
   await env.DB.prepare('INSERT INTO release_tasks(id,date,account,owner_id,created_by,payload,revision,deleted,updated_at) VALUES(?,?,?,?,?,?,1,0,?)').bind(taskId,changes.date,changes.account,ownerId,user.id,JSON.stringify(payload),now).run();
   const row=await env.DB.prepare(select+' WHERE t.id=?').bind(taskId).first<Row>();
   return reply({entry:entry(row!,user)},201);
  }
  const row=await env.DB.prepare(select+' WHERE t.id=?').bind(id).first<Row>();
  if(!row)return reply({error:'任务不存在'},404);
  if(!canEditTask(user,row.owner_id))return reply({error:'只能修改或删除自己的任务'},403);
  if(!Number.isInteger(body.revision)||body.revision!==row.revision)return reply({error:'任务已被其他页面修改，请刷新后重试',entry:entry(row,user)},409);
  const now=new Date().toISOString();
  let result;
  if(request.method==='DELETE'||body.restore===true) {
   const deleted=request.method==='DELETE'?1:0;
   if(row.deleted===deleted)return reply({error:deleted?'任务已移除':'任务未被移除'},409);
   result=await env.DB.prepare('UPDATE release_tasks SET deleted=?,revision=revision+1,updated_at=? WHERE id=? AND revision=? AND deleted=?').bind(deleted,now,id,row.revision,row.deleted).run();
  } else {
   if(row.deleted)return reply({error:'任务已移除，请刷新'},410);
   let changes;try{changes=validateChanges(body.changes,user)}catch(e){return reply({error:(e as Error).message},400)}
   const ownerId=changes.ownerId??row.owner_id;
   if(ownerId && !(await env.DB.prepare('SELECT id FROM member_accounts WHERE id=? AND active=1').bind(ownerId).first()))return reply({error:'负责人账号不存在或已停用'},400);
   const payload={...JSON.parse(row.payload),...changes};if('ownerId' in changes)payload.owner='';
   result=await env.DB.prepare('UPDATE release_tasks SET date=?,account=?,owner_id=?,payload=?,revision=revision+1,updated_at=? WHERE id=? AND revision=? AND deleted=0').bind(changes.date||row.date,changes.account||row.account,ownerId,JSON.stringify(payload),now,id,row.revision).run();
  }
  if(!result.meta.changes)return reply({error:'任务已更新，请刷新后重试'},409);
  const updated=await env.DB.prepare(select+' WHERE t.id=?').bind(id).first<Row>();
  return reply({entry:entry(updated!,user),deleted:!!updated!.deleted});
 }catch(e){console.error('Release task request failed',e);return reply({error:'任务服务暂时不可用，请稍后重试'},500)}
}
