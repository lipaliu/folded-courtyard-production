-- 第一场历史服装备选经 Lipa 人工确认，全部属于顾丽乔。
-- 先保留可恢复快照；移动时不改文件 id、对象键、上传作者或上传时间。
CREATE TABLE IF NOT EXISTS art_scene1_wardrobe_items_backup_0914 AS
SELECT * FROM script_analysis_items
WHERE id IN ('ep1-v3-s1-auto-10','ep1-v3-s1-heroine-wardrobe');

CREATE TABLE IF NOT EXISTS art_scene1_wardrobe_details_backup_0914 AS
SELECT * FROM art_submission_details
WHERE item_id IN ('ep1-v3-s1-auto-10','ep1-v3-s1-heroine-wardrobe');

CREATE TABLE IF NOT EXISTS art_scene1_wardrobe_files_backup_0914 AS
SELECT * FROM art_submission_files
WHERE item_id IN ('ep1-v3-s1-auto-10','ep1-v3-s1-heroine-wardrobe');

UPDATE art_submission_details
SET selected_file_id=COALESCE(
  NULLIF(selected_file_id,''),
  (SELECT NULLIF(selected_file_id,'') FROM art_submission_details WHERE item_id='ep1-v3-s1-auto-10'),
  ''
)
WHERE item_id='ep1-v3-s1-heroine-wardrobe';

INSERT OR IGNORE INTO art_reference_exclusions(item_id,file_id,removed_by,created_at)
SELECT 'ep1-v3-s1-heroine-wardrobe',file_id,removed_by,created_at
FROM art_reference_exclusions
WHERE item_id='ep1-v3-s1-auto-10';

DELETE FROM art_reference_exclusions WHERE item_id='ep1-v3-s1-auto-10';

UPDATE art_submission_files
SET item_id='ep1-v3-s1-heroine-wardrobe'
WHERE item_id='ep1-v3-s1-auto-10';

UPDATE script_analysis_items
SET name='顾丽乔｜服装',
    detail='第一场顾丽乔的完整穿搭；原历史服装备选已确认并全部归入本项。',
    visual_brief='同一上传位可放多张服装图，不按剧本句子拆分。',
    yoyo_approved=MAX(yoyo_approved,COALESCE((SELECT yoyo_approved FROM script_analysis_items WHERE id='ep1-v3-s1-auto-10'),0)),
    producer_approved=MAX(producer_approved,COALESCE((SELECT producer_approved FROM script_analysis_items WHERE id='ep1-v3-s1-auto-10'),0)),
    sort_order=11,
    updated_at=datetime('now'),
    is_active=1
WHERE id='ep1-v3-s1-heroine-wardrobe';

UPDATE script_analysis_items
SET is_active=0, updated_at=datetime('now')
WHERE id='ep1-v3-s1-auto-10';

UPDATE art_submission_details
SET status=CASE
      WHEN EXISTS(SELECT 1 FROM art_submission_files f WHERE f.item_id='ep1-v3-s1-heroine-wardrobe')
      THEN CASE WHEN status='已锁定' THEN '已锁定' ELSE '已上传' END
      ELSE '待上传'
    END,
    review_note='',
    updated_at=datetime('now')
WHERE item_id='ep1-v3-s1-heroine-wardrobe';

UPDATE production_items
SET planned_qty=(
      SELECT COUNT(*)
      FROM script_analysis_items i
      JOIN script_analyses a ON a.id=i.analysis_id
      WHERE a.episode=production_items.episode AND a.is_active=1 AND i.is_active=1
    ),
    updated_at=datetime('now')
WHERE category='美术清单';

INSERT INTO activity_log(item_type,item_id,action,operator,created_at)
VALUES('episode_assets','第1集','第一场历史服装备选全部归入顾丽乔服装；保留文件与真实上传作者','Lipa',datetime('now'));
