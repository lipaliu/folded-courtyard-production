-- Lipa explicitly requested vehicle exterior and cabin mood upload slots.
-- Add to the verified current episode 2 / scene 6 without replacing any asset.
UPDATE script_analysis_items SET sort_order=sort_order+2
WHERE analysis_id='final-script-version-ep2-20260916-bingbing-6' AND sort_order>0
  AND NOT EXISTS (SELECT 1 FROM script_analysis_items WHERE id='ep2-v1-s6-vehicle-exterior');

INSERT OR IGNORE INTO script_analysis_items
  (id,analysis_id,category,name,detail,visual_brief,yoyo_approved,producer_approved,sort_order,updated_at,is_active)
SELECT 'ep2-v1-s6-vehicle-exterior',id,'场景','陆文川的车｜外观参考',
  '本场陆文川乘坐的车辆外观备选，与前一场接上顾丽乔的车保持连续。当前剧本提到宾利；具体车型、车身颜色与外观方案由Lipa选择。',
  '上传大家对这辆车的想象图：整车外形、正侧面、车门和车窗视角等。可一次多选或拖入多张备选，不要求先确定唯一车型。',
  0,0,1,strftime('%Y-%m-%dT%H:%M:%fZ','now'),1
FROM script_analyses WHERE id='final-script-version-ep2-20260916-bingbing-6' AND episode='第2集' AND scene_no=6 AND is_active=1;

INSERT OR IGNORE INTO script_analysis_items
  (id,analysis_id,category,name,detail,visual_brief,yoyo_approved,producer_approved,sort_order,updated_at,is_active)
SELECT 'ep2-v1-s6-vehicle-interior',id,'场景','陆文川的车｜内饰氛围',
  '顾丽乔与陆文川坐在后排交谈。当前剧本明确车内干净整洁、奢华；内饰配色、座椅材质、空间与灯光感觉均是待选方案，不视作已定稿。',
  '集中上传车内饰想象图：后排整体、双人座位空间、门板与座椅材质、夜间车内灯光和窗外氛围。允许多张、多种方向，最终由Lipa选定。',
  0,0,2,strftime('%Y-%m-%dT%H:%M:%fZ','now'),1
FROM script_analyses WHERE id='final-script-version-ep2-20260916-bingbing-6' AND episode='第2集' AND scene_no=6 AND is_active=1;

INSERT OR IGNORE INTO art_submission_details
  (item_id,assigned_to,due_at,handoff_to,done_definition,status,submission_note,review_note,submitted_at,reviewed_at,updated_at)
SELECT id,'主美、服化道副导演','','Lipa',visual_brief,'待上传','','','','',strftime('%Y-%m-%dT%H:%M:%fZ','now')
FROM script_analysis_items WHERE id IN ('ep2-v1-s6-vehicle-exterior','ep2-v1-s6-vehicle-interior');

UPDATE script_versions SET item_count=(SELECT COUNT(*) FROM script_analysis_items i JOIN script_analyses a ON a.id=i.analysis_id WHERE a.script_version_id=script_versions.id AND a.is_active=1 AND i.is_active=1)
WHERE id='script-version-ep2-20260916-bingbing';

UPDATE production_items SET planned_qty=(SELECT COUNT(*) FROM script_analysis_items i JOIN script_analyses a ON a.id=i.analysis_id WHERE a.episode='第2集' AND a.is_active=1 AND i.is_active=1 AND (production_items.owner!='服化道副导演' OR i.category IN ('场景','服装'))),updated_at=strftime('%Y-%m-%dT%H:%M:%fZ','now')
WHERE episode='第2集' AND category='美术清单' AND owner IN ('主美','服化道副导演');

INSERT INTO activity_log(item_type,item_id,action,operator,created_at)
SELECT 'script_analysis','final-script-version-ep2-20260916-bingbing-6','按Lipa要求补充车辆外观与内饰氛围两项上传位，保留原场景、人物、图片与审核记录。','Lipa',strftime('%Y-%m-%dT%H:%M:%fZ','now')
WHERE EXISTS(SELECT 1 FROM script_analysis_items WHERE id='ep2-v1-s6-vehicle-interior')
AND NOT EXISTS(SELECT 1 FROM activity_log WHERE item_id='final-script-version-ep2-20260916-bingbing-6' AND action='按Lipa要求补充车辆外观与内饰氛围两项上传位，保留原场景、人物、图片与审核记录。');
