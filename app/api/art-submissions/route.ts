import { env } from 'cloudflare:workers';
import { requireMember } from '@/lib/auth';
import { canEditArtCategory, roleCanSeeArt } from '@/lib/team-roles';

const allowedImageTypes = new Set(['image/jpeg', 'image/png', 'image/webp']);
const submissionStatuses = ['待上传', '已上传', '待审核', '打回', '已锁定', '需复核'] as const;

function canEditArt(user: { isAdmin: boolean; role: string }) {
  return user.isAdmin || roleCanSeeArt(user.role);
}

function safePart(value: string) {
  return value.normalize('NFKC').replace(/[^\p{L}\p{N}._-]+/gu, '-').replace(/^-+|-+$/g, '').slice(0, 80) || 'asset';
}

export async function GET(request: Request) {
  const user = await requireMember(request);
  if (!user) return Response.json({ error: '请先登录并注册岗位' }, { status: 401 });
  try {
    const [details, files, exclusions] = await Promise.all([
      env.DB.prepare(`SELECT item_id AS itemId, assigned_to AS assignedTo, due_at AS dueAt,
        handoff_to AS handoffTo, done_definition AS doneDefinition, status,
        submission_note AS submissionNote, review_note AS reviewNote,
        selected_file_id AS selectedFileId, reuse_source_item_id AS reuseSourceItemId,
        submitted_at AS submittedAt, reviewed_at AS reviewedAt, updated_at AS updatedAt
        FROM art_submission_details ORDER BY updated_at DESC`).all(),
      env.DB.prepare(`SELECT id, item_id AS itemId, file_name AS fileName, content_type AS contentType,
        byte_size AS byteSize, uploaded_by AS uploadedBy, sort_order AS sortOrder, created_at AS createdAt
        FROM art_submission_files ORDER BY item_id, sort_order, created_at`).all<{ id: string; itemId: string; fileName: string; contentType: string; byteSize: number; uploadedBy: string; sortOrder: number; createdAt: string }>(),
      env.DB.prepare('SELECT item_id AS itemId, file_id AS fileId FROM art_reference_exclusions').all(),
    ]);
    return Response.json({
      exclusions: exclusions.results,
      details: details.results,
      files: files.results.map((file) => ({ ...file, url: `/api/art-submissions/file/${file.id}` })),
      canEdit: canEditArt(user),
    });
  } catch (error) {
    return Response.json({ details: [], files: [], error: error instanceof Error ? error.message : '读取提报资料失败' });
  }
}

