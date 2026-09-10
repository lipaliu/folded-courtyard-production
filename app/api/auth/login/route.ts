import { env } from 'cloudflare:workers';
import { createSession, getAccountByUsername, verifyPassword } from '@/lib/auth';

export async function POST(request: Request) {
  const body = await request.json() as { username?: string; password?: string };
  const account = await getAccountByUsername(body.username || '');
  const now = new Date();
  if (account?.lockedUntil && new Date(account.lockedUntil).getTime() > now.getTime()) {
    return Response.json({ error: '尝试次数过多，请15分钟后再试' }, { status: 429 });
  }
  const valid = Boolean(account?.active) && Boolean(body.password) && await verifyPassword(body.password || '', account!);
  if (!valid || !account) {
    if (account) {
      const attempts = account.failedAttempts + 1;
      const lockedUntil = attempts >= 5 ? new Date(now.getTime() + 15 * 60000).toISOString() : '';
      await env.DB.prepare('UPDATE member_accounts SET failed_attempts = ?, locked_until = ?, updated_at = ? WHERE id = ?')
        .bind(attempts >= 5 ? 0 : attempts, lockedUntil, now.toISOString(), account.id).run();
    }
    return Response.json({ error: '登录名或密码不正确' }, { status: 401 });
  }
  await env.DB.prepare("UPDATE member_accounts SET failed_attempts = 0, locked_until = '', updated_at = ? WHERE id = ?")
    .bind(now.toISOString(), account.id).run();
  const cookie = await createSession(account.id);
  return Response.json({ user: { id: account.id, username: account.username, name: account.name, role: account.role, isAdmin: Boolean(account.isAdmin) } }, { headers: { 'Set-Cookie': cookie } });
}
