INSERT OR IGNORE INTO `script_analysis_items`
  (`id`, `analysis_id`, `category`, `name`, `detail`, `visual_brief`, `yoyo_approved`, `producer_approved`, `sort_order`, `updated_at`)
VALUES
  ('ep1-v3-s3-i09', 'ep1-v3-s3', '人物', '男主陆·出场人脸 Options', '陆文川初次出场的人脸与妆发方向备选；当前为Option A—D，统一为年轻、克制、清冷的东亚男性形象。', '保留四组近景与半身参考，重点对比骨相、眉眼、下颌线、黑色短发与冷静气质；最终采用由Lipa记录叶总／Yoyo微信确认结果。', 0, 0, 9, '2026-09-11T10:00:00.000Z'),
  ('ep1-v3-s3-i10', 'ep1-v3-s3', '服装', '男主陆·出场服装 Options', '陆文川初次出场的服装方向备选；当前为Option A—M，涵盖深色西装、卡其猎装、针织与宽松中性色层叠、浅色套装等方向。', '保留十三组完整服装参考，对比身份感、廓形、层次、材质、色系与火场动作便利性；未锁定前均只标记为主创选择。', 0, 0, 10, '2026-09-11T10:00:00.000Z');

INSERT INTO `art_submission_details`
  (`item_id`, `assigned_to`, `due_at`, `handoff_to`, `done_definition`, `status`, `submission_note`, `review_note`, `submitted_at`, `reviewed_at`, `updated_at`)
VALUES
  ('ep1-v3-s3-i09', '主美小金', '2026-09-11T18:00', 'Lipa', '对比男主陆出场人脸Option A—D，最终锁定一张脸及黑色短发方向。', '已上传', '四组人脸Option已入库，尚未锁定。', '', '2026-09-11T10:00:00.000Z', '', '2026-09-11T10:00:00.000Z'),
  ('ep1-v3-s3-i10', '主美小金', '2026-09-11T18:00', 'Lipa', '对比男主陆出场服装Option A—M，最终锁定一套及备选顺序。', '已上传', '十三组服装Option已入库，尚未锁定。', '', '2026-09-11T10:00:00.000Z', '', '2026-09-11T10:00:00.000Z')
ON CONFLICT(`item_id`) DO UPDATE SET
  `due_at` = CASE WHEN `art_submission_details`.`due_at` = '' THEN excluded.`due_at` ELSE `art_submission_details`.`due_at` END,
  `handoff_to` = CASE WHEN `art_submission_details`.`handoff_to` = '' THEN excluded.`handoff_to` ELSE `art_submission_details`.`handoff_to` END,
  `done_definition` = excluded.`done_definition`,
  `status` = CASE WHEN `art_submission_details`.`status` = '已锁定' THEN `art_submission_details`.`status` ELSE '已上传' END,
  `submission_note` = excluded.`submission_note`,
  `submitted_at` = CASE WHEN `art_submission_details`.`submitted_at` = '' THEN excluded.`submitted_at` ELSE `art_submission_details`.`submitted_at` END,
  `updated_at` = excluded.`updated_at`;

INSERT OR IGNORE INTO `art_submission_files`
  (`id`, `item_id`, `object_key`, `file_name`, `content_type`, `byte_size`, `uploaded_by`, `sort_order`, `created_at`)
