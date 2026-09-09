import { env } from 'cloudflare:workers';
import { requireAdmin } from '@/lib/auth';
import { initialScriptBreakdowns } from '@/lib/script-breakdown-data';

const seedVersion = 'script_breakdown_ep1_v3_v1';

async function ensureFirstEpisodeBreakdown() {
  const seeded = await env.DB.prepare('SELECT value FROM app_settings WHERE key = ?').bind(seedVersion).first<{ value: string }>();
  if (seeded) return;
  const now = new Date().toISOString();
  const statements = initialScriptBreakdowns.flatMap((analysis) => [
    env.DB.prepare(`INSERT OR IGNORE INTO script_analyses
      (id, episode, scene_no, scene_title, script_text, scene_summary, location, created_at, updated_at)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`)
      .bind(analysis.id, analysis.episode, analysis.sceneNo, analysis.sceneTitle, analysis.scriptText, analysis.sceneSummary, analysis.location, now, now),
    ...analysis.items.map((item) => env.DB.prepare(`INSERT OR IGNORE INTO script_analysis_items
      (id, analysis_id, category, name, detail, visual_brief, yoyo_approved, sort_order, updated_at)
      VALUES (?, ?, ?, ?, ?, ?, 0, ?, ?)`)
      .bind(item.id, item.analysisId, item.category, item.name, item.detail, item.visualBrief, item.sortOrder, now)),
  ]);
  await env.DB.batch([
    ...statements,
    env.DB.prepare('INSERT INTO app_settings (key, value, updated_at) VALUES (?, ?, ?)').bind(seedVersion, 'done', now),
  ]);
}

export async function GET() {
  try {
    await ensureFirstEpisodeBreakdown();
    const [analyses, items] = await Promise.all([
      env.DB.prepare(`SELECT id, episode, scene_no AS sceneNo, scene_title AS sceneTitle,
        script_text AS scriptText, scene_summary AS sceneSummary, location, created_at AS createdAt,
        updated_at AS updatedAt FROM script_analyses ORDER BY episode, scene_no`).all(),
      env.DB.prepare(`SELECT id, analysis_id AS analysisId, category, name, detail,
        visual_brief AS visualBrief, yoyo_approved AS yoyoApproved, producer_approved AS producerApproved, sort_order AS sortOrder,
        updated_at AS updatedAt FROM script_analysis_items ORDER BY analysis_id, sort_order`).all(),
    ]);
    return Response.json({ analyses: analyses.results, items: items.results, mode: 'manual' });
  } catch (error) {
    return Response.json({ analyses: [], items: [], mode: 'manual', error: error instanceof Error ? error.message : '读取失败' });
  }
}

