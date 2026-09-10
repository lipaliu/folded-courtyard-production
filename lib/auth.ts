import { env } from 'cloudflare:workers';

export const TEAM_ROLES = ['编剧', '主美', 'AIGC抽卡师', '剪辑', '制片人（叶总）', '红人（Yoyo）', '项目成员'] as const;
export type SiteUser = { id: string; email: string; name: string; phone?: string; role: string; isAdmin: boolean; needsRegistration?: boolean };

export function getRequestIdentity(request: Request) {
  let id = request.headers.get('oai-authenticated-user-id') || '';
  let email = request.headers.get('oai-authenticated-user-email') || '';
  if (!id && ['localhost', '127.0.0.1'].includes(new URL(request.url).hostname)) {
    id = 'local-preview';
    email = 'lipa@local.preview';
  }
  let name = email.split('@')[0] || '项目成员';
  const encodedName = request.headers.get('oai-authenticated-user-full-name');
  if (encodedName && request.headers.get('oai-authenticated-user-full-name-encoding') === 'percent-encoded-utf-8') {
    try { name = decodeURIComponent(encodedName); } catch { /* keep email fallback */ }
  }
  return { id, email, name };
}

export async function getSiteUser(request: Request): Promise<SiteUser | null> {
  const user = getRequestIdentity(request);
  if (!user.id) return null;
  if (user.id === 'local-preview') return { ...user, name: 'Lipa', role: '联合制片人／导演', isAdmin: true };
  const admin = await env.DB.prepare("SELECT value FROM app_settings WHERE key = 'admin_user_id'").first<{ value: string }>();
  if (admin?.value === user.id) return { ...user, name: 'Lipa', role: '联合制片人／导演', isAdmin: true };
  const member = await env.DB.prepare(`SELECT name, phone, role FROM team_members WHERE user_id = ? AND active = 1`).bind(user.id).first<{ name: string; phone: string; role: string }>();
  if (!member) return null;
  return { ...user, ...member, isAdmin: false };
}

export async function claimOrGetSiteUser(request: Request): Promise<SiteUser | null> {
  const user = getRequestIdentity(request);
  if (!user.id) return null;
  if (user.id === 'local-preview') return { ...user, name: 'Lipa', role: '联合制片人／导演', isAdmin: true };
  const admin = await env.DB.prepare("SELECT value FROM app_settings WHERE key = 'admin_user_id'").first<{ value: string }>();
  if (!admin?.value) {
    const now = new Date().toISOString();
    await env.DB.batch([
      env.DB.prepare("INSERT OR IGNORE INTO app_settings (key, value, updated_at) VALUES ('admin_user_id', ?, ?)").bind(user.id, now),
      env.DB.prepare("INSERT OR REPLACE INTO app_settings (key, value, updated_at) VALUES ('admin_email', ?, ?)").bind(user.email, now),
    ]);
    return { ...user, name: 'Lipa', role: '联合制片人／导演', isAdmin: true };
  }
  if (admin.value === user.id) return { ...user, name: 'Lipa', role: '联合制片人／导演', isAdmin: true };
  const member = await env.DB.prepare(`SELECT name, phone, role FROM team_members WHERE user_id = ? AND active = 1`).bind(user.id).first<{ name: string; phone: string; role: string }>();
  if (member) return { ...user, ...member, isAdmin: false };
  return { ...user, role: '', isAdmin: false, needsRegistration: true };
}

export async function requireMember(request: Request) { return getSiteUser(request); }

export async function requireAdmin(request: Request) {
  const user = await getSiteUser(request);
  if (!user?.isAdmin) return null;
  return user;
}
