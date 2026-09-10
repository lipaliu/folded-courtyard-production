import { env } from 'cloudflare:workers';
import { requireMember } from '@/lib/auth';

export async function GET(request: Request, context: { params: Promise<{ id: string }> }) {
  const user = await requireMember(request);
  if (!user) return Response.json({ error: '请先登录' }, { status: 401 });
  const { id } = await context.params;
  const file = await env.DB.prepare(`SELECT object_key AS objectKey, file_name AS fileName, content_type AS contentType
    FROM art_submission_files WHERE id = ?`).bind(id).first<{ objectKey: string; fileName: string; contentType: string }>();
  if (!file) return Response.json({ error: '图片不存在' }, { status: 404 });
  const object = await env.ART_ASSETS.get(file.objectKey);
  if (!object) return Response.json({ error: '图片文件不存在' }, { status: 404 });
  const headers = new Headers();
  object.writeHttpMetadata(headers);
  headers.set('Content-Type', file.contentType);
  headers.set('Cache-Control', 'private, max-age=3600');
  headers.set('Content-Disposition', `inline; filename*=UTF-8''${encodeURIComponent(file.fileName)}`);
  headers.set('X-Content-Type-Options', 'nosniff');
  return new Response(object.body, { headers });
}