VALUES
  ('curated-male-lu-face-a', 'ep1-v3-s3-i09', 'static:/reference-assets/episode-1/male-lu-face-a.jpg', '男主陆·人脸 Option A｜黑发冷感·白衬衫黑西装', 'image/jpeg', 149837, 'Lipa', 1, '2026-09-11T10:00:00.000Z'),
  ('curated-male-lu-face-b', 'ep1-v3-s3-i09', 'static:/reference-assets/episode-1/male-lu-face-b.jpg', '男主陆·人脸 Option B｜黑发冷感·全黑西装', 'image/jpeg', 145250, 'Lipa', 2, '2026-09-11T10:00:00.000Z'),
  ('curated-male-lu-face-c', 'ep1-v3-s3-i09', 'static:/reference-assets/episode-1/male-lu-face-c.jpg', '男主陆·人脸 Option C｜锐利眉眼·松散领带', 'image/jpeg', 160347, 'Lipa', 3, '2026-09-11T10:00:00.000Z'),
  ('curated-male-lu-face-d', 'ep1-v3-s3-i09', 'static:/reference-assets/episode-1/male-lu-face-d.jpg', '男主陆·人脸 Option D｜成熟骨相·正侧近景', 'image/jpeg', 136887, 'Lipa', 4, '2026-09-11T10:00:00.000Z'),
  ('curated-male-lu-wardrobe-a', 'ep1-v3-s3-i10', 'static:/reference-assets/episode-1/male-lu-wardrobe-a.jpg', '男主陆·服装 Option A｜卡其收腰猎装夹克', 'image/jpeg', 89591, 'Lipa', 1, '2026-09-11T10:00:00.000Z'),
  ('curated-male-lu-wardrobe-b', 'ep1-v3-s3-i10', 'static:/reference-assets/episode-1/male-lu-wardrobe-b.jpg', '男主陆·服装 Option B｜棕灰短外套＋宽松长裤', 'image/jpeg', 110296, 'Lipa', 2, '2026-09-11T10:00:00.000Z'),
  ('curated-male-lu-wardrobe-c', 'ep1-v3-s3-i10', 'static:/reference-assets/episode-1/male-lu-wardrobe-c.jpg', '男主陆·服装 Option C｜棕色绞花针织＋阔腿裤', 'image/jpeg', 140306, 'Lipa', 3, '2026-09-11T10:00:00.000Z'),
  ('curated-male-lu-wardrobe-d', 'ep1-v3-s3-i10', 'static:/reference-assets/episode-1/male-lu-wardrobe-d.jpg', '男主陆·服装 Option D｜橄榄绿腰带猎装套装', 'image/jpeg', 148704, 'Lipa', 4, '2026-09-11T10:00:00.000Z'),
  ('curated-male-lu-wardrobe-e', 'ep1-v3-s3-i10', 'static:/reference-assets/episode-1/male-lu-wardrobe-e.jpg', '男主陆·服装 Option E｜浅灰双排扣西装＋阔腿裤', 'image/jpeg', 61936, 'Lipa', 5, '2026-09-11T10:00:00.000Z'),
  ('curated-male-lu-wardrobe-f', 'ep1-v3-s3-i10', 'static:/reference-assets/episode-1/male-lu-wardrobe-f.jpg', '男主陆·服装 Option F｜格纹西装＋酒红针织层叠', 'image/jpeg', 84941, 'Lipa', 6, '2026-09-11T10:00:00.000Z'),
  ('curated-male-lu-wardrobe-g', 'ep1-v3-s3-i10', 'static:/reference-assets/episode-1/male-lu-wardrobe-g.jpg', '男主陆·服装 Option G｜蓝灰工装外套＋针织裤', 'image/jpeg', 85602, 'Lipa', 7, '2026-09-11T10:00:00.000Z'),
  ('curated-male-lu-wardrobe-h', 'ep1-v3-s3-i10', 'static:/reference-assets/episode-1/male-lu-wardrobe-h.jpg', '男主陆·服装 Option H｜棕色针织开衫＋白色阔腿裤', 'image/jpeg', 74995, 'Lipa', 8, '2026-09-11T10:00:00.000Z'),
  ('curated-male-lu-wardrobe-i', 'ep1-v3-s3-i10', 'static:/reference-assets/episode-1/male-lu-wardrobe-i.jpg', '男主陆·服装 Option I｜九套大地色造型方向', 'image/jpeg', 108255, 'Lipa', 9, '2026-09-11T10:00:00.000Z'),
  ('curated-male-lu-wardrobe-j', 'ep1-v3-s3-i10', 'static:/reference-assets/episode-1/male-lu-wardrobe-j.jpg', '男主陆·服装 Option J｜九套秋冬层叠方向', 'image/jpeg', 118701, 'Lipa', 10, '2026-09-11T10:00:00.000Z'),
  ('curated-male-lu-wardrobe-k', 'ep1-v3-s3-i10', 'static:/reference-assets/episode-1/male-lu-wardrobe-k.jpg', '男主陆·服装 Option K｜卡其收腰猎装四视图', 'image/jpeg', 160485, 'Lipa', 11, '2026-09-11T10:00:00.000Z'),
  ('curated-male-lu-wardrobe-l', 'ep1-v3-s3-i10', 'static:/reference-assets/episode-1/male-lu-wardrobe-l.jpg', '男主陆·服装 Option L｜米白西装＋粉色衬衫四视图', 'image/jpeg', 171953, 'Lipa', 12, '2026-09-11T10:00:00.000Z'),
  ('curated-male-lu-wardrobe-m', 'ep1-v3-s3-i10', 'static:/reference-assets/episode-1/male-lu-wardrobe-m.jpg', '男主陆·服装 Option M｜米白西装完整四视图', 'image/jpeg', 162350, 'Lipa', 13, '2026-09-11T10:00:00.000Z');

PRAGMA optimize;
