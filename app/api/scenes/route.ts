import { env } from 'cloudflare:workers';
import { initialScenes, STATUSES } from '@/lib/plan-data';
import { requireAdmin } from '@/lib/auth';

const allowedFields = new Set(['scriptStatus', 'characterStatus', 'locationStatus', 'wardrobeStatus', 'whiteModelStatus', 'shotStatus', 'roughCutStatus', 'finalStatus']);
const columns: Record<string, string> = {
  scriptStatus: 'script_status', characterStatus: 'character_status', locationStatus: 'location_status',
  wardrobeStatus: 'wardrobe_status', whiteModelStatus: 'white_model_status', shotStatus: 'shot_status',
  roughCutStatus: 'rough_cut_status', finalStatus: 'final_status',
};

export async function GET() {
  try {
    const count = await env.DB.prepare('SELECT COUNT(*) AS count FROM scenes').first<{ count: number }>();
    if (!count?.count) {
      await env.DB.batch(initialScenes.map((row) => env.DB.prepare(`
        INSERT INTO scenes
        (id, episode, scene_no, title, location, owner, script_status, character_status, location_status, wardrobe_status, white_model_status, shot_status, rough_cut_status, final_status, updated_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      `).bind(row.id, row.episode, row.sceneNo, row.title, row.location, row.owner, row.scriptStatus, row.characterStatus, row.locationStatus, row.wardrobeStatus, row.whiteModelStatus, row.shotStatus, row.roughCutStatus, row.finalStatus, row.updatedAt)));
    }
    const result = await env.DB.prepare(`
      SELECT id, episode, scene_no AS sceneNo, title, location, owner,
             script_status AS scriptStatus, character_status AS characterStatus,
             location_status AS locationStatus, wardrobe_status AS wardrobeStatus,
             white_model_status AS whiteModelStatus, shot_status AS shotStatus,
             rough_cut_status AS roughCutStatus, final_status AS finalStatus, updated_at AS updatedAt
      FROM scenes ORDER BY episode, scene_no
    `).all();
    return Response.json({ scenes: result.results });
  } catch (error) {
    return Response.json({ scenes: initialScenes, localFallback: true, error: error instanceof Error ? error.message : '读取失败' });
  }
}

export async function PATCH(request: Request) {
  const admin = await requireAdmin(request);
  if (!admin) return Response.json({ error: '只有Lipa可以修改场次' }, { status: 403 });
  const body = await request.json() as { id?: string; field?: string; status?: string; operator?: string };
  if (!body.id || !body.field || !allowedFields.has(body.field) || !body.status || !STATUSES.includes(body.status as (typeof STATUSES)[number])) {
    return Response.json({ error: '参数不正确' }, { status: 400 });
  }
  const updatedAt = new Date().toISOString();
  try {
    const sql = `UPDATE scenes SET ${columns[body.field]} = ?, updated_at = ? WHERE id = ?`;
    await env.DB.batch([
      env.DB.prepare(sql).bind(body.status, updatedAt, body.id),
      env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)').bind('scene', body.id, `${body.field}更新为${body.status}`, body.operator || 'Lipa', updatedAt),
    ]);
    return Response.json({ ok: true, id: body.id, field: body.field, status: body.status, updatedAt });
  } catch (error) {
    return Response.json({ error: error instanceof Error ? error.message : '保存失败' }, { status: 500 });
  }
}
