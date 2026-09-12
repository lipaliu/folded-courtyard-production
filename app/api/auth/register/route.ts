import { env } from 'cloudflare:workers';
import { createSession, hashPassword, normalizeUsername, TEAM_ROLES, validatePassword, validateUsername } from '@/lib/auth';

async function handleRegistration(request: Request) {
  const body = await request.json() as { name?: string; role?: string; username?: string; password?: string };
  const name = (body.name || '').trim();
  const role = (body.role || '').trim();
  const username = normalizeUsername(body.username || '');
  const password = body.password || '';

  if (!name) return Response.json({ error: '请填写姓名' }, { status: 400 });
  if (!TEAM_ROLES.includes(role as (typeof TEAM_ROLES)[number])) return Response.json({ error: '请选择岗位' }, { status: 400 });
  if (!validateUsername(username)) return Response.json({ error: '请输入登录名' }, { status: 400 });
  if (username === 'lipa') return Response.json({ error: '这个登录名已由管理员保留' }, { status: 409 });
  if (!validatePassword(password)) return Response.json({ error: '请设置密码' }, { status: 400 });

  const existing = await env.DB.prepare('SELECT id FROM member_accounts WHERE username = ?').bind(username).first();
  if (existing) return Response.json({ error: '这个登录名已经注册，请换一个' }, { status: 409 });

  const credentials = await hashPassword(password);
  const id = crypto.randomUUID();
  const now = new Date().toISOString();
  try {
    await env.DB.batch([
      env.DB.prepare(`INSERT INTO member_accounts
        (id, username, password_hash, password_salt, password_iterations, name, role, is_admin, active, failed_attempts, locked_until, created_at, updated_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, 0, 1, 0, '', ?, ?)`).bind(id, username, credentials.hash, credentials.salt, credentials.iterations, name, role, now, now),
      env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)')
        .bind('member_account', id, `注册项目账号：${role}`, name, now),
    ]);
  } catch (error) {
    console.error('Registration insert failed', error);
    return Response.json({ error: '这个登录名已经注册，请换一个' }, { status: 409 });
  }

  const cookie = await createSession(id);
  return Response.json(
    { user: { id, username, name, role, isAdmin: false } },
    { status: 201, headers: { 'Set-Cookie': cookie } },
  );
}

export async function POST(request: Request) {
  try {
    return await handleRegistration(request);
  } catch (error) {
    console.error('Registration failed unexpectedly', error);
    return Response.json({ error: '注册服务暂时不可用，请稍后重试' }, { status: 500 });
  }
}
