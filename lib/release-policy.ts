export type ReleaseMember = { id: string; name: string; role: string; isAdmin: boolean };
export const RELEASE_START = '2026-09-18';
export const RELEASE_END = '2026-10-15';
export const RELEASE_ACCOUNTS = ['yoyo_main','virtual_yoyo','yoyo_small','studio','studio_ai','zheng','male','matrix','marketing','clips'];
const limits: Record<string, number> = {title:200, how:4000, relay:2000, gate:2000, quantity:200, clock:5, status:20, memo:4000, rhythm:200, kind:10, ownerId:100, date:10, account:40};
export function canEditTask(user: ReleaseMember, ownerId: string) { return user.isAdmin || (!!ownerId && user.id === ownerId); }
export function validateChanges(value: unknown, user: ReleaseMember): Record<string,string> {
  if (!value || typeof value !== 'object' || Array.isArray(value) || !Object.keys(value).length) throw Error('请填写任务内容');
  const changes = value as Record<string,string>;
  for (const [key,v] of Object.entries(changes)) {
    if (!Object.hasOwn(limits,key) || typeof v !== 'string' || v.length > limits[key]) throw Error('字段不支持或文字过长');
  }
  if ('ownerId' in changes && !user.isAdmin && changes.ownerId !== user.id) throw Error('只能为自己安排任务');
  if ('title' in changes && !changes.title.trim()) throw Error('请填写任务名称');
  if ('date' in changes && (!/^\d{4}-\d{2}-\d{2}$/.test(changes.date) || changes.date<RELEASE_START || changes.date>RELEASE_END || new Date(changes.date+'T12:00:00Z').toISOString().slice(0,10)!==changes.date)) throw Error('日期须在9月18日至10月15日之间');
  if ('account' in changes && !RELEASE_ACCOUNTS.includes(changes.account)) throw Error('请选择发行账号');
  if ('kind' in changes && !['发布','直播','筹备','不更'].includes(changes.kind)) throw Error('请选择任务类型');
  if ('status' in changes && !['待确认','制作中','待审核','可发布','已发布','已完成','顺延','取消'].includes(changes.status)) throw Error('执行状态不正确');
  if (changes.clock && !/^([01]\d|2[0-3]):[0-5]\d$/.test(changes.clock)) throw Error('时刻格式不正确');
  return changes;
}
export function validWriteOrigin(request: Request) {
  const origin=request.headers.get('origin');
  return request.headers.get('sec-fetch-site') !== 'cross-site' && !!origin && [new URL(request.url).origin,'https://folded-courtyard-production-web.pages.dev','https://folded-courtyard-production.lipaliu514.workers.dev'].includes(origin);
}
