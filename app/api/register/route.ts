import { env } from 'cloudflare:workers';
import { claimOrGetSiteUser, getRequestIdentity, TEAM_ROLES } from '@/lib/auth';

export async function POST(request: Request) {
  const identity = getRequestIdentity(request);
  if (!identity.id) return Response.json({ error: '请先使用ChatGPT登录' }, { status: 401 });
  const current = await claimOrGetSiteUser(request);
  if (current?.isAdmin) return Response.json({ user: current });
  const body = await request.json() as { name?: string; phone?: string; role?: string };
  const name = (body.name || '').trim().slice(0, 40);
  const phone = (body.phone || '').trim().replace(/\s+/g, '').slice(0, 24);
  const role = (body.role || '').trim();
  if (name.length < 2) return Response.json({ error: '请填写姓名' }, { status: 400 });
  if (!/^[+\d][\d-]{5,23}$/.test(phone)) return Response.json({ error: '请填写正确的手机号' }, { status: 400 });
  if (!TEAM_ROLES.includes(role as (typeof TEAM_ROLES)[number])) return Response.json({ error: '请选择岗位' }, { status: 400 });
  const phoneOwner = await env.DB.prepare('SELECT user_id AS userId FROM team_members WHERE phone = ? AND user_id != ?').bind(phone, identity.id).first<{ userId: string }>();
  if (phoneOwner) return Response.json({ error: '这个手机号已经注册' }, { status: 409 });
  const now = new Date().toISOString();
  await env.DB.batch([
    env.DB.prepare(`INSERT INTO team_members (user_id, email, name, phone, role, active, created_at, updated_at)
      VALUES (?, ?, ?, ?, ?, 1, ?, ?)
      ON CONFLICT(user_id) DO UPDATE SET email = excluded.email, name = excluded.name, phone = excluded.phone,
        role = excluded.role, active = 1, updated_at = excluded.updated_at`)
      .bind(identity.id, identity.email, name, phone, role, now, now),
    env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)')
      .bind('team_member', identity.id, `注册岗位：${role}`, name, now),
  ]);
  return Response.json({ user: { ...identity, name, phone, role, isAdmin: false } });
}
