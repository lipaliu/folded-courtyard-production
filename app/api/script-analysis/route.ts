import { env } from 'cloudflare:workers';
import { requireAdmin, requireMember } from '@/lib/auth';
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

export async function GET(request: Request) {
  if (!await requireMember(request)) return Response.json({ error: '请先登录并注册岗位' }, { status: 401 });
  try {
    await ensureFirstEpisodeBreakdown();
    const now = new Date().toISOString();
    await env.DB.prepare(`INSERT OR IGNORE INTO art_submission_details
      (item_id, assigned_to, due_at, handoff_to, done_definition, status, submission_note, review_note, submitted_at, reviewed_at, updated_at)
      SELECT id, '主美小金', '', 'Lipa', visual_brief, '待上传', '', '', '', '', ? FROM script_analysis_items`).bind(now).run();
    const [analyses, items, versions, assignments] = await Promise.all([
      env.DB.prepare(`SELECT id, episode, scene_no AS sceneNo, scene_title AS sceneTitle,
        script_text AS scriptText, scene_summary AS sceneSummary, location, created_at AS createdAt,
        updated_at AS updatedAt FROM script_analyses ORDER BY episode, scene_no`).all(),
      env.DB.prepare(`SELECT id, analysis_id AS analysisId, category, name, detail,
        visual_brief AS visualBrief, yoyo_approved AS yoyoApproved, producer_approved AS producerApproved, sort_order AS sortOrder,
        updated_at AS updatedAt FROM script_analysis_items ORDER BY analysis_id, sort_order`).all(),
      env.DB.prepare(`SELECT id, episode, version_no AS versionNo, file_name AS fileName, source_text AS sourceText,
        change_summary AS changeSummary, work_date AS workDate, submitted_by AS submittedBy,
        scene_count AS sceneCount, item_count AS itemCount, created_at AS createdAt
        FROM script_versions ORDER BY created_at DESC LIMIT 30`).all(),
      env.DB.prepare(`SELECT id, work_date AS workDate, analysis_id AS analysisId, script_version_id AS scriptVersionId,
        assigned_by AS assignedBy, created_at AS createdAt FROM daily_scene_assignments ORDER BY work_date DESC, created_at`).all(),
    ]);
    return Response.json({ analyses: analyses.results, items: items.results, versions: versions.results, assignments: assignments.results, mode: 'manual' });
  } catch (error) {
    return Response.json({ analyses: [], items: [], versions: [], assignments: [], mode: 'manual', error: error instanceof Error ? error.message : '读取失败' });
  }
}

