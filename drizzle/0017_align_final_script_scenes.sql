-- The first finalized draft inserted a monitoring-room scene. The legacy work
-- items were reused by old scene number, so scenes 4-7 became offset by one.
-- Keep recoverable snapshots before moving any records.
CREATE TABLE IF NOT EXISTS art_scene_alignment_items_backup_0914 AS
SELECT * FROM script_analysis_items WHERE analysis_id IN ('ep1-v3-s4','ep1-v3-s5','ep1-v3-s6','ep1-v3-s7');
CREATE TABLE IF NOT EXISTS art_scene_alignment_details_backup_0914 AS
SELECT d.* FROM art_submission_details d JOIN script_analysis_items i ON i.id=d.item_id
WHERE i.analysis_id IN ('ep1-v3-s4','ep1-v3-s5','ep1-v3-s6','ep1-v3-s7');
CREATE TABLE IF NOT EXISTS art_scene_alignment_files_backup_0914 AS
SELECT f.* FROM art_submission_files f JOIN script_analysis_items i ON i.id=f.item_id
WHERE i.analysis_id IN ('ep1-v3-s4','ep1-v3-s5','ep1-v3-s6','ep1-v3-s7');

-- Put the already simplified work-item groups under their actual scene headings.
UPDATE script_analysis_items SET analysis_id='ep1-v3-s7', updated_at=datetime('now')
WHERE id IN ('ep1-v3-s6-auto-9','ep1-v3-s6-auto-1','ep1-v3-s6-heroine-wardrobe','ep1-v3-s6-overall-cast');
UPDATE script_analysis_items SET analysis_id='ep1-v3-s6', updated_at=datetime('now')
WHERE id IN ('ep1-v3-s5-auto-7','ep1-v3-s5-auto-1','ep1-v3-s5-hero-wardrobe','ep1-v3-s5-overall-cast');
UPDATE script_analysis_items SET analysis_id='ep1-v3-s5', updated_at=datetime('now')
WHERE id IN ('ep1-v3-s4-auto-7','ep1-v3-s4-overall-cast');

-- Merge the hospital material that was sitting under scene 7 into scene 6.
-- File ids and uploaded_by remain untouched, so every author attribution survives.
UPDATE art_submission_details SET selected_file_id=COALESCE(NULLIF(selected_file_id,''),
  (SELECT NULLIF(selected_file_id,'') FROM art_submission_details WHERE item_id='ep1-v3-s7-i01'),'')
WHERE item_id='ep1-v3-s5-auto-7';
UPDATE art_submission_details SET selected_file_id=COALESCE(NULLIF(selected_file_id,''),
  (SELECT NULLIF(selected_file_id,'') FROM art_submission_details WHERE item_id='ep1-v3-s7-i02'),'')
WHERE item_id='ep1-v3-s5-auto-1';
UPDATE art_submission_details SET selected_file_id=COALESCE(NULLIF(selected_file_id,''),
  (SELECT NULLIF(selected_file_id,'') FROM art_submission_details WHERE item_id='ep1-v3-s7-i03'),'')
WHERE item_id='ep1-v3-s5-hero-wardrobe';
UPDATE art_submission_details SET selected_file_id=COALESCE(NULLIF(selected_file_id,''),
  (SELECT NULLIF(selected_file_id,'') FROM art_submission_details WHERE item_id='ep1-v3-s7-overall-cast'),'')
WHERE item_id='ep1-v3-s5-overall-cast';

UPDATE art_submission_files SET item_id='ep1-v3-s5-auto-7' WHERE item_id='ep1-v3-s7-i01';
UPDATE art_submission_files SET item_id='ep1-v3-s5-auto-1' WHERE item_id='ep1-v3-s7-i02';
UPDATE art_submission_files SET item_id='ep1-v3-s5-hero-wardrobe' WHERE item_id='ep1-v3-s7-i03';
UPDATE art_submission_files SET item_id='ep1-v3-s5-overall-cast' WHERE item_id='ep1-v3-s7-overall-cast';