export async function POST(request: Request) {
  const user = await requireMember(request);
  if (!user) return Response.json({ error: '请先登录并注册岗位' }, { status: 401 });
  if (!canEditArt(user)) return Response.json({ error: '只有Lipa、主美、美术或服化道副导演可以上传参考图' }, { status: 403 });

  const form = await request.formData();
  const itemIdValue = form.get('itemId');
  const itemId = typeof itemIdValue === 'string' ? itemIdValue.trim() : '';
  const file = form.get('file');
  if (!itemId || !(file instanceof File)) return Response.json({ error: '请选择要上传的图片' }, { status: 400 });
  if (!allowedImageTypes.has(file.type)) return Response.json({ error: '只支持 JPG、PNG 或 WebP 图片' }, { status: 400 });
  if (file.size <= 0 || file.size > 12 * 1024 * 1024) return Response.json({ error: '单张图片必须小于12MB' }, { status: 400 });

  const item = await env.DB.prepare(`SELECT i.id, i.category, a.episode, a.scene_no AS sceneNo
    FROM script_analysis_items i JOIN script_analyses a ON a.id = i.analysis_id WHERE i.id = ? AND i.is_active = 1 AND a.is_active = 1`).bind(itemId).first<{ id: string; category: string; episode: string; sceneNo: number }>();
  if (!item) return Response.json({ error: '工作项不存在或已经更新' }, { status: 404 });
  if (!canEditArtCategory(user, item.category)) return Response.json({ error: '服化道副导演只可上传场景和角色服装' }, { status: 403 });

  const extension = file.type === 'image/png' ? 'png' : file.type === 'image/webp' ? 'webp' : 'jpg';
  const id = crypto.randomUUID();
  const artAssets = (env as unknown as { ART_ASSETS?: R2Bucket }).ART_ASSETS;
  if (!artAssets && file.size > 1_600_000) return Response.json({ error: '图片过大，请压缩到1.5MB以再上传' }, { status: 400 });
  const objectKey = artAssets ? `art-submissions/${safePart(item.episode)}/scene-${item.sceneNo}/${safePart(itemId)}/${id}.${extension}` : `d1:${id}`;
  const fileBytes = await file.arrayBuffer();
  const now = new Date().toISOString();
  const sortRow = await env.DB.prepare('SELECT COALESCE(MAX(sort_order), 0) AS maxSort FROM art_submission_files WHERE item_id = ?').bind(itemId).first<{ maxSort: number }>();
  try {
    if (artAssets) await artAssets.put(objectKey, fileBytes, {
      httpMetadata: { contentType: file.type, cacheControl: 'private, max-age=3600' },
      customMetadata: { itemId, episode: item.episode, sceneNo: String(item.sceneNo), uploadedBy: user.name },
    });
    await env.DB.batch([
      env.DB.prepare(`INSERT INTO art_submission_files
        (id, item_id, object_key, file_name, content_type, byte_size, uploaded_by, sort_order, file_data, created_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`).bind(id, itemId, objectKey, file.name.slice(0, 180), file.type, file.size, user.name, Number(sortRow?.maxSort || 0) + 1, artAssets ? null : fileBytes, now),
      env.DB.prepare(`INSERT OR IGNORE INTO art_submission_details
        (item_id, assigned_to, due_at, handoff_to, done_definition, status, submission_note, review_note, submitted_at, reviewed_at, updated_at)
        VALUES (?, ?, '', 'Lipa', '', '待上传', '', '', '', '', ?)`).bind(itemId, user.name, now),
      env.DB.prepare(`UPDATE art_submission_details SET status = CASE WHEN status = '已锁定' THEN status ELSE '已上传' END,
        reuse_source_item_id = '', assigned_to = CASE WHEN assigned_to = '' THEN ? ELSE assigned_to END, submitted_at = ?, updated_at = ? WHERE item_id = ?`).bind(user.name, now, now, itemId),
      env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)').bind('art_submission_file', id, `上传参考图：${file.name.slice(0, 120)}`, user.name, now),
    ]);
  } catch (error) {
    await artAssets?.delete(objectKey).catch(() => undefined);
    return Response.json({ error: error instanceof Error ? error.message : '图片上传失败' }, { status: 500 });
  }
  const savedDetail = await env.DB.prepare('SELECT status, selected_file_id AS selectedFileId FROM art_submission_details WHERE item_id = ?').bind(itemId).first<{ status: string; selectedFileId: string }>();

  return Response.json({
    ok: true,
    file: { id, itemId, fileName: file.name, contentType: file.type, byteSize: file.size, uploadedBy: user.name, sortOrder: Number(sortRow?.maxSort || 0) + 1, createdAt: now, url: `/api/art-submissions/file/${id}` },
    detail: { itemId, status: savedDetail?.status || '已上传', selectedFileId: savedDetail?.selectedFileId || '', submittedAt: now, updatedAt: now },
  });
}