export async function POST(request: Request) {
  const member = await requireMember(request);
  if (!member) return Response.json({ error: '请先登录' }, { status: 401 });
  const body = await request.json() as Partial<{ action: string; workDate: string; analysisIds: string[]; episode: string; sceneNo: number; sceneTitle: string; location: string; scriptText: string; fileName: string; text: string; changeSummary: string }>;

  if (body.action === 'importScript') {
    if (!member.isAdmin && member.role !== '编剧') return Response.json({ error: '只有编剧可以上传新一集' }, { status: 403 });
    if (!/^\d{4}-\d{2}-\d{2}$/.test(body.workDate || '') || !body.text?.trim()) return Response.json({ error: '没有读取到剧本文字' }, { status: 400 });
    await ensureFirstEpisodeBreakdown();
    const scenes = parseScriptDocument(body.text.slice(0, 300000), body.fileName || '');
    if (!scenes.length) return Response.json({ error: '没有识别到场次。请检查剧本是否有“1. 地点 时间 内/外”这样的场头。' }, { status: 400 });
    const now = new Date().toISOString();
    const analysisIds: string[] = [];
    const statements = [];
    const versionRows: Array<{ id: string; episode: string; versionNo: number }> = [];
    for (const episode of new Set(scenes.slice(0, 40).map((scene) => scene.episode))) {
      const previous = await env.DB.prepare('SELECT COALESCE(MAX(version_no), 0) AS latest FROM script_versions WHERE episode = ?').bind(episode).first<{ latest: number }>();
      const versionNo = Number(previous?.latest || 0) + 1;
      const versionId = `script-version-${crypto.randomUUID()}`;
      const episodeScenes = scenes.slice(0, 40).filter((scene) => scene.episode === episode);
      versionRows.push({ id: versionId, episode, versionNo });
      statements.push(env.DB.prepare(`INSERT INTO script_versions
        (id, episode, version_no, file_name, source_text, change_summary, work_date, submitted_by, scene_count, item_count, created_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`)
        .bind(versionId, episode, versionNo, (body.fileName || '').slice(0, 180), body.text.slice(0, 300000), (body.changeSummary || (versionNo === 1 ? '首次单集提报' : '未填写更新说明')).slice(0, 1000), body.workDate, member.name, episodeScenes.length, episodeScenes.reduce((sum, scene) => sum + scene.items.length, 0), now));
    }
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
      scene.items.forEach((item, index) => {
        const itemId = `${analysisId}-auto-${index + 1}`;
        statements.push(env.DB.prepare(`INSERT INTO script_analysis_items
          (id, analysis_id, category, name, detail, visual_brief, yoyo_approved, producer_approved, sort_order, updated_at)
          VALUES (?, ?, ?, ?, ?, ?, 0, 0, ?, ?)`)
          .bind(itemId, analysisId, item.category, item.name, item.detail, item.visualBrief, index + 1, now));
        statements.push(env.DB.prepare(`INSERT INTO art_submission_details
          (item_id, assigned_to, due_at, handoff_to, done_definition, status, submission_note, review_note, submitted_at, reviewed_at, updated_at)
          VALUES (?, '主美小金', ?, 'Lipa', ?, '待上传', '', '', '', '', ?)
          ON CONFLICT(item_id) DO UPDATE SET due_at = excluded.due_at, done_definition = excluded.done_definition,
            status = '需复核', review_note = '剧本已更新，请按最新版本复核此项。', reviewed_at = '', updated_at = excluded.updated_at`)
          .bind(itemId, `${body.workDate}T18:00`, item.visualBrief, now));
      });
      statements.push(env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)').bind('script_analysis', analysisId, `导入${body.fileName || '剧本文件'}并自动拆解主美工作`, member.name, now));
    }
    for (const episode of new Set(scenes.slice(0, 40).map((scene) => scene.episode))) {
      statements.push(env.DB.prepare("UPDATE production_items SET status = '未开始', completed_qty = 0, updated_at = ? WHERE episode = ? AND category = '整集资产确认'").bind(now, episode));
      statements.push(env.DB.prepare('DELETE FROM production_items WHERE id = ?').bind(`rollup-${body.workDate}-${episodeKey(episode)}-aigc`));
    }
    await env.DB.batch(statements);
    return Response.json({ ok: true, analysisIds, versions: versionRows, sceneCount: analysisIds.length, itemCount: scenes.slice(0, 40).reduce((sum, scene) => sum + scene.items.length, 0) });
  }

  const admin = member.isAdmin ? member : null;
  if (!admin) return Response.json({ error: '只有制片人可以分配当天工作' }, { status: 403 });

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
    const previousVersion = await env.DB.prepare('SELECT COALESCE(MAX(version_no), 0) AS latest FROM script_versions WHERE episode = ?').bind(episode).first<{ latest: number }>();
    const versionNo = Number(previousVersion?.latest || 0) + 1;
    const versionStatement = env.DB.prepare(`INSERT INTO script_versions
      (id, episode, version_no, file_name, source_text, change_summary, work_date, submitted_by, scene_count, item_count, created_at)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, 1, 4, ?)`).bind(`script-version-${crypto.randomUUID()}`, episode, versionNo, `手工补录_第${sceneNo}场.txt`, scriptText, (body.changeSummary || (versionNo === 1 ? '首次单集提报' : `手工更新第${sceneNo}场`)).slice(0, 1000), body.workDate, admin.name, now);
    if (existing) {
      await env.DB.batch([
        versionStatement,
        env.DB.prepare('UPDATE script_analyses SET scene_title = ?, script_text = ?, location = ?, updated_at = ? WHERE id = ?').bind(sceneTitle, scriptText, location, now, analysisId),
        env.DB.prepare(`UPDATE art_submission_details SET status = '需复核', review_note = '剧本已更新，请按最新版本复核此项。', reviewed_at = '', updated_at = ?
          WHERE item_id IN (SELECT id FROM script_analysis_items WHERE analysis_id = ?)`).bind(now, analysisId),
        env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)').bind('script_analysis', analysisId, `更新${body.workDate}当天工作剧本`, 'Lipa', now),
      ]);
      return Response.json({ ok: true, analysisId, versionNo, created: false });
    }

    const starterItems = [
      { category: '人物', name: '人物造型', detail: '根据本场剧本确定出场人物、身份状态、妆发与造型连续性。', visualBrief: '人物定妆图、发型与妆面、表情状态及必要的正侧面参考。' },
      { category: '服装', name: '本场服装', detail: '根据时间、地点、人物状态和前后场连续性确定本场穿搭。', visualBrief: '完整穿搭图，标清内外层、鞋袜、配饰、颜色和材质。' },
      { category: '道具', name: '本场道具', detail: '从人物动作、剧情信息和互动关系中提取必须出现或使用的道具。', visualBrief: '关键道具设定图、尺寸与材质参考；需要手持或互动的要补使用状态。' },
      { category: '场景', name: '本场场景图', detail: '根据剧本中的内外景、日夜、空间关系和动作调度确定场景。', visualBrief: '场景全景、关键机位方向、出入口和主要陈设；足够支持后续白模调度。' },
    ];
    await env.DB.batch([
      versionStatement,
      env.DB.prepare(`INSERT INTO script_analyses
        (id, episode, scene_no, scene_title, script_text, scene_summary, location, created_at, updated_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`)
        .bind(analysisId, episode, sceneNo, sceneTitle, scriptText, '今日工作剧本；待Lipa按剧本继续细化主美出图清单。', location, now, now),
      ...starterItems.map((item, index) => env.DB.prepare(`INSERT INTO script_analysis_items
        (id, analysis_id, category, name, detail, visual_brief, yoyo_approved, producer_approved, sort_order, updated_at)
        VALUES (?, ?, ?, ?, ?, ?, 0, 0, ?, ?)`)
        .bind(`${analysisId}-${index + 1}`, analysisId, item.category, item.name, item.detail, item.visualBrief, index + 1, now)),
      ...starterItems.map((item, index) => env.DB.prepare(`INSERT INTO art_submission_details
        (item_id, assigned_to, due_at, handoff_to, done_definition, status, submission_note, review_note, submitted_at, reviewed_at, updated_at)
        VALUES (?, '主美小金', ?, 'Lipa', ?, '待上传', '', '', '', '', ?)`)
        .bind(`${analysisId}-${index + 1}`, `${body.workDate}T18:00`, item.visualBrief, now)),
      env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)').bind('script_analysis', analysisId, `新增${body.workDate}当天工作剧本并建立主美四类工作`, 'Lipa', now),
    ]);
    return Response.json({ ok: true, analysisId, versionNo, created: true });
  }

  if (body.action !== 'assign' || !/^2026-\d{2}-\d{2}$/.test(body.workDate || '') || !Array.isArray(body.analysisIds) || !body.analysisIds.length) {
    return Response.json({ error: '请选择工作日期和至少一个场次' }, { status: 400 });
  }

  await ensureFirstEpisodeBreakdown();
  const uniqueIds = [...new Set(body.analysisIds)].slice(0, 30);
  const placeholders = uniqueIds.map(() => '?').join(',');
  const [analysisRows, itemRows, submissionRows] = await Promise.all([
    env.DB.prepare(`SELECT id, episode, scene_no AS sceneNo, scene_title AS sceneTitle FROM script_analyses WHERE id IN (${placeholders}) ORDER BY episode, scene_no`).bind(...uniqueIds).all<{ id: string; episode: string; sceneNo: number; sceneTitle: string }>(),
    env.DB.prepare(`SELECT analysis_id AS analysisId, COUNT(*) AS itemCount FROM script_analysis_items WHERE analysis_id IN (${placeholders}) GROUP BY analysis_id`).bind(...uniqueIds).all<{ analysisId: string; itemCount: number }>(),
    env.DB.prepare(`SELECT id, visual_brief AS visualBrief FROM script_analysis_items WHERE analysis_id IN (${placeholders})`).bind(...uniqueIds).all<{ id: string; visualBrief: string }>(),
  ]);
  if (!analysisRows.results.length) return Response.json({ error: '没有找到所选场次' }, { status: 404 });

  const itemCountByAnalysis = new Map(itemRows.results.map((row) => [row.analysisId, Number(row.itemCount)]));
  const now = new Date().toISOString();
  const workDate = body.workDate!;
  const latestVersionByEpisode = new Map<string, string>();
  for (const episode of new Set(analysisRows.results.map((row) => row.episode))) {
    const latestVersion = await env.DB.prepare('SELECT id FROM script_versions WHERE episode = ? ORDER BY version_no DESC LIMIT 1').bind(episode).first<{ id: string }>();
    latestVersionByEpisode.set(episode, latestVersion?.id || '');
  }
  const groups = new Map<string, { episode: string; count: number; sceneCount: number }>();
  for (const analysis of analysisRows.results) {
    const group = groups.get(analysis.episode) || { episode: analysis.episode, count: 0, sceneCount: 0 };
    group.count += itemCountByAnalysis.get(analysis.id) || 1;
    group.sceneCount += 1;
    groups.set(analysis.episode, group);
  }
  const tasks = [...groups.values()].flatMap((group, groupIndex) => episodeRollupTasks(workDate, group.episode, group.count, group.sceneCount, groupIndex, now));
  const obsoleteTaskDeletes = uniqueIds.flatMap((analysisId) => ['script', 'breakdown', 'art', 'white', 'send', 'yoyo', 'producer'].map((suffix) => env.DB.prepare('DELETE FROM production_items WHERE id = ?').bind(`daily-${workDate}-${analysisId}-${suffix}`)));

  const submissionDefaults = submissionRows.results.map((row) => env.DB.prepare(`INSERT INTO art_submission_details
    (item_id, assigned_to, due_at, handoff_to, done_definition, status, submission_note, review_note, submitted_at, reviewed_at, updated_at)
    VALUES (?, '主美小金', ?, 'Lipa', ?, '待上传', '', '', '', '', ?)
    ON CONFLICT(item_id) DO UPDATE SET due_at = CASE WHEN art_submission_details.due_at = '' THEN excluded.due_at ELSE art_submission_details.due_at END,
      done_definition = CASE WHEN art_submission_details.done_definition = '' THEN excluded.done_definition ELSE art_submission_details.done_definition END,
      updated_at = excluded.updated_at`).bind(row.id, `${workDate}T18:00`, row.visualBrief, now));
  const assignmentStatements = analysisRows.results.map((row) => env.DB.prepare(`INSERT INTO daily_scene_assignments
    (id, work_date, analysis_id, script_version_id, assigned_by, created_at) VALUES (?, ?, ?, ?, ?, ?)
    ON CONFLICT(work_date, analysis_id) DO UPDATE SET script_version_id = excluded.script_version_id,
      assigned_by = excluded.assigned_by, created_at = excluded.created_at`)
    .bind(`daily-scene-${workDate}-${row.id}`, workDate, row.id, latestVersionByEpisode.get(row.episode) || '', admin.name, now));
  await env.DB.batch([...obsoleteTaskDeletes, ...submissionDefaults, ...assignmentStatements, ...tasks.map((row) => env.DB.prepare(`INSERT INTO production_items
    (id, work_date, episode, category, title, owner, reviewer, status, planned_qty, completed_qty, due_time, depends_on_id, handoff_to, handoff_deadline, note, sort_order, updated_at)
    VALUES (?, ?, ?, ?, ?, ?, ?, '未开始', ?, 0, ?, ?, ?, ?, ?, ?, ?)
    ON CONFLICT(id) DO UPDATE SET episode = excluded.episode, category = excluded.category, title = excluded.title,
      owner = excluded.owner, reviewer = excluded.reviewer, planned_qty = excluded.planned_qty, due_time = excluded.due_time,
      depends_on_id = excluded.depends_on_id, handoff_to = excluded.handoff_to, handoff_deadline = excluded.handoff_deadline,
      note = excluded.note, sort_order = excluded.sort_order, updated_at = excluded.updated_at`)
    .bind(row.id, row.workDate, row.episode, row.category, row.title, row.owner, 'Yoyo', row.plannedQty, row.dueTime, row.dependsOnId, row.handoffTo, row.handoffDeadline, row.note, row.sortOrder, row.updatedAt))]);

  return Response.json({ ok: true, assignedScenes: analysisRows.results.length, taskCount: tasks.length });
}

