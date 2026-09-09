import { env } from 'cloudflare:workers';
import { initialItems, STATUSES } from '@/lib/plan-data';
import { requireAdmin } from '@/lib/auth';

export async function GET() {
  try {
    const count = await env.DB.prepare('SELECT COUNT(*) AS count FROM production_items').first<{ count: number }>();
    if (!count?.count) {
      await env.DB.batch(initialItems.map((row) => env.DB.prepare(`
        INSERT INTO production_items
        (id, work_date, episode, category, title, owner, reviewer, status, planned_qty, completed_qty, due_time, depends_on_id, handoff_to, handoff_deadline, note, sort_order, updated_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      `).bind(row.id, row.workDate, row.episode, row.category, row.title, row.owner, row.reviewer, row.status, row.plannedQty, row.completedQty, row.dueTime, row.dependsOnId, row.handoffTo, row.handoffDeadline, row.note, row.sortOrder, row.updatedAt)));
    }
    const workflowVersion = await env.DB.prepare("SELECT value FROM app_settings WHERE key = 'workflow_items_v3'").first<{ value: string }>();
    if (!workflowVersion) {
      await env.DB.batch([
        env.DB.prepare("DELETE FROM production_items WHERE id IN ('0909-art', '0909-review', '0909-outline', '0910-review') OR id LIKE '2026-%-edit'"),
        ...initialItems.map((row) => env.DB.prepare(`
          INSERT OR REPLACE INTO production_items
          (id, work_date, episode, category, title, owner, reviewer, status, planned_qty, completed_qty, due_time, depends_on_id, handoff_to, handoff_deadline, note, sort_order, updated_at)
          VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        `).bind(row.id, row.workDate, row.episode, row.category, row.title, row.owner, row.reviewer, row.status, row.plannedQty, row.completedQty, row.dueTime, row.dependsOnId, row.handoffTo, row.handoffDeadline, row.note, row.sortOrder, row.updatedAt)),
        env.DB.prepare("INSERT INTO app_settings (key, value, updated_at) VALUES ('workflow_items_v3', 'done', ?)").bind(new Date().toISOString()),
      ]);
    }
    const resetVersion = await env.DB.prepare("SELECT value FROM app_settings WHERE key = 'progress_reset_0910_v1'").first<{ value: string }>();
    if (!resetVersion) {
      const updatedAt = new Date().toISOString();
      await env.DB.batch([
        env.DB.prepare("UPDATE production_items SET status = '未开始', completed_qty = 0, updated_at = ? WHERE work_date = '2026-09-10'").bind(updatedAt),
        env.DB.prepare("INSERT INTO app_settings (key, value, updated_at) VALUES ('progress_reset_0910_v1', 'done', ?)").bind(updatedAt),
      ]);
    }
    const scriptFlowVersion = await env.DB.prepare("SELECT value FROM app_settings WHERE key = 'workflow_script_flow_v1'").first<{ value: string }>();
    if (!scriptFlowVersion) {
      const updatedAt = new Date().toISOString();
      const meeting = initialItems.find((row) => row.id === '0910-script-meeting');
      if (meeting) {
        await env.DB.batch([
          env.DB.prepare("UPDATE production_items SET episode = '第1—10集', category = '剧本', title = '提交全剧大纲＋分集初版', owner = '编剧', status = '未开始', planned_qty = 1, completed_qty = 0, due_time = '15:00', depends_on_id = '', handoff_to = '联合制片人／导演：Lipa', handoff_deadline = '15:30', note = '先锁定强逻辑内容和每集方向', sort_order = 1, updated_at = ? WHERE id = '0910-script'").bind(updatedAt),
          env.DB.prepare(`INSERT OR REPLACE INTO production_items (id, work_date, episode, category, title, owner, reviewer, status, planned_qty, completed_qty, due_time, depends_on_id, handoff_to, handoff_deadline, note, sort_order, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`)
            .bind(meeting.id, meeting.workDate, meeting.episode, meeting.category, meeting.title, meeting.owner, meeting.reviewer, meeting.status, meeting.plannedQty, meeting.completedQty, meeting.dueTime, meeting.dependsOnId, meeting.handoffTo, meeting.handoffDeadline, meeting.note, meeting.sortOrder, updatedAt),
          env.DB.prepare("UPDATE production_items SET title = '完成第一集台词细化版并交Lipa', status = '未开始', completed_qty = 0, due_time = '20:00', depends_on_id = '0910-script-meeting', handoff_to = '联合制片人／导演：Lipa', handoff_deadline = '20:15', note = '按9月10日过会意见细化人物状态、动作与全部台词', updated_at = ? WHERE id = '0911-lock'").bind(updatedAt),
          env.DB.prepare("INSERT INTO app_settings (key, value, updated_at) VALUES ('workflow_script_flow_v1', 'done', ?)").bind(updatedAt),
        ]);
      }
    }
    const whiteFlowVersion = await env.DB.prepare("SELECT value FROM app_settings WHERE key = 'workflow_white_review_v1'").first<{ value: string }>();
    if (!whiteFlowVersion) {
      const updatedAt = new Date().toISOString();
      const reviewRows = initialItems.filter((row) => row.id === '0911-yoyo-white' || row.id === '0911-producer-white');
      await env.DB.batch([
        env.DB.prepare("UPDATE production_items SET title = '依据第一集剧本生成首批场景白模视频', status = '未开始', completed_qty = 0, due_time = '21:00', depends_on_id = '', handoff_to = '红人（Yoyo）＋制片人（叶总）', handoff_deadline = '2026-09-11 18:00', note = '第一集剧本已具备，可直接按剧本制作；生成后提报Yoyo和叶总审批', updated_at = ? WHERE id = '0910-white'").bind(updatedAt),
        env.DB.prepare("UPDATE production_items SET title = '完成并提报第一集全部场景白模视频', status = '未开始', completed_qty = 0, due_time = '15:00', depends_on_id = '0910-white', handoff_to = '红人（Yoyo）＋制片人（叶总）', handoff_deadline = '18:00', note = '依据剧本完成全部场景与调度白模，15:00同步审核材料', updated_at = ? WHERE id = '0911-white'").bind(updatedAt),
        ...reviewRows.map((row) => env.DB.prepare(`INSERT OR REPLACE INTO production_items (id, work_date, episode, category, title, owner, reviewer, status, planned_qty, completed_qty, due_time, depends_on_id, handoff_to, handoff_deadline, note, sort_order, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`)
          .bind(row.id, row.workDate, row.episode, row.category, row.title, row.owner, row.reviewer, row.status, row.plannedQty, row.completedQty, row.dueTime, row.dependsOnId, row.handoffTo, row.handoffDeadline, row.note, row.sortOrder, updatedAt)),
        env.DB.prepare("UPDATE production_items SET category = '审核汇总', title = '汇总Yoyo与叶总意见并锁定白模', status = '未开始', planned_qty = 1, completed_qty = 0, due_time = '20:00', depends_on_id = '0911-white', handoff_to = 'AIGC抽卡师', handoff_deadline = '2026-09-12 09:00', note = '必须收到Yoyo和叶总两边审批后，才能标记通过并释放正式镜头', sort_order = 11, updated_at = ? WHERE id = '0911-review'").bind(updatedAt),
        env.DB.prepare("INSERT INTO app_settings (key, value, updated_at) VALUES ('workflow_white_review_v1', 'done', ?)").bind(updatedAt),
      ]);
    }
    const asyncReviewVersion = await env.DB.prepare("SELECT value FROM app_settings WHERE key = 'workflow_yoyo_async_v1'").first<{ value: string }>();
    if (!asyncReviewVersion) {
      const updatedAt = new Date().toISOString();
      await env.DB.batch([
        env.DB.prepare("UPDATE production_items SET due_time = '异步', handoff_deadline = '收到回复后更新', note = 'Yoyo不登录系统、不设硬deadline；未回复不阻断剧本、场景图和白模', updated_at = ? WHERE id = '0910-yoyo'").bind(updatedAt),
        env.DB.prepare("UPDATE production_items SET title = '收到后录入Yoyo反馈并更新已通过场景', due_time = '收到后', depends_on_id = '', handoff_deadline = '录入后即时同步', note = '收到一项录入一项；不影响剧本、场景图和白模继续推进', updated_at = ? WHERE id = '0910-lipa-record'").bind(updatedAt),
        env.DB.prepare("UPDATE production_items SET note = '收到主美提报后立即发送；发出后进入异步审核', handoff_deadline = '发出即进入异步审核', updated_at = ? WHERE id = '0910-send-yoyo'").bind(updatedAt),
        env.DB.prepare("UPDATE production_items SET note = '第一集剧本已具备，可直接按剧本制作；无需等待Yoyo回复，生成后同步提报Yoyo和叶总', handoff_deadline = '生成后即提报', updated_at = ? WHERE id = '0910-white'").bind(updatedAt),
        env.DB.prepare("UPDATE production_items SET note = '依据剧本完成全部场景与调度白模；无需等待Yoyo回复，完成后同步审核材料', handoff_deadline = '完成后即提报', updated_at = ? WHERE id = '0911-white'").bind(updatedAt),
        env.DB.prepare("UPDATE production_items SET due_time = '异步', handoff_deadline = '收到回复后更新', note = 'Yoyo不登录系统、不设硬deadline；Lipa收到微信意见后更新结果', updated_at = ? WHERE id = '0911-yoyo-white'").bind(updatedAt),
        env.DB.prepare("UPDATE production_items SET due_time = '异步', handoff_deadline = '收到回复后更新', note = 'Yoyo不登录系统、不设硬deadline；未回复不阻断剧本、场景图和白模，只影响最终锁定', updated_at = ? WHERE owner = '红人（Yoyo）' AND id LIKE '2026-%-review'").bind(updatedAt),
        env.DB.prepare("UPDATE production_items SET title = '更新已收到的微信意见并调整次日Rundown', depends_on_id = '', note = '不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排', updated_at = ? WHERE owner = '联合制片人／导演：Lipa' AND id LIKE '2026-%-lipa'").bind(updatedAt),
        env.DB.prepare("UPDATE production_items SET note = '每天提报2场；发给Yoyo后继续下一场，不等待回复', handoff_deadline = '完成后即提报', updated_at = ? WHERE owner = '主美' AND id LIKE '2026-%-prep'").bind(updatedAt),
        env.DB.prepare("INSERT INTO app_settings (key, value, updated_at) VALUES ('workflow_yoyo_async_v1', 'done', ?)").bind(updatedAt),
      ]);
    }
    const plainReviewLabelVersion = await env.DB.prepare("SELECT value FROM app_settings WHERE key = 'workflow_plain_review_label_v1'").first<{ value: string }>();
    if (!plainReviewLabelVersion) {
      const updatedAt = new Date().toISOString();
      await env.DB.batch([
        env.DB.prepare("UPDATE production_items SET due_time = '微信待回复', updated_at = ? WHERE due_time = '异步'").bind(updatedAt),
        env.DB.prepare("UPDATE production_items SET note = REPLACE(note, '异步审核', '等待微信回复'), handoff_deadline = REPLACE(handoff_deadline, '异步审核', '等待微信回复'), updated_at = ? WHERE note LIKE '%异步审核%' OR handoff_deadline LIKE '%异步审核%'").bind(updatedAt),
        env.DB.prepare("INSERT INTO app_settings (key, value, updated_at) VALUES ('workflow_plain_review_label_v1', 'done', ?)").bind(updatedAt),
      ]);
    }
    const visualReviewOnlyVersion = await env.DB.prepare("SELECT value FROM app_settings WHERE key = 'workflow_visual_review_only_v1'").first<{ value: string }>();
    if (!visualReviewOnlyVersion) {
      const updatedAt = new Date().toISOString();
      await env.DB.batch([
        env.DB.prepare("UPDATE production_items SET category = '美术图审核', title = '在微信反馈第一集主美视觉图', due_time = '微信待回复', depends_on_id = '0910-send-yoyo', note = 'Yoyo只看主美做的图，不审核剧本和白模；Lipa收到意见后逐项更新', updated_at = ? WHERE id = '0911-yoyo-white'").bind(updatedAt),
        env.DB.prepare("UPDATE production_items SET category = '美术图审核', title = '审核第一集主美视觉图', depends_on_id = '0910-send-yoyo', note = '叶总只看主美做的图，不审核剧本和白模', updated_at = ? WHERE id = '0911-producer-white'").bind(updatedAt),
        env.DB.prepare("UPDATE production_items SET title = '汇总Yoyo与叶总对主美图的意见', depends_on_id = '0910-send-yoyo', note = '按已收到的意见逐项更新；最终视觉锁定后释放正式镜头', updated_at = ? WHERE id = '0911-review'").bind(updatedAt),
        env.DB.prepare("INSERT INTO app_settings (key, value, updated_at) VALUES ('workflow_visual_review_only_v1', 'done', ?)").bind(updatedAt),
      ]);
    }
    const episodeRollupVersion = await env.DB.prepare("SELECT value FROM app_settings WHERE key = 'workflow_episode_rollup_v1'").first<{ value: string }>();
    if (!episodeRollupVersion) {
      const updatedAt = new Date().toISOString();
      const rollupRows = await env.DB.prepare("SELECT DISTINCT work_date AS workDate, episode FROM production_items WHERE id LIKE 'daily-%'").all<{ workDate: string; episode: string }>();
      const statements = [
        env.DB.prepare(`DELETE FROM production_items WHERE
          id LIKE 'daily-%-script' OR id LIKE 'daily-%-breakdown' OR id LIKE 'daily-%-art' OR id LIKE 'daily-%-white' OR
          id LIKE 'daily-%-send' OR id LIKE 'daily-%-yoyo' OR id LIKE 'daily-%-producer'`),
        env.DB.prepare("DELETE FROM production_items WHERE id IN ('0910-art','0910-send-yoyo','0910-yoyo','0910-lipa-record','0910-white','0911-white','0911-yoyo-white','0911-producer-white','0911-review')"),
      ];
      for (const [index, row] of rollupRows.results.entries()) {
        const totals = await env.DB.prepare(`SELECT COUNT(*) AS total, SUM(i.yoyo_approved) AS yoyoCount, SUM(i.producer_approved) AS producerCount
          FROM script_analysis_items i JOIN script_analyses a ON a.id = i.analysis_id WHERE a.episode = ?`).bind(row.episode).first<{ total: number; yoyoCount: number; producerCount: number }>();
        const count = Number(totals?.total || 1);
        const prefix = `rollup-${row.workDate}-${episodeRollupKey(row.episode)}`;
        const base = index * 10;
        const rows = [
          rollupRow(`${prefix}-script`, row.workDate, row.episode, '剧本', `交付${row.episode}完整剧本`, '编剧', 1, '12:00', '', '联合制片人／导演：Lipa', '交付后继续下一集', '整集一次交付，不按单场与资产审核绑定。', base + 1, updatedAt),
          rollupRow(`${prefix}-art`, row.workDate, row.episode, '美术清单', `完成${row.episode}全部主美资产清单与出图`, '主美', count, '18:00', `${prefix}-script`, '联合制片人／导演：Lipa', '18:15', `点开查看全部人物造型、服装、道具、场景图，共${count}项。`, base + 2, updatedAt),
          rollupRow(`${prefix}-send`, row.workDate, row.episode, '资产提报', `整理${row.episode}完整资产包并发微信`, '联合制片人／导演：Lipa', 1, '18:30', `${prefix}-art`, '制片人（叶总）＋红人（Yoyo）', '发出后等待微信确认', '只负责整集资产包提报，不逐项确认。', base + 3, updatedAt),
          rollupRow(`${prefix}-producer`, row.workDate, row.episode, '整集资产确认', `记录叶总是否已确认${row.episode}全部资产`, '制片人（叶总）', 1, '收到后', `${prefix}-send`, '联合制片人／导演：Lipa', '收到微信后录入', '叶总在微信确认；本平台仅由Lipa记录最终结果。', base + 4, updatedAt, Number(totals?.producerCount) === count),
          rollupRow(`${prefix}-yoyo`, row.workDate, row.episode, '整集资产确认', `记录Yoyo是否已确认${row.episode}全部资产`, '红人（Yoyo）', 1, '微信待回复', `${prefix}-send`, '联合制片人／导演：Lipa', '收到微信后录入', 'Yoyo在微信确认；本平台仅由Lipa记录最终结果。', base + 5, updatedAt, Number(totals?.yoyoCount) === count),
        ];
        rows.forEach((item) => statements.push(env.DB.prepare(`INSERT OR REPLACE INTO production_items
          (id, work_date, episode, category, title, owner, reviewer, status, planned_qty, completed_qty, due_time, depends_on_id, handoff_to, handoff_deadline, note, sort_order, updated_at)
          VALUES (?, ?, ?, ?, ?, ?, 'Yoyo', ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`)
          .bind(item.id, item.workDate, item.episode, item.category, item.title, item.owner, item.status, item.plannedQty, item.completedQty, item.dueTime, item.dependsOnId, item.handoffTo, item.handoffDeadline, item.note, item.sortOrder, item.updatedAt)));
      }
      statements.push(env.DB.prepare("INSERT INTO app_settings (key, value, updated_at) VALUES ('workflow_episode_rollup_v1', 'done', ?)").bind(updatedAt));
      await env.DB.batch(statements);
    }
    const calendarVersion = await env.DB.prepare("SELECT value FROM app_settings WHERE key = 'workflow_calendar_six_on_one_off_v1'").first<{ value: string }>();
    if (!calendarVersion) {
      const updatedAt = new Date().toISOString();
      const scheduleRows = initialItems.filter((row) => /^2026-/.test(row.id) || row.id === '1021-delivery');
      await env.DB.prepare("DELETE FROM production_items WHERE id LIKE '2026-%' OR id IN ('1009-delivery', '1020-delivery', '1021-delivery')").run();
      for (let index = 0; index < scheduleRows.length; index += 50) {
        await env.DB.batch(scheduleRows.slice(index, index + 50).map((row) => env.DB.prepare(`INSERT INTO production_items
          (id, work_date, episode, category, title, owner, reviewer, status, planned_qty, completed_qty, due_time, depends_on_id, handoff_to, handoff_deadline, note, sort_order, updated_at)
          VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`)
          .bind(row.id, row.workDate, row.episode, row.category, row.title, row.owner, row.reviewer, row.status, row.plannedQty, row.completedQty, row.dueTime, row.dependsOnId, row.handoffTo, row.handoffDeadline, row.note, row.sortOrder, updatedAt)));
      }
      await env.DB.prepare("INSERT INTO app_settings (key, value, updated_at) VALUES ('workflow_calendar_six_on_one_off_v1', 'done', ?)").bind(updatedAt).run();
    }
    const result = await env.DB.prepare(`
      SELECT id, work_date AS workDate, episode, category, title, owner, reviewer, status,
             planned_qty AS plannedQty, completed_qty AS completedQty, due_time AS dueTime,
             depends_on_id AS dependsOnId, handoff_to AS handoffTo, handoff_deadline AS handoffDeadline,
             note, sort_order AS sortOrder, updated_at AS updatedAt
      FROM production_items ORDER BY work_date, sort_order
    `).all();
    return Response.json({ items: result.results });
  } catch (error) {
    return Response.json({ items: initialItems, localFallback: true, error: error instanceof Error ? error.message : '读取失败' });
  }
}

