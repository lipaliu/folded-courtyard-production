import { env } from 'cloudflare:workers';
import { createSession, getAccountByUsername, getSiteUser, hashPassword, validatePassword, verifyPassword } from '@/lib/auth';

export async function PATCH(request: Request) {
  const user = await getSiteUser(request);
  if (!user) return Response.json({ error: '请先登录' }, { status: 401 });
  const body = await request.json() as { currentPassword?: string; newPassword?: string };
  if (!validatePassword(body.newPassword || '')) return Response.json({ error: '请输入新密码' }, { status: 400 });
  const account = await getAccountByUsername(user.username);
  if (!account || !await verifyPassword(body.currentPassword || '', account)) return Response.json({ error: '当前密码不正确' }, { status: 400 });
  const credentials = await hashPassword(body.newPassword || '');
  const now = new Date().toISOString();
  await env.DB.batch([
    env.DB.prepare('UPDATE member_accounts SET password_hash = ?, password_salt = ?, password_iterations = ?, failed_attempts = 0, locked_until = ?, updated_at = ? WHERE id = ?')
      .bind(credentials.hash, credentials.salt, credentials.iterations, '', now, user.id),
    env.DB.prepare('DELETE FROM member_sessions WHERE account_id = ?').bind(user.id),
  ]);
  const cookie = await createSession(user.id);
  return Response.json({ ok: true }, { headers: { 'Set-Cookie': cookie } });
}