export async function PATCH(request: Request) {
  const admin = await requireAdmin(request);
  if (!admin) return Response.json({ error: '只有Lipa可以修改审核项' }, { status: 403 });
  const body = await request.json() as Partial<{ id: string; analysisId: string; scriptText: string; episode: string; workDate: string; approvalTarget: 'yoyo' | 'producer'; approved: boolean; yoyoApproved: boolean; producerApproved: boolean; name: string; detail: string; visualBrief: string }>;
  if (body.episode && body.workDate && body.approvalTarget && typeof body.approved === 'boolean') {
    const column = body.approvalTarget === 'yoyo' ? 'yoyo_approved' : 'producer_approved';
    const updatedAt = new Date().toISOString();
    const prefix = `rollup-${body.workDate}-${episodeKey(body.episode)}`;
    const reviewTaskId = `${prefix}-${body.approvalTarget}`;
    await env.DB.batch([
      env.DB.prepare(`UPDATE script_analysis_items SET ${column} = ?, updated_at = ? WHERE analysis_id IN (SELECT id FROM script_analyses WHERE episode = ?)`).bind(body.approved ? 1 : 0, updatedAt, body.episode),
      env.DB.prepare("UPDATE production_items SET status = ?, completed_qty = ?, updated_at = ? WHERE id = ?").bind(body.approved ? '已通过' : '未开始', body.approved ? 1 : 0, updatedAt, reviewTaskId),
      env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)').bind('episode_assets', body.episode, `${body.approvalTarget === 'yoyo' ? 'Yoyo' : '叶总'}微信确认结果：${body.approved ? '已确认' : '未确认'}`, 'Lipa', updatedAt),
    ]);
    const totals = await env.DB.prepare(`SELECT COUNT(*) AS total, SUM(yoyo_approved) AS yoyoCount, SUM(producer_approved) AS producerCount
      FROM script_analysis_items WHERE analysis_id IN (SELECT id FROM script_analyses WHERE episode = ?)`).bind(body.episode).first<{ total: number; yoyoCount: number; producerCount: number }>();
    const fullyApproved = Boolean(totals?.total && Number(totals.yoyoCount) === Number(totals.total) && Number(totals.producerCount) === Number(totals.total));
    const aigcTaskId = `${prefix}-aigc`;
    if (fullyApproved) {
      await env.DB.prepare(`INSERT INTO production_items
        (id, work_date, episode, category, title, owner, reviewer, status, planned_qty, completed_qty, due_time, depends_on_id, handoff_to, handoff_deadline, note, sort_order, updated_at)
        VALUES (?, ?, ?, '抽卡生成', ?, 'AIGC抽卡师', '执行制片人：Lipa', '未开始', 1, 0, '21:00', ?, '执行制片人：Lipa', '完成后同步', ?, 90, ?)
        ON CONFLICT(id) DO NOTHING`)
        .bind(aigcTaskId, body.workDate, body.episode, `开始${body.episode}抽卡与正式镜头生成`, `${prefix}-producer`, '叶总和Yoyo均已在微信确认整集资产，正式放行抽卡与视频生成。', updatedAt).run();
    } else {
      await env.DB.prepare('DELETE FROM production_items WHERE id = ?').bind(aigcTaskId).run();
    }
    return Response.json({ ok: true, episode: body.episode, fullyApproved });
  }
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

