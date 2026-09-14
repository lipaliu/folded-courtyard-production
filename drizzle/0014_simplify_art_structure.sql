-- Preserve original item definitions, review notes and file ownership before regrouping.
CREATE TABLE IF NOT EXISTS art_structure_backup_0914 AS SELECT * FROM script_analysis_items;
CREATE TABLE IF NOT EXISTS art_detail_backup_0914 AS SELECT * FROM art_submission_details;
CREATE TABLE IF NOT EXISTS art_file_ownership_backup_0914 AS SELECT id, item_id, uploaded_by, file_name FROM art_submission_files;

INSERT OR IGNORE INTO script_analysis_items (id, analysis_id, category, name, detail, visual_brief, yoyo_approved, producer_approved, sort_order, updated_at, is_active)
SELECT a.id || '-overall-cast', a.id, '服装', '配角与群演｜整体参考', '本场配角、群演整体形象与服装集中上传；历史参考全部保留。', '一个整体参考上传位，可追加多张备选，不逐人拆分。', 0, 0, 800, datetime('now'), 1
FROM script_analyses a WHERE a.is_active=1 AND EXISTS (SELECT 1 FROM script_analysis_items i WHERE i.analysis_id=a.id AND i.is_active=1 AND i.category='人物' AND i.name NOT LIKE '%顾丽乔%' AND i.name NOT LIKE '%陆文川%');

UPDATE art_submission_files SET item_id = (SELECT i.analysis_id || '-overall-cast' FROM script_analysis_items i WHERE i.id=art_submission_files.item_id)
WHERE item_id IN (SELECT i.id FROM script_analysis_items i JOIN script_analyses a ON a.id=i.analysis_id WHERE a.is_active=1 AND i.is_active=1 AND i.category='人物' AND i.name NOT LIKE '%顾丽乔%' AND i.name NOT LIKE '%陆文川%');

UPDATE script_analysis_items SET is_active=0 WHERE id IN (SELECT i.id FROM script_analysis_items i JOIN script_analyses a ON a.id=i.analysis_id WHERE a.is_active=1 AND i.is_active=1 AND i.category='人物' AND i.name NOT LIKE '%顾丽乔%' AND i.name NOT LIKE '%陆文川%');

INSERT OR IGNORE INTO script_analysis_items (id, analysis_id, category, name, detail, visual_brief, yoyo_approved, producer_approved, sort_order, updated_at, is_active)
SELECT i.analysis_id || CASE WHEN i.name LIKE '%顾丽乔%' THEN '-heroine-wardrobe' ELSE '-hero-wardrobe' END, i.analysis_id, '服装', CASE WHEN i.name LIKE '%顾丽乔%' THEN '顾丽乔｜服装' ELSE '陆文川｜服装' END, '本场该角色服装，请团队上传完整穿搭与备选。', '同一上传位可放多张服装图，不按剧本句子拆分。', 0, 0, CASE WHEN i.name LIKE '%顾丽乔%' THEN 11 ELSE 21 END, datetime('now'), 1
FROM script_analysis_items i JOIN script_analyses a ON a.id=i.analysis_id WHERE a.is_active=1 AND i.is_active=1 AND i.category='人物' AND (i.name LIKE '%顾丽乔%' OR i.name LIKE '%陆文川%')
AND NOT EXISTS (SELECT 1 FROM script_analysis_items w WHERE w.analysis_id=i.analysis_id AND w.is_active=1 AND w.category='服装' AND ((i.name LIKE '%顾丽乔%' AND w.name LIKE '%顾丽乔%') OR (i.name LIKE '%陆文川%' AND w.name LIKE '%陆文川%')));

UPDATE script_analysis_items SET name=CASE WHEN name LIKE '%顾丽乔%' THEN '顾丽乔｜人脸、妆造、梳发' ELSE '陆文川｜人脸、妆造、梳发' END, visual_brief='本场人脸、妆造、梳发集中在此，可上传多张备选。'
WHERE is_active=1 AND category='人物' AND (name LIKE '%顾丽乔%' OR name LIKE '%陆文川%');

UPDATE script_analysis_items SET is_active=0 WHERE is_active=1 AND (category='道具' OR category='美术图' OR (category='服装' AND name LIKE '本场%')) AND NOT EXISTS (SELECT 1 FROM art_submission_files f WHERE f.item_id=script_analysis_items.id);
UPDATE script_analysis_items SET name='历史服装备选（待确认角色）', detail='保留原有全部上传图与作者，尚未人工确认角色归属；不擅自当成女主或男主服装。', visual_brief='Lipa可把图片移到对应角色服装项。', sort_order=850 WHERE is_active=1 AND category='服装' AND name LIKE '本场%';
UPDATE script_analysis_items SET visual_brief='一个场景上传位：先放完整氛围图，再追加局部与不同角度，不按文字拆多个场景项。', sort_order=0 WHERE is_active=1 AND category='场景';

INSERT OR IGNORE INTO art_submission_details (item_id, assigned_to, due_at, handoff_to, done_definition, status, submission_note, review_note, selected_file_id, submitted_at, reviewed_at, updated_at)
SELECT i.id, '', '2026-09-14T20:00', 'Lipa', i.visual_brief, CASE WHEN EXISTS(SELECT 1 FROM art_submission_files f WHERE f.item_id=i.id) THEN '已上传' ELSE '待上传' END, '', '', '', '', '', datetime('now') FROM script_analysis_items i WHERE i.is_active=1;

UPDATE production_items SET planned_qty=(SELECT COUNT(*) FROM script_analysis_items i JOIN script_analyses a ON a.id=i.analysis_id WHERE a.episode=production_items.episode AND a.is_active=1 AND i.is_active=1) WHERE category='美术清单';