export async function PATCH(request: Request) {
  const user = await requireMember(request);
  if (!user) return Response.json({ error: '请先登录并注册岗位' }, { status: 401 });
  if (!canEditArt(user)) return Response.json({ error: '只有Lipa、主美、美术或服化道副导演可以更新提报项' }, { status: 403 });
  const body = await request.json() as Partial<{
    itemId: string; assignedTo: string; dueAt: string; handoffTo: string; doneDefinition: string;
    moveFileId: string;
    status: typeof submissionStatuses[number]; submissionNote: string; reviewNote: string; selectedFileId: string; reuseSourceItemId: string;
  }>;
  if (!body.itemId) return Response.json({ error: '缺少工作项ID' }, { status: 400 });
  const itemExists = await env.DB.prepare('SELECT id, category FROM script_analysis_items WHERE id = ?').bind(body.itemId).first<{ id: string; category: string }>();
  if (!itemExists) return Response.json({ error: '工作项不存在' }, { status: 404 });
  if (!canEditArtCategory(user, itemExists.category)) return Response.json({ error: '服化道副导演只可更新场景和角色服装' }, { status: 403 });
  if (body.moveFileId) {
    if (!user.isAdmin) return Response.json({ error: '只有Lipa可以调整图片归属' }, { status: 403 });
    const source = await env.DB.prepare('SELECT f.item_id AS itemId, i.analysis_id AS analysisId FROM art_submission_files f JOIN script_analysis_items i ON i.id=f.item_id WHERE f.id=?').bind(body.moveFileId).first<{ itemId: string; analysisId: string }>();
    const target = await env.DB.prepare('SELECT analysis_id AS analysisId FROM script_analysis_items WHERE id=? AND is_active=1').bind(body.itemId).first<{ analysisId: string }>();
    if (!source || !target || source.analysisId !== target.analysisId) return Response.json({ error: '只能移到同一场的资产项' }, { status: 400 });
    const now = new Date().toISOString();
    await env.DB.batch([
      env.DB.prepare('UPDATE art_submission_files SET item_id=? WHERE id=?').bind(body.itemId, body.moveFileId),
      env.DB.prepare("UPDATE art_submission_details SET selected_file_id='', status='需复核', updated_at=? WHERE item_id=? AND selected_file_id=?").bind(now, source.itemId, body.moveFileId),
      env.DB.prepare("INSERT INTO art_submission_details (item_id, assigned_to, due_at, handoff_to, done_definition, status, submission_note, review_note, submitted_at, reviewed_at, updated_at) VALUES (?, '', '', 'Lipa', '', '已上传', '', '', '', '', ?) ON CONFLICT(item_id) DO UPDATE SET status=CASE WHEN status='已锁定' THEN status ELSE '已上传' END, updated_at=excluded.updated_at").bind(body.itemId, now),
      env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)').bind('art_submission_file', body.moveFileId, '调整归属：' + source.itemId + ' → ' + body.itemId, user.name, now),
    ]);
    return Response.json({ ok: true });
  }
  const current = await env.DB.prepare(`SELECT assigned_to AS assignedTo, due_at AS dueAt, handoff_to AS handoffTo,
    done_definition AS doneDefinition, status, submission_note AS submissionNote, review_note AS reviewNote,
    selected_file_id AS selectedFileId, reuse_source_item_id AS reuseSourceItemId,
    submitted_at AS submittedAt, reviewed_at AS reviewedAt FROM art_submission_details WHERE item_id = ?`).bind(body.itemId).first<Record<string, string>>();
  const selectionChanged = Object.prototype.hasOwnProperty.call(body, 'selectedFileId');
  const reuseChanged = Object.prototype.hasOwnProperty.call(body, 'reuseSourceItemId');
  if (selectionChanged && !user.isAdmin) return Response.json({ error: '只有Lipa可以选择定稿图' }, { status: 403 });
  if (reuseChanged && !user.isAdmin) return Response.json({ error: '只有Lipa可以确认本场沿用其他场次' }, { status: 403 });
  const selectedFileId = selectionChanged ? String(body.selectedFileId || '').trim().slice(0, 100) : (current?.selectedFileId || '');
  if (selectedFileId) {
    const selectedFile = await env.DB.prepare('SELECT id FROM art_submission_files WHERE id = ? AND item_id = ?').bind(selectedFileId, body.itemId).first<{ id: string }>();
    if (!selectedFile) return Response.json({ error: '所选图片不属于当前资产项' }, { status: 400 });
  }
  const reuseSourceItemId = reuseChanged ? String(body.reuseSourceItemId || '').trim().slice(0, 100) : (current?.reuseSourceItemId || '');
  if (reuseSourceItemId) {
    const source = await env.DB.prepare(`SELECT source.id FROM script_analysis_items target
      JOIN script_analyses target_scene ON target_scene.id=target.analysis_id
      JOIN script_analysis_items source ON source.id=? AND source.category=target.category AND source.is_active=1
      JOIN script_analyses source_scene ON source_scene.id=source.analysis_id AND source_scene.episode=target_scene.episode
      WHERE target.id=? AND source_scene.scene_no < target_scene.scene_no
      AND EXISTS(SELECT 1 FROM art_submission_files f WHERE f.item_id=source.id)`).bind(reuseSourceItemId, body.itemId).first<{ id: string }>();
    if (!source) return Response.json({ error: '只能沿用同集前面场次中已有图片的同类资产' }, { status: 400 });
  }
  const requestedStatus = selectedFileId || reuseSourceItemId ? '已锁定' : body.status && submissionStatuses.includes(body.status) ? body.status : (current?.status || '待上传');
  if (!user.isAdmin && ['打回', '已锁定'].includes(requestedStatus)) return Response.json({ error: '只有Lipa可以打回或锁定提报项' }, { status: 403 });
  const now = new Date().toISOString();
  const detail = {
    itemId: body.itemId,
    assignedTo: String(body.assignedTo ?? current?.assignedTo ?? user.name).trim().slice(0, 80),
    dueAt: String(body.dueAt ?? current?.dueAt ?? '').trim().slice(0, 40),
    handoffTo: String(body.handoffTo ?? current?.handoffTo ?? 'Lipa').trim().slice(0, 80),
    doneDefinition: String(body.doneDefinition ?? current?.doneDefinition ?? '').trim().slice(0, 1000),
    status: requestedStatus,
    submissionNote: String(body.submissionNote ?? current?.submissionNote ?? '').trim().slice(0, 1000),
    reviewNote: String(body.reviewNote ?? current?.reviewNote ?? '').trim().slice(0, 1000),
    selectedFileId,
    reuseSourceItemId,
    submittedAt: current?.submittedAt || '',
    reviewedAt: user.isAdmin && ['打回', '已锁定'].includes(requestedStatus) ? now : (current?.reviewedAt || ''),
    updatedAt: now,
  };
  if (!selectionChanged && (!detail.assignedTo || !detail.dueAt || !detail.handoffTo || !detail.doneDefinition)) return Response.json({ error: '责任人、截止时间、下一交接人和完成定义都必须填写' }, { status: 400 });
  await env.DB.batch([
    env.DB.prepare(`INSERT INTO art_submission_details
      (item_id, assigned_to, due_at, handoff_to, done_definition, status, submission_note, review_note, selected_file_id, reuse_source_item_id, submitted_at, reviewed_at, updated_at)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      ON CONFLICT(item_id) DO UPDATE SET assigned_to = excluded.assigned_to, due_at = excluded.due_at,
        handoff_to = excluded.handoff_to, done_definition = excluded.done_definition, status = excluded.status,
        submission_note = excluded.submission_note, review_note = excluded.review_note,
        selected_file_id = excluded.selected_file_id, reuse_source_item_id = excluded.reuse_source_item_id,
        reviewed_at = excluded.reviewed_at, updated_at = excluded.updated_at`)
      .bind(detail.itemId, detail.assignedTo, detail.dueAt, detail.handoffTo, detail.doneDefinition, detail.status, detail.submissionNote, detail.reviewNote, detail.selectedFileId, detail.reuseSourceItemId, detail.submittedAt, detail.reviewedAt, detail.updatedAt),
    env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)').bind('art_submission_detail', detail.itemId, reuseChanged ? (detail.reuseSourceItemId ? `确认沿用资产：${detail.reuseSourceItemId}` : '取消沿用资产') : selectionChanged ? (detail.selectedFileId ? `选择定稿图：${detail.selectedFileId}` : '取消定稿图') : `提报状态更新为${detail.status}，责任人${detail.assignedTo}，截止${detail.dueAt}`, user.name, now),
  ]);
  return Response.json({ ok: true, detail });
}