export async function DELETE(request: Request) {
  const member = await requireMember(request);
  if (!member || (!member.isAdmin && member.role !== '执行制片人')) return Response.json({ error: '只有执行制片人可以删除自动拆出的道具' }, { status: 403 });
  const body = await request.json() as { id?: string; ids?: string[] };
  if (Array.isArray(body.ids) && body.ids.length) {
    const ids = [...new Set(body.ids)].slice(0, 100);
    const placeholders = ids.map(() => '?').join(',');
    const matched = await env.DB.prepare(`SELECT i.id, a.episode FROM script_analysis_items i JOIN script_analyses a ON a.id = i.analysis_id
      WHERE i.id IN (${placeholders}) AND i.category = '道具'`).bind(...ids).all<{ id: string; episode: string }>();
    if (!matched.results.length) return Response.json({ error: '没有找到可删除的道具' }, { status: 404 });
    const matchedIds = matched.results.map((row) => row.id);
    const matchedPlaceholders = matchedIds.map(() => '?').join(',');
    const affectedEpisodes = [...new Set(matched.results.map((row) => row.episode))];
    const updatedAt = new Date().toISOString();
    const statements = [
      env.DB.prepare(`DELETE FROM art_submission_files WHERE item_id IN (${matchedPlaceholders})`).bind(...matchedIds),
      env.DB.prepare(`DELETE FROM art_submission_details WHERE item_id IN (${matchedPlaceholders})`).bind(...matchedIds),
      env.DB.prepare(`DELETE FROM script_analysis_items WHERE id IN (${matchedPlaceholders}) AND category = '道具'`).bind(...matchedIds),
      ...affectedEpisodes.map((episode) => env.DB.prepare(`UPDATE production_items SET planned_qty = (SELECT COUNT(*) FROM script_analysis_items i JOIN script_analyses a ON a.id = i.analysis_id WHERE a.episode = ?), updated_at = ?
        WHERE episode = ? AND category = '美术清单'`).bind(episode, updatedAt, episode)),
      env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)').bind('script_analysis_item', matchedIds.join(',').slice(0, 500), `批量删除${matchedIds.length}项道具`, member.name, updatedAt),
    ];
    await env.DB.batch(statements);
    return Response.json({ ok: true, ids: matchedIds, deletedCount: matchedIds.length });
  }
  if (!body.id) return Response.json({ error: '缺少工作项ID' }, { status: 400 });
  const current = await env.DB.prepare(`SELECT i.analysis_id AS analysisId, i.name, i.category, a.episode
    FROM script_analysis_items i JOIN script_analyses a ON a.id = i.analysis_id WHERE i.id = ?`).bind(body.id).first<{ analysisId: string; name: string; category: string; episode: string }>();
  if (!current) return Response.json({ error: '工作项不存在' }, { status: 404 });
  if (!member.isAdmin && current.category !== '道具') return Response.json({ error: '执行制片人只能删除道具，人物、服装和场景不能删除' }, { status: 403 });
  const updatedAt = new Date().toISOString();
  await env.DB.batch([
    env.DB.prepare('DELETE FROM art_submission_files WHERE item_id = ?').bind(body.id),
    env.DB.prepare('DELETE FROM art_submission_details WHERE item_id = ?').bind(body.id),
    env.DB.prepare('DELETE FROM script_analysis_items WHERE id = ?').bind(body.id),
    env.DB.prepare(`UPDATE production_items SET planned_qty = (SELECT COUNT(*) FROM script_analysis_items i JOIN script_analyses a ON a.id = i.analysis_id WHERE a.episode = ?), updated_at = ?
      WHERE episode = ? AND category = '美术清单'`).bind(current.episode, updatedAt, current.episode),
    env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)').bind('script_analysis_item', body.id, `删除主美工作项：${current.name}`, member.name, updatedAt),
  ]);
  return Response.json({ ok: true, id: body.id });
}

