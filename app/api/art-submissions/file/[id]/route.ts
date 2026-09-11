import { env } from 'cloudflare:workers';
import { requireMember } from '@/lib/auth';

export async function GET(request: Request, context: { params: Promise<{ id: string }> }) {
  const user = await requireMember(request);
  if (!user) return Response.json({ error: '请先登录' }, { status: 401 });
  const { id } = await context.params;
  const file = await env.DB.prepare(`SELECT object_key AS objectKey, file_name AS fileName, content_type AS contentType, file_data AS fileData
    FROM art_submission_files WHERE id = ?`).bind(id).first<{ objectKey: string; fileName: string; contentType: string; fileData: number[] | ArrayBuffer | ArrayBufferView | null }>();
  if (!file) return Response.json({ error: '图片不存在' }, { status: 404 });
  if (file.objectKey.startsWith('static:')) {
    const assetPath = file.objectKey.slice('static:'.length);
    const assetUrl = new URL(assetPath, request.url);
    return Response.redirect(assetUrl, 302);
  }
  if (file.objectKey.startsWith('d1:')) {
    if (!file.fileData) return Response.json({ error: '图片文件不存在' }, { status: 404 });
    return new Response(asImageBytes(file.fileData), { headers: imageHeaders(file.contentType, file.fileName) });
  }
  const artAssets = (env as unknown as { ART_ASSETS?: R2Bucket }).ART_ASSETS;
  if (!artAssets) return Response.json({ error: '图片存储尚未配置' }, { status: 503 });
  const object = await artAssets.get(file.objectKey);
  if (!object) return Response.json({ error: '图片文件不存在' }, { status: 404 });
  const headers = new Headers();
  object.writeHttpMetadata(headers);
  headers.set('Content-Type', file.contentType);
  headers.set('Cache-Control', 'private, max-age=3600');
  headers.set('Content-Disposition', `inline; filename*=UTF-8''${encodeURIComponent(file.fileName)}`);
  headers.set('X-Content-Type-Options', 'nosniff');
  return new Response(object.body, { headers });
}

function asImageBytes(value: number[] | ArrayBuffer | ArrayBufferView): ArrayBuffer {
  const bytes = Array.isArray(value)
    ? Uint8Array.from(value)
    : value instanceof ArrayBuffer
      ? new Uint8Array(value)
      : new Uint8Array(value.buffer, value.byteOffset, value.byteLength);
  const copy = new Uint8Array(bytes.byteLength);
  copy.set(bytes);
  return copy.buffer;
}

function imageHeaders(contentType: string, fileName: string) {
  const headers = new Headers();
  headers.set('Content-Type', contentType);
  headers.set('Cache-Control', 'private, max-age=3600');
  headers.set('Content-Disposition', `inline; filename*=UTF-8''${encodeURIComponent(fileName)}`);
  headers.set('X-Content-Type-Options', 'nosniff');
  return headers;
}