export async function POST(request: Request) {
  const admin = await requireAdmin(request);
  if (!admin) return Response.json({ error: '只有Lipa可以分配当天工作' }, { status: 403 });
  const body = await request.json() as Partial<{ action: string; workDate: string; analysisIds: string[] }>;
  if (body.action !== 'assign' || !/^2026-\d{2}-\d{2}$/.test(body.workDate || '') || !Array.isArray(body.analysisIds) || !body.analysisIds.length) {
    return Response.json({ error: '请选择工作日期和至少一个场次' }, { status: 400 });
  }

  await ensureFirstEpisodeBreakdown();
  const uniqueIds = [...new Set(body.analysisIds)].slice(0, 30);
  const placeholders = uniqueIds.map(() => '?').join(',');
  const [analysisRows, itemRows] = await Promise.all([
    env.DB.prepare(`SELECT id, episode, scene_no AS sceneNo, scene_title AS sceneTitle FROM script_analyses WHERE id IN (${placeholders}) ORDER BY episode, scene_no`).bind(...uniqueIds).all<{ id: string; episode: string; sceneNo: number; sceneTitle: string }>(),
    env.DB.prepare(`SELECT analysis_id AS analysisId, COUNT(*) AS itemCount FROM script_analysis_items WHERE analysis_id IN (${placeholders}) GROUP BY analysis_id`).bind(...uniqueIds).all<{ analysisId: string; itemCount: number }>(),
  ]);
  if (!analysisRows.results.length) return Response.json({ error: '没有找到所选场次' }, { status: 404 });

  const itemCountByAnalysis = new Map(itemRows.results.map((row) => [row.analysisId, Number(row.itemCount)]));
  const now = new Date().toISOString();
  const workDate = body.workDate!;
  const tasks = analysisRows.results.flatMap((analysis, sceneIndex) => {
    const prefix = `daily-${workDate}-${analysis.id}`;
    const sceneLabel = `${analysis.episode}第${analysis.sceneNo}场`;
    const count = itemCountByAnalysis.get(analysis.id) || 1;
    return [
      task(`${prefix}-script`, workDate, analysis.episode, '剧本', `锁定${sceneLabel}剧本、动作与台词`, '编剧', 1, '12:00', '', '联合制片人／导演：Lipa', '12:15', `当天选定场次：${analysis.sceneTitle}；剧本若有改动，先同步本场拆解。`, sceneIndex * 10 + 1, now),
      task(`${prefix}-breakdown`, workDate, analysis.episode, '美术拆解', `按剧本总结${sceneLabel}需要生成的全部内容`, '主美', count, '14:00', `${prefix}-script`, '联合制片人／导演：Lipa', '14:15', `逐项核对场景、人物、服装、妆发、道具和美术图，共${count}项；叶总和Yoyo不审核剧本。`, sceneIndex * 10 + 2, now),
      task(`${prefix}-art`, workDate, analysis.episode, '美术出图', `生成${sceneLabel}场景、人物、服化道与道具图`, '主美', count, '18:00', `${prefix}-breakdown`, '联合制片人／导演：Lipa', '18:15', `按主美确认后的拆解清单逐项出图，共${count}项；出一项可先提报一项。`, sceneIndex * 10 + 3, now),
      task(`${prefix}-white`, workDate, analysis.episode, '白模', `依据主美图制作${sceneLabel}白模与调度预演`, 'AIGC抽卡师', 1, '21:00', `${prefix}-art`, '联合制片人／导演：Lipa', '21:15', '主美基础图可用后即启动；不等待叶总或Yoyo回复，未确认部分标为待核准。', sceneIndex * 10 + 4, now),
      task(`${prefix}-send`, workDate, analysis.episode, '提报审核', `检查${sceneLabel}主美图并发微信给Yoyo、叶总`, '联合制片人／导演：Lipa', count, '18:30', `${prefix}-art`, '红人（Yoyo）＋制片人（叶总）', '发出即进入审核', '只发送主美生成的视觉图，不发送剧本；收到一项发一项。', sceneIndex * 10 + 5, now),
      task(`${prefix}-yoyo`, workDate, analysis.episode, '美术图审核', `微信反馈${sceneLabel}主美视觉图`, '红人（Yoyo）', count, '微信待回复', `${prefix}-send`, '联合制片人／导演：Lipa', '收到回复后更新', 'Yoyo只审核主美图、不审核剧本；红色未勾代表尚未收到确认，不阻断剧本、美术和白模。', sceneIndex * 10 + 6, now),
      task(`${prefix}-producer`, workDate, analysis.episode, '美术图审核', `审核${sceneLabel}主美视觉图`, '制片人（叶总）', count, '20:00', `${prefix}-send`, '联合制片人／导演：Lipa', '20:15', '叶总只审核主美图，不审核剧本。', sceneIndex * 10 + 7, now),
    ];
  });

  await env.DB.batch(tasks.map((row) => env.DB.prepare(`INSERT OR IGNORE INTO production_items
    (id, work_date, episode, category, title, owner, reviewer, status, planned_qty, completed_qty, due_time, depends_on_id, handoff_to, handoff_deadline, note, sort_order, updated_at)
    VALUES (?, ?, ?, ?, ?, ?, ?, '未开始', ?, 0, ?, ?, ?, ?, ?, ?, ?)`)
    .bind(row.id, row.workDate, row.episode, row.category, row.title, row.owner, 'Yoyo', row.plannedQty, row.dueTime, row.dependsOnId, row.handoffTo, row.handoffDeadline, row.note, row.sortOrder, row.updatedAt)));

  return Response.json({ ok: true, assignedScenes: analysisRows.results.length, taskCount: tasks.length });
}

