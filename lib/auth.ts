import { env } from 'cloudflare:workers';

export type SiteUser = { id: string; email: string; name: string; isAdmin: boolean };

function headerUser(request: Request) {
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
  const user = headerUser(request);
  if (!user.id) return null;
  if (user.id === 'local-preview') return { ...user, name: 'Lipa', isAdmin: true };
  const admin = await env.DB.prepare("SELECT value FROM app_settings WHERE key = 'admin_user_id'").first<{ value: string }>();
  return { ...user, isAdmin: admin?.value === user.id };
}

export async function claimOrGetSiteUser(request: Request): Promise<SiteUser | null> {
  const user = headerUser(request);
  if (!user.id) return null;
  if (user.id === 'local-preview') return { ...user, name: 'Lipa', isAdmin: true };
  const admin = await env.DB.prepare("SELECT value FROM app_settings WHERE key = 'admin_user_id'").first<{ value: string }>();
  if (!admin?.value) {
    const now = new Date().toISOString();
    await env.DB.batch([
      env.DB.prepare("INSERT OR IGNORE INTO app_settings (key, value, updated_at) VALUES ('admin_user_id', ?, ?)").bind(user.id, now),
      env.DB.prepare("INSERT OR REPLACE INTO app_settings (key, value, updated_at) VALUES ('admin_email', ?, ?)").bind(user.email, now),
    ]);
    return { ...user, name: 'Lipa', isAdmin: true };
  }
  return { ...user, isAdmin: admin.value === user.id };
}

export async function requireAdmin(request: Request) {
  const user = await getSiteUser(request);
  if (!user?.isAdmin) return null;
  return user;
}