INSERT OR IGNORE INTO art_reference_exclusions(item_id,file_id,removed_by,created_at)
SELECT 'ep1-v3-s5-auto-7',file_id,removed_by,created_at FROM art_reference_exclusions WHERE item_id='ep1-v3-s7-i01';
INSERT OR IGNORE INTO art_reference_exclusions(item_id,file_id,removed_by,created_at)
SELECT 'ep1-v3-s5-auto-1',file_id,removed_by,created_at FROM art_reference_exclusions WHERE item_id='ep1-v3-s7-i02';
INSERT OR IGNORE INTO art_reference_exclusions(item_id,file_id,removed_by,created_at)
SELECT 'ep1-v3-s5-hero-wardrobe',file_id,removed_by,created_at FROM art_reference_exclusions WHERE item_id='ep1-v3-s7-i03';
INSERT OR IGNORE INTO art_reference_exclusions(item_id,file_id,removed_by,created_at)
SELECT 'ep1-v3-s5-overall-cast',file_id,removed_by,created_at FROM art_reference_exclusions WHERE item_id='ep1-v3-s7-overall-cast';
DELETE FROM art_reference_exclusions WHERE item_id IN ('ep1-v3-s7-i01','ep1-v3-s7-i02','ep1-v3-s7-i03','ep1-v3-s7-overall-cast');

UPDATE script_analysis_items SET yoyo_approved=MAX(yoyo_approved,COALESCE((SELECT yoyo_approved FROM script_analysis_items old WHERE old.id='ep1-v3-s7-i01'),0)), producer_approved=MAX(producer_approved,COALESCE((SELECT producer_approved FROM script_analysis_items old WHERE old.id='ep1-v3-s7-i01'),0)) WHERE id='ep1-v3-s5-auto-7';
UPDATE script_analysis_items SET yoyo_approved=MAX(yoyo_approved,COALESCE((SELECT yoyo_approved FROM script_analysis_items old WHERE old.id='ep1-v3-s7-i02'),0)), producer_approved=MAX(producer_approved,COALESCE((SELECT producer_approved FROM script_analysis_items old WHERE old.id='ep1-v3-s7-i02'),0)) WHERE id='ep1-v3-s5-auto-1';
UPDATE script_analysis_items SET yoyo_approved=MAX(yoyo_approved,COALESCE((SELECT yoyo_approved FROM script_analysis_items old WHERE old.id='ep1-v3-s7-i03'),0)), producer_approved=MAX(producer_approved,COALESCE((SELECT producer_approved FROM script_analysis_items old WHERE old.id='ep1-v3-s7-i03'),0)) WHERE id='ep1-v3-s5-hero-wardrobe';
UPDATE script_analysis_items SET is_active=0, updated_at=datetime('now')
WHERE id IN ('ep1-v3-s7-i01','ep1-v3-s7-i02','ep1-v3-s7-i03','ep1-v3-s7-overall-cast');

-- Scene 4 now gets a clean, ordered current-draft structure. Identical names
-- intentionally allow the existing reuse logic to paste references from scene 2.
INSERT OR IGNORE INTO script_analysis_items
(id,analysis_id,category,name,detail,visual_brief,yoyo_approved,producer_approved,sort_order,updated_at,is_active) VALUES
('ep1-v3-s4-current-scene','ep1-v3-s4','场景','东方庭院·临水巷道　日　内｜场景图','根据场头“东方庭院·临水巷道　日　内”建立本场空间。','一个场景上传位：先放完整氛围图，再追加局部与不同角度，不按文字拆多个场景项。',0,0,0,datetime('now'),1),
('ep1-v3-s4-current-heroine','ep1-v3-s4','人物','顾丽乔｜人脸、妆造、梳发','本场顾丽乔的人脸、妆造、梳发统一参考。','本场人脸、妆造、梳发集中在此，可上传多张备选。',0,0,10,datetime('now'),1),
('ep1-v3-s4-current-heroine-wardrobe','ep1-v3-s4','服装','顾丽乔｜服装','本场顾丽乔的完整穿搭。','同一上传位可放多张服装图，不按剧本句子拆分。',0,0,11,datetime('now'),1),
('ep1-v3-s4-current-hero','ep1-v3-s4','人物','陆文川｜人脸、妆造、梳发','本场陆文川的人脸、妆造、梳发统一参考。','本场人脸、妆造、梳发集中在此，可上传多张备选。',0,0,20,datetime('now'),1),
('ep1-v3-s4-current-hero-wardrobe','ep1-v3-s4','服装','陆文川｜服装','本场陆文川的完整穿搭。','同一上传位可放多张服装图，不按剧本句子拆分。',0,0,21,datetime('now'),1);