export async function PATCH(request: Request) {
  const admin = await requireAdmin(request);
  if (!admin) return Response.json({ error: '只有Lipa可以修改审核项' }, { status: 403 });
  const body = await request.json() as Partial<{ id: string; analysisId: string; scriptText: string; yoyoApproved: boolean; producerApproved: boolean; name: string; detail: string; visualBrief: string }>;
  if (body.analysisId && typeof body.scriptText === 'string') {
    const updatedAt = new Date().toISOString();
    await env.DB.batch([
      env.DB.prepare('UPDATE script_analyses SET script_text = ?, updated_at = ? WHERE id = ?').bind(body.scriptText.slice(0, 50000), updatedAt, body.analysisId),
      env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)').bind('script_analysis', body.analysisId, '更新生产手册剧本', 'Lipa', updatedAt),
    ]);
    return Response.json({ ok: true, analysisId: body.analysisId, scriptText: body.scriptText.slice(0, 50000), updatedAt });
  }
  if (!body.id) return Response.json({ error: '缺少审核项ID' }, { status: 400 });
  const current = await env.DB.prepare('SELECT name, detail, visual_brief AS visualBrief, yoyo_approved AS yoyoApproved, producer_approved AS producerApproved FROM script_analysis_items WHERE id = ?').bind(body.id).first<Record<string, string | number>>();
  if (!current) return Response.json({ error: '审核项不存在' }, { status: 404 });
  const updatedAt = new Date().toISOString();
  const updated = {
    name: typeof body.name === 'string' ? body.name.slice(0, 120) : String(current.name),
    detail: typeof body.detail === 'string' ? body.detail.slice(0, 500) : String(current.detail),
    visualBrief: typeof body.visualBrief === 'string' ? body.visualBrief.slice(0, 1000) : String(current.visualBrief),
    yoyoApproved: typeof body.yoyoApproved === 'boolean' ? body.yoyoApproved : Boolean(current.yoyoApproved),
    producerApproved: typeof body.producerApproved === 'boolean' ? body.producerApproved : Boolean(current.producerApproved),
  };
  await env.DB.batch([
    env.DB.prepare('UPDATE script_analysis_items SET name = ?, detail = ?, visual_brief = ?, yoyo_approved = ?, producer_approved = ?, updated_at = ? WHERE id = ?')
      .bind(updated.name, updated.detail, updated.visualBrief, updated.yoyoApproved ? 1 : 0, updated.producerApproved ? 1 : 0, updatedAt, body.id),
    env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)')
      .bind('script_analysis_item', body.id, typeof body.producerApproved === 'boolean' ? (updated.producerApproved ? '叶总已通过主美图' : '叶总未通过主美图') : (updated.yoyoApproved ? 'Yoyo已通过主美图' : 'Yoyo未通过主美图'), 'Lipa', updatedAt),
  ]);
  return Response.json({ ok: true, item: { ...updated, id: body.id, updatedAt } });
}

function task(id: string, workDate: string, episode: string, category: string, title: string, owner: string, plannedQty: number, dueTime: string, dependsOnId: string, handoffTo: string, handoffDeadline: string, note: string, sortOrder: number, updatedAt: string) {
  return { id, workDate, episode, category, title, owner, plannedQty, dueTime, dependsOnId, handoffTo, handoffDeadline, note, sortOrder, updatedAt };
}