export async function DELETE(request: Request) {
  const user = await requireMember(request);
  if (!user) return Response.json({ error: '请先登录并注册岗位' }, { status: 401 });
  if (!canEditArt(user)) return Response.json({ error: '只有Lipa、主美、美术或服化道副导演可以删除上传错误的图片' }, { status: 403 });
  const body = await request.json() as { fileId?: string; itemId?: string };
  if (!body.fileId) return Response.json({ error: '缺少图片ID' }, { status: 400 });
  const file = await env.DB.prepare('SELECT f.id, f.item_id AS itemId, f.object_key AS objectKey, f.uploaded_by AS uploadedBy, i.category FROM art_submission_files f JOIN script_analysis_items i ON i.id = f.item_id WHERE f.id = ?').bind(body.fileId).first<{ id: string; itemId: string; objectKey: string; uploadedBy: string; category: string }>();
  if (!file) return Response.json({ error: '图片不存在' }, { status: 404 });
  if (!canEditArtCategory(user, file.category)) return Response.json({ error: '只能管理有权限的场景和角色服装图片' }, { status: 403 });
  if (body.itemId && body.itemId !== file.itemId) {
    const target = await env.DB.prepare('SELECT category FROM script_analysis_items WHERE id = ? AND is_active = 1').bind(body.itemId).first<{ category: string }>();
    if (!target || !canEditArtCategory(user, target.category)) return Response.json({ error: '不能修改此资产项' }, { status: 403 });
    const now = new Date().toISOString();
    await env.DB.batch([
      env.DB.prepare('INSERT OR IGNORE INTO art_reference_exclusions (item_id, file_id, removed_by, created_at) VALUES (?, ?, ?, ?)').bind(body.itemId, file.id, user.name, now),
      env.DB.prepare("UPDATE art_submission_details SET selected_file_id = '', status = '需复核', updated_at = ? WHERE item_id = ? AND selected_file_id = ?").bind(now, body.itemId, file.id),
      env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)').bind('art_submission_detail', body.itemId, '从本场移除复用图：' + file.id, user.name, now),
    ]);
    return Response.json({ ok: true, fileId: file.id, itemId: body.itemId, excluded: true });
  }
  const artAssets = (env as unknown as { ART_ASSETS?: R2Bucket }).ART_ASSETS;
  if (!file.objectKey.startsWith('static:') && !file.objectKey.startsWith('d1:')) await artAssets?.delete(file.objectKey);
  await env.DB.batch([
    env.DB.prepare('DELETE FROM art_submission_files WHERE id = ?').bind(file.id),
    env.DB.prepare(`UPDATE art_submission_details SET status = CASE WHEN (SELECT COUNT(*) FROM art_submission_files WHERE item_id = ?) = 0 THEN '待上传' WHEN selected_file_id = ? THEN '已上传' ELSE status END,
      selected_file_id = CASE WHEN selected_file_id = ? THEN '' ELSE selected_file_id END,
      updated_at = ? WHERE item_id = ?`).bind(file.itemId, file.id, file.id, new Date().toISOString(), file.itemId),
    env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)').bind('art_submission_file', file.id, '删除错误参考图', user.name, new Date().toISOString()),
  ]);
  return Response.json({ ok: true, fileId: file.id, itemId: file.itemId });
}
