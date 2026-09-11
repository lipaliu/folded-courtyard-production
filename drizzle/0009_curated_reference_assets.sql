INSERT OR IGNORE INTO `script_analysis_items`
  (`id`, `analysis_id`, `category`, `name`, `detail`, `visual_brief`, `yoyo_approved`, `producer_approved`, `sort_order`, `updated_at`)
VALUES
  ('ep1-v3-s1-i12', 'ep1-v3-s1', '服装', '婚姻闪回／家暴出租屋穿搭 Options', '家暴出租屋现实空间中的顾丽乔穿搭备选；与戏中戏白衣分开，当前五个Option尚未锁定。', '保留Option A—E的完整穿搭参考，对比衣长、层次、颜色、材质与发型；最终采用由Lipa记录叶总／Yoyo微信确认结果。', 0, 0, 12, '2026-09-10T14:00:00.000Z'),
  ('ep1-v3-s1-i13', 'ep1-v3-s1', '场景', '女主出租屋（现居）参考', '书架、绿色沙发、木地板和夜景窗面构成的现居出租屋；与家暴闪回中的逼仄、破损出租屋严格分开。', '保留不同俯视、平视、低机位与日夜氛围参考；后续按具体场次锁定书架、沙发、茶几、窗面和灯位。', 0, 0, 13, '2026-09-10T14:00:00.000Z'),
  ('ep1-v3-s3-i08', 'ep1-v3-s3', '服装', '女主下班后日常穿搭 Options', '女主脱离片场造型后的日常穿搭备选；当前为Option A—J，包含卫衣牛仔、英伦层叠、暗色短裙、牛仔套装与针织叠穿等方向。', '保留每个Option的正背侧参考，对比黑色短发、廓形、层次、鞋包与活动便利性；未锁定前均只标记为主创选择。', 0, 0, 8, '2026-09-10T14:00:00.000Z');

INSERT INTO `art_submission_details`
  (`item_id`, `assigned_to`, `due_at`, `handoff_to`, `done_definition`, `status`, `submission_note`, `review_note`, `submitted_at`, `reviewed_at`, `updated_at`)