function rollupRow(id: string, workDate: string, episode: string, category: string, title: string, owner: string, plannedQty: number, dueTime: string, dependsOnId: string, handoffTo: string, handoffDeadline: string, note: string, sortOrder: number, updatedAt: string, completed = false) {
  return { id, workDate, episode, category, title, owner, status: completed ? '已通过' : '未开始', plannedQty, completedQty: completed ? plannedQty : 0, dueTime, dependsOnId, handoffTo, handoffDeadline, note, sortOrder, updatedAt };
}

function episodeRollupKey(episode: string) {
  const number = episode.match(/\d+/)?.[0];
  return number ? `ep${number}` : `ep-${[...episode].reduce((sum, character) => sum + character.charCodeAt(0), 0)}`;
}

export async function PATCH(request: Request) {
  const admin = await requireAdmin(request);
  if (!admin) return Response.json({ error: '只有Lipa可以修改任务' }, { status: 403 });
  const body = await request.json() as Partial<{
    id: string; workDate: string; episode: string; category: string; title: string; owner: string;
    reviewer: string; status: string; plannedQty: number; completedQty: number; dueTime: string;
    dependsOnId: string; handoffTo: string; handoffDeadline: string; note: string; operator: string;
  }>;
  if (!body.id || (body.status && !STATUSES.includes(body.status as (typeof STATUSES)[number]))) {
    return Response.json({ error: '参数不正确' }, { status: 400 });
  }
  const updatedAt = new Date().toISOString();
  try {
    const existing = await env.DB.prepare(`
      SELECT work_date AS workDate, episode, category, title, owner, reviewer, status,
             planned_qty AS plannedQty, completed_qty AS completedQty, due_time AS dueTime,
             depends_on_id AS dependsOnId, handoff_to AS handoffTo, handoff_deadline AS handoffDeadline, note
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
      dueTime: body.dueTime ?? String(existing.dueTime), dependsOnId: body.dependsOnId ?? String(existing.dependsOnId),
      handoffTo: body.handoffTo ?? String(existing.handoffTo), handoffDeadline: body.handoffDeadline ?? String(existing.handoffDeadline),
      note: typeof body.note === 'string' ? body.note.slice(0, 500) : String(existing.note),
    };
    await env.DB.batch([
      env.DB.prepare(`
        UPDATE production_items SET work_date = ?, episode = ?, category = ?, title = ?, owner = ?, reviewer = ?,
          status = ?, planned_qty = ?, completed_qty = ?, due_time = ?, depends_on_id = ?, handoff_to = ?, handoff_deadline = ?, note = ?, updated_at = ? WHERE id = ?
      `).bind(updated.workDate, updated.episode, updated.category, updated.title, updated.owner, updated.reviewer, updated.status, updated.plannedQty, updated.completedQty, updated.dueTime, updated.dependsOnId, updated.handoffTo, updated.handoffDeadline, updated.note, updatedAt, body.id),
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
  const body = await request.json() as Partial<{ workDate: string; episode: string; category: string; title: string; owner: string; reviewer: string; plannedQty: number; dueTime: string; dependsOnId: string; handoffTo: string; handoffDeadline: string; note: string }>;
  if (!body.workDate || !body.title || !body.owner) return Response.json({ error: '日期、任务和负责人不能为空' }, { status: 400 });
  const row = {
    id: crypto.randomUUID(), workDate: body.workDate, episode: body.episode || '全片', category: body.category || '统筹',
    title: body.title, owner: body.owner, reviewer: body.reviewer || 'Yoyo', status: '未开始',
    plannedQty: Math.max(0, Number(body.plannedQty || 1)), completedQty: 0, dueTime: body.dueTime || '18:00',
    dependsOnId: body.dependsOnId || '', handoffTo: body.handoffTo || '', handoffDeadline: body.handoffDeadline || '',
    note: body.note || '', sortOrder: Date.now(), updatedAt: new Date().toISOString(),
  };
  try {
    await env.DB.prepare(`
      INSERT INTO production_items
      (id, work_date, episode, category, title, owner, reviewer, status, planned_qty, completed_qty, due_time, depends_on_id, handoff_to, handoff_deadline, note, sort_order, updated_at)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `).bind(row.id, row.workDate, row.episode, row.category, row.title, row.owner, row.reviewer, row.status, row.plannedQty, row.completedQty, row.dueTime, row.dependsOnId, row.handoffTo, row.handoffDeadline, row.note, row.sortOrder, row.updatedAt).run();
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
