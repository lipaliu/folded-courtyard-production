import { env } from 'cloudflare:workers';
import { requireMember } from '@/lib/auth';

export async function GET(request: Request) {
  const user = await requireMember(request);
  if (!user) return Response.json({ error: '请先登录' }, { status: 401 });
  const rows = await env.DB.prepare('SELECT fav.file_id AS fileId FROM art_file_favorites fav JOIN art_submission_files f ON f.id=fav.file_id WHERE fav.account_id=?').bind(user.id).all<{ fileId: string }>();
  return Response.json({ fileIds: rows.results.map(row => row.fileId) }, { headers: { 'Cache-Control': 'no-store' } });
}

export async function PATCH(request: Request) {
  const user = await requireMember(request);
  if (!user) return Response.json({ error: '请先登录' }, { status: 401 });
  const { fileId, favorite } = await request.json() as { fileId?: string; favorite?: boolean };
  if (typeof fileId !== 'string' || !fileId || typeof favorite !== 'boolean') return Response.json({ error: '缺少图片或收藏状态' }, { status: 400 });
  const file = await env.DB.prepare('SELECT id FROM art_submission_files WHERE id=?').bind(fileId).first();
  if (!file) return Response.json({ error: '图片不存在' }, { status: 404 });
  if (favorite) await env.DB.prepare('INSERT OR IGNORE INTO art_file_favorites (account_id,file_id,created_at) VALUES (?,?,?)').bind(user.id, fileId, new Date().toISOString()).run();
  else await env.DB.prepare('DELETE FROM art_file_favorites WHERE account_id=? AND file_id=?').bind(user.id, fileId).run();
  return Response.json({ fileId, favorite });
}
