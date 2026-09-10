import { env } from 'cloudflare:workers';
import { createSession, getAccountByUsername, hashPassword, normalizeUsername, verifyPassword } from '@/lib/auth';

async function handleLogin(request: Request) {
  const body = await request.json() as { username?: string; password?: string };
  const username = normalizeUsername(body.username || '');
  let account = await getAccountByUsername(username);
  if (!account && username === 'lipa' && body.password && body.password === env.ADMIN_INITIAL_PASSWORD) {
    const credentials = await hashPassword(body.password);
    const id = crypto.randomUUID();
    const createdAt = new Date().toISOString();
    await env.DB.prepare(`INSERT INTO member_accounts
      (id, username, password_hash, password_salt, password_iterations, name, role, is_admin, active, failed_attempts, locked_until, created_at, updated_at)
      VALUES (?, 'lipa', ?, ?, ?, 'Lipa', '联合制片人／导演', 1, 1, 0, '', ?, ?)`)
      .bind(id, credentials.hash, credentials.salt, credentials.iterations, createdAt, createdAt).run();
    account = await getAccountByUsername(username);
  }
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

export async function POST(request: Request) {
  try {
    return await handleLogin(request);
  } catch (error) {
    console.error('Login failed unexpectedly', error);
    return Response.json(
      { error: '登录服务暂时不可用，请稍后重试' },
      { status: 500 },
    );
  }
}
