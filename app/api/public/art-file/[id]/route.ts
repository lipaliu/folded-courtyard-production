import { env } from 'cloudflare:workers';

export async function GET(request: Request, context: { params: Promise<{ id: string }> }) {
  const { id } = await context.params;
  const file = await env.DB.prepare(`SELECT f.object_key AS objectKey, f.file_name AS fileName,
    f.content_type AS contentType, f.file_data AS fileData
    FROM art_submission_files f
    JOIN script_analysis_items i ON i.id = f.item_id
    JOIN script_analyses a ON a.id = i.analysis_id
    WHERE f.id = ? AND i.is_active = 1 AND a.is_active = 1`).bind(id)
    .first<{ objectKey: string; fileName: string; contentType: string; fileData: number[] | ArrayBuffer | ArrayBufferView | null }>();
  if (!file) return Response.json({ error: '图片不存在' }, { status: 404 });
  if (file.objectKey.startsWith('static:')) return Response.redirect(new URL(file.objectKey.slice(7), request.url), 302);
  if (file.objectKey.startsWith('d1:')) {
    if (!file.fileData) return Response.json({ error: '图片文件不存在' }, { status: 404 });
    return new Response(asImageBytes(file.fileData), { headers: imageHeaders(file.contentType, file.fileName) });
  }
  const bucket = (env as unknown as { ART_ASSETS?: R2Bucket }).ART_ASSETS;
  if (!bucket) return Response.json({ error: '图片存储尚未配置' }, { status: 503 });
  const object = await bucket.get(file.objectKey);
  if (!object) return Response.json({ error: '图片文件不存在' }, { status: 404 });
  const headers = imageHeaders(file.contentType, file.fileName);
  object.writeHttpMetadata(headers);
  return new Response(object.body, { headers });
}

function asImageBytes(value: number[] | ArrayBuffer | ArrayBufferView): ArrayBuffer {
  const bytes = Array.isArray(value) ? Uint8Array.from(value) : value instanceof ArrayBuffer
    ? new Uint8Array(value) : new Uint8Array(value.buffer, value.byteOffset, value.byteLength);
  const copy = new Uint8Array(bytes.byteLength); copy.set(bytes); return copy.buffer;
}

function imageHeaders(contentType: string, fileName: string) {
  const headers = new Headers();
  headers.set('Content-Type', contentType);
  headers.set('Cache-Control', 'public, max-age=3600');
  headers.set('Content-Disposition', `inline; filename*=UTF-8''${encodeURIComponent(fileName)}`);
  headers.set('X-Content-Type-Options', 'nosniff');
  return headers;
}