-- Normalize labels and ordering for scenes 5-7 after the move.
UPDATE script_analysis_items SET name='影视城监控室　夜　内｜场景图', detail='根据场头“影视城监控室　夜　内”建立本场空间。', sort_order=0, updated_at=datetime('now') WHERE id='ep1-v3-s4-auto-7';
UPDATE script_analysis_items SET name='医院病房　深夜　内｜场景图', detail='根据场头“医院病房　深夜　内”建立本场空间。', sort_order=0, updated_at=datetime('now') WHERE id='ep1-v3-s5-auto-7';
UPDATE script_analysis_items SET name='群演酒店标间　深夜　内｜场景图', detail='根据场头“群演酒店标间　深夜　内”建立本场空间。', sort_order=0, updated_at=datetime('now') WHERE id='ep1-v3-s6-auto-9';
UPDATE script_analysis_items SET sort_order=10 WHERE id IN ('ep1-v3-s5-auto-1','ep1-v3-s6-auto-1');
UPDATE script_analysis_items SET sort_order=11 WHERE id='ep1-v3-s6-heroine-wardrobe';
UPDATE script_analysis_items SET sort_order=21 WHERE id='ep1-v3-s5-hero-wardrobe';
UPDATE script_analysis_items SET sort_order=800 WHERE id IN ('ep1-v3-s4-overall-cast','ep1-v3-s5-overall-cast','ep1-v3-s6-overall-cast');

INSERT OR IGNORE INTO art_submission_details
(item_id,assigned_to,due_at,handoff_to,done_definition,status,submission_note,review_note,selected_file_id,submitted_at,reviewed_at,updated_at)
SELECT id,'','2026-09-14T20:00','Lipa',visual_brief,'待上传','','','','','',datetime('now')
FROM script_analysis_items WHERE id LIKE 'ep1-v3-s4-current-%';

UPDATE art_submission_details SET status=CASE WHEN EXISTS(SELECT 1 FROM art_submission_files f WHERE f.item_id=art_submission_details.item_id) THEN CASE WHEN status='已锁定' THEN '已锁定' ELSE '已上传' END ELSE '待上传' END, review_note='', updated_at=datetime('now')
WHERE item_id IN ('ep1-v3-s4-current-scene','ep1-v3-s4-current-heroine','ep1-v3-s4-current-heroine-wardrobe','ep1-v3-s4-current-hero','ep1-v3-s4-current-hero-wardrobe','ep1-v3-s4-auto-7','ep1-v3-s4-overall-cast','ep1-v3-s5-auto-7','ep1-v3-s5-auto-1','ep1-v3-s5-hero-wardrobe','ep1-v3-s5-overall-cast','ep1-v3-s6-auto-9','ep1-v3-s6-auto-1','ep1-v3-s6-heroine-wardrobe','ep1-v3-s6-overall-cast');

UPDATE production_items SET planned_qty=(SELECT COUNT(*) FROM script_analysis_items i JOIN script_analyses a ON a.id=i.analysis_id WHERE a.episode=production_items.episode AND a.is_active=1 AND i.is_active=1), updated_at=datetime('now') WHERE category='美术清单';
INSERT INTO activity_log(item_type,item_id,action,operator,created_at) VALUES('episode_assets','第1集','按定稿场头校正第4—7场工作项：临水巷道、监控室、医院、酒店；保留全部图片和上传作者','Lipa',datetime('now'));
