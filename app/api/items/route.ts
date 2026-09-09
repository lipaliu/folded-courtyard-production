import { env } from 'cloudflare:workers';
import { initialItems, STATUSES } from '@/lib/plan-data';
import { requireAdmin } from '@/lib/auth';

export async function GET() {
  try {
    const count = await env.DB.prepare('SELECT COUNT(*) AS count FROM production_items').first<{ count: number }>();
    if (!count?.count) {
      await env.DB.batch(initialItems.map((row) => env.DB.prepare(`
        INSERT INTO production_items
        (id, work_date, episode, category, title, owner, reviewer, status, planned_qty, completed_qty, due_time, note, sort_order, updated_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      `).bind(row.id, row.workDate, row.episode, row.category, row.title, row.owner, row.reviewer, row.status, row.plannedQty, row.completedQty, row.dueTime, row.note, row.sortOrder, row.updatedAt)));
    }
    const result = await env.DB.prepare(`
      SELECT id, work_date AS workDate, episode, category, title, owner, reviewer, status,
             planned_qty AS plannedQty, completed_qty AS completedQty, due_time AS dueTime,
             note, sort_order AS sortOrder, updated_at AS updatedAt
      FROM production_items ORDER BY work_date, sort_order
    `).all();
    return Response.json({ items: result.results });
  } catch (error) {
    return Response.json({ items: initialItems, localFallback: true, error: error instanceof Error ? error.message : '读取失败' });
  }
}

export async function PATCH(request: Request) {
  const admin = await requireAdmin(request);
  if (!admin) return Response.json({ error: '只有Lipa可以修改任务' }, { status: 403 });
  const body = await request.json() as Partial<{
    id: string; workDate: string; episode: string; category: string; title: string; owner: string;
    reviewer: string; status: string; plannedQty: number; completedQty: number; dueTime: string; note: string; operator: string;
  }>;
  if (!body.id || (body.status && !STATUSES.includes(body.status as (typeof STATUSES)[number]))) {
    return Response.json({ error: '参数不正确' }, { status: 400 });
  }
  const updatedAt = new Date().toISOString();
  try {
    const existing = await env.DB.prepare(`
      SELECT work_date AS workDate, episode, category, title, owner, reviewer, status,
             planned_qty AS plannedQty, completed_qty AS completedQty, due_time AS dueTime, note
      FROM production_items WHERE id = ?
    `).bind(body.id).first<Record<string, string | number>>();
    if (!existing) return Response.json({ error: '任务不存在' }, { status: 404 });
    const updated = {
      workDate: body.workDate ?? String(existing.workDate), episode: body.episode ?? String(existing.episode),
      category: body.category ?? String(existing.category), title: body.title ?? String(existing.title),
      owner: body.owner ?? String(existing.owner), reviewer: body.reviewer ?? String(existing.reviewer),
      status: body.status ?? String(existing.status),
      plannedQty: Number.isFinite(body.plannedQty) ? Math.max(0, Number(body.plannedQty)) : Number(existing.plannedQty),
      completedQty: Number.isFinite(body.completedQty) ? Math.max(0, Number(body.completedQty)) : Number(existing.completedQty),
      dueTime: body.dueTime ?? String(existing.dueTime), note: typeof body.note === 'string' ? body.note.slice(0, 500) : String(existing.note),
    };
    await env.DB.batch([
      env.DB.prepare(`
        UPDATE production_items SET work_date = ?, episode = ?, category = ?, title = ?, owner = ?, reviewer = ?,
          status = ?, planned_qty = ?, completed_qty = ?, due_time = ?, note = ?, updated_at = ? WHERE id = ?
      `).bind(updated.workDate, updated.episode, updated.category, updated.title, updated.owner, updated.reviewer, updated.status, updated.plannedQty, updated.completedQty, updated.dueTime, updated.note, updatedAt, body.id),
      env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)').bind('task', body.id, `任务更新：${updated.status}`, body.operator || 'Lipa', updatedAt),
    ]);
    return Response.json({ ok: true, item: { ...updated, id: body.id, updatedAt } });
  } catch (error) {
    return Response.json({ error: error instanceof Error ? error.message : '保存失败' }, { status: 500 });
  }
}

export async function POST(request: Request) {
  const admin = await requireAdmin(request);
  if (!admin) return Response.json({ error: '只有Lipa可以新增任务' }, { status: 403 });
  const body = await request.json() as Partial<{ workDate: string; episode: string; category: string; title: string; owner: string; reviewer: string; plannedQty: number; dueTime: string; note: string }>;
  if (!body.workDate || !body.title || !body.owner) return Response.json({ error: '日期、任务和负责人不能为空' }, { status: 400 });
  const row = {
    id: crypto.randomUUID(), workDate: body.workDate, episode: body.episode || '全片', category: body.category || '统筹',
    title: body.title, owner: body.owner, reviewer: body.reviewer || 'Yoyo', status: '未开始',
    plannedQty: Math.max(0, Number(body.plannedQty || 1)), completedQty: 0, dueTime: body.dueTime || '18:00',
    note: body.note || '', sortOrder: Date.now(), updatedAt: new Date().toISOString(),
  };
  try {
    await env.DB.prepare(`
      INSERT INTO production_items
      (id, work_date, episode, category, title, owner, reviewer, status, planned_qty, completed_qty, due_time, note, sort_order, updated_at)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `).bind(row.id, row.workDate, row.episode, row.category, row.title, row.owner, row.reviewer, row.status, row.plannedQty, row.completedQty, row.dueTime, row.note, row.sortOrder, row.updatedAt).run();
    return Response.json({ ok: true, item: row });
  } catch (error) {
    return Response.json({ error: error instanceof Error ? error.message : '新建失败' }, { status: 500 });
  }
}

export async function DELETE(request: Request) {
  const admin = await requireAdmin(request);
  if (!admin) return Response.json({ error: '只有Lipa可以删除任务' }, { status: 403 });
  const { id } = await request.json() as { id?: string };
  if (!id) return Response.json({ error: '缺少任务ID' }, { status: 400 });
  const now = new Date().toISOString();
  await env.DB.batch([
    env.DB.prepare('DELETE FROM production_items WHERE id = ?').bind(id),
    env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)').bind('task', id, '删除任务', 'Lipa', now),
  ]);
  return Response.json({ ok: true });
}
