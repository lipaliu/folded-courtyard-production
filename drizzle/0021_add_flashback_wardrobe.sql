-- 第一场家暴闪回按“场景→20岁顾丽乔穿搭→家暴男穿搭”独立上传和审核。
UPDATE script_analysis_items
SET sort_order=2,
    updated_at=datetime('now')
WHERE id='ep1-v3-s1-i02';

INSERT OR IGNORE INTO script_analysis_items
  (id, analysis_id, category, name, detail, visual_brief, yoyo_approved, producer_approved, sort_order, updated_at, is_active)
VALUES
  ('ep1-v3-s1-i12', 'ep1-v3-s1', '服装', '闪回｜20岁顾丽乔穿搭',
   '20岁顾丽乔在小家遭遇家暴时的完整穿搭，与片场服装分开审核。',
   '上传完整穿搭参考，可追加正侧背、材质与受损状态；不要混入当前时空服装。',
   0, 0, 3, datetime('now'), 1),
  ('ep1-v3-s1-flashback-abuser-wardrobe', 'ep1-v3-s1', '服装', '闪回｜家暴男（前夫）穿搭',
   '家暴男（前夫）在小家闪回中的完整穿搭。',
   '上传完整穿搭参考，可追加正侧背和细节；与顾丽乔穿搭分开审核。',
   0, 0, 4, datetime('now'), 1);

UPDATE script_analysis_items
SET category='服装',
    name='闪回｜20岁顾丽乔穿搭',
    detail='20岁顾丽乔在小家遭遇家暴时的完整穿搭，与片场服装分开审核。',
    visual_brief='上传完整穿搭参考，可追加正侧背、材质与受损状态；不要混入当前时空服装。',
    sort_order=3,
    is_active=1,
    updated_at=datetime('now')
WHERE id='ep1-v3-s1-i12';

UPDATE script_analysis_items
SET category='服装',
    name='闪回｜家暴男（前夫）穿搭',
    detail='家暴男（前夫）在小家闪回中的完整穿搭。',
    visual_brief='上传完整穿搭参考，可追加正侧背和细节；与顾丽乔穿搭分开审核。',
    sort_order=4,
    is_active=1,
    updated_at=datetime('now')
WHERE id='ep1-v3-s1-flashback-abuser-wardrobe';

INSERT OR IGNORE INTO art_submission_details
  (item_id, assigned_to, due_at, handoff_to, done_definition, status, submission_note, review_note, selected_file_id, submitted_at, reviewed_at, updated_at)
VALUES
  ('ep1-v3-s1-i12', '', '2026-09-14T20:00', 'Lipa',
   '上传20岁顾丽乔在家暴闪回中的完整穿搭，与片场服装分开审核。',
   CASE WHEN EXISTS(SELECT 1 FROM art_submission_files WHERE item_id='ep1-v3-s1-i12') THEN '已上传' ELSE '待上传' END,
   '', '', '', '', '', datetime('now')),
  ('ep1-v3-s1-flashback-abuser-wardrobe', '', '2026-09-14T20:00', 'Lipa',
   '上传家暴男（前夫）在小家闪回中的完整穿搭。',
   CASE WHEN EXISTS(SELECT 1 FROM art_submission_files WHERE item_id='ep1-v3-s1-flashback-abuser-wardrobe') THEN '已上传' ELSE '待上传' END,
   '', '', '', '', '', datetime('now'));

UPDATE art_submission_details
SET status=CASE WHEN EXISTS(SELECT 1 FROM art_submission_files WHERE item_id='ep1-v3-s1-i12') THEN '已上传' ELSE '待上传' END,
    done_definition='上传20岁顾丽乔在家暴闪回中的完整穿搭，与片场服装分开审核。',
    updated_at=datetime('now')
WHERE item_id='ep1-v3-s1-i12';

UPDATE art_submission_details
SET status=CASE WHEN EXISTS(SELECT 1 FROM art_submission_files WHERE item_id='ep1-v3-s1-flashback-abuser-wardrobe') THEN '已上传' ELSE '待上传' END,
    done_definition='上传家暴男（前夫）在小家闪回中的完整穿搭。',
    updated_at=datetime('now')
WHERE item_id='ep1-v3-s1-flashback-abuser-wardrobe';

UPDATE production_items
SET planned_qty=(SELECT COUNT(*) FROM script_analysis_items i JOIN script_analyses a ON a.id=i.analysis_id WHERE a.episode=production_items.episode AND a.is_active=1 AND i.is_active=1),
    updated_at=datetime('now')
WHERE episode='第1集' AND category='美术清单';

INSERT INTO activity_log(item_type,item_id,action,operator,created_at)
VALUES('episode_assets','第1集','补齐第一场家暴闪回的顾丽乔穿搭和家暴男穿搭上传项','Lipa',datetime('now'));
