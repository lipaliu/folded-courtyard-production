import { env } from 'cloudflare:workers';
import { requireAdmin, requireMember } from '@/lib/auth';
import { nextProductionDay } from '@/lib/work-calendar';
import { isLockedScheduleDate } from '@/lib/locked-schedule';

type TaskRow = {
  id: string;
  workDate: string;
  episode: string;
  category: string;
  title: string;
  owner: string;
  status: string;
  plannedQty: number;
  completedQty: number;
  dependsOnId: string;
  handoffDeadline: string;
  note: string;
};

type BatchRow = {
  id: string;
  startDate: string;
  endDate: string;
  production: string;
  prep: string;
  note: string;
};

type BatchRollover = BatchRow & {
  fromStartDate: string;
  fromEndDate: string;
  toStartDate: string;
  toEndDate: string;
};

type ReportSummary = {
  completed: TaskRow[];
  incomplete: TaskRow[];
  yoyoPending: TaskRow[];
  rollovers: Array<TaskRow & { fromDate: string; toDate: string }>;
  batchRollovers: BatchRollover[];
  projectedEnd: string;
};

async function allTasks() {
  const result = await env.DB.prepare(`SELECT id, work_date AS workDate, episode, category, title, owner, status,
    planned_qty AS plannedQty, completed_qty AS completedQty, depends_on_id AS dependsOnId,
    handoff_deadline AS handoffDeadline, note FROM production_items ORDER BY work_date, sort_order`).all<TaskRow>();
  return result.results;
}

async function allBatches() {
  const result = await env.DB.prepare(`SELECT id, start_date AS startDate, end_date AS endDate,
    production, prep, note FROM plan_batches ORDER BY sort_order`).all<BatchRow>();
  return result.results;
}

function isFixedCalendarBatch(batch: BatchRow) {
  return batch.id === 'kickoff-0914' || batch.production.includes('休息') || batch.production.includes('放假');
}

function isExternalReview(item: TaskRow) {
  return item.owner === '叶总／Yoyo' || item.owner === '红人（Yoyo）';
}

function buildSummary(tasks: TaskRow[], batches: BatchRow[], workDate: string): ReportSummary {
  const today = tasks.filter((item) => item.workDate === workDate);
  const completed = today.filter((item) => item.status === '已通过');
  const yoyoPending = today.filter((item) => isExternalReview(item) && item.status !== '已通过');
  const incomplete = today.filter((item) => !isExternalReview(item) && item.status !== '已通过');
  const shouldReflow = incomplete.length > 0;
  const rollovers = shouldReflow ? tasks
    .filter((item) => item.workDate >= workDate && !isLockedScheduleDate(item.workDate) && item.status !== '已通过' && !isExternalReview(item))
    .map((item) => ({ ...item, fromDate: item.workDate, toDate: nextProductionDay(item.workDate) }))
  : [];
  const batchRollovers = shouldReflow ? batches
    .filter((batch) => batch.endDate >= workDate && !isFixedCalendarBatch(batch))
    .map((batch) => {
      const toStartDate = batch.startDate < workDate ? batch.startDate : nextProductionDay(batch.startDate);
      const toEndDate = nextProductionDay(batch.endDate);
      return { ...batch, fromStartDate: batch.startDate, fromEndDate: batch.endDate, toStartDate, toEndDate };
    })
  : [];
  const projectedEnd = [
    ...tasks.map((item) => item.workDate),
    ...batches.map((batch) => batch.endDate),
    ...rollovers.map((item) => item.toDate),
    ...batchRollovers.map((batch) => batch.toEndDate),
  ].sort().at(-1) || workDate;
  return { completed, incomplete, yoyoPending, rollovers, batchRollovers, projectedEnd };
}

function parseReport(row: Record<string, unknown>) {
  const stored = JSON.parse(String(row.summaryJson || '{}')) as Partial<ReportSummary>;
  const summary: ReportSummary = {
    completed: stored.completed || [],
    incomplete: stored.incomplete || [],
    yoyoPending: stored.yoyoPending || [],
    rollovers: stored.rollovers || [],
    batchRollovers: stored.batchRollovers || [],
    projectedEnd: stored.projectedEnd || '',
  };
  return {
    id: row.id,
    workDate: row.workDate,
    completedCount: Number(row.completedCount || 0),
    incompleteCount: Number(row.incompleteCount || 0),
    rolloverCount: Number(row.rolloverCount || 0),
    summary,
    createdAt: row.createdAt,
    updatedAt: row.updatedAt,
  };
}

