import { env } from 'cloudflare:workers';
import { requireMember } from '@/lib/auth';

export async function GET(request: Request) {
  if (!await requireMember(request)) return Response.json({ error: '请先登录' }, { status: 401 });
  try {
    const rows = await env.DB.prepare(`SELECT id, episode, version_no AS versionNo,
      source_text AS sourceText, finalized_at AS finalizedAt, finalized_by AS finalizedBy
      FROM script_versions WHERE is_final = 1 ORDER BY episode, version_no DESC`).all();
    return Response.json({ scripts: rows.results }, { headers: { 'Cache-Control': 'private, no-store' } });
  } catch {
    return Response.json({ error: '读取定稿剧本失败，请重试' }, { status: 500 });
  }
}
