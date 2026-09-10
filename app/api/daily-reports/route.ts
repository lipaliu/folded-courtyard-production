import { env } from 'cloudflare:workers';
import { requireAdmin, requireMember } from '@/lib/auth';
import { nextProductionDay } from '@/lib/work-calendar';

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
};

type ReportSummary = {
  completed: TaskRow[];
  incomplete: TaskRow[];
  yoyoPending: TaskRow[];
  rollovers: Array<TaskRow & { fromDate: string; toDate: string }>;
};

async function allTasks() {
  const result = await env.DB.prepare(`SELECT id, work_date AS workDate, episode, category, title, owner, status,
    planned_qty AS plannedQty, completed_qty AS completedQty, depends_on_id AS dependsOnId,
    handoff_deadline AS handoffDeadline FROM production_items ORDER BY work_date, sort_order`).all<TaskRow>();
  return result.results;
}

function buildSummary(tasks: TaskRow[], workDate: string): ReportSummary {
  const today = tasks.filter((item) => item.workDate === workDate);
  const completed = today.filter((item) => item.status === '已通过');
  const yoyoPending = today.filter((item) => item.owner === '红人（Yoyo）' && item.status !== '已通过');
  const incomplete = today.filter((item) => item.owner !== '红人（Yoyo）' && item.status !== '已通过');
  const affectedIds = new Set(incomplete.map((item) => item.id));
  let changed = true;
  while (changed) {
    changed = false;
    for (const task of tasks) {
      if (task.status === '已通过' || task.owner === '红人（Yoyo）' || affectedIds.has(task.id)) continue;
      if (task.dependsOnId && affectedIds.has(task.dependsOnId)) {
        affectedIds.add(task.id);
        changed = true;
      }
    }
  }
  const rollovers = tasks
    .filter((item) => affectedIds.has(item.id))
    .map((item) => ({ ...item, fromDate: item.workDate, toDate: nextProductionDay(item.workDate) }));
  return { completed, incomplete, yoyoPending, rollovers };
}

function parseReport(row: Record<string, unknown>) {
  return {
    id: row.id,
    workDate: row.workDate,
    completedCount: Number(row.completedCount || 0),
    incompleteCount: Number(row.incompleteCount || 0),
    rolloverCount: Number(row.rolloverCount || 0),
    summary: JSON.parse(String(row.summaryJson || '{}')) as ReportSummary,
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
  if (!body.workDate || !/^2026-\d{2}-\d{2}$/.test(body.workDate)) return Response.json({ error: '工作日期不正确' }, { status: 400 });

  const existing = await env.DB.prepare(`SELECT id, work_date AS workDate, completed_count AS completedCount,
    incomplete_count AS incompleteCount, rollover_count AS rolloverCount, summary_json AS summaryJson,
    created_at AS createdAt, updated_at AS updatedAt FROM daily_reports WHERE work_date = ?`).bind(body.workDate).first<Record<string, unknown>>();
  if (existing) return Response.json({ report: parseReport(existing), alreadyFinalized: true });

  const tasks = await allTasks();
  const summary = buildSummary(tasks, body.workDate);
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
  await env.DB.batch([
    env.DB.prepare(`INSERT INTO daily_reports
      (id, work_date, completed_count, incomplete_count, rollover_count, summary_json, created_at, updated_at)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)`)
      .bind(reportId, body.workDate, summary.completed.length, summary.incomplete.length, summary.rollovers.length, JSON.stringify(summary), now, now),
    env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)')
      .bind('daily_report', reportId, `归档${body.workDate}生产日志并顺延${summary.rollovers.length}项`, 'Lipa', now),
  ]);
  return Response.json({ report: { id: reportId, workDate: body.workDate, completedCount: summary.completed.length, incompleteCount: summary.incomplete.length, rolloverCount: summary.rollovers.length, summary, createdAt: now, updatedAt: now } });
}