export async function GET(request: Request) {
  if (!await requireMember(request)) return Response.json({ error: '请先登录并注册岗位' }, { status: 401 });
  const result = await env.DB.prepare(`SELECT id, work_date AS workDate, completed_count AS completedCount,
    incomplete_count AS incompleteCount, rollover_count AS rolloverCount, summary_json AS summaryJson,
    created_at AS createdAt, updated_at AS updatedAt FROM daily_reports ORDER BY work_date DESC`).all<Record<string, unknown>>();
  return Response.json({ reports: result.results.map(parseReport) });
}

export async function POST(request: Request) {
  const admin = await requireAdmin(request);
  if (!admin) return Response.json({ error: '只有Lipa可以归档和顺延每日计划' }, { status: 403 });
  const body = await request.json() as { action?: 'preview' | 'finalize'; workDate?: string };
  if (!body.workDate || !/^\d{4}-\d{2}-\d{2}$/.test(body.workDate)) return Response.json({ error: '工作日期不正确' }, { status: 400 });

  const existing = await env.DB.prepare(`SELECT id, work_date AS workDate, completed_count AS completedCount,
    incomplete_count AS incompleteCount, rollover_count AS rolloverCount, summary_json AS summaryJson,
    created_at AS createdAt, updated_at AS updatedAt FROM daily_reports WHERE work_date = ?`).bind(body.workDate).first<Record<string, unknown>>();
  if (existing) return Response.json({ report: parseReport(existing), alreadyFinalized: true });

  const [tasks, batches] = await Promise.all([allTasks(), allBatches()]);
  const summary = buildSummary(tasks, batches, body.workDate);
  if (body.action === 'preview') return Response.json({ preview: summary });
  if (body.action !== 'finalize') return Response.json({ error: '操作不正确' }, { status: 400 });

  const now = new Date().toISOString();
  const reportId = `daily-report-${body.workDate}`;
  const statements = summary.rollovers.map((item) => {
    const deadline = item.handoffDeadline.startsWith(item.fromDate)
      ? `${item.toDate}${item.handoffDeadline.slice(item.fromDate.length)}`
      : item.handoffDeadline;
    return env.DB.prepare('UPDATE production_items SET work_date = ?, handoff_deadline = ?, updated_at = ? WHERE id = ?')
      .bind(item.toDate, deadline, now, item.id);
  });
  for (let index = 0; index < statements.length; index += 50) {
    await env.DB.batch(statements.slice(index, index + 50));
  }
  const batchStatements = summary.batchRollovers.map((batch) => env.DB.prepare(
    'UPDATE plan_batches SET start_date = ?, end_date = ?, note = ?, updated_at = ? WHERE id = ?',
  ).bind(
    batch.toStartDate,
    batch.toEndDate,
    `${batch.note}${batch.note ? '\n' : ''}[${body.workDate}自动重排] 因当日存在未完成项，整体顺延1个生产日`,
    now,
    batch.id,
  ));
  if (batchStatements.length) await env.DB.batch(batchStatements);
  await env.DB.batch([
    env.DB.prepare(`INSERT INTO daily_reports
      (id, work_date, completed_count, incomplete_count, rollover_count, summary_json, created_at, updated_at)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)`)
      .bind(reportId, body.workDate, summary.completed.length, summary.incomplete.length, summary.rollovers.length, JSON.stringify(summary), now, now),
    env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)')
      .bind('daily_report', reportId, `归档${body.workDate}生产日志；全计划重排${summary.rollovers.length}项，交付推至${summary.projectedEnd}`, 'Lipa', now),
  ]);
  return Response.json({ report: { id: reportId, workDate: body.workDate, completedCount: summary.completed.length, incompleteCount: summary.incomplete.length, rolloverCount: summary.rollovers.length, summary, createdAt: now, updatedAt: now } });
}
