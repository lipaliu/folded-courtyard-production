import { env } from 'cloudflare:workers';
import { hashPassword, normalizeUsername, validatePassword, validateUsername } from '@/lib/auth';

export async function POST(request: Request) {
  const configuredSecret = env.ADMIN_BOOTSTRAP_SECRET || '';
  const suppliedSecret = (request.headers.get('authorization') || '').replace(/^Bearer\s+/i, '');
  if (!configuredSecret || suppliedSecret !== configuredSecret) return Response.json({ error: '无权执行' }, { status: 403 });
  const existingAdmin = await env.DB.prepare('SELECT id FROM member_accounts WHERE is_admin = 1 LIMIT 1').first();
  if (existingAdmin) return Response.json({ error: '管理员账号已经建立' }, { status: 409 });
  const body = await request.json() as { username?: string; password?: string };
  const username = normalizeUsername(body.username || '');
  const password = body.password || '';
  if (!validateUsername(username) || !validatePassword(password)) return Response.json({ error: '账号或密码格式不正确' }, { status: 400 });
  const credentials = await hashPassword(password);
  const id = crypto.randomUUID();
  const now = new Date().toISOString();
  await env.DB.prepare(`INSERT INTO member_accounts
    (id, username, password_hash, password_salt, password_iterations, name, role, is_admin, active, failed_attempts, locked_until, created_at, updated_at)
    VALUES (?, ?, ?, ?, ?, 'Lipa', '联合制片人／导演', 1, 1, 0, '', ?, ?)`)
    .bind(id, username, credentials.hash, credentials.salt, credentials.iterations, now, now).run();
  return Response.json({ ok: true, username });
}