VALUES
  ('ep1-v3-s1-i01', '主美小金', '2026-09-10T18:00', 'Lipa', '确认片场完整空间、主机位和俯视调度关系。', '已上传', '片场／教堂空间参考已入库，待整集微信确认。', '', '2026-09-10T14:00:00.000Z', '', '2026-09-10T14:00:00.000Z'),
  ('ep1-v3-s1-i02', '主美小金', '2026-09-10T18:00', 'Lipa', '确认家暴出租屋空间、破损状态和黄昏光线。', '已上传', '家暴出租屋场景参考已入库，待整集微信确认。', '', '2026-09-10T14:00:00.000Z', '', '2026-09-10T14:00:00.000Z'),
  ('ep1-v3-s1-i04', '主美小金', '2026-09-10T18:00', 'Lipa', '对比教堂片场白衣与粉色长发Option A—C。', '已上传', '三个独立服装发型Option已入库，尚未锁定。', '', '2026-09-10T14:00:00.000Z', '', '2026-09-10T14:00:00.000Z'),
  ('ep1-v3-s1-i12', '主美小金', '2026-09-10T18:00', 'Lipa', '对比家暴出租屋穿搭Option A—E，明确衣长、材质、受损状态与发型。', '已上传', '五个独立Option已入库，尚未锁定。', '', '2026-09-10T14:00:00.000Z', '', '2026-09-10T14:00:00.000Z'),
  ('ep1-v3-s1-i13', '主美小金', '2026-09-10T18:00', 'Lipa', '对比女主现居出租屋的日夜氛围、家具布局和主机位。', '已上传', '五张空间视角已入库，与家暴出租屋分组显示。', '', '2026-09-10T14:00:00.000Z', '', '2026-09-10T14:00:00.000Z'),
  ('ep1-v3-s3-i08', '主美小金', '2026-09-10T18:00', 'Lipa', '对比女主下班后日常穿搭Option A—J，最终锁定一套及备选顺序。', '已上传', '十个独立Option已入库，尚未锁定。', '', '2026-09-10T14:00:00.000Z', '', '2026-09-10T14:00:00.000Z'),
  ('ep1-v3-s4-i01', '主美小金', '2026-09-10T18:00', 'Lipa', '确认东方庭院总布局、水道、月洞门和调度线。', '已上传', '庭院场景参考已入库，待整集微信确认。', '', '2026-09-10T14:00:00.000Z', '', '2026-09-10T14:00:00.000Z'),
  ('ep1-v3-s4-i03', '主美小金', '2026-09-10T18:00', 'Lipa', '庭院场沿用教堂片场的白衣与粉发Option A—C。', '已上传', '与教堂片场一致的三个Option已入库，尚未锁定。', '', '2026-09-10T14:00:00.000Z', '', '2026-09-10T14:00:00.000Z')
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
  ('curated-s1-set-01', 'ep1-v3-s1-i01', 'static:/reference-assets/episode-1/scene-1-set-01.png', '片场参考 01｜带工作人员与机位', 'image/png', 1702155, 'Lipa', 1, '2026-09-10T14:00:00.000Z'),
  ('curated-s1-set-02', 'ep1-v3-s1-i01', 'static:/reference-assets/episode-1/scene-1-set-02.jpg', '片场参考 02｜教堂空间与尸体血迹', 'image/jpeg', 2587531, 'Lipa', 2, '2026-09-10T14:00:00.000Z'),
  ('curated-s1-wardrobe-a', 'ep1-v3-s1-i04', 'static:/reference-assets/episode-1/scene-1-wardrobe-a.png', '教堂片场 Option A｜长款白色吊带裙＋粉色长发', 'image/png', 1744223, 'Lipa', 1, '2026-09-10T14:00:00.000Z'),
  ('curated-s1-wardrobe-b', 'ep1-v3-s1-i04', 'static:/reference-assets/episode-1/scene-1-wardrobe-b.png', '教堂片场 Option B｜收腰白色缎面中长裙＋粉色长发', 'image/png', 1711169, 'Lipa', 2, '2026-09-10T14:00:00.000Z'),
  ('curated-s1-wardrobe-c', 'ep1-v3-s1-i04', 'static:/reference-assets/episode-1/scene-1-wardrobe-c.png', '教堂片场 Option C｜白色短款伞摆裙＋粉色长发', 'image/png', 1716944, 'Lipa', 3, '2026-09-10T14:00:00.000Z'),
  ('curated-s1-domestic-set-01', 'ep1-v3-s1-i02', 'static:/reference-assets/episode-1/scene-1-domestic-set-01.png', '家暴出租屋｜破损房间与黄昏光线参考', 'image/png', 1667327, 'Lipa', 1, '2026-09-10T14:00:00.000Z'),
  ('curated-s1-domestic-wardrobe-a', 'ep1-v3-s1-i12', 'static:/reference-assets/episode-1/scene-1-domestic-wardrobe-a.jpg', '家暴出租屋 Option A｜灰蓝长袖长裤家居服', 'image/jpeg', 65154, 'Lipa', 1, '2026-09-10T14:00:00.000Z'),
  ('curated-s1-domestic-wardrobe-b', 'ep1-v3-s1-i12', 'static:/reference-assets/episode-1/scene-1-domestic-wardrobe-b.jpg', '家暴出租屋 Option B｜浅色长袖短裤家居服', 'image/jpeg', 65511, 'Lipa', 2, '2026-09-10T14:00:00.000Z'),
  ('curated-s1-domestic-wardrobe-c', 'ep1-v3-s1-i12', 'static:/reference-assets/episode-1/scene-1-domestic-wardrobe-c.jpg', '家暴出租屋 Option C｜深灰长袖长裤家居服', 'image/jpeg', 59698, 'Lipa', 3, '2026-09-10T14:00:00.000Z'),
  ('curated-s1-domestic-wardrobe-d', 'ep1-v3-s1-i12', 'static:/reference-assets/episode-1/scene-1-domestic-wardrobe-d.jpg', '家暴出租屋 Option D｜白色长袖长裤家居服', 'image/jpeg', 70948, 'Lipa', 4, '2026-09-10T14:00:00.000Z'),
  ('curated-s1-domestic-wardrobe-e', 'ep1-v3-s1-i12', 'static:/reference-assets/episode-1/scene-1-domestic-wardrobe-e.jpg', '家暴出租屋 Option E｜蓝色背心＋白色下装组合', 'image/jpeg', 527200, 'Lipa', 5, '2026-09-10T14:00:00.000Z'),
  ('curated-hero-rental-set-01', 'ep1-v3-s1-i13', 'static:/reference-assets/episode-1/hero-rental-set-01.png', '女主出租屋｜空间参考 01', 'image/png', 2267102, 'Lipa', 1, '2026-09-10T14:00:00.000Z'),
  ('curated-hero-rental-set-02', 'ep1-v3-s1-i13', 'static:/reference-assets/episode-1/hero-rental-set-02.png', '女主出租屋｜空间参考 02', 'image/png', 2569710, 'Lipa', 2, '2026-09-10T14:00:00.000Z'),
  ('curated-hero-rental-set-03', 'ep1-v3-s1-i13', 'static:/reference-assets/episode-1/hero-rental-set-03.jpg', '女主出租屋｜空间参考 03', 'image/jpeg', 240986, 'Lipa', 3, '2026-09-10T14:00:00.000Z'),
  ('curated-hero-rental-set-04', 'ep1-v3-s1-i13', 'static:/reference-assets/episode-1/hero-rental-set-04.png', '女主出租屋｜空间参考 04', 'image/png', 2360564, 'Lipa', 4, '2026-09-10T14:00:00.000Z'),
  ('curated-hero-rental-set-05', 'ep1-v3-s1-i13', 'static:/reference-assets/episode-1/hero-rental-set-05.png', '女主出租屋｜空间参考 05', 'image/png', 2403051, 'Lipa', 5, '2026-09-10T14:00:00.000Z'),
  ('curated-offwork-a', 'ep1-v3-s3-i08', 'static:/reference-assets/episode-1/offwork-wardrobe-a.png', '下班后 Option A｜连帽卫衣＋破洞牛仔长裤', 'image/png', 2120606, 'Lipa', 1, '2026-09-10T14:00:00.000Z'),
  ('curated-offwork-b', 'ep1-v3-s3-i08', 'static:/reference-assets/episode-1/offwork-wardrobe-b.jpg', '下班后 Option B｜短款连帽卫衣＋破洞牛仔长裤', 'image/jpeg', 183307, 'Lipa', 2, '2026-09-10T14:00:00.000Z'),
  ('curated-offwork-c', 'ep1-v3-s3-i08', 'static:/reference-assets/episode-1/offwork-wardrobe-c.jpg', '下班后 Option C｜白色短上衣＋黑色层叠短裙', 'image/jpeg', 195765, 'Lipa', 3, '2026-09-10T14:00:00.000Z'),
  ('curated-offwork-d', 'ep1-v3-s3-i08', 'static:/reference-assets/episode-1/offwork-wardrobe-d.png', '下班后 Option D｜白色立体上衣＋黑色层叠短裙', 'image/png', 2360309, 'Lipa', 4, '2026-09-10T14:00:00.000Z'),
  ('curated-offwork-e', 'ep1-v3-s3-i08', 'static:/reference-assets/episode-1/offwork-wardrobe-e.png', '下班后 Option E｜白色海军领上衣＋黑色短裙', 'image/png', 2000742, 'Lipa', 5, '2026-09-10T14:00:00.000Z'),
  ('curated-offwork-f', 'ep1-v3-s3-i08', 'static:/reference-assets/episode-1/offwork-wardrobe-f.png', '下班后 Option F｜印花短袖衬衫＋短裙长靴', 'image/png', 2219299, 'Lipa', 6, '2026-09-10T14:00:00.000Z'),
  ('curated-offwork-g', 'ep1-v3-s3-i08', 'static:/reference-assets/episode-1/offwork-wardrobe-g.png', '下班后 Option G｜黑色长外套＋围巾叠穿', 'image/png', 2136822, 'Lipa', 7, '2026-09-10T14:00:00.000Z'),
  ('curated-offwork-h', 'ep1-v3-s3-i08', 'static:/reference-assets/episode-1/offwork-wardrobe-h.png', '下班后 Option H｜牛仔外套＋牛仔长裤', 'image/png', 2058772, 'Lipa', 8, '2026-09-10T14:00:00.000Z'),
  ('curated-offwork-i', 'ep1-v3-s3-i08', 'static:/reference-assets/episode-1/offwork-wardrobe-i.png', '下班后 Option I｜针织开衫＋卫衣＋破洞牛仔裤', 'image/png', 2243414, 'Lipa', 9, '2026-09-10T14:00:00.000Z'),
  ('curated-offwork-j', 'ep1-v3-s3-i08', 'static:/reference-assets/episode-1/offwork-wardrobe-j.png', '下班后 Option J｜黑色吊带＋牛仔短裤＋堆叠长靴', 'image/png', 1969555, 'Lipa', 10, '2026-09-10T14:00:00.000Z'),
  ('curated-s4-set-01', 'ep1-v3-s4-i01', 'static:/reference-assets/episode-1/scene-4-courtyard-set-01.jpg', '东方庭院｜建筑、水道与月洞门参考', 'image/jpeg', 175523, 'Lipa', 1, '2026-09-10T14:00:00.000Z'),
  ('curated-s4-wardrobe-a', 'ep1-v3-s4-i03', 'static:/reference-assets/episode-1/scene-4-wardrobe-a.jpg', '庭院沿用 Option A｜白色短款伞摆裙＋粉色长发', 'image/jpeg', 106701, 'Lipa', 1, '2026-09-10T14:00:00.000Z'),
  ('curated-s4-wardrobe-b', 'ep1-v3-s4-i03', 'static:/reference-assets/episode-1/scene-4-wardrobe-b.jpg', '庭院沿用 Option B｜长款白色吊带裙＋粉色长发', 'image/jpeg', 101820, 'Lipa', 2, '2026-09-10T14:00:00.000Z'),
  ('curated-s4-wardrobe-c', 'ep1-v3-s4-i03', 'static:/reference-assets/episode-1/scene-4-wardrobe-c.png', '庭院沿用 Option C｜收腰白色缎面中长裙＋粉色长发', 'image/png', 1711169, 'Lipa', 3, '2026-09-10T14:00:00.000Z');

PRAGMA optimize;
