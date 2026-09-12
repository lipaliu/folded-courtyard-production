import { env } from 'cloudflare:workers';
import { initialBatches } from '@/lib/plan-data';
import { requireAdmin, requireMember } from '@/lib/auth';

export async function GET(request: Request) {
  if (!await requireMember(request)) return Response.json({ error: '请先登录并注册岗位' }, { status: 401 });
  try {
    const count = await env.DB.prepare('SELECT COUNT(*) AS count FROM plan_batches').first<{ count: number }>();
    if (!count?.count) {
      await env.DB.batch(initialBatches.map((row) => env.DB.prepare(`
        INSERT INTO plan_batches (id, start_date, end_date, production, prep, note, sort_order, updated_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
      `).bind(row.id, row.startDate, row.endDate, row.production, row.prep, row.note, row.sortOrder, row.updatedAt)));
    }
    const workflowVersion = await env.DB.prepare("SELECT value FROM app_settings WHERE key = 'workflow_plan_v3'").first<{ value: string }>();
    if (!workflowVersion) {
      await env.DB.batch([
        ...initialBatches.map((row) => env.DB.prepare(`
          INSERT OR REPLACE INTO plan_batches (id, start_date, end_date, production, prep, note, sort_order, updated_at)
          VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        `).bind(row.id, row.startDate, row.endDate, row.production, row.prep, row.note, row.sortOrder, row.updatedAt)),
        env.DB.prepare("INSERT INTO app_settings (key, value, updated_at) VALUES ('workflow_plan_v3', 'done', ?)").bind(new Date().toISOString()),
      ]);
    }
    const calendarVersion = await env.DB.prepare("SELECT value FROM app_settings WHERE key = 'workflow_plan_calendar_v1'").first<{ value: string }>();
    if (!calendarVersion) {
      const updatedAt = new Date().toISOString();
      await env.DB.batch([
        env.DB.prepare('DELETE FROM plan_batches'),
        ...initialBatches.map((row) => env.DB.prepare(`INSERT INTO plan_batches
          (id, start_date, end_date, production, prep, note, sort_order, updated_at)
          VALUES (?, ?, ?, ?, ?, ?, ?, ?)`)
          .bind(row.id, row.startDate, row.endDate, row.production, row.prep, row.note, row.sortOrder, updatedAt)),
        env.DB.prepare("INSERT INTO app_settings (key, value, updated_at) VALUES ('workflow_plan_calendar_v1', 'done', ?)").bind(updatedAt),
      ]);
    }
    const lockedScheduleVersion = await env.DB.prepare("SELECT value FROM app_settings WHERE key = 'workflow_locked_plan_0912_0914_v1'").first<{ value: string }>();
    if (!lockedScheduleVersion) {
      const updatedAt = new Date().toISOString();
      await env.DB.batch([
        env.DB.prepare('DELETE FROM plan_batches'),
        ...initialBatches.map((row) => env.DB.prepare(`INSERT INTO plan_batches
          (id, start_date, end_date, production, prep, note, sort_order, updated_at)
          VALUES (?, ?, ?, ?, ?, ?, ?, ?)`)
          .bind(row.id, row.startDate, row.endDate, row.production, row.prep, row.note, row.sortOrder, updatedAt)),
        env.DB.prepare("INSERT INTO app_settings (key, value, updated_at) VALUES ('workflow_locked_plan_0912_0914_v1', 'done', ?)").bind(updatedAt),
      ]);
    }
    const result = await env.DB.prepare(`
      SELECT id, start_date AS startDate, end_date AS endDate, production, prep, note,
             sort_order AS sortOrder, updated_at AS updatedAt
      FROM plan_batches ORDER BY sort_order
    `).all();
    return Response.json({ batches: result.results });
  } catch (error) {
    return Response.json({ batches: initialBatches, localFallback: true, error: error instanceof Error ? error.message : '读取失败' });
  }
}

export async function PATCH(request: Request) {
  const admin = await requireAdmin(request);
  if (!admin) return Response.json({ error: '只有Lipa可以修改大计划' }, { status: 403 });
  const body = await request.json() as Partial<{ id: string; startDate: string; endDate: string; production: string; prep: string; note: string }>;
  if (!body.id || !body.startDate || !body.endDate || !body.production || !body.prep) return Response.json({ error: '大计划信息不完整' }, { status: 400 });
  if (body.id === 'priority-0912-0914') return Response.json({ error: '9月12日至14日为锁定排期，不能修改' }, { status: 409 });
  const updatedAt = new Date().toISOString();
  try {
    await env.DB.prepare('UPDATE plan_batches SET start_date = ?, end_date = ?, production = ?, prep = ?, note = ?, updated_at = ? WHERE id = ?')
      .bind(body.startDate, body.endDate, body.production, body.prep, body.note || '', updatedAt, body.id).run();
    return Response.json({ ok: true, batch: { ...body, updatedAt } });
  } catch (error) {
    return Response.json({ error: error instanceof Error ? error.message : '保存失败' }, { status: 500 });
  }
}
