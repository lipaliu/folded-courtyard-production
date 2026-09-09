import { env } from 'cloudflare:workers';
import { requireAdmin } from '@/lib/auth';
import { initialScriptBreakdowns } from '@/lib/script-breakdown-data';
import { parseScriptDocument } from '@/lib/script-import';

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
  const body = await request.json() as Partial<{ action: string; workDate: string; analysisIds: string[]; episode: string; sceneNo: number; sceneTitle: string; location: string; scriptText: string; fileName: string; text: string }>;

  if (body.action === 'importScript') {
    if (!/^2026-\d{2}-\d{2}$/.test(body.workDate || '') || !body.text?.trim()) return Response.json({ error: '没有读取到剧本文字' }, { status: 400 });
    await ensureFirstEpisodeBreakdown();
    const scenes = parseScriptDocument(body.text.slice(0, 300000), body.fileName || '');
    if (!scenes.length) return Response.json({ error: '没有识别到场次。请检查剧本是否有“1. 地点 时间 内/外”这样的场头。' }, { status: 400 });
    const now = new Date().toISOString();
    const analysisIds: string[] = [];
    const statements = [];
    for (const scene of scenes.slice(0, 40)) {
      const existing = await env.DB.prepare('SELECT id FROM script_analyses WHERE episode = ? AND scene_no = ?').bind(scene.episode, scene.sceneNo).first<{ id: string }>();
      const analysisId = existing?.id || `import-${crypto.randomUUID()}`;
      analysisIds.push(analysisId);
      if (existing) {
        statements.push(env.DB.prepare('UPDATE script_analyses SET scene_title = ?, script_text = ?, scene_summary = ?, location = ?, updated_at = ? WHERE id = ?').bind(scene.sceneTitle, scene.scriptText, scene.sceneSummary, scene.location, now, analysisId));
        statements.push(env.DB.prepare('DELETE FROM script_analysis_items WHERE analysis_id = ?').bind(analysisId));
      } else {
        statements.push(env.DB.prepare(`INSERT INTO script_analyses
          (id, episode, scene_no, scene_title, script_text, scene_summary, location, created_at, updated_at)
          VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`)
          .bind(analysisId, scene.episode, scene.sceneNo, scene.sceneTitle, scene.scriptText, scene.sceneSummary, scene.location, now, now));
      }
      scene.items.forEach((item, index) => statements.push(env.DB.prepare(`INSERT INTO script_analysis_items
        (id, analysis_id, category, name, detail, visual_brief, yoyo_approved, producer_approved, sort_order, updated_at)
        VALUES (?, ?, ?, ?, ?, ?, 0, 0, ?, ?)`)
        .bind(`${analysisId}-auto-${index + 1}`, analysisId, item.category, item.name, item.detail, item.visualBrief, index + 1, now)));
      statements.push(env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)').bind('script_analysis', analysisId, `导入${body.fileName || '剧本文件'}并自动拆解主美工作`, 'Lipa', now));
    }
    await env.DB.batch(statements);
    return Response.json({ ok: true, analysisIds, sceneCount: analysisIds.length, itemCount: scenes.slice(0, 40).reduce((sum, scene) => sum + scene.items.length, 0) });
  }

  if (body.action === 'saveScene') {
    if (!/^2026-\d{2}-\d{2}$/.test(body.workDate || '') || !body.episode?.trim() || !Number.isInteger(Number(body.sceneNo)) || Number(body.sceneNo) < 1 || !body.sceneTitle?.trim() || !body.scriptText?.trim()) {
      return Response.json({ error: '请填写日期、集数、场次、场名和完整剧本' }, { status: 400 });
    }
    await ensureFirstEpisodeBreakdown();
    const episode = body.episode.trim().slice(0, 40);
    const sceneNo = Number(body.sceneNo);
    const sceneTitle = body.sceneTitle.trim().slice(0, 120);
    const location = (body.location || '').trim().slice(0, 160);
    const scriptText = body.scriptText.trim().slice(0, 50000);
    const existing = await env.DB.prepare('SELECT id FROM script_analyses WHERE episode = ? AND scene_no = ?').bind(episode, sceneNo).first<{ id: string }>();
    const analysisId = existing?.id || `manual-${crypto.randomUUID()}`;
    const now = new Date().toISOString();
    if (existing) {
      await env.DB.batch([
        env.DB.prepare('UPDATE script_analyses SET scene_title = ?, script_text = ?, location = ?, updated_at = ? WHERE id = ?').bind(sceneTitle, scriptText, location, now, analysisId),
        env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)').bind('script_analysis', analysisId, `更新${body.workDate}当天工作剧本`, 'Lipa', now),
      ]);
      return Response.json({ ok: true, analysisId, created: false });
    }

    const starterItems = [
      { category: '人物', name: '人物造型', detail: '根据本场剧本确定出场人物、身份状态、妆发与造型连续性。', visualBrief: '人物定妆图、发型与妆面、表情状态及必要的正侧面参考。' },
      { category: '服装', name: '本场服装', detail: '根据时间、地点、人物状态和前后场连续性确定本场穿搭。', visualBrief: '完整穿搭图，标清内外层、鞋袜、配饰、颜色和材质。' },
      { category: '道具', name: '本场道具', detail: '从人物动作、剧情信息和互动关系中提取必须出现或使用的道具。', visualBrief: '关键道具设定图、尺寸与材质参考；需要手持或互动的要补使用状态。' },
      { category: '场景', name: '本场场景图', detail: '根据剧本中的内外景、日夜、空间关系和动作调度确定场景。', visualBrief: '场景全景、关键机位方向、出入口和主要陈设；足够支持后续白模调度。' },
    ];
    await env.DB.batch([
      env.DB.prepare(`INSERT INTO script_analyses
        (id, episode, scene_no, scene_title, script_text, scene_summary, location, created_at, updated_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`)
        .bind(analysisId, episode, sceneNo, sceneTitle, scriptText, '今日工作剧本；待Lipa按剧本继续细化主美出图清单。', location, now, now),
      ...starterItems.map((item, index) => env.DB.prepare(`INSERT INTO script_analysis_items
        (id, analysis_id, category, name, detail, visual_brief, yoyo_approved, producer_approved, sort_order, updated_at)
        VALUES (?, ?, ?, ?, ?, ?, 0, 0, ?, ?)`)
        .bind(`${analysisId}-${index + 1}`, analysisId, item.category, item.name, item.detail, item.visualBrief, index + 1, now)),
      env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)').bind('script_analysis', analysisId, `新增${body.workDate}当天工作剧本并建立主美四类工作`, 'Lipa', now),
    ]);
    return Response.json({ ok: true, analysisId, created: true });
  }

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

  await env.DB.batch(tasks.map((row) => env.DB.prepare(`INSERT INTO production_items
    (id, work_date, episode, category, title, owner, reviewer, status, planned_qty, completed_qty, due_time, depends_on_id, handoff_to, handoff_deadline, note, sort_order, updated_at)
    VALUES (?, ?, ?, ?, ?, ?, ?, '未开始', ?, 0, ?, ?, ?, ?, ?, ?, ?)
    ON CONFLICT(id) DO UPDATE SET episode = excluded.episode, category = excluded.category, title = excluded.title,
      owner = excluded.owner, reviewer = excluded.reviewer, planned_qty = excluded.planned_qty, due_time = excluded.due_time,
      depends_on_id = excluded.depends_on_id, handoff_to = excluded.handoff_to, handoff_deadline = excluded.handoff_deadline,
      note = excluded.note, sort_order = excluded.sort_order, updated_at = excluded.updated_at`)
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