function task(id: string, workDate: string, episode: string, category: string, title: string, owner: string, plannedQty: number, dueTime: string, dependsOnId: string, handoffTo: string, handoffDeadline: string, note: string, sortOrder: number, updatedAt: string) {
  return { id, workDate, episode, category, title, owner, plannedQty, dueTime, dependsOnId, handoffTo, handoffDeadline, note, sortOrder, updatedAt };
}

function episodeRollupTasks(workDate: string, episode: string, count: number, sceneCount: number, index: number, updatedAt: string) {
  const prefix = `rollup-${workDate}-${episodeKey(episode)}`;
  const base = index * 10;
  return [
    task(`${prefix}-script`, workDate, episode, '剧本', `交付${episode}完整剧本`, '编剧', 1, '12:00', '', '执行制片人：Lipa', '交付后继续下一集', `整集一次交付，不再按${sceneCount}个场次分别确认，也不参与美术资产审核。`, base + 1, updatedAt),
    task(`${prefix}-art`, workDate, episode, '美术清单', `完成${episode}全部主美资产清单与出图`, '主美', count, '18:00', `${prefix}-script`, '执行制片人：Lipa', '18:15', `点开生产手册查看${sceneCount}场、共${count}项人物造型/服装/道具/场景图清单；不逐项做审核勾选。`, base + 2, updatedAt),
    task(`${prefix}-send`, workDate, episode, '资产提报', `整理${episode}完整资产包并发微信`, '执行制片人：Lipa', 1, '18:30', `${prefix}-art`, '制片人（叶总）＋红人（Yoyo）', '发出后等待微信确认', '只负责整集资产包提报，不逐项确认。', base + 3, updatedAt),
    task(`${prefix}-producer`, workDate, episode, '整集资产确认', `记录叶总是否已确认${episode}全部资产`, '制片人（叶总）', 1, '收到后', `${prefix}-send`, '执行制片人：Lipa', '收到微信后录入', '叶总在微信确认；本平台仅由Lipa记录最终结果。', base + 4, updatedAt),
    task(`${prefix}-yoyo`, workDate, episode, '整集资产确认', `记录Yoyo是否已确认${episode}全部资产`, '红人（Yoyo）', 1, '微信待回复', `${prefix}-send`, '执行制片人：Lipa', '收到微信后录入', 'Yoyo在微信确认；本平台仅由Lipa记录最终结果。', base + 5, updatedAt),
  ];
}

function episodeKey(episode: string) {
  const number = episode.match(/\d+/)?.[0];
  return number ? `ep${number}` : `ep-${[...episode].reduce((sum, character) => sum + character.charCodeAt(0), 0)}`;
}
