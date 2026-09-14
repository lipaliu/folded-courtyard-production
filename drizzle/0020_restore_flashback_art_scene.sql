-- 第一场正文内的家暴闪回是独立美术空间；恢复上传入口并接回已归档参考图。
INSERT OR IGNORE INTO script_analysis_items
  (id, analysis_id, category, name, detail, visual_brief, yoyo_approved, producer_approved, sort_order, updated_at, is_active)
VALUES
  ('ep1-v3-s1-i02', 'ep1-v3-s1', '场景', '闪回｜20岁顾丽乔被前夫家暴的小家',
   '20岁的顾丽乔在逼仄的小家里被前夫家暴；这是第一场正文中的闪回空间，与复古教堂片场分开审核。',
   '单独上传小家完整空间、压迫氛围与必要局部；后续闪回和蒙太奇也各自建立独立场景项。',
   0, 0, 1, datetime('now'), 1);

UPDATE script_analysis_items
SET category='场景',
    name='闪回｜20岁顾丽乔被前夫家暴的小家',
    detail='20岁的顾丽乔在逼仄的小家里被前夫家暴；这是第一场正文中的闪回空间，与复古教堂片场分开审核。',
    visual_brief='单独上传小家完整空间、压迫氛围与必要局部；后续闪回和蒙太奇也各自建立独立场景项。',
    sort_order=1,
    is_active=1,
    updated_at=datetime('now')
WHERE id='ep1-v3-s1-i02';

INSERT OR IGNORE INTO art_submission_details
  (item_id, assigned_to, due_at, handoff_to, done_definition, status, submission_note, review_note, selected_file_id, submitted_at, reviewed_at, updated_at)
VALUES
  ('ep1-v3-s1-i02', '', '2026-09-14T20:00', 'Lipa',
   '上传小家完整空间、压迫氛围与必要局部，并与教堂片场分开审核。',
   CASE WHEN EXISTS(SELECT 1 FROM art_submission_files WHERE item_id='ep1-v3-s1-i02') THEN '已上传' ELSE '待上传' END,
   '', '', '', '', '', datetime('now'));

UPDATE art_submission_details
SET status=CASE WHEN EXISTS(SELECT 1 FROM art_submission_files WHERE item_id='ep1-v3-s1-i02') THEN '已上传' ELSE '待上传' END,
    done_definition='上传小家完整空间、压迫氛围与必要局部，并与教堂片场分开审核。',
    updated_at=datetime('now')
WHERE item_id='ep1-v3-s1-i02';

UPDATE production_items
SET planned_qty=(SELECT COUNT(*) FROM script_analysis_items i JOIN script_analyses a ON a.id=i.analysis_id WHERE a.episode=production_items.episode AND a.is_active=1 AND i.is_active=1),
    updated_at=datetime('now')
WHERE episode='第1集' AND category='美术清单';

INSERT INTO activity_log(item_type,item_id,action,operator,created_at)
VALUES('episode_assets','第1集','恢复第一场家暴闪回独立场景上传项并接回原参考图','Lipa',datetime('now'));
