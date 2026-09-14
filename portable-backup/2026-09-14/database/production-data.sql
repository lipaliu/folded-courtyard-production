PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE d1_migrations(
		id         INTEGER PRIMARY KEY AUTOINCREMENT,
		name       TEXT UNIQUE,
		applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
INSERT INTO d1_migrations VALUES(1,'0000_nostalgic_micromacro.sql','2026-09-10 10:52:04');
INSERT INTO d1_migrations VALUES(2,'0001_chilly_sumo.sql','2026-09-10 10:52:05');
INSERT INTO d1_migrations VALUES(3,'0002_organic_slipstream.sql','2026-09-10 10:52:06');
INSERT INTO d1_migrations VALUES(4,'0003_past_sunfire.sql','2026-09-10 10:52:06');
INSERT INTO d1_migrations VALUES(5,'0004_natural_leper_queen.sql','2026-09-10 10:52:08');
INSERT INTO d1_migrations VALUES(6,'0005_special_lifeguard.sql','2026-09-10 10:52:09');
INSERT INTO d1_migrations VALUES(7,'0006_graceful_fenris.sql','2026-09-10 10:52:09');
INSERT INTO d1_migrations VALUES(8,'0007_old_stick.sql','2026-09-10 13:56:40');
INSERT INTO d1_migrations VALUES(9,'0008_purple_sentinels.sql','2026-09-10 13:56:42');
INSERT INTO d1_migrations VALUES(10,'0009_curated_reference_assets.sql','2026-09-11 06:18:56');
INSERT INTO d1_migrations VALUES(11,'0010_upload_blob_fallback.sql','2026-09-11 06:18:56');
INSERT INTO d1_migrations VALUES(12,'0011_male_lead_lu_references.sql','2026-09-11 06:19:00');
INSERT INTO d1_migrations VALUES(13,'0012_selected_art_file.sql','2026-09-12 18:13:55');
INSERT INTO d1_migrations VALUES(14,'0013_reuse_exclusions.sql','2026-09-14 07:37:09');
INSERT INTO d1_migrations VALUES(15,'0014_simplify_art_structure.sql','2026-09-14 07:37:10');
INSERT INTO d1_migrations VALUES(16,'0015_review_day_schedule.sql','2026-09-14 07:37:11');
INSERT INTO d1_migrations VALUES(17,'0016_merge_legacy_wardrobe.sql','2026-09-14 08:07:32');
INSERT INTO d1_migrations VALUES(18,'0017_align_final_script_scenes.sql','2026-09-14 08:27:00');
INSERT INTO d1_migrations VALUES(19,'0018_assign_scene1_wardrobe_to_guliqiao.sql','2026-09-14 10:55:46');
INSERT INTO d1_migrations VALUES(20,'0019_clarify_guliqiao_scene1_wardrobe.sql','2026-09-14 11:06:45');
INSERT INTO d1_migrations VALUES(21,'0020_restore_flashback_art_scene.sql','2026-09-14 11:50:31');
INSERT INTO d1_migrations VALUES(22,'0021_add_flashback_wardrobe.sql','2026-09-14 12:06:18');
CREATE TABLE `activity_log` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`item_type` text NOT NULL,
	`item_id` text NOT NULL,
	`action` text NOT NULL,
	`operator` text NOT NULL,
	`created_at` text NOT NULL
);
INSERT INTO activity_log VALUES(2,'task','0910-script','任务更新：已通过','Lipa','2026-09-10T11:45:36.543Z');
INSERT INTO activity_log VALUES(3,'task','0910-script-meeting','任务更新：已通过','Lipa','2026-09-10T11:45:37.559Z');
INSERT INTO activity_log VALUES(4,'member_account','9fb5947f-d722-451e-ba68-62ad2fb4bbfc','注册项目账号：编剧','李明鑫','2026-09-10T12:03:54.030Z');
INSERT INTO activity_log VALUES(5,'script_analysis','ep1-v3-s1','导入《折叠庭院的她》第一集0911（丙）.docx并自动拆解主美工作','Lipa','2026-09-11T06:33:38.594Z');
INSERT INTO activity_log VALUES(6,'script_analysis','ep1-v3-s2','导入《折叠庭院的她》第一集0911（丙）.docx并自动拆解主美工作','Lipa','2026-09-11T06:33:38.594Z');
INSERT INTO activity_log VALUES(7,'script_analysis','ep1-v3-s3','导入《折叠庭院的她》第一集0911（丙）.docx并自动拆解主美工作','Lipa','2026-09-11T06:33:38.594Z');
INSERT INTO activity_log VALUES(8,'script_analysis','ep1-v3-s4','导入《折叠庭院的她》第一集0911（丙）.docx并自动拆解主美工作','Lipa','2026-09-11T06:33:38.594Z');
INSERT INTO activity_log VALUES(9,'script_analysis','ep1-v3-s4','导入《折叠庭院的她》第一集0911（丙）.docx并自动拆解主美工作','Lipa','2026-09-11T06:33:38.594Z');
INSERT INTO activity_log VALUES(10,'script_analysis','ep1-v3-s5','导入《折叠庭院的她》第一集0911（丙）.docx并自动拆解主美工作','Lipa','2026-09-11T06:33:38.594Z');
INSERT INTO activity_log VALUES(11,'script_analysis','ep1-v3-s6','导入《折叠庭院的她》第一集0911（丙）.docx并自动拆解主美工作','Lipa','2026-09-11T06:33:38.594Z');
INSERT INTO activity_log VALUES(12,'art_submission_file','b5cbb7c5-e392-4296-9685-78147bd1a42e','上传参考图：3b6e1cb4b0a05e87a02c6b0348ffc9bb-web.jpg','Lipa','2026-09-11T06:35:25.208Z');
INSERT INTO activity_log VALUES(13,'art_submission_file','b5cbb7c5-e392-4296-9685-78147bd1a42e','删除错误参考图','Lipa','2026-09-11T06:35:39.204Z');
INSERT INTO activity_log VALUES(14,'art_submission_file','04258e60-9590-40b4-9cb1-7b0045ebab52','上传参考图：5572bf0ef3eebabfd439dc20fff35c73.jpg','Lipa','2026-09-11T06:36:46.479Z');
INSERT INTO activity_log VALUES(15,'art_submission_detail','ep1-v3-s1-auto-1','提报状态更新为已上传，责任人主美小金，截止2026-09-10T18:00','Lipa','2026-09-11T06:37:21.752Z');
INSERT INTO activity_log VALUES(16,'art_submission_detail','ep1-v3-s1-auto-1','提报状态更新为已上传，责任人主美小金，截止2026-09-10T18:00','Lipa','2026-09-11T06:37:55.705Z');
INSERT INTO activity_log VALUES(17,'art_submission_detail','ep1-v3-s1-auto-1','提报状态更新为已上传，责任人主美小金，截止2026-09-10T18:00','Lipa','2026-09-11T06:38:02.583Z');
INSERT INTO activity_log VALUES(18,'task','0910-script','任务更新：未开始','Lipa','2026-09-11T08:53:41.600Z');
INSERT INTO activity_log VALUES(19,'task','0910-script-meeting','任务更新：未开始','Lipa','2026-09-11T08:53:42.645Z');
INSERT INTO activity_log VALUES(20,'task','rollup-2026-09-10-ep1-script','任务更新：已通过','Lipa','2026-09-11T08:53:52.149Z');
INSERT INTO activity_log VALUES(21,'task','rollup-2026-09-10-ep1-art','任务更新：已通过','Lipa','2026-09-11T08:53:53.062Z');
INSERT INTO activity_log VALUES(22,'task','rollup-2026-09-10-ep1-script','任务更新：未开始','Lipa','2026-09-11T08:53:53.895Z');
INSERT INTO activity_log VALUES(23,'task','rollup-2026-09-10-ep1-art','任务更新：未开始','Lipa','2026-09-11T08:53:54.747Z');
INSERT INTO activity_log VALUES(24,'task','rollup-2026-09-10-ep1-send','任务更新：已通过','Lipa','2026-09-11T08:53:55.765Z');
INSERT INTO activity_log VALUES(25,'task','rollup-2026-09-10-ep1-send','任务更新：未开始','Lipa','2026-09-11T08:53:56.228Z');
INSERT INTO activity_log VALUES(26,'episode_assets','第1集','叶总微信确认结果：已确认','Lipa','2026-09-11T08:53:57.108Z');
INSERT INTO activity_log VALUES(27,'episode_assets','第1集','叶总微信确认结果：未确认','Lipa','2026-09-11T08:53:57.659Z');
INSERT INTO activity_log VALUES(28,'task','rollup-2026-09-10-ep1-script','任务更新：已通过','Lipa','2026-09-11T08:54:09.029Z');
INSERT INTO activity_log VALUES(29,'task','rollup-2026-09-10-ep1-script','任务更新：未开始','Lipa','2026-09-11T08:54:09.849Z');
INSERT INTO activity_log VALUES(30,'task','rollup-2026-09-10-ep1-art','任务更新：已通过','Lipa','2026-09-11T08:54:11.689Z');
INSERT INTO activity_log VALUES(31,'task','rollup-2026-09-10-ep1-art','任务更新：未开始','Lipa','2026-09-11T08:54:12.461Z');
INSERT INTO activity_log VALUES(32,'task','rollup-2026-09-10-ep1-script','任务更新：已通过','Lipa','2026-09-11T08:54:13.403Z');
INSERT INTO activity_log VALUES(33,'task','rollup-2026-09-10-ep1-script','任务更新：未开始','Lipa','2026-09-11T08:54:13.907Z');
INSERT INTO activity_log VALUES(34,'task','0910-script','任务更新：已通过','Lipa','2026-09-11T08:55:27.574Z');
INSERT INTO activity_log VALUES(35,'task','0910-script','任务更新：未开始','Lipa','2026-09-11T08:55:28.148Z');
INSERT INTO activity_log VALUES(36,'task','rollup-2026-09-10-ep1-art','任务更新：已通过','Lipa','2026-09-11T08:55:34.094Z');
INSERT INTO activity_log VALUES(37,'task','rollup-2026-09-10-ep1-art','任务更新：未开始','Lipa','2026-09-11T08:55:34.589Z');
INSERT INTO activity_log VALUES(38,'script_analysis','ep1-v3-s1','导入《折叠庭院的她》第一集0911（丙）.docx并自动拆解主美工作','李明鑫','2026-09-11T11:11:27.893Z');
INSERT INTO activity_log VALUES(39,'script_analysis','ep1-v3-s2','导入《折叠庭院的她》第一集0911（丙）.docx并自动拆解主美工作','李明鑫','2026-09-11T11:11:27.893Z');
INSERT INTO activity_log VALUES(40,'script_analysis','ep1-v3-s3','导入《折叠庭院的她》第一集0911（丙）.docx并自动拆解主美工作','李明鑫','2026-09-11T11:11:27.893Z');
INSERT INTO activity_log VALUES(41,'script_analysis','ep1-v3-s4','导入《折叠庭院的她》第一集0911（丙）.docx并自动拆解主美工作','李明鑫','2026-09-11T11:11:27.893Z');
INSERT INTO activity_log VALUES(42,'script_analysis','ep1-v3-s4','导入《折叠庭院的她》第一集0911（丙）.docx并自动拆解主美工作','李明鑫','2026-09-11T11:11:27.893Z');
INSERT INTO activity_log VALUES(43,'script_analysis','ep1-v3-s5','导入《折叠庭院的她》第一集0911（丙）.docx并自动拆解主美工作','李明鑫','2026-09-11T11:11:27.893Z');
INSERT INTO activity_log VALUES(44,'script_analysis','ep1-v3-s6','导入《折叠庭院的她》第一集0911（丙）.docx并自动拆解主美工作','李明鑫','2026-09-11T11:11:27.893Z');
INSERT INTO activity_log VALUES(45,'script_analysis','ep1-v3-s1','导入《折叠庭院的她》第一集0911（丙）.docx并自动拆解主美工作','Lipa','2026-09-11T11:11:51.980Z');
INSERT INTO activity_log VALUES(46,'script_analysis','ep1-v3-s2','导入《折叠庭院的她》第一集0911（丙）.docx并自动拆解主美工作','Lipa','2026-09-11T11:11:51.980Z');
INSERT INTO activity_log VALUES(47,'script_analysis','ep1-v3-s3','导入《折叠庭院的她》第一集0911（丙）.docx并自动拆解主美工作','Lipa','2026-09-11T11:11:51.980Z');
INSERT INTO activity_log VALUES(48,'script_analysis','ep1-v3-s4','导入《折叠庭院的她》第一集0911（丙）.docx并自动拆解主美工作','Lipa','2026-09-11T11:11:51.980Z');
INSERT INTO activity_log VALUES(49,'script_analysis','ep1-v3-s4','导入《折叠庭院的她》第一集0911（丙）.docx并自动拆解主美工作','Lipa','2026-09-11T11:11:51.980Z');
INSERT INTO activity_log VALUES(50,'script_analysis','ep1-v3-s5','导入《折叠庭院的她》第一集0911（丙）.docx并自动拆解主美工作','Lipa','2026-09-11T11:11:51.980Z');
INSERT INTO activity_log VALUES(51,'script_analysis','ep1-v3-s6','导入《折叠庭院的她》第一集0911（丙）.docx并自动拆解主美工作','Lipa','2026-09-11T11:11:51.980Z');
INSERT INTO activity_log VALUES(52,'member_account','45af6f6e-ce07-4adf-9552-95d187aea464','注册项目账号：主美','王承恺','2026-09-11T11:37:18.206Z');
INSERT INTO activity_log VALUES(53,'art_submission_file','5585aa26-9573-439f-8652-f8ee30496aa9','上传参考图：1ac929ed6447e576c287a17ecaa3b502-web.jpg','王承恺','2026-09-11T11:41:12.707Z');
INSERT INTO activity_log VALUES(54,'art_submission_file','d5eae93a-f927-42ce-b3d8-805dfb055ce9','上传参考图：8deca509bd2116bc6dbcb3d54f1403a9.jpg','王承恺','2026-09-11T11:41:39.044Z');
INSERT INTO activity_log VALUES(55,'art_submission_file','343f61f8-5d78-4c92-ab17-0b0e6bdd6c03','上传参考图：1752ee2a4a290d16ff1ad91251894c63-web.jpg','王承恺','2026-09-11T11:41:55.792Z');
INSERT INTO activity_log VALUES(56,'art_submission_file','cb4a20b8-f589-4494-b051-b3ca36300eca','上传参考图：e28398705c396791e21643a73064c3d4-web.jpg','王承恺','2026-09-11T11:42:08.485Z');
INSERT INTO activity_log VALUES(57,'art_submission_detail','ep1-v3-s1-auto-2','提报状态更新为已上传，责任人主美小金，截止2026-09-11T18:00','王承恺','2026-09-11T11:42:13.910Z');
INSERT INTO activity_log VALUES(58,'art_submission_file','87bf8357-1ec3-4de5-9afe-2df47de82d21','上传参考图：图片 - 2026-09-04T162506.963.jpg','王承恺','2026-09-11T11:43:25.750Z');
INSERT INTO activity_log VALUES(59,'art_submission_file','5b420262-0cd9-479f-856c-8710ad3e98e0','上传参考图：图片 - 2026-09-04T162506.963.jpg','王承恺','2026-09-11T11:44:13.656Z');
INSERT INTO activity_log VALUES(60,'art_submission_file','5b420262-0cd9-479f-856c-8710ad3e98e0','删除错误参考图','王承恺','2026-09-11T11:44:20.488Z');
INSERT INTO activity_log VALUES(61,'art_submission_file','195bc710-6b90-440c-8340-186ca232242d','上传参考图：使用老机型iPhone全身 噪点略糊没有背景虚化：豪华公寓中20岁中国男人，帅气俊朗健身男性，身材健硕，胸前带口袋设计的T恤袖，下身是西裤皮.jpg','王承恺','2026-09-11T11:44:29.148Z');
INSERT INTO activity_log VALUES(62,'art_submission_file','5f26c4b9-9b2d-4f1a-8fa6-5dc5aea6eccc','上传参考图：图片 - 2026-09-11T180707.728.jpg','王承恺','2026-09-11T11:44:45.961Z');
INSERT INTO activity_log VALUES(63,'art_submission_file','279e72db-07c8-45b8-80e4-5576df238e0f','上传参考图：图片 - 2026-09-11T182558.740.jpg','王承恺','2026-09-11T11:49:48.161Z');
INSERT INTO activity_log VALUES(64,'art_submission_file','ecdf267d-8609-4cf8-9d41-231759bfa23a','上传参考图：图片 - 2026-09-11T180608.414.jpg','王承恺','2026-09-11T11:49:48.533Z');
INSERT INTO activity_log VALUES(65,'art_submission_file','dae10025-c8a8-4b6d-9b5f-f6e3c3b3cdd1','上传参考图：34e82df325c99ed1a126f49d6cb008f9.png','王承恺','2026-09-11T11:50:27.821Z');
INSERT INTO activity_log VALUES(66,'art_submission_file','1ed41dc3-642f-40d4-8aa7-04b61613d897','上传参考图：韩国男性白幼瘦帅哥博主，25岁。东亚男性，韩国男明星英俊帅气。立体骨相，高挺笔直鼻梁，山根自然不突兀，不明显双眼皮眼型偏长，眼尾微微收，不肿.jpg','王承恺','2026-09-11T11:50:59.359Z');
INSERT INTO activity_log VALUES(67,'art_submission_file','3ebaad51-2ac6-4021-9f0b-831d97a5523c','上传参考图：图片 - 2026-09-11T160305.320.jpg','王承恺','2026-09-11T11:51:32.585Z');
INSERT INTO activity_log VALUES(68,'task','0911-lock','任务更新：已通过','Lipa','2026-09-11T15:12:07.065Z');
INSERT INTO activity_log VALUES(69,'task','rollup-2026-09-11-ep1-script','任务更新：已通过','Lipa','2026-09-11T15:12:12.670Z');
INSERT INTO activity_log VALUES(70,'task','0911-lock','任务更新：已通过','Lipa','2026-09-11T15:12:19.393Z');
INSERT INTO activity_log VALUES(71,'art_submission_detail','ep1-v3-s1-auto-1','提报状态更新为需复核，责任人主美小金，截止2026-09-11T18:00','Lipa','2026-09-11T15:12:32.560Z');
INSERT INTO activity_log VALUES(72,'art_submission_detail','ep1-v3-s1-auto-2','提报状态更新为已上传，责任人主美小金，截止2026-09-11T18:00','Lipa','2026-09-11T15:12:37.486Z');
INSERT INTO activity_log VALUES(73,'art_submission_detail','ep1-v3-s1-auto-3','提报状态更新为已上传，责任人主美小金，截止2026-09-11T18:00','Lipa','2026-09-11T15:12:38.861Z');
INSERT INTO activity_log VALUES(74,'art_submission_detail','ep1-v3-s1-auto-4','提报状态更新为已上传，责任人主美小金，截止2026-09-11T18:00','Lipa','2026-09-11T15:12:39.940Z');
INSERT INTO activity_log VALUES(75,'art_submission_detail','ep1-v3-s1-auto-5','提报状态更新为已上传，责任人主美小金，截止2026-09-11T18:00','Lipa','2026-09-11T15:12:41.832Z');
INSERT INTO activity_log VALUES(76,'art_submission_detail','ep1-v3-s1-auto-6','提报状态更新为已上传，责任人主美小金，截止2026-09-11T18:00','Lipa','2026-09-11T15:12:42.642Z');
INSERT INTO activity_log VALUES(77,'art_submission_detail','ep1-v3-s1-auto-7','提报状态更新为已上传，责任人主美小金，截止2026-09-11T18:00','Lipa','2026-09-11T15:12:48.818Z');
INSERT INTO activity_log VALUES(78,'script_analysis_item','ep1-v3-s1-auto-12','删除主美工作项：祭坛','Lipa','2026-09-11T15:13:00.350Z');
INSERT INTO activity_log VALUES(79,'script_analysis_item','ep1-v3-s1-auto-13','删除主美工作项：手机','Lipa','2026-09-11T15:13:07.151Z');
INSERT INTO activity_log VALUES(80,'script_analysis_item','ep1-v3-s1-auto-14','删除主美工作项：酒瓶','Lipa','2026-09-11T15:13:11.625Z');
INSERT INTO activity_log VALUES(81,'script_analysis_item','ep1-v3-s1-auto-15','删除主美工作项：镜子','Lipa','2026-09-11T15:13:14.787Z');
INSERT INTO activity_log VALUES(82,'script_analysis_item','ep1-v3-s1-auto-16','删除主美工作项：电子钟','Lipa','2026-09-11T15:13:17.920Z');
INSERT INTO activity_log VALUES(83,'script_analysis_item','ep1-v3-s1-auto-17','删除主美工作项：头套','Lipa','2026-09-11T15:13:26.570Z');
INSERT INTO activity_log VALUES(84,'script_analysis_item','ep1-v3-s1-auto-18','删除主美工作项：警铃','Lipa','2026-09-11T15:13:30.050Z');
INSERT INTO activity_log VALUES(85,'script_analysis_item','ep1-v3-s1-auto-19','删除主美工作项：景片','Lipa','2026-09-11T15:13:37.240Z');
INSERT INTO activity_log VALUES(86,'script_analysis_item','ep1-v3-s2-auto-3','删除主美工作项：乌篷船','Lipa','2026-09-11T15:13:48.565Z');
INSERT INTO activity_log VALUES(87,'task','priority-0912-ep1-assets','任务更新：已通过','Lipa','2026-09-11T16:56:05.003Z');
INSERT INTO activity_log VALUES(88,'task','priority-0912-ep1-assets','任务更新：延期','Lipa','2026-09-11T16:56:06.372Z');
INSERT INTO activity_log VALUES(89,'task','priority-0912-ep1-assets','任务更新：未完成','Lipa','2026-09-11T16:56:07.425Z');
INSERT INTO activity_log VALUES(90,'task','priority-0912-ep1-assets','任务更新：延期','Lipa','2026-09-11T16:56:09.109Z');
INSERT INTO activity_log VALUES(91,'task','priority-0912-ep1-assets','任务更新：已通过','Lipa','2026-09-11T16:56:10.291Z');
INSERT INTO activity_log VALUES(92,'task','priority-0912-ep1-assets','任务更新：已通过','Lipa','2026-09-11T16:56:11.326Z');
INSERT INTO activity_log VALUES(93,'task','priority-0912-ep1-assets','任务更新：已通过','Lipa','2026-09-11T16:56:13.432Z');
INSERT INTO activity_log VALUES(94,'task','priority-0912-ep1-assets','任务更新：未开始','Lipa','2026-09-11T16:56:15.290Z');
INSERT INTO activity_log VALUES(95,'script_version','script-version-807c4b22-827a-4517-9598-3258096744fe','选择第1集剧本v3为定稿，后续拆场、主美资产和PDF均按此版生成','Lipa','2026-09-11T16:56:33.690Z');
INSERT INTO activity_log VALUES(96,'script_analysis_item','ep1-v3-s3-auto-6','删除主美工作项：手机','Lipa','2026-09-11T16:57:03.927Z');
INSERT INTO activity_log VALUES(97,'script_analysis_item','ep1-v3-s7-i06','删除主美工作项：缺失一分钟提示','Lipa','2026-09-11T16:58:21.474Z');
INSERT INTO activity_log VALUES(98,'script_analysis_item','ep1-v3-s3-auto-7,ep1-v3-s4-auto-4,ep1-v3-s4-auto-5,ep1-v3-s4-auto-6,ep1-v3-s5-auto-5,ep1-v3-s5-auto-6,ep1-v3-s6-auto-5,ep1-v3-s6-auto-6,ep1-v3-s6-auto-7,ep1-v3-s6-auto-8,ep1-v3-s7-i05','批量删除11项道具','Lipa','2026-09-11T16:58:30.373Z');
INSERT INTO activity_log VALUES(99,'task','rollup-2026-09-12-ep1-script','任务更新：已通过','Lipa','2026-09-12T03:38:49.617Z');
INSERT INTO activity_log VALUES(100,'member_account','4cae466c-8329-48a0-af3e-5cdfda7ad6fc','注册项目账号：服化道副导演','玉冰','2026-09-12T11:22:20.350Z');
INSERT INTO activity_log VALUES(101,'member_account','a2f2d547-1c45-485b-bbe5-a1e3b951d913','注册项目账号：服化道副导演','罗新姗','2026-09-12T11:22:40.280Z');
INSERT INTO activity_log VALUES(102,'member_account','30897c1d-0637-498f-8a49-e6f63845097f','注册项目账号：服化道副导演','胖胖','2026-09-12T11:27:57.389Z');
INSERT INTO activity_log VALUES(103,'art_submission_file','d2906d6b-a178-4623-a53a-05865e50058f','上传参考图：截屏2026-09-10 16.36.40_副本.jpg','罗新姗','2026-09-12T11:28:56.256Z');
INSERT INTO activity_log VALUES(104,'art_submission_detail','ep1-v3-s1-auto-10','提报状态更新为已上传，责任人主美小金，截止2026-09-11T18:00','罗新姗','2026-09-12T11:29:01.888Z');
INSERT INTO activity_log VALUES(105,'art_submission_file','d2906d6b-a178-4623-a53a-05865e50058f','删除错误参考图','罗新姗','2026-09-12T11:29:12.385Z');
INSERT INTO activity_log VALUES(106,'task','rollup-2026-09-14-ep1-script','任务更新：已通过','Lipa','2026-09-12T19:06:42.550Z');
INSERT INTO activity_log VALUES(107,'task','rollup-2026-09-14-ep1-script','任务更新：未开始','Lipa','2026-09-12T19:06:43.737Z');
INSERT INTO activity_log VALUES(108,'task','rollup-2026-09-14-ep1-script','任务更新：已通过','李明鑫','2026-09-13T07:49:03.474Z');
INSERT INTO activity_log VALUES(109,'task','rollup-2026-09-14-ep1-script','任务更新：未开始','李明鑫','2026-09-13T07:49:04.767Z');
INSERT INTO activity_log VALUES(110,'art_submission_file','66bc6579-ef7c-486d-aa97-ac61c7c1451f','上传参考图：0c813fa85480efcab802842d3e4a2082.jpg','玉冰','2026-09-14T05:34:41.705Z');
INSERT INTO activity_log VALUES(111,'art_submission_file','94d97cf1-e4b2-4809-aca6-376ed79d5177','上传参考图：5eb11628a9267d18545909fae4843fdf.jpg','玉冰','2026-09-14T05:34:44.133Z');
INSERT INTO activity_log VALUES(112,'art_submission_file','78991d4a-07ca-4ecc-85d3-3da238223c29','上传参考图：89234c34ce1ecd3cebc19a265772dd53.jpg','玉冰','2026-09-14T05:34:46.392Z');
INSERT INTO activity_log VALUES(113,'art_submission_file','48178c8c-6d41-4963-bcd3-804ff865fafd','上传参考图：a36995e93f74cc5aab3e572f59698a97.jpg','玉冰','2026-09-14T05:34:48.341Z');
INSERT INTO activity_log VALUES(114,'art_submission_file','ec1a0394-0b80-4293-b0a7-af9fee8223c1','上传参考图：e00ec71d56da89f16455b1eeb6a02848.jpg','玉冰','2026-09-14T05:34:50.630Z');
INSERT INTO activity_log VALUES(115,'art_submission_detail','ep1-v3-s1-auto-10','提报状态更新为已上传，责任人玉冰，截止2026-09-11T18:00','玉冰','2026-09-14T05:35:31.751Z');
INSERT INTO activity_log VALUES(116,'art_submission_file','e4a964cc-629e-4641-bd89-192485c7a05f','上传参考图：图片 - 2026-09-10T174138.885-web.jpg','王承恺','2026-09-14T05:41:23.314Z');
INSERT INTO activity_log VALUES(117,'art_submission_file','5585aa26-9573-439f-8652-f8ee30496aa9','删除错误参考图','王承恺','2026-09-14T05:44:43.146Z');
INSERT INTO activity_log VALUES(118,'art_submission_file','d5eae93a-f927-42ce-b3d8-805dfb055ce9','删除错误参考图','王承恺','2026-09-14T05:44:46.575Z');
INSERT INTO activity_log VALUES(119,'art_submission_file','343f61f8-5d78-4c92-ab17-0b0e6bdd6c03','删除错误参考图','王承恺','2026-09-14T05:44:48.856Z');
INSERT INTO activity_log VALUES(120,'art_submission_file','cb4a20b8-f589-4494-b051-b3ca36300eca','删除错误参考图','王承恺','2026-09-14T05:44:51.485Z');
INSERT INTO activity_log VALUES(121,'art_submission_file','50e489a6-665a-4e24-ae46-b19f1d000618','上传参考图：图片 - 2026-09-14T131555.437.jpg','王承恺','2026-09-14T05:45:08.494Z');
INSERT INTO activity_log VALUES(122,'art_submission_file','b239780a-45ef-4ec8-8515-7b0dd114b4d5','上传参考图：图片 - 2026-09-14T132026.982.jpg','王承恺','2026-09-14T05:45:33.810Z');
INSERT INTO activity_log VALUES(123,'art_submission_file','aae49962-5e18-4228-871d-8fb448f5c20e','上传参考图：图片 - 2026-09-14T131746.495.jpg','王承恺','2026-09-14T05:48:09.129Z');
INSERT INTO activity_log VALUES(124,'art_submission_file','d0742bf6-34f9-4f33-9c93-ad438302c167','上传参考图：图片 - 2026-09-14T131759.502.jpg','王承恺','2026-09-14T05:48:25.008Z');
INSERT INTO activity_log VALUES(125,'art_submission_file','7fc85f91-cd6c-4f07-9c8f-9262f69d2d1f','上传参考图：图片 - 2026-09-14T131145.969.jpg','王承恺','2026-09-14T05:48:51.003Z');
INSERT INTO activity_log VALUES(126,'art_submission_file','75373a3e-bc9b-4c8d-b73c-b2265c1ee70b','上传参考图：图片 - 2026-09-12T193423.622.jpg','王承恺','2026-09-14T05:49:49.072Z');
INSERT INTO activity_log VALUES(127,'art_submission_file','55102b50-b512-47b9-9056-e476071822cb','上传参考图：IMG_0500.JPG','罗新姗','2026-09-14T05:51:16.824Z');
INSERT INTO activity_log VALUES(128,'art_submission_file','72c5724c-63c5-493c-81d7-07b0ab88fd22','上传参考图：IMG_0499.JPG','罗新姗','2026-09-14T05:51:19.194Z');
INSERT INTO activity_log VALUES(129,'art_submission_file','db1b1e4f-b0eb-4976-aa75-46bb2899b6db','上传参考图：IMG_0498.jpg','罗新姗','2026-09-14T05:51:21.325Z');
INSERT INTO activity_log VALUES(130,'art_submission_file','c2083cf0-c800-4894-8ed7-a6c80fc2a121','上传参考图：IMG_0497.jpg','罗新姗','2026-09-14T05:51:23.027Z');
INSERT INTO activity_log VALUES(131,'art_submission_file','bdee9268-700a-403a-a48f-7226f9c802c5','上传参考图：IMG_0495-web.jpg','罗新姗','2026-09-14T05:51:25.200Z');
INSERT INTO activity_log VALUES(132,'art_submission_file','0d18421a-2a5e-4d88-89c4-a6eb985cd0bd','上传参考图：IMG_0494-web.jpg','罗新姗','2026-09-14T05:51:27.216Z');
INSERT INTO activity_log VALUES(133,'art_submission_detail','ep1-v3-s1-auto-10','提报状态更新为已上传，责任人玉冰，截止2026-09-11T18:00','罗新姗','2026-09-14T05:52:10.341Z');
INSERT INTO activity_log VALUES(134,'art_submission_file','ecdf267d-8609-4cf8-9d41-231759bfa23a','删除错误参考图','王承恺','2026-09-14T05:57:01.201Z');
INSERT INTO activity_log VALUES(135,'art_submission_file','7fc85f91-cd6c-4f07-9c8f-9262f69d2d1f','删除错误参考图','王承恺','2026-09-14T05:57:01.199Z');
INSERT INTO activity_log VALUES(136,'art_submission_file','b5eb5594-6b0b-4123-87a0-7173d41feb5d','上传参考图：7871eed29fc0557369ef0845bca4b547.jpg','玉冰','2026-09-14T05:57:19.358Z');
INSERT INTO activity_log VALUES(137,'art_submission_file','e0ab773a-921f-42a9-a5bc-58660b96dd7f','上传参考图：IMG_0501-web.jpg','罗新姗','2026-09-14T05:57:20.993Z');
INSERT INTO activity_log VALUES(138,'art_submission_file','e7c24f0b-f710-4e9e-84aa-cb79446f9f56','上传参考图：c8d6f05b5a1850c07b3cd3667d78e86c.jpg','玉冰','2026-09-14T05:57:22.268Z');
INSERT INTO activity_log VALUES(139,'art_submission_file','e846589d-3fdb-411b-95a6-a1979e00c1ba','上传参考图：IMG_0502.JPG','罗新姗','2026-09-14T05:57:23.238Z');
INSERT INTO activity_log VALUES(140,'art_submission_file','71f8271f-694e-416b-9985-6e39deac28b0','上传参考图：图片 - 2026-09-14T140227.702.jpg','王承恺','2026-09-14T06:03:12.659Z');
INSERT INTO activity_log VALUES(141,'art_submission_file','8450096b-3cfc-4ed8-aeac-25f5be456030','上传参考图：图片 - 2026-09-14T140044.487.jpg','王承恺','2026-09-14T06:03:20.769Z');
INSERT INTO activity_log VALUES(142,'art_submission_file','71e8b32e-c3ae-476e-8d22-27f2905f5615','上传参考图：图片 - 2026-09-14T135926.626.jpg','王承恺','2026-09-14T06:03:34.272Z');
INSERT INTO activity_log VALUES(143,'art_submission_file','e846589d-3fdb-411b-95a6-a1979e00c1ba','删除错误参考图','罗新姗','2026-09-14T06:05:17.036Z');
INSERT INTO activity_log VALUES(144,'art_submission_file','e0ab773a-921f-42a9-a5bc-58660b96dd7f','删除错误参考图','罗新姗','2026-09-14T06:05:17.950Z');
INSERT INTO activity_log VALUES(145,'art_submission_file','82bc2b56-cbe2-4cca-8ce4-8be099892cba','上传参考图：图片 - 2026-09-14T140115.174.jpg','王承恺','2026-09-14T06:05:32.458Z');
INSERT INTO activity_log VALUES(146,'art_submission_file','5d1856da-34c3-4c11-9c8b-136e3050acef','上传参考图：IMG_0507.JPG','罗新姗','2026-09-14T06:09:16.278Z');
INSERT INTO activity_log VALUES(147,'art_submission_file','6dbd33f9-6868-4832-a799-2c8351b9da13','上传参考图：IMG_0506.JPG','罗新姗','2026-09-14T06:09:18.797Z');
INSERT INTO activity_log VALUES(148,'art_submission_file','6cb351c9-942e-4748-87bf-ee103f18ef8a','上传参考图：28cb3986d21dacb5ac8f3d660d1bb331.jpg','玉冰','2026-09-14T06:09:20.218Z');
INSERT INTO activity_log VALUES(149,'art_submission_file','182ad487-9f33-4b2c-80df-4d4e1ba1269f','上传参考图：IMG_0505.JPG','罗新姗','2026-09-14T06:09:21.329Z');
INSERT INTO activity_log VALUES(150,'art_submission_file','0b8db1cf-560d-4380-95a2-ce637d1cea47','上传参考图：85a3671004a61724de177288cb5041e6.jpg','玉冰','2026-09-14T06:09:23.022Z');
INSERT INTO activity_log VALUES(151,'art_submission_file','ee1de1e2-8b75-41e9-8775-e16bed271876','上传参考图：IMG_0504.JPG','罗新姗','2026-09-14T06:09:23.792Z');
INSERT INTO activity_log VALUES(152,'art_submission_file','83563063-2c3e-48d0-b1aa-b7cf0f922a3b','上传参考图：c88124b172e72cc1fff259b0af64b43c.jpg','玉冰','2026-09-14T06:09:25.620Z');
INSERT INTO activity_log VALUES(153,'art_submission_file','58f8082d-06a6-4488-a723-a88a8ed1925b','上传参考图：1aece3bb68dd2f9950a402b548ae64b2.jpg','玉冰','2026-09-14T06:09:40.431Z');
INSERT INTO activity_log VALUES(154,'art_submission_file','dfa8522b-33e7-4578-b0f6-694d29ba8106','上传参考图：64721185ba4e059022764bc6d9aceb00.jpg','玉冰','2026-09-14T06:09:42.963Z');
INSERT INTO activity_log VALUES(155,'art_submission_detail','ep1-v3-s7-i01','提报状态更新为已上传，责任人主美小金，截止2026-09-11T18:00','罗新姗','2026-09-14T06:09:45.768Z');
INSERT INTO activity_log VALUES(156,'art_submission_file','17c10d75-7b36-4309-b972-1a4fee9edc8f','上传参考图：38031c83a5a5f22c5e75bc72cc403410.jpg','玉冰','2026-09-14T06:09:45.457Z');
INSERT INTO activity_log VALUES(157,'art_submission_file','228a0145-722b-4011-923e-0583b90028c1','上传参考图：16f85cdea6400ab45679d2ac1e1bfeb4.jpg','玉冰','2026-09-14T06:10:35.671Z');
INSERT INTO activity_log VALUES(158,'art_submission_file','db6531be-718d-4359-a91f-5b6a1633cc99','上传参考图：b17c5bfbf860a97f29d2de9d617d3fca.jpg','玉冰','2026-09-14T06:10:39.290Z');
INSERT INTO activity_log VALUES(159,'art_submission_file','8f3acbff-28ed-406e-866b-e74f0de7f348','上传参考图：79cf0582b6f793ca4c668c57605b03e5.jpg','玉冰','2026-09-14T06:10:50.691Z');
INSERT INTO activity_log VALUES(160,'art_submission_file','fcb322ab-867a-44fa-a103-60a17666d36b','上传参考图：b0a0b97315a5cad66e3fd87f4b2a3892.jpg','玉冰','2026-09-14T06:10:58.035Z');
INSERT INTO activity_log VALUES(161,'art_submission_file','3a37a9ca-ce51-4105-9409-13c3b692a406','上传参考图：4e7c8e1b5191b90560b6f8ef1110afb2.jpg','玉冰','2026-09-14T06:12:25.439Z');
INSERT INTO activity_log VALUES(162,'art_submission_file','f0f2a575-e7be-4591-b450-2bbc8e642f80','上传参考图：20318d68479db6282d56c143b07555f6.jpg','玉冰','2026-09-14T06:12:29.606Z');
INSERT INTO activity_log VALUES(163,'art_submission_file','76e7788f-74a7-4162-bb73-fd9495c2d7d8','上传参考图：d92d086c7c2e67531205cf4fa5caf306.jpg','玉冰','2026-09-14T06:12:35.899Z');
INSERT INTO activity_log VALUES(164,'art_submission_file','9d080b36-1e7c-456b-9578-99bb59ed4482','上传参考图：bbd3e3a7fd4732cd7e23be5aa7f10364.jpg','玉冰','2026-09-14T06:12:59.712Z');
INSERT INTO activity_log VALUES(165,'art_submission_file','6ec855e3-79b7-40ee-ae4b-bacb9acfd047','上传参考图：4526eb5e228e8addf0957f5e35814a76.jpg','玉冰','2026-09-14T06:13:02.451Z');
INSERT INTO activity_log VALUES(166,'art_submission_file','f64448e5-6b00-4703-b8e6-ecfbd842497e','上传参考图：图片 - 2026-09-14T142156.710.jpg','王承恺','2026-09-14T06:22:16.713Z');
INSERT INTO activity_log VALUES(167,'art_submission_file','33885290-7473-4638-8e81-311921c4b9e0','上传参考图：IMG_0511.jpg','罗新姗','2026-09-14T06:22:21.371Z');
INSERT INTO activity_log VALUES(168,'art_submission_file','c77d0282-e97c-4f7d-b9d3-1e849fb3b08c','上传参考图：IMG_0510.jpg','罗新姗','2026-09-14T06:22:23.455Z');
INSERT INTO activity_log VALUES(169,'art_submission_file','f004c2f6-313f-4037-80ce-d1377b4a45b7','上传参考图：图片 - 2026-09-14T143054.419.jpg','王承恺','2026-09-14T06:31:12.659Z');
INSERT INTO activity_log VALUES(170,'art_submission_file','6b48a2d2-4c9a-431d-adf0-bb278bfc55ef','上传参考图：图片 - 2026-09-14T143134.745.jpg','王承恺','2026-09-14T06:31:50.647Z');
INSERT INTO activity_log VALUES(171,'art_submission_file','56b4c63d-3e53-45ba-8cd8-9d0ffaf3ce48','上传参考图：IMG_0512-web.jpg','罗新姗','2026-09-14T06:32:03.873Z');
INSERT INTO activity_log VALUES(172,'art_submission_detail','ep1-v3-s7-i01','提报状态更新为已上传，责任人主美小金，截止2026-09-11T18:00','玉冰','2026-09-14T06:33:26.091Z');
INSERT INTO activity_log VALUES(173,'art_submission_detail','ep1-v3-s7-i03','提报状态更新为已上传，责任人主美小金，截止2026-09-11T18:00','玉冰','2026-09-14T06:33:29.763Z');
INSERT INTO activity_log VALUES(174,'art_submission_detail','ep1-v3-s1-auto-11','提报状态更新为已上传，责任人主美小金，截止2026-09-11T18:00','罗新姗','2026-09-14T06:36:43.410Z');
INSERT INTO activity_log VALUES(175,'art_submission_file','598a22fc-eb86-4582-9f43-65d982637d28','上传参考图：图片 - 2026-09-14T144122.604.jpg','王承恺','2026-09-14T06:41:41.475Z');
INSERT INTO activity_log VALUES(176,'art_submission_file','598a22fc-eb86-4582-9f43-65d982637d28','删除错误参考图','王承恺','2026-09-14T06:41:59.173Z');
INSERT INTO activity_log VALUES(177,'art_submission_file','b788eeb8-6ec6-4e51-8911-b1cb99ad2323','上传参考图：图片 - 2026-09-14T144306.507.jpg','王承恺','2026-09-14T06:43:49.875Z');
INSERT INTO activity_log VALUES(178,'art_submission_file','43bebf5d-bfc6-4881-b306-df81757aba76','上传参考图：图片 - 2026-09-10T143809.164-web.jpg','王承恺','2026-09-14T06:47:22.416Z');
INSERT INTO activity_log VALUES(179,'art_submission_file','7164c8ac-a541-462d-9ad9-e78ed1278516','上传参考图：1gFXtXsdHn-e_41HTnmD5yXshIHMsDf1nfSgZHgewRvo8NmCJQLoQTzuLK09Ot7ezPojlFllXuf89RzgAnqMfFSQ_oWOLnTTUWfytfsL8rmQyZBWSaxoV3zc','胖胖','2026-09-14T06:50:56.467Z');
INSERT INTO activity_log VALUES(180,'art_submission_file','81d9d08b-f5a2-452f-8e88-ac14397509dc','上传参考图：3FXl29iRGihq0Rg2wl-0EqW6M0UxL1A5rMa819ghIFHt0po9Ma9L8xOnPKH18E-kDuEp-PhrJflHuaNyYO4bKDnwIQkEr49pDqHyB_UNhiCGZVtpLjpRiB7m','胖胖','2026-09-14T06:50:56.479Z');
INSERT INTO activity_log VALUES(181,'art_submission_file','a3b0e02d-392b-4c84-9b86-6d540e58b7ce','上传参考图：4XireAcAlWxjiUSh8ZpeGO-99Q8oLexgL_hHmLjomT5ut7JlS7Q89KTY13w1EFbGhTJzkdY-9FBPlt2ZnffBjySESmsymri4qT9T3_YBPF0Mc1jYhzP2IJ7R','胖胖','2026-09-14T06:50:56.812Z');
INSERT INTO activity_log VALUES(182,'art_submission_file','62e8576c-e10e-4a97-b828-3e6581b0af27','上传参考图：dAR5HAinIIvj2eOXeuCJz0kcfBOixx9O1V3-34ugccgpQX7iZLjiM1uiRUgZkhjSZwjxallN5KzvNLW2UVMCVMEyp1o86KPSh3_x5lX_z22CTLKfXXf6lyKN','胖胖','2026-09-14T06:50:58.822Z');
INSERT INTO activity_log VALUES(183,'art_submission_file','6d7294f1-1795-493d-8116-5b966ddda92a','上传参考图：0355uMAJSDajiwnXB-ry-uh8tRQirk6qijvKQM5HfNAZmZBFpUOBhNvd0_RF9J5-yWJER30bZTmymMfA-gc3Rzjtrzl811cFsKkIW0Sq6O-f7fVq2ehDGDt2','胖胖','2026-09-14T06:50:59.561Z');
INSERT INTO activity_log VALUES(184,'art_submission_file','99b0e336-86b5-406e-8d35-55d288e372fc','上传参考图：5bT2aygKFRNuzsKGcowPgwfp08IJ1atYxKH5cARGAsx9ib_o5igf4hDPr5uzayhhXQOmO1LKHW0I-5QtTuRak_qQbAPlz9_wJadZ45IKfHp2RkaCgrsPuTHA','胖胖','2026-09-14T06:51:00.380Z');
INSERT INTO activity_log VALUES(185,'art_submission_file','78676931-85e0-4121-87fa-22e394328aa3','上传参考图：DP329151-web.jpg','胖胖','2026-09-14T06:51:01.493Z');
INSERT INTO activity_log VALUES(186,'art_submission_file','5a048402-4483-4730-a503-98af0a6581ee','上传参考图：DP334115-web.jpg','胖胖','2026-09-14T06:51:02.016Z');
INSERT INTO activity_log VALUES(187,'art_submission_file','bf7d5ad4-89cd-4ba9-9d06-41ada6a9d098','上传参考图：eBCbD0tCvwhMtOF8hZ4fFwpJLJyd84QdUd9KcgKhd4ZWPintiYiuv3R3DBBqY_SrzZZp6_y9r8VaWZabOg1odr5Yzvp3SyDaT0e5pL2zdDrtlhpzTcs-i_XV','胖胖','2026-09-14T06:51:02.946Z');
INSERT INTO activity_log VALUES(188,'art_submission_file','9d70c8a3-9393-4f9f-bc99-a2e93d80869d','上传参考图：fq9ERrBc7IKM03BXV8HzdJXU1vXXF2_0xwSHZqGpQA10IbfkoLCPxEfFuVR4hc0m62JSg3Rkqz_NDW9jy8gNra79oJ3RsvEXecWmeb4ZXEXLN3C7zJYZyg5o','胖胖','2026-09-14T06:51:05.196Z');
INSERT INTO activity_log VALUES(189,'art_submission_file','b127c139-6cd5-473d-88ab-92537ab541e4','上传参考图：FTAbfIS-d4l4NbXQGY4rvB-4DQhbx62sNIc1ycBHHX__khHlLxREqfK6oXtMLnL_QUcQ_U1HnnOepGi7uymlZRvpbaKVuIJOcFPosR0JXsdLYYqpMUQj5153','胖胖','2026-09-14T06:51:05.951Z');
INSERT INTO activity_log VALUES(190,'art_submission_file','8c90ac30-99f2-4ede-b26d-3f05cf634562','上传参考图：FYWxB1ACYLjpX6rc7ffXRIcL9E6V4OgYnzuH_0GquTdQhRAqE_-nfKyLQRo-jC-Q-erMsjk6zh1qyyUww0Q_Da_sYdi1AAVByaNoqcZZeTeZjE91L8IIDdYn','胖胖','2026-09-14T06:51:07.033Z');
INSERT INTO activity_log VALUES(191,'art_submission_file','72926cec-d4d8-4478-a111-b1dd506886ff','上传参考图：gBXbbghdBf7-KCDHqn7NDG_WmJcPpYH1ZQ9Kp1TPTgXHm47WOVCPQesbd6XQvtNrySefHlaijtrM2AmfXA4ufyQePDTA4K0iiA-t9pV1EqZD9JAlHr2wWOOC','胖胖','2026-09-14T06:51:07.651Z');
INSERT INTO activity_log VALUES(192,'art_submission_file','2bb03e28-efce-4d9d-849e-6b10eeda8e96','上传参考图：fWnJIuP0yomHbcCv8GcNEQKQhc7u2QO-taI7P-4l5KK_kUvMfotJMkKQxrSOJ81vqdtd6zVETd17fn1TLXMbcV8T_Rk3TjWARrSQ1ZbJYrkh4vAnMOfjZE7W','胖胖','2026-09-14T06:51:07.436Z');
INSERT INTO activity_log VALUES(193,'art_submission_file','66604019-6c7a-44bb-90b2-f6791ce31252','上传参考图：gc3CRefyAYioNJort_cJ_tZRfeyV0ISKRr5FwLBbcegZcw8Drjs5l2kYkoguXc27_TtWZku8PSGMmOk3Y3esbkb8p2SfFSRbDNpEfYj5Vnd-BfuoJZ026UNy','胖胖','2026-09-14T06:51:08.604Z');
INSERT INTO activity_log VALUES(194,'art_submission_file','c915aeda-87f9-4a40-9bc1-24a60234ded4','上传参考图：h3VJiQWSoP6bcWmeGkNSCNWIZiTaG3a-pLnHAdTHCZQuvDalsfYQd9jQSxM8ir5ERWVq8kttaCzsYn_T0hOStOoqiSHvlNJDf2iRvSXyfcrwQkRgmDI63p_O','胖胖','2026-09-14T06:51:10.594Z');
INSERT INTO activity_log VALUES(195,'art_submission_file','51f2b787-70af-493d-b10b-48c04d719cf0','上传参考图：gfYTY-jarqHxM--llUFEPnlc5sOOMe1KuYxv8TMGG5-UVnT2TsJqPMwDqVPSaSOPKkoXQWShcyZN_CmyH1DJHT8If5pG9snwKqEroaaBLzFewXST1-MQjWiu','胖胖','2026-09-14T06:51:10.223Z');
INSERT INTO activity_log VALUES(196,'art_submission_file','f7fdee75-bd50-480d-9820-43c780b8a716','上传参考图：GGrD3BiHCdP3TBZJEaqyw9ECSHTME9RdnK4qUxTAPTJYzpXsqYnfvvSvb6gRKOVMVTsLvIKrgpdvk4l_7KQ1zkW6J6Xr330RFSowxI3frcTYpvJhzjPhtImY','胖胖','2026-09-14T06:51:10.554Z');
INSERT INTO activity_log VALUES(197,'art_submission_file','60895e5b-e4cf-4045-8bf7-dc1161c52508','上传参考图：IHupEl6gAOdtkxgKBmVtDRMBxuVmcF6UpsDsZyXQvNDq2m4I-U1qVADJ0oFPRtKd8QUSWtRKnDMo4gFKDJf29TUNIsRxFd1bFAglOKai8H4ykR4b0lJIdVYc','胖胖','2026-09-14T06:51:12.482Z');
INSERT INTO activity_log VALUES(198,'art_submission_file','fe65aac8-5efd-4528-af2b-587a14f4abcc','上传参考图：IeZC7TjLrCVmSAW0vUqsUG_QjhUZ6gP26-UU--5uVjGIvgtNErZoyrK6Iev2fy6JicJqfVJufkzGzgbuvi7Py4KPe3_VLcFxNU_y_iN39zGPLpFgOtCsaM42','胖胖','2026-09-14T06:51:12.540Z');
INSERT INTO activity_log VALUES(199,'art_submission_file','bb7d4235-e4a7-4022-893b-5e7e2a1cba2d','上传参考图：JULt-bHCqJ5QEhKQg1hf0ZyDi5Zn-BUOvXIsXBffL0Jm66bCG0hGyHhmMnx0_CzoHdbsiNbaLoAEM7qr9NlRM4CjrkvxqjY6slIO26yGaNtFZNxVIX2tsQyg','胖胖','2026-09-14T06:51:15.863Z');
INSERT INTO activity_log VALUES(200,'art_submission_file','24572603-7e91-4e5f-b370-222135c34d40','上传参考图：KF0_l7Lzh7-psBr0Um9RkJ_3jnkmFwAIAb1VdseUuiimC8mkrZcaF6HkatzIsHR_sA7AQLI2_0Ade_BZHfEoe_kNYNDnkNWgodzyjfHJs33Cm7jzoE5mtwId','胖胖','2026-09-14T06:51:16.056Z');
INSERT INTO activity_log VALUES(201,'art_submission_file','45c78a13-350f-47a0-a4f8-8a9a2b1343dd','上传参考图：iZIzShaz9PuiSBPP8Ghti9cPgm5g9FEe0vMVtkRoQ6QS6xOlGSpqu9IBNXtT9aKKsV5JG59tqX1geY2nLvLqrik7HoDUQBafBzR91o7HR5_TozgIiO3KWi0n','胖胖','2026-09-14T06:51:17.007Z');
INSERT INTO activity_log VALUES(202,'art_submission_file','124174a0-d627-4f77-83e9-a7ad4ad7f1db','上传参考图：L6zzgdcxfvRGbHLQyjyQOy_sqvqzkryHIhFu2Uhip4tZ5o96rJMcLbRtWZPHLzFvh5zVw38NpaZW-9sIZmUChob20dUIIeYrLSnHNbIcijFCshzF1SW9Dhrb','胖胖','2026-09-14T06:51:17.873Z');
INSERT INTO activity_log VALUES(203,'art_submission_file','5d85cd42-8d03-4361-b8c2-aa0c76b72efc','上传参考图：lKHCXThffZNoCJ9KvB6v9j8OxHFJSdJPvjjB3W1MfiAwRBOtEpesQOAq8H-SednqAqb78UF4d5n2zE8IWE6dLH2pk19vUXJb9JVhMkH9i_mXCdhfa8lXZOsU','胖胖','2026-09-14T06:51:19.610Z');
INSERT INTO activity_log VALUES(204,'art_submission_file','39d63a15-2ed2-4301-aea1-69695a6274f8','上传参考图：MUmtaFheaqa-zL2yA8fUXwCWRuDmRTU2tMwvKvfBtaPfO0pOOJgf8d0yYMWxSCs1i2ZttO6QnRCp3LUrP57GZOw2Qv19WO-npHikqlkVbNtjKPvDf-gUdZTO','胖胖','2026-09-14T06:51:19.611Z');
INSERT INTO activity_log VALUES(205,'art_submission_file','2a05b8ba-1752-4fce-be52-e51d3ff46f33','上传参考图：lDwPZNx2ySF8bgaW7NAqpxTWD7tgSUy336-PCAC9OcjwY1gdffz89RN9yrLkQeACZLAeTy2sXAOpEEqsISJALHts18GaOzs-_9snazTyQW7kKCCU4bCeUarF','胖胖','2026-09-14T06:51:20.705Z');
INSERT INTO activity_log VALUES(206,'art_submission_file','be92a6d4-9f52-4879-90b1-505a46fe150c','上传参考图：nJSlMeDmVj9mlpyyLWdU4gd0tHRxb3BW4IpdqGE99CZh0xe88lWkX8tRuIrE_MTV5bt4fwqMqAoY-VHBB_Frr8wweqiCz00Jwd5liNSBH5w4lLmPvmdogu2A','胖胖','2026-09-14T06:51:22.653Z');
INSERT INTO activity_log VALUES(207,'art_submission_file','9e7c2bbf-e656-4e25-9268-4500dc7fc0f2','上传参考图：nxEsD9pQ-5FEHrjIcR-V_Ql7JP_aG50YOKBWwc5jFuEtq1j3pNhenxpSXZ61H8rYd1930Y1LnRzExRVumawzjeq9dNZNYnUh66KtHdZPoO8p-wOYaHfPgTch','胖胖','2026-09-14T06:51:22.875Z');
INSERT INTO activity_log VALUES(208,'art_submission_file','6e304928-3390-49ba-9059-9f753b6a4bbf','上传参考图：n-ytXSaE0svt2NmDeB3z3By1vGd9qpmxHwZ-CxDlhYWHO8WMw8-JzxrtflORnJl-uROmgduGP-zxEaUOwBM-vT9R7WYiveFjwuwsuSxdMztzUmRGev5NywJf','胖胖','2026-09-14T06:51:23.622Z');
INSERT INTO activity_log VALUES(209,'art_submission_file','14f233b6-c3c8-4dab-a846-a1bf2e4dc7aa','上传参考图：Qhyp-1tgxIYMTSl-hJGdyorgpIfmCPm0dHDIlE6vCp6p4V2AsZlHxNoy2GoIwBO9NXsPXCDFvxKBeKJ_E9ZlIBaQe5Y5h82buRhOXW3HvB8K0FXBT1RHGpsj','胖胖','2026-09-14T06:51:25.798Z');
INSERT INTO activity_log VALUES(210,'art_submission_file','e0dc74a2-70ab-48c6-80a6-0560cafe6dd4','上传参考图：pr6tD-6ZMXmeObxcWJMpxUyiJ6QcFW2fiajN6YnANlvrfzW-YWeOUsq5Aqnn3DOcnlLopIw3kjJUdBO8M8j47P_P40oFHI5O4Q4NSN8OyI62-fa_W2mE4DAR','胖胖','2026-09-14T06:51:25.829Z');
INSERT INTO activity_log VALUES(211,'art_submission_file','69293b24-1329-4bc0-9f18-7ed4660a6064','上传参考图：pFp8r_AzjWIIvDPjjUFYCcJqb9aMgMZxGB3kHPjo3TGCeWeyTI93NsuYqhzX1y8dUSgIV1Ro9iNjgFdOtDA0lzre_Y8uWiXnFtALRK9A4KL00K5KzGNLwSFI','胖胖','2026-09-14T06:51:26.357Z');
INSERT INTO activity_log VALUES(212,'art_submission_file','64f84f63-bded-4652-8767-36fa6e40190f','上传参考图：sKp52dlO-GkJ9p4APYnpRk9uS5KJDDeH8T5ItIxRwzVZPg4PaItdiiCYtg0cJlU57PSQLapNl3Re4GWBaohLWTXJTh0RWL-HKAmmPCbwO6AZwcGG60SF01zi','胖胖','2026-09-14T06:51:28.228Z');
INSERT INTO activity_log VALUES(213,'art_submission_file','8e59d059-0a13-4839-ab66-39176f8c4e11','上传参考图：QlJaZKT20CBJAifxaV4GbmRbCrlQilk0CAFAyT1qFxaFH4RxbF3sU97HcohN3mdfaggmeF62E8EbX4Yx54zcUo6vCmoi84S00mFzH-uqoEwgh6UzA5VQ5fA2','胖胖','2026-09-14T06:51:28.421Z');
INSERT INTO activity_log VALUES(214,'art_submission_file','66b5bbca-08cc-423a-b08e-a5574956639a','上传参考图：RD0oMdSE4lAsMMVPzEdhugB3bgwxHqehAluHBTv3ruH95BsP5-lT6gpLB8JcvyxJmnW6I2MrfZafUfB-2DmGXZYnKPIjKnkiqXrEpl5yzI3ZaPhSuQkd8LVc','胖胖','2026-09-14T06:51:28.905Z');
INSERT INTO activity_log VALUES(215,'art_submission_file','978d2eae-7391-48fd-90eb-774d237e1821','上传参考图：UpgfK781YxJoZzqFOunv5qNB-Lmd5UDFRp71DamrZyRg3ATlsPfiTkyt-sRWJtvfbcNCfEW0H4-CrxbuyXzh9azn9QpBZWIvcoJijEmc9GhrQO8MWtXgUO7v','胖胖','2026-09-14T06:51:29.941Z');
INSERT INTO activity_log VALUES(216,'art_submission_file','7c7c0486-c8d3-4b01-a4c8-8ec41fc3f6f5','上传参考图：w2NX4ub6mIrPWZHMrx57L3s5buBQ65nYglbgvHbJ6DyvkxEKLPht1FnoW93npRfzjCm9Pur11wb6vrlnDr0f-c2mXmfCLqH_o66gkzGDnLeBqhEHfqhft55j','胖胖','2026-09-14T06:51:31.519Z');
INSERT INTO activity_log VALUES(217,'art_submission_file','4d022b44-4b45-4c59-9e79-c7868a01c01c','上传参考图：VTetNB4nT4fz7gtQIG1sMefcUdz1QHn7ii99FlXsOFtQcYF1stLzMvBMnF2j50fYSrZhpEXe8RAc0Xtiu-C0k6xwJe-Vx-__tBBnhFqaIN7hbaZ5aECUOWNj','胖胖','2026-09-14T06:51:31.826Z');
INSERT INTO activity_log VALUES(218,'art_submission_file','636f94f7-a1ad-4f41-b229-236366d97749','上传参考图：Whzb-CShAB4a6JaLGDIYN8EcH_NLMMXQHfppewxrsxiB4tPWjUYhCOfdijo6GSuG5F02ofnbfytu5K71PRIzvg06Hx8V_eSN7neUIYDVJtUOzXSldYnzamYQ','胖胖','2026-09-14T06:51:32.005Z');
INSERT INTO activity_log VALUES(219,'art_submission_file','cb43b16d-1253-4959-8afc-60c4e2bb74f1','上传参考图：ZQlyiiZSR362LZ4lPA9CkQgZnaQRYFrvwMid8mrwLM6PwoToAUUDZo5n_TI4CDISFax6JePoL35D6KN-l-W-LF7I_1pZcQLkZHogP52sCotYwN6O07Zx-kDL','胖胖','2026-09-14T06:51:34.101Z');
INSERT INTO activity_log VALUES(220,'art_submission_file','aa575347-de1d-4f6c-afe2-b7d73c4d08a0','上传参考图：wKzh4SRsyrNHjP18bv5DDWvtuQoPWEMowiStNQSKmrt8cd-D8sNZ_HTEsG10PKDERqgiZfYNcOpQae-iEXRA7BzC5GVfG_XjoFsRcdFnvRPxbE0aql8xkXEk','胖胖','2026-09-14T06:51:34.093Z');
INSERT INTO activity_log VALUES(221,'art_submission_file','70695bdf-d94f-426d-b391-ecf1c3274696','上传参考图：微信图片_20260914144522_2001_22.jpg','胖胖','2026-09-14T06:51:35.639Z');
INSERT INTO activity_log VALUES(222,'art_submission_file','f254d7af-3594-4e7c-afeb-ae2a6a0b4f50','上传参考图：微信图片_20260914144522_2002_22.jpg','胖胖','2026-09-14T06:51:35.677Z');
INSERT INTO activity_log VALUES(223,'art_submission_file','1bc4ac08-b3b9-4cfc-ad20-d1b962149de4','上传参考图：xuJF5qrbQHPPDLpCbNHX9d20diTraRfSmYuNrEkHfovBfkfox8rybNVLul9k3qjRRkXVBLfjAveID0j82sx-vlVoy73R7lcZL9rmLHt3IhZMxURwH7oM909b','胖胖','2026-09-14T06:51:36.019Z');
INSERT INTO activity_log VALUES(224,'art_submission_file','5063ddf1-6e14-44a3-84d2-ad92616fd827','上传参考图：微信图片_20260914144522_2003_22.jpg','胖胖','2026-09-14T06:51:37.848Z');
INSERT INTO activity_log VALUES(225,'art_submission_file','c8778664-744f-42d8-908c-c638c01a6495','上传参考图：微信图片_20260914144522_2004_22.jpg','胖胖','2026-09-14T06:51:37.913Z');
INSERT INTO activity_log VALUES(226,'art_submission_file','8c5656b7-bbcc-4eb1-8b2a-b659e57f2763','上传参考图：微信图片_20260914144522_2005_22.jpg','胖胖','2026-09-14T06:51:38.586Z');
INSERT INTO activity_log VALUES(227,'art_submission_file','bbbbb0f6-7506-4a29-b411-f48d02face5e','上传参考图：微信图片_20260914144522_2006_22.jpg','胖胖','2026-09-14T06:51:39.513Z');
INSERT INTO activity_log VALUES(228,'art_submission_file','a689d2a3-ffa9-4a1b-9ce1-d49bf1637677','上传参考图：微信图片_20260914144522_2007_22.jpg','胖胖','2026-09-14T06:51:39.545Z');
INSERT INTO activity_log VALUES(229,'art_submission_file','ceee1bb2-bf4a-4fa7-a205-41e7a09187cb','上传参考图：微信图片_20260914144522_2008_22.jpg','胖胖','2026-09-14T06:51:42.841Z');
INSERT INTO activity_log VALUES(230,'art_submission_file','4706554b-772d-462d-9f70-1495e52a4741','上传参考图：微信图片_20260914144522_2009_22.jpg','胖胖','2026-09-14T06:51:43.691Z');
INSERT INTO activity_log VALUES(231,'art_submission_file','fb3ad5da-7484-490f-9222-c4711c745dc4','上传参考图：微信图片_20260914144522_2010_22.jpg','胖胖','2026-09-14T06:51:43.729Z');
INSERT INTO activity_log VALUES(232,'art_submission_file','232f38f6-b07c-4cc2-8879-f2e6c6735238','上传参考图：微信图片_20260914144522_2011_22.jpg','胖胖','2026-09-14T06:51:44.943Z');
INSERT INTO activity_log VALUES(233,'art_submission_file','bac0881e-9426-4e0c-a51d-22e5c0fc06a4','上传参考图：微信图片_20260914144522_2012_22.jpg','胖胖','2026-09-14T06:51:45.219Z');
INSERT INTO activity_log VALUES(234,'art_submission_file','bdbb3a8d-8972-45cc-b09d-240750006353','上传参考图：微信图片_20260914144522_2013_22.jpg','胖胖','2026-09-14T06:51:46.020Z');
INSERT INTO activity_log VALUES(235,'art_submission_file','9e3fb7fb-e777-45db-9359-c5ef010ff3f6','上传参考图：微信图片_20260914144522_2015_22.jpg','胖胖','2026-09-14T06:51:46.915Z');
INSERT INTO activity_log VALUES(236,'art_submission_file','d6b756dc-d516-44dd-b02c-030dccf0685d','上传参考图：微信图片_20260914144522_2014_22.jpg','胖胖','2026-09-14T06:51:46.902Z');
INSERT INTO activity_log VALUES(237,'art_submission_file','d0902c5e-8877-477b-af40-764d692256b5','上传参考图：微信图片_20260914144522_2016_22.jpg','胖胖','2026-09-14T06:51:48.264Z');
INSERT INTO activity_log VALUES(238,'art_submission_file','1f8d2c29-aaba-49a7-a4c0-63bf3ae0a9b9','上传参考图：微信图片_20260914144522_2018_22.jpg','胖胖','2026-09-14T06:51:49.337Z');
INSERT INTO activity_log VALUES(239,'art_submission_file','488f4f4a-6818-4c73-859e-788685b9cab7','上传参考图：微信图片_20260914144522_2017_22.jpg','胖胖','2026-09-14T06:51:49.500Z');
INSERT INTO activity_log VALUES(240,'art_submission_file','a252106b-cfd8-41f0-abdd-7543a28b1659','上传参考图：微信图片_20260914144522_2019_22.jpg','胖胖','2026-09-14T06:51:51.081Z');
INSERT INTO activity_log VALUES(241,'art_submission_file','1b9688b0-19c2-4452-bec6-3afbe5bb6cda','上传参考图：微信图片_20260914144522_2021_22.jpg','胖胖','2026-09-14T06:51:52.251Z');
INSERT INTO activity_log VALUES(242,'art_submission_file','c7d093ef-5ea2-4a75-ae8e-dd33f06af732','上传参考图：微信图片_20260914144522_2020_22.jpg','胖胖','2026-09-14T06:51:53.670Z');
INSERT INTO activity_log VALUES(243,'art_submission_file','f786439e-b0e4-4682-88aa-92de57eddae2','上传参考图：微信图片_20260914144522_2022_22.jpg','胖胖','2026-09-14T06:51:53.976Z');
INSERT INTO activity_log VALUES(244,'art_submission_file','a14cf2ca-e57f-4997-9c3c-109d72c8a380','上传参考图：微信图片_20260914144522_2023_22.jpg','胖胖','2026-09-14T06:51:53.967Z');
INSERT INTO activity_log VALUES(245,'art_submission_file','6b88ae5a-1d2b-4a55-8d19-c565f9348acd','上传参考图：微信图片_20260914144522_2024_22.jpg','胖胖','2026-09-14T06:51:55.465Z');
INSERT INTO activity_log VALUES(246,'art_submission_file','0a31bbe6-7946-40a8-abb7-c582a4ff712d','上传参考图：微信图片_20260914144522_2026_22.jpg','胖胖','2026-09-14T06:51:57.170Z');
INSERT INTO activity_log VALUES(247,'art_submission_file','06163309-9277-4450-ad3b-3589bc60f81b','上传参考图：微信图片_20260914144522_2027_22.jpg','胖胖','2026-09-14T06:51:57.635Z');
INSERT INTO activity_log VALUES(248,'art_submission_file','2ec1a9fb-e235-479a-a941-806c7c6baff3','上传参考图：微信图片_20260914144522_2025_22.jpg','胖胖','2026-09-14T06:51:57.649Z');
INSERT INTO activity_log VALUES(249,'art_submission_file','8bb9f69a-7643-47b3-998a-929319b91da8','上传参考图：微信图片_20260914144522_2028_22.jpg','胖胖','2026-09-14T06:51:59.812Z');
INSERT INTO activity_log VALUES(250,'art_submission_file','aa360e24-6443-4873-8c76-205fb1325275','上传参考图：微信图片_20260914144522_2030_22.jpg','胖胖','2026-09-14T06:51:59.822Z');
INSERT INTO activity_log VALUES(251,'art_submission_file','1db59894-9e03-4292-a303-8d30d4c20820','上传参考图：微信图片_20260914144522_2029_22.jpg','胖胖','2026-09-14T06:52:01.434Z');
INSERT INTO activity_log VALUES(252,'art_submission_file','b044966e-0c0a-46b1-acc4-28ef6c8fc33b','上传参考图：微信图片_20260914144522_2033_22.jpg','胖胖','2026-09-14T06:52:06.382Z');
INSERT INTO activity_log VALUES(253,'art_submission_file','1c1057ce-3736-4250-a240-15a6b32783e0','上传参考图：微信图片_20260914144522_2031_22.jpg','胖胖','2026-09-14T06:52:06.411Z');
INSERT INTO activity_log VALUES(254,'art_submission_file','dafcec62-1586-4301-aa23-5ed2157b2fc4','上传参考图：微信图片_20260914144522_2032_22.jpg','胖胖','2026-09-14T06:52:06.414Z');
INSERT INTO activity_log VALUES(255,'art_submission_file','82b059d7-eb38-41b8-8996-92b3521b432f','上传参考图：微信图片_20260914144522_2034_22.jpg','胖胖','2026-09-14T06:52:07.966Z');
INSERT INTO activity_log VALUES(256,'art_submission_file','73ca0748-09b2-411c-b91f-3e68d0c83819','上传参考图：微信图片_20260914144522_2035_22.jpg','胖胖','2026-09-14T06:52:08.001Z');
INSERT INTO activity_log VALUES(257,'art_submission_file','c94021e4-dad9-44f7-b058-34808fb52b7f','上传参考图：微信图片_20260914144522_2036_22.jpg','胖胖','2026-09-14T06:52:08.371Z');
INSERT INTO activity_log VALUES(258,'art_submission_file','67077851-22bf-4a33-831a-de0cfa53914e','上传参考图：微信图片_20260914144522_2038_22.jpg','胖胖','2026-09-14T06:52:10.600Z');
INSERT INTO activity_log VALUES(259,'art_submission_file','f4669b8c-bceb-47e8-bd78-6c18d756caaf','上传参考图：微信图片_20260914144522_2037_22.jpg','胖胖','2026-09-14T06:52:10.389Z');
INSERT INTO activity_log VALUES(260,'art_submission_file','102f9bd1-c456-4642-a928-4f296cd423fe','上传参考图：微信图片_20260914144522_2039_22.jpg','胖胖','2026-09-14T06:52:10.574Z');
INSERT INTO activity_log VALUES(261,'art_submission_file','e1d64053-8d7a-4e0d-a8f9-0f10328fad78','上传参考图：微信图片_20260914144522_2040_22.jpg','胖胖','2026-09-14T06:52:13.342Z');
INSERT INTO activity_log VALUES(262,'art_submission_file','7e759486-2bc8-4b80-afea-14c4bd284fcc','上传参考图：微信图片_20260914144522_2042_22.jpg','胖胖','2026-09-14T06:52:13.340Z');
INSERT INTO activity_log VALUES(263,'art_submission_file','619c49b6-b63c-4116-b1b7-67bd97b4ce5a','上传参考图：微信图片_20260914144522_2041_22.jpg','胖胖','2026-09-14T06:52:13.335Z');
INSERT INTO activity_log VALUES(264,'art_submission_file','06a7d8dc-de7e-46e6-b5c3-9ac3d5dc641a','上传参考图：微信图片_20260914144522_2043_22.jpg','胖胖','2026-09-14T06:52:15.326Z');
INSERT INTO activity_log VALUES(265,'art_submission_file','c80882ee-2194-47d5-8cc7-6d883c900aff','上传参考图：微信图片_20260914144522_2045_22.jpg','胖胖','2026-09-14T06:52:15.393Z');
INSERT INTO activity_log VALUES(266,'art_submission_file','64a0e6b6-991d-455a-bde6-698cbf51cafd','上传参考图：微信图片_20260914144522_2044_22.jpg','胖胖','2026-09-14T06:52:15.733Z');
INSERT INTO activity_log VALUES(267,'art_submission_file','6ce5ab18-5eb1-4c32-bbbf-488ae9e1bf9c','上传参考图：微信图片_20260914144522_2046_22.jpg','胖胖','2026-09-14T06:52:16.895Z');
INSERT INTO activity_log VALUES(268,'art_submission_file','0c7a5c9b-893a-498d-9708-8998a9b3b055','上传参考图：微信图片_20260914144522_2049_22.jpg','胖胖','2026-09-14T06:52:18.897Z');
INSERT INTO activity_log VALUES(269,'art_submission_file','35c0af1d-b860-494e-ae85-e3e01229cf38','上传参考图：微信图片_20260914144522_2047_22.jpg','胖胖','2026-09-14T06:52:18.274Z');
INSERT INTO activity_log VALUES(270,'art_submission_file','5630e975-b6b7-454b-a875-70be7b386498','上传参考图：微信图片_20260914144522_2048_22.jpg','胖胖','2026-09-14T06:52:18.701Z');
INSERT INTO activity_log VALUES(271,'art_submission_file','e7a4750a-96c9-4ec3-b717-ce2601ba5811','上传参考图：微信图片_20260914144522_2050_22.jpg','胖胖','2026-09-14T06:52:20.482Z');
INSERT INTO activity_log VALUES(272,'art_submission_file','336a9253-bcba-4a8d-bc1c-fe0d3591da3e','上传参考图：微信图片_20260914144522_2052_22.jpg','胖胖','2026-09-14T06:52:20.836Z');
INSERT INTO activity_log VALUES(273,'art_submission_file','30fe8a44-1f68-4fe4-84ed-1a5f6e14163f','上传参考图：微信图片_20260914144522_2051_22.jpg','胖胖','2026-09-14T06:52:20.708Z');
INSERT INTO activity_log VALUES(274,'art_submission_file','b55ab793-9918-40dd-add6-319c4e8a10a4','上传参考图：微信图片_20260914144522_2053_22.jpg','胖胖','2026-09-14T06:52:22.114Z');
INSERT INTO activity_log VALUES(275,'art_submission_file','18bfdf1c-7ef4-4e14-ba41-506c754fedf1','上传参考图：微信图片_20260914144522_2055_22.jpg','胖胖','2026-09-14T06:52:22.415Z');
INSERT INTO activity_log VALUES(276,'art_submission_file','abf30ac7-7116-4767-9252-2f15a2e56054','上传参考图：微信图片_20260914144522_2054_22.jpg','胖胖','2026-09-14T06:52:22.387Z');
INSERT INTO activity_log VALUES(277,'art_submission_file','dce5fbc8-10db-43f8-964a-b824a23c8e0c','上传参考图：微信图片_20260914144522_2056_22.jpg','胖胖','2026-09-14T06:52:23.911Z');
INSERT INTO activity_log VALUES(278,'art_submission_file','b4d21e02-5c41-4b01-808c-b80d4ccfa14e','上传参考图：微信图片_20260914144522_2057_22.jpg','胖胖','2026-09-14T06:52:24.203Z');
INSERT INTO activity_log VALUES(279,'art_submission_file','e47a9fb7-42bb-47cd-bbaa-d879c724f4c3','上传参考图：微信图片_20260914144522_2058_22.jpg','胖胖','2026-09-14T06:52:25.518Z');
INSERT INTO activity_log VALUES(280,'art_submission_file','d5209c8f-3be4-4204-a5cc-1a800b0c7563','上传参考图：微信图片_20260914144522_2060_22.jpg','胖胖','2026-09-14T06:52:26.123Z');
INSERT INTO activity_log VALUES(281,'art_submission_file','4cf816c6-0cc1-4046-8c13-9dfb0b260ced','上传参考图：微信图片_20260914144522_2059_22.jpg','胖胖','2026-09-14T06:52:25.724Z');
INSERT INTO activity_log VALUES(282,'art_submission_file','52887c83-e5cf-4be6-8d25-42714699b0d9','上传参考图：微信图片_20260914144522_2063_22.jpg','胖胖','2026-09-14T06:52:27.896Z');
INSERT INTO activity_log VALUES(283,'art_submission_file','11072865-e078-4bba-a7a6-79a6a3fc8baa','上传参考图：微信图片_20260914144522_2062_22.jpg','胖胖','2026-09-14T06:52:27.903Z');
INSERT INTO activity_log VALUES(284,'art_submission_file','cea86304-ecc6-40f9-acac-97386298d1b2','上传参考图：微信图片_20260914144522_2061_22.jpg','胖胖','2026-09-14T06:52:27.915Z');
INSERT INTO activity_log VALUES(285,'art_submission_file','ddfbe91d-f7ca-4e43-bc2e-da26a34071b9','上传参考图：微信图片_20260914144522_2064_22.jpg','胖胖','2026-09-14T06:52:30.248Z');
INSERT INTO activity_log VALUES(286,'art_submission_file','d6f9d003-5a9f-48d4-90df-9b78067270c0','上传参考图：微信图片_20260914144522_2065_22.jpg','胖胖','2026-09-14T06:52:31.983Z');
INSERT INTO activity_log VALUES(287,'art_submission_file','90f40f71-021f-4be0-bd76-658256187c3c','上传参考图：微信图片_20260914144522_2066_22.jpg','胖胖','2026-09-14T06:52:32.018Z');
INSERT INTO activity_log VALUES(288,'art_submission_file','7834c7bd-2ad1-44eb-bd62-aa2c7b77bdc4','上传参考图：微信图片_20260914144522_2068_22.jpg','胖胖','2026-09-14T06:52:33.671Z');
INSERT INTO activity_log VALUES(289,'art_submission_file','75010c7c-2e36-4843-a434-0175353fc39e','上传参考图：微信图片_20260914144522_2067_22.jpg','胖胖','2026-09-14T06:52:33.866Z');
INSERT INTO activity_log VALUES(290,'art_submission_file','99a3c05d-9576-44b2-a316-e5be578cee19','上传参考图：微信图片_20260914144522_2069_22.jpg','胖胖','2026-09-14T06:52:35.624Z');
INSERT INTO activity_log VALUES(291,'art_submission_file','1d82a4b6-6b71-4151-9796-294a0c1d9b86','上传参考图：微信图片_20260914144522_2071_22.jpg','胖胖','2026-09-14T06:52:36.314Z');
INSERT INTO activity_log VALUES(292,'art_submission_file','08d3ed05-dc9a-4768-9b7c-d1c2317c9493','上传参考图：微信图片_20260914144522_2070_22.jpg','胖胖','2026-09-14T06:52:36.014Z');
INSERT INTO activity_log VALUES(293,'art_submission_file','be9c172f-8d0e-4e36-b3bc-e3c60983a058','上传参考图：微信图片_20260914144522_2072_22.jpg','胖胖','2026-09-14T06:52:37.822Z');
INSERT INTO activity_log VALUES(294,'art_submission_file','82859475-93a8-4d72-8206-61666409f219','上传参考图：微信图片_20260914144522_2073_22.jpg','胖胖','2026-09-14T06:52:38.678Z');
INSERT INTO activity_log VALUES(295,'art_submission_file','32b52ecd-92e9-4d74-ae84-200fd74ecd03','上传参考图：微信图片_20260914144522_2074_22.jpg','胖胖','2026-09-14T06:52:40.316Z');
INSERT INTO activity_log VALUES(296,'art_submission_file','93f9608a-311c-4b09-a9f1-934ae2052441','上传参考图：微信图片_20260914144522_2076_22.jpg','胖胖','2026-09-14T06:52:41.132Z');
INSERT INTO activity_log VALUES(297,'art_submission_file','7d76a4f0-4bf5-4ab6-a61c-1969cfa7e79e','上传参考图：微信图片_20260914144522_2075_22.jpg','胖胖','2026-09-14T06:52:41.294Z');
INSERT INTO activity_log VALUES(298,'art_submission_file','0730514c-4dd5-4595-97e0-cb0ae26d6aae','上传参考图：微信图片_20260914144522_2079_22.jpg','胖胖','2026-09-14T06:52:43.774Z');
INSERT INTO activity_log VALUES(299,'art_submission_file','d4d9449d-8d6f-472b-8470-c88e25bc877b','上传参考图：微信图片_20260914144522_2078_22.jpg','胖胖','2026-09-14T06:52:43.767Z');
INSERT INTO activity_log VALUES(300,'art_submission_file','9b59ff7d-3d47-4eb1-a595-3e316da99d24','上传参考图：微信图片_20260914144522_2077_22.jpg','胖胖','2026-09-14T06:52:43.995Z');
INSERT INTO activity_log VALUES(301,'art_submission_file','3078a7ca-aba7-41f2-8057-c967561fe565','上传参考图：微信图片_20260914144522_2081_22.jpg','胖胖','2026-09-14T06:52:45.484Z');
INSERT INTO activity_log VALUES(302,'art_submission_file','b4bc5eee-37d9-4abb-88ee-996c37bc99be','上传参考图：微信图片_20260914144522_2080_22.jpg','胖胖','2026-09-14T06:52:45.692Z');
INSERT INTO activity_log VALUES(303,'art_submission_file','7164c8ac-a541-462d-9ad9-e78ed1278516','删除错误参考图','胖胖','2026-09-14T06:53:43.598Z');
INSERT INTO activity_log VALUES(304,'art_submission_file','62e8576c-e10e-4a97-b828-3e6581b0af27','删除错误参考图','胖胖','2026-09-14T06:53:47.543Z');
INSERT INTO activity_log VALUES(305,'art_submission_file','6d7294f1-1795-493d-8116-5b966ddda92a','删除错误参考图','胖胖','2026-09-14T06:53:51.580Z');
INSERT INTO activity_log VALUES(306,'art_submission_file','99b0e336-86b5-406e-8d35-55d288e372fc','删除错误参考图','胖胖','2026-09-14T06:53:57.166Z');
INSERT INTO activity_log VALUES(307,'art_submission_file','5a048402-4483-4730-a503-98af0a6581ee','删除错误参考图','胖胖','2026-09-14T06:54:02.216Z');
INSERT INTO activity_log VALUES(308,'art_submission_file','bf7d5ad4-89cd-4ba9-9d06-41ada6a9d098','删除错误参考图','胖胖','2026-09-14T06:54:06.005Z');
INSERT INTO activity_log VALUES(309,'art_submission_file','b127c139-6cd5-473d-88ab-92537ab541e4','删除错误参考图','胖胖','2026-09-14T06:54:10.842Z');
INSERT INTO activity_log VALUES(310,'art_submission_file','8c90ac30-99f2-4ede-b26d-3f05cf634562','删除错误参考图','胖胖','2026-09-14T06:54:13.645Z');
INSERT INTO activity_log VALUES(311,'art_submission_file','72926cec-d4d8-4478-a111-b1dd506886ff','删除错误参考图','胖胖','2026-09-14T06:54:16.261Z');
INSERT INTO activity_log VALUES(312,'art_submission_file','2bb03e28-efce-4d9d-849e-6b10eeda8e96','删除错误参考图','胖胖','2026-09-14T06:54:18.934Z');
INSERT INTO activity_log VALUES(313,'art_submission_file','51f2b787-70af-493d-b10b-48c04d719cf0','删除错误参考图','胖胖','2026-09-14T06:54:24.457Z');
INSERT INTO activity_log VALUES(314,'art_submission_file','60895e5b-e4cf-4045-8bf7-dc1161c52508','删除错误参考图','胖胖','2026-09-14T06:54:30.847Z');
INSERT INTO activity_log VALUES(315,'art_submission_file','bb7d4235-e4a7-4022-893b-5e7e2a1cba2d','删除错误参考图','胖胖','2026-09-14T06:54:35.941Z');
INSERT INTO activity_log VALUES(316,'art_submission_file','24572603-7e91-4e5f-b370-222135c34d40','删除错误参考图','胖胖','2026-09-14T06:54:39.195Z');
INSERT INTO activity_log VALUES(317,'art_submission_file','45c78a13-350f-47a0-a4f8-8a9a2b1343dd','删除错误参考图','胖胖','2026-09-14T06:54:44.402Z');
INSERT INTO activity_log VALUES(318,'art_submission_file','be92a6d4-9f52-4879-90b1-505a46fe150c','删除错误参考图','胖胖','2026-09-14T06:54:51.347Z');
INSERT INTO activity_log VALUES(319,'art_submission_file','6e304928-3390-49ba-9059-9f753b6a4bbf','删除错误参考图','胖胖','2026-09-14T06:54:55.609Z');
INSERT INTO activity_log VALUES(320,'art_submission_file','e0dc74a2-70ab-48c6-80a6-0560cafe6dd4','删除错误参考图','胖胖','2026-09-14T06:55:01.404Z');
INSERT INTO activity_log VALUES(321,'art_submission_file','14f233b6-c3c8-4dab-a846-a1bf2e4dc7aa','删除错误参考图','胖胖','2026-09-14T06:55:04.405Z');
INSERT INTO activity_log VALUES(322,'art_submission_file','69293b24-1329-4bc0-9f18-7ed4660a6064','删除错误参考图','胖胖','2026-09-14T06:55:06.929Z');
INSERT INTO activity_log VALUES(323,'art_submission_file','8e59d059-0a13-4839-ab66-39176f8c4e11','删除错误参考图','胖胖','2026-09-14T06:55:11.101Z');
INSERT INTO activity_log VALUES(324,'art_submission_file','66b5bbca-08cc-423a-b08e-a5574956639a','删除错误参考图','胖胖','2026-09-14T06:55:15.211Z');
INSERT INTO activity_log VALUES(325,'art_submission_file','7c7c0486-c8d3-4b01-a4c8-8ec41fc3f6f5','删除错误参考图','胖胖','2026-09-14T06:55:19.503Z');
INSERT INTO activity_log VALUES(326,'art_submission_file','cb43b16d-1253-4959-8afc-60c4e2bb74f1','删除错误参考图','胖胖','2026-09-14T06:55:24.958Z');
INSERT INTO activity_log VALUES(327,'art_submission_file','70695bdf-d94f-426d-b391-ecf1c3274696','删除错误参考图','胖胖','2026-09-14T06:55:29.174Z');
INSERT INTO activity_log VALUES(328,'art_submission_file','f254d7af-3594-4e7c-afeb-ae2a6a0b4f50','删除错误参考图','胖胖','2026-09-14T06:55:32.512Z');
INSERT INTO activity_log VALUES(329,'art_submission_file','1bc4ac08-b3b9-4cfc-ad20-d1b962149de4','删除错误参考图','胖胖','2026-09-14T06:55:36.338Z');
INSERT INTO activity_log VALUES(330,'art_submission_file','5063ddf1-6e14-44a3-84d2-ad92616fd827','删除错误参考图','胖胖','2026-09-14T06:55:44.276Z');
INSERT INTO activity_log VALUES(331,'art_submission_file','c8778664-744f-42d8-908c-c638c01a6495','删除错误参考图','胖胖','2026-09-14T06:55:46.679Z');
INSERT INTO activity_log VALUES(332,'art_submission_file','0a31bbe6-7946-40a8-abb7-c582a4ff712d','删除错误参考图','胖胖','2026-09-14T06:55:58.701Z');
INSERT INTO activity_log VALUES(333,'art_submission_file','06163309-9277-4450-ad3b-3589bc60f81b','删除错误参考图','胖胖','2026-09-14T06:56:04.333Z');
INSERT INTO activity_log VALUES(334,'art_submission_file','a252106b-cfd8-41f0-abdd-7543a28b1659','删除错误参考图','胖胖','2026-09-14T06:56:08.565Z');
INSERT INTO activity_log VALUES(335,'art_submission_file','2ec1a9fb-e235-479a-a941-806c7c6baff3','删除错误参考图','胖胖','2026-09-14T06:56:11.650Z');
INSERT INTO activity_log VALUES(336,'art_submission_file','b044966e-0c0a-46b1-acc4-28ef6c8fc33b','删除错误参考图','胖胖','2026-09-14T06:56:17.054Z');
INSERT INTO activity_log VALUES(337,'art_submission_file','1c1057ce-3736-4250-a240-15a6b32783e0','删除错误参考图','胖胖','2026-09-14T06:56:19.305Z');
INSERT INTO activity_log VALUES(338,'art_submission_file','dafcec62-1586-4301-aa23-5ed2157b2fc4','删除错误参考图','胖胖','2026-09-14T06:56:22.190Z');
INSERT INTO activity_log VALUES(339,'art_submission_file','82b059d7-eb38-41b8-8996-92b3521b432f','删除错误参考图','胖胖','2026-09-14T06:56:24.936Z');
INSERT INTO activity_log VALUES(340,'art_submission_file','73ca0748-09b2-411c-b91f-3e68d0c83819','删除错误参考图','胖胖','2026-09-14T06:56:31.206Z');
INSERT INTO activity_log VALUES(341,'art_submission_file','aa360e24-6443-4873-8c76-205fb1325275','删除错误参考图','胖胖','2026-09-14T06:56:33.386Z');
INSERT INTO activity_log VALUES(342,'art_submission_file','67077851-22bf-4a33-831a-de0cfa53914e','删除错误参考图','胖胖','2026-09-14T06:56:42.314Z');
INSERT INTO activity_log VALUES(343,'art_submission_file','64a0e6b6-991d-455a-bde6-698cbf51cafd','删除错误参考图','胖胖','2026-09-14T06:56:51.761Z');
INSERT INTO activity_log VALUES(344,'art_submission_file','35c0af1d-b860-494e-ae85-e3e01229cf38','删除错误参考图','胖胖','2026-09-14T06:56:56.935Z');
INSERT INTO activity_log VALUES(345,'art_submission_file','a3b0e02d-392b-4c84-9b86-6d540e58b7ce','删除错误参考图','胖胖','2026-09-14T06:57:41.470Z');
INSERT INTO activity_log VALUES(346,'art_submission_file','fe65aac8-5efd-4528-af2b-587a14f4abcc','删除错误参考图','胖胖','2026-09-14T06:57:52.223Z');
INSERT INTO activity_log VALUES(347,'art_submission_file','1db59894-9e03-4292-a303-8d30d4c20820','删除错误参考图','胖胖','2026-09-14T06:58:18.221Z');
INSERT INTO activity_log VALUES(348,'art_submission_file','c94021e4-dad9-44f7-b058-34808fb52b7f','删除错误参考图','胖胖','2026-09-14T06:58:22.115Z');
INSERT INTO activity_log VALUES(349,'art_submission_file','9b59ff7d-3d47-4eb1-a595-3e316da99d24','删除错误参考图','胖胖','2026-09-14T06:58:36.948Z');
INSERT INTO activity_log VALUES(350,'art_submission_file','93f9608a-311c-4b09-a9f1-934ae2052441','删除错误参考图','胖胖','2026-09-14T06:58:40.212Z');
INSERT INTO activity_log VALUES(351,'art_submission_file','4d022b44-4b45-4c59-9e79-c7868a01c01c','删除错误参考图','胖胖','2026-09-14T06:59:00.877Z');
INSERT INTO activity_log VALUES(352,'art_submission_file','9d70c8a3-9393-4f9f-bc99-a2e93d80869d','删除错误参考图','胖胖','2026-09-14T06:59:10.008Z');
INSERT INTO activity_log VALUES(353,'art_submission_detail','ep1-v3-s1-auto-10','提报状态更新为已上传，责任人玉冰，截止2026-09-11T18:00','胖胖','2026-09-14T07:07:38.014Z');
INSERT INTO activity_log VALUES(354,'task','rollup-2026-09-14-ep1-script','任务更新：已通过','Lipa','2026-09-14T07:09:01.561Z');
INSERT INTO activity_log VALUES(355,'task','rollup-2026-09-14-ep1-wardrobe','任务更新：已通过','Lipa','2026-09-14T07:09:04.203Z');
INSERT INTO activity_log VALUES(356,'art_submission_file','29a7ab5f-dcce-4706-b6b2-b606337e76f1','上传参考图：图片节点 7 (6)-web.jpg','Lipa','2026-09-14T07:11:11.839Z');
INSERT INTO activity_log VALUES(357,'art_submission_file','e9664ca7-d45c-44b4-99ef-08b009840fe3','上传参考图：图片节点 7 (4)-web.jpg','Lipa','2026-09-14T07:11:11.783Z');
INSERT INTO activity_log VALUES(358,'art_submission_file','29a7ab5f-dcce-4706-b6b2-b606337e76f1','删除错误参考图','Lipa','2026-09-14T07:11:21.311Z');
INSERT INTO activity_log VALUES(359,'art_submission_file','e9664ca7-d45c-44b4-99ef-08b009840fe3','删除错误参考图','Lipa','2026-09-14T07:11:24.391Z');
INSERT INTO activity_log VALUES(360,'art_submission_file','35e7477d-4d20-4b84-aef2-86426ca24e39','上传参考图：图片 - 2026-09-14T160916.136.jpg','王承恺','2026-09-14T08:10:24.973Z');
INSERT INTO activity_log VALUES(361,'art_submission_file','22b8b9b4-92f2-4a5e-8d0b-a6aa64c057f6','上传参考图：图片 - 2026-09-14T161253.881.jpg','王承恺','2026-09-14T08:13:21.111Z');
INSERT INTO activity_log VALUES(362,'art_submission_file','9ebcedd6-c55a-4851-9b77-3eadd4fd43ca','上传参考图：图片 - 2026-09-14T161248.479.jpg','王承恺','2026-09-14T08:13:21.308Z');
INSERT INTO activity_log VALUES(363,'art_submission_file','35e7477d-4d20-4b84-aef2-86426ca24e39','删除错误参考图','王承恺','2026-09-14T08:13:43.283Z');
INSERT INTO activity_log VALUES(364,'art_submission_file','307470df-8e4a-4f5b-9322-8599cd20c912','上传参考图：图片 - 2026-09-14T135620.198.jpg','王承恺','2026-09-14T08:15:19.855Z');
INSERT INTO activity_log VALUES(365,'art_submission_file','8d9ac9dc-4295-4b3e-9804-d0e4bbe059e4','上传参考图：图片 - 2026-09-14T160922.307.jpg','王承恺','2026-09-14T08:17:36.235Z');
INSERT INTO activity_log VALUES(366,'art_submission_file','d7c588fe-3cb2-4d3d-9ca4-62d5451e2a3e','上传参考图：静帧 2026-09-14 155557_1.4.3-web.jpg','王承恺','2026-09-14T08:18:36.944Z');
INSERT INTO activity_log VALUES(367,'episode_assets','第1集','按定稿场头校正第4—7场工作项：临水巷道、监控室、医院、酒店；保留全部图片和上传作者','Lipa','2026-09-14 08:27:00');
INSERT INTO activity_log VALUES(368,'art_submission_file','59d8cb89-f595-4c73-af55-7bf3fe4c198c','上传参考图：图片 - 2026-09-14T170936.365.jpg','王承恺','2026-09-14T09:10:23.018Z');
INSERT INTO activity_log VALUES(369,'task','rollup-2026-09-14-ep2-script','任务更新：已通过','李明鑫','2026-09-14T10:07:02.005Z');
INSERT INTO activity_log VALUES(370,'art_submission_file','04258e60-9590-40b4-9cb1-7b0045ebab52','删除错误参考图','Lipa','2026-09-14T10:47:05.869Z');
INSERT INTO activity_log VALUES(371,'episode_assets','第1集','第一场历史服装备选全部归入顾丽乔服装；保留文件与真实上传作者','Lipa','2026-09-14 10:55:46');
INSERT INTO activity_log VALUES(372,'task','rollup-2026-09-14-ep1-art','任务更新：已通过','王承恺','2026-09-14T10:57:24.620Z');
INSERT INTO activity_log VALUES(373,'task','rollup-2026-09-14-ep1-art','任务更新：未开始','王承恺','2026-09-14T10:57:26.597Z');
INSERT INTO activity_log VALUES(374,'art_submission_file','981ca381-0d1b-497c-a40f-a82f6f4165f7','上传参考图：IMG_2520-web.jpg','王承恺','2026-09-14T10:58:07.106Z');
INSERT INTO activity_log VALUES(375,'art_submission_file','d0742bf6-34f9-4f33-9c93-ad438302c167','删除错误参考图','王承恺','2026-09-14T10:59:38.075Z');
INSERT INTO activity_log VALUES(376,'art_submission_file','5320c385-97d6-40c0-a34d-70a712887685','上传参考图：图片 - 2026-09-10T162342.848-web.jpg','王承恺','2026-09-14T11:00:00.744Z');
INSERT INTO activity_log VALUES(377,'art_submission_file','2ba67fff-80d2-4326-8860-34597c0514bd','上传参考图：图片 - 2026-09-14T190820.705.jpg','王承恺','2026-09-14T11:09:24.696Z');
INSERT INTO activity_log VALUES(378,'art_submission_file','19adf828-b38e-4606-95b1-55f970537b67','上传参考图：图片 - 2026-09-14T190820.705.jpg','王承恺','2026-09-14T11:09:54.232Z');
INSERT INTO activity_log VALUES(379,'art_submission_file','87ab0b9d-706a-4ec6-bd41-4e48a3b14c61','上传参考图：IMG_8386.JPG','玉冰','2026-09-14T11:11:27.609Z');
INSERT INTO activity_log VALUES(380,'art_submission_file','dc1d377f-bc98-4f69-a5d0-8978742bf958','上传参考图：IMG_8385.JPG','玉冰','2026-09-14T11:11:28.052Z');
INSERT INTO activity_log VALUES(381,'art_submission_file','e750bad8-b7c6-49c5-929a-0e1e382c2921','上传参考图：IMG_8382.JPG','玉冰','2026-09-14T11:11:28.271Z');
INSERT INTO activity_log VALUES(382,'art_submission_file','9aa0dc9e-9163-42b5-87ce-bff18b15bd6e','上传参考图：IMG_8383-web.jpg','玉冰','2026-09-14T11:11:31.084Z');
INSERT INTO activity_log VALUES(383,'art_submission_file','41a8946b-bf1f-47c5-aeca-7639f00736c5','上传参考图：IMG_8381-web.jpg','玉冰','2026-09-14T11:11:31.623Z');
INSERT INTO activity_log VALUES(384,'art_submission_file','7772efa8-2911-4bba-8d60-b409602024b8','上传参考图：IMG_8380-web.jpg','玉冰','2026-09-14T11:11:31.641Z');
INSERT INTO activity_log VALUES(385,'art_submission_file','f300e35c-fe9b-4595-8a2b-327af458865a','上传参考图：IMG_0537.jpg','罗新姗','2026-09-14T11:11:45.607Z');
INSERT INTO activity_log VALUES(386,'art_submission_file','e73b87f7-189a-4d0e-be08-98d27ce6cdeb','上传参考图：IMG_0538.jpg','罗新姗','2026-09-14T11:11:47.687Z');
INSERT INTO activity_log VALUES(387,'art_submission_file','5464f265-0db3-4dd1-a347-f97415964dcc','上传参考图：IMG_0539.jpg','罗新姗','2026-09-14T11:11:47.751Z');
INSERT INTO activity_log VALUES(388,'art_submission_detail','ep1-v3-s1-heroine-wardrobe','选择定稿图：f64448e5-6b00-4703-b8e6-ecfbd842497e','Lipa','2026-09-14T11:12:24.499Z');
INSERT INTO activity_log VALUES(389,'art_submission_file','f64448e5-6b00-4703-b8e6-ecfbd842497e','调整归属：ep1-v3-s1-heroine-wardrobe → ep1-v3-s1-overall-cast','Lipa','2026-09-14T11:12:24.491Z');
INSERT INTO activity_log VALUES(390,'art_submission_file','af521a4f-7b4a-49e3-85d2-d9705e6ab524','上传参考图：IMG_0540.jpg','罗新姗','2026-09-14T11:12:26.768Z');
INSERT INTO activity_log VALUES(391,'task','rollup-2026-09-14-ep2-script','任务更新：未开始','Lipa','2026-09-14T11:14:24.617Z');
INSERT INTO activity_log VALUES(392,'task','rollup-2026-09-14-ep2-script','任务更新：已通过','Lipa','2026-09-14T11:14:25.029Z');
INSERT INTO activity_log VALUES(393,'art_submission_file','1143aff1-669e-4f44-a370-39ed33bf4219','上传参考图：图片 - 2026-09-14T135620.198.jpg','王承恺','2026-09-14T11:17:19.752Z');
INSERT INTO activity_log VALUES(394,'art_submission_file','307470df-8e4a-4f5b-9322-8599cd20c912','删除错误参考图','王承恺','2026-09-14T11:17:40.416Z');
INSERT INTO activity_log VALUES(395,'art_submission_file','08531755-8a15-4fce-88a8-fcbe3eb50d48','上传参考图：截屏2026-08-24 20.55.48-web.jpg','王承恺','2026-09-14T11:17:58.258Z');
INSERT INTO activity_log VALUES(396,'art_submission_file','e3a86eb8-e152-4e0d-9c73-0198234ef8ce','上传参考图：图片 - 2026-09-14T191826.436.jpg','王承恺','2026-09-14T11:19:06.647Z');
INSERT INTO activity_log VALUES(397,'art_submission_file','2a318656-5eec-454f-baaa-fc2032dbc27c','上传参考图：图片 - 2026-09-14T191832.702.jpg','王承恺','2026-09-14T11:19:06.617Z');
INSERT INTO activity_log VALUES(398,'task','rollup-2026-09-14-ep1-art','任务更新：已通过','王承恺','2026-09-14T11:19:34.291Z');
INSERT INTO activity_log VALUES(399,'task','rollup-2026-09-14-ep1-art','任务更新：已通过','王承恺','2026-09-14T11:19:37.608Z');
INSERT INTO activity_log VALUES(400,'art_submission_file','de08aed6-bb3c-478b-8659-b034df4cdb92','上传参考图：图片 - 2026-09-14T191826.436.jpg','王承恺','2026-09-14T11:20:04.965Z');
INSERT INTO activity_log VALUES(401,'art_submission_file','2875c29f-9249-4c03-89f3-120b0e373cc9','上传参考图：图片 - 2026-09-14T191832.702.jpg','王承恺','2026-09-14T11:20:05.429Z');
INSERT INTO activity_log VALUES(402,'art_submission_file','f004c2f6-313f-4037-80ce-d1377b4a45b7','调整归属：ep1-v3-s1-heroine-wardrobe → ep1-v3-s1-overall-cast','Lipa','2026-09-14T11:30:04.042Z');
INSERT INTO activity_log VALUES(403,'art_submission_file','c038739f-9e4d-46c4-8e3e-49a55dea29f1','上传参考图：微信图片_20260914190637_2099_22.jpg','胖胖','2026-09-14T11:39:20.481Z');
INSERT INTO activity_log VALUES(404,'art_submission_file','cbe2b366-0b33-4768-9b11-3f50a2f081ce','上传参考图：微信图片_20260914190637_2100_22.jpg','胖胖','2026-09-14T11:39:20.637Z');
INSERT INTO activity_log VALUES(405,'art_submission_file','098e9db9-2884-4235-ac90-b51665e3b3b4','上传参考图：微信图片_20260914190637_2101_22.jpg','胖胖','2026-09-14T11:39:20.630Z');
INSERT INTO activity_log VALUES(406,'art_submission_file','273780bf-d493-4582-9684-a759a7131cb3','上传参考图：微信图片_20260914190637_2103_22.jpg','胖胖','2026-09-14T11:39:22.542Z');
INSERT INTO activity_log VALUES(407,'art_submission_file','6d626447-7a55-4cfb-899c-ec09197de867','上传参考图：微信图片_20260914190637_2102_22.jpg','胖胖','2026-09-14T11:39:22.558Z');
INSERT INTO activity_log VALUES(408,'art_submission_file','0312fe35-ceaa-4852-afbd-276d03346be6','上传参考图：微信图片_20260914190637_2104_22.jpg','胖胖','2026-09-14T11:39:23.434Z');
INSERT INTO activity_log VALUES(409,'art_submission_file','feb3a002-3d15-4956-a71e-3010ca9d4760','上传参考图：微信图片_20260914191133_2106_22.jpg','胖胖','2026-09-14T11:39:24.898Z');
INSERT INTO activity_log VALUES(410,'art_submission_file','a6096580-7b73-471b-a095-12a26c1b4a84','上传参考图：微信图片_20260914191133_2105_22.jpg','胖胖','2026-09-14T11:39:24.799Z');
INSERT INTO activity_log VALUES(411,'art_submission_file','8f170acb-e25e-41b8-bd3f-abc0846db3b3','上传参考图：微信图片_20260914191133_2107_22.jpg','胖胖','2026-09-14T11:39:25.473Z');
INSERT INTO activity_log VALUES(412,'art_submission_file','043856f9-e750-476d-b614-6cb21f74ef0c','上传参考图：微信图片_20260914191133_2108_22.jpg','胖胖','2026-09-14T11:39:27.200Z');
INSERT INTO activity_log VALUES(413,'art_submission_file','5d9edbe2-efa0-44d3-90c8-c8ea8fee0c6a','上传参考图：微信图片_20260914191133_2109_22.jpg','胖胖','2026-09-14T11:39:28.137Z');
INSERT INTO activity_log VALUES(414,'art_submission_file','d2a122c2-15e7-41c5-8fcb-e4076bfff0d8','上传参考图：微信图片_20260914191133_2110_22.jpg','胖胖','2026-09-14T11:39:28.495Z');
INSERT INTO activity_log VALUES(415,'art_submission_file','8a28f271-6304-4b30-9fbc-01de57404abe','上传参考图：微信图片_20260914191133_2111_22.jpg','胖胖','2026-09-14T11:39:30.316Z');
INSERT INTO activity_log VALUES(416,'art_submission_file','6f619f8c-ebb2-4bd1-9fee-fe65eca5269b','上传参考图：微信图片_20260914191133_2113_22.jpg','胖胖','2026-09-14T11:39:31.205Z');
INSERT INTO activity_log VALUES(417,'art_submission_file','976bb7a1-af99-496b-b814-46dc872db981','上传参考图：微信图片_20260914191133_2112_22.jpg','胖胖','2026-09-14T11:39:31.043Z');
INSERT INTO activity_log VALUES(418,'art_submission_file','9785e60a-96ff-4df2-bd33-698ebd932007','上传参考图：微信图片_20260914191133_2114_22.jpg','胖胖','2026-09-14T11:39:33.394Z');
INSERT INTO activity_log VALUES(419,'art_submission_file','efc8067a-c730-4310-849e-f414216a8ded','上传参考图：微信图片_20260914191133_2116_22.jpg','胖胖','2026-09-14T11:39:33.972Z');
INSERT INTO activity_log VALUES(420,'art_submission_file','5923776c-5ab2-47ba-9728-557563a4e934','上传参考图：微信图片_20260914191133_2115_22.jpg','胖胖','2026-09-14T11:39:33.971Z');
INSERT INTO activity_log VALUES(421,'art_submission_file','704a998c-5114-41e2-98f5-339d9edc812f','上传参考图：微信图片_20260914191133_2117_22.jpg','胖胖','2026-09-14T11:39:36.395Z');
INSERT INTO activity_log VALUES(422,'episode_assets','第1集','恢复第一场家暴闪回独立场景上传项并接回原参考图','Lipa','2026-09-14 11:50:31');
INSERT INTO activity_log VALUES(423,'episode_assets','第1集','补齐第一场家暴闪回的顾丽乔穿搭和家暴男穿搭上传项','Lipa','2026-09-14 12:06:18');
CREATE TABLE `app_settings` (
	`key` text PRIMARY KEY NOT NULL,
	`value` text NOT NULL,
	`updated_at` text NOT NULL
);
INSERT INTO app_settings VALUES('workflow_items_v3','done','2026-09-10T11:26:22.343Z');
INSERT INTO app_settings VALUES('progress_reset_0910_v1','done','2026-09-10T11:26:22.432Z');
INSERT INTO app_settings VALUES('workflow_script_flow_v1','done','2026-09-10T11:26:22.474Z');
INSERT INTO app_settings VALUES('workflow_white_review_v1','done','2026-09-10T11:26:22.513Z');
INSERT INTO app_settings VALUES('workflow_yoyo_async_v1','done','2026-09-10T11:26:22.560Z');
INSERT INTO app_settings VALUES('workflow_plain_review_label_v1','done','2026-09-10T11:26:22.611Z');
INSERT INTO app_settings VALUES('workflow_visual_review_only_v1','done','2026-09-10T11:26:22.658Z');
INSERT INTO app_settings VALUES('workflow_episode_rollup_v1','done','2026-09-10T11:26:22.699Z');
INSERT INTO app_settings VALUES('workflow_calendar_six_on_one_off_v1','done','2026-09-10T11:26:22.767Z');
INSERT INTO app_settings VALUES('workflow_plan_v3','done','2026-09-10T11:45:07.959Z');
INSERT INTO app_settings VALUES('episode_one_v3_eight_scenes_v1','done','2026-09-10T11:45:07.965Z');
INSERT INTO app_settings VALUES('workflow_plan_calendar_v1','done','2026-09-10T11:45:08.500Z');
INSERT INTO app_settings VALUES('script_breakdown_ep1_v3_v1','done','2026-09-10T11:45:16.540Z');
INSERT INTO app_settings VALUES('workflow_dedupe_ep1_art_v1','done','2026-09-12T04:00:00.000Z');
INSERT INTO app_settings VALUES('workflow_locked_0912_0914_v2','done','2026-09-12T12:00:00.000Z');
INSERT INTO app_settings VALUES('workflow_locked_plan_0912_0914_v1','done','2026-09-12T12:00:00.000Z');
INSERT INTO app_settings VALUES('workflow_kickoff_0914_v1','done','2026-09-12T12:12:47.631Z');
INSERT INTO app_settings VALUES('workflow_kickoff_plan_0914_v1','done','2026-09-12T12:12:47.631Z');
CREATE TABLE `plan_batches` (
	`id` text PRIMARY KEY NOT NULL,
	`start_date` text NOT NULL,
	`end_date` text NOT NULL,
	`production` text NOT NULL,
	`prep` text NOT NULL,
	`note` text DEFAULT '' NOT NULL,
	`sort_order` integer DEFAULT 0 NOT NULL,
	`updated_at` text NOT NULL
);
INSERT INTO plan_batches VALUES('kickoff-0914','2026-09-14','2026-09-14','Day 1：第一集全部资产上传完成','编剧交完整剧本至第二集','9月14日固定安排，已完成记录保留。',1,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches VALUES('batch-1','2026-09-16','2026-09-19','第1集 生成＋初剪＋成片','第2—3集 筹备','9月15日先过剧本，再开始第二集资产；其余按工作日顺延，保留六休一及国庆安排。',2,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches VALUES('batch-2','2026-09-21','2026-09-26','第2—3集 生成＋初剪＋成片','第4—5集 筹备','9月15日先过剧本，再开始第二集资产；其余按工作日顺延，保留六休一及国庆安排。',3,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches VALUES('rest-0920','2026-09-20','2026-09-20','全组休息','不排硬交付','从9月14日开工起按六休一计算。',4,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches VALUES('batch-3','2026-09-28','2026-10-10','第4—5集 生成＋初剪＋成片','第6—7集 筹备','9月15日先过剧本，再开始第二集资产；其余按工作日顺延，保留六休一及国庆安排。',5,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches VALUES('rest-0927','2026-09-27','2026-09-27','全组休息','不排硬交付','六休一',6,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches VALUES('holiday-national-day','2026-10-01','2026-10-07','国庆放假','全组不排工作','按2026年国庆节法定安排休息7天',9,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches VALUES('batch-4','2026-10-12','2026-10-17','第6—7集 生成＋初剪＋成片','第8—9集 筹备','9月15日先过剧本，再开始第二集资产；其余按工作日顺延，保留六休一及国庆安排。',10,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches VALUES('rest-1011','2026-10-11','2026-10-11','全组休息','不排硬交付','六休一',11,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches VALUES('batch-5','2026-10-19','2026-10-22','第8—9集 生成＋初剪＋成片','第10集 筹备','9月15日先过剧本，再开始第二集资产；其余按工作日顺延，保留六休一及国庆安排。',12,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches VALUES('rest-1018','2026-10-18','2026-10-18','全组休息','不排硬交付','六休一',13,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches VALUES('batch-6','2026-10-23','2026-10-26','第10集生成＋初剪＋成片','全片精剪与统一','9月15日先过剧本，再开始第二集资产；其余按工作日顺延，保留六休一及国庆安排。',14,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches VALUES('delivery','2026-10-26','2026-10-26','全片最终交付','机动修正','9月15日先过剧本，再开始第二集资产；其余按工作日顺延，保留六休一及国庆安排。',99,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches VALUES('review-day-0915','2026-09-15','2026-09-15','Lipa与叶总／Yoyo过第1、2集剧本','通过后全组开始上传第2集资产','先过稿，后定稿与第二集资产上传。',1.5,'2026-09-09T09:00:00.000Z');
CREATE TABLE `production_items` (
	`id` text PRIMARY KEY NOT NULL,
	`work_date` text NOT NULL,
	`episode` text NOT NULL,
	`category` text NOT NULL,
	`title` text NOT NULL,
	`owner` text NOT NULL,
	`reviewer` text DEFAULT 'Yoyo' NOT NULL,
	`status` text DEFAULT '未开始' NOT NULL,
	`planned_qty` integer DEFAULT 1 NOT NULL,
	`completed_qty` integer DEFAULT 0 NOT NULL,
	`due_time` text DEFAULT '18:00' NOT NULL,
	`note` text DEFAULT '' NOT NULL,
	`sort_order` integer DEFAULT 0 NOT NULL,
	`updated_at` text NOT NULL
, `depends_on_id` text DEFAULT '' NOT NULL, `handoff_to` text DEFAULT '' NOT NULL, `handoff_deadline` text DEFAULT '' NOT NULL);
INSERT INTO production_items VALUES('rollup-2026-09-14-ep1-script','2026-09-14','第1集','剧本','交付第1集完整剧本','编剧','叶总／Yoyo','已通过',1,1,'12:00',unistr('整集一次交付，不再按7个场次分别确认，也不参与美术资产审核。\u000a9月14日更新：保留已交第一集剧本；今天编剧交稿至第二集，明天统一过稿。'),1,'2026-09-14T07:12:21.210Z','','执行制片人：Lipa','交付后继续下一集');
INSERT INTO production_items VALUES('rollup-2026-09-14-ep2-script','2026-09-14','第2集','剧本','上传第2集完整剧本（交稿至第二集）','编剧','叶总／Yoyo','已通过',1,1,'13:00',unistr('上传完整稿，由Lipa选择定稿后生成本集生产与美术清单。\u000a9月14日更新：今天交第二集完整稿，明天Lipa与叶总／Yoyo过剧本后定稿。'),2,'2026-09-14T11:14:25.029Z','','执行制片人：Lipa','9月15日过稿');
INSERT INTO production_items VALUES('rollup-2026-09-14-ep1-art','2026-09-14','第1集','美术清单','生成并上传第1集全部主美资产','主美','叶总／Yoyo','已通过',31,28,'18:00','点开生产手册查看7场、共40项人物造型/服装/道具/场景图清单；不逐项做审核勾选。',2,'2026-09-14 12:06:18','rollup-2026-09-14-ep1-script','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('rollup-2026-09-14-ep2-art','2026-09-15','第2集','美术清单','剧本审核通过后，开始上传第2集美术资产','主美','叶总／Yoyo','未开始',0,0,'过稿后开始',unistr('人物造型、服装、道具、场景全部生成并上传；按最终剧本清单逐项完成。\u000a9月14日更新：先由Lipa与叶总／Yoyo过稿，确认定稿后全组开始第二集资产，不要求过稿前出图。'),4,'2026-09-14 10:55:46','review-scripts-2026-09-15','执行制片人：Lipa','随上传进度预览');
INSERT INTO production_items VALUES('rollup-2026-09-14-ep1-wardrobe','2026-09-14','第1集','场景服装清单','上传第1集全部场景与每个角色服装图','服化道副导演','叶总／Yoyo','已通过',40,1,'18:00','与主美并行，负责场景和每个角色的服装；图片自动记录实际上传人。',3,'2026-09-14T07:12:21.210Z','rollup-2026-09-14-ep1-script','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('rollup-2026-09-14-ep2-wardrobe','2026-09-15','第2集','场景服装清单','剧本审核通过后，开始上传第2集场景和服装','服化道副导演','叶总／Yoyo','未开始',1,0,'过稿后开始',unistr('与主美并行；负责场景和每个角色的服装，图片自动记录实际上传人。\u000a9月14日更新：先由Lipa与叶总／Yoyo过稿，确认定稿后全组开始第二集资产，不要求过稿前出图。'),6,'2026-09-12T12:12:47.631Z','review-scripts-2026-09-15','执行制片人：Lipa','随上传进度预览');
INSERT INTO production_items VALUES('rollup-2026-09-14-ep1-send','2026-09-14','第1集','资产提报','整理第1集完整资产包并上传给Yoyo','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'18:30','确认主美与服化道副导演已上传完整；整集提报，不逐项拆开确认。',4,'2026-09-14T07:12:21.210Z','rollup-2026-09-14-ep1-wardrobe','叶总／Yoyo','发出后等待微信确认');
INSERT INTO production_items VALUES('rollup-2026-09-14-ep2-send','2026-09-16','第2集','资产提报','整理第2集全部图片并上传给Yoyo','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'资产齐套后',unistr('确认主美与服化道副导演已传齐，再生成美术提报H5／PDF并上传Yoyo。\u000a9月14日更新：第二集资产齐套后由Lipa提报，再统一记录叶总／Yoyo审核意见。'),8,'2026-09-12T12:12:47.631Z','rollup-2026-09-14-ep2-wardrobe','叶总／Yoyo','发出后等待回复');
INSERT INTO production_items VALUES('rollup-2026-09-14-ep1-review','2026-09-15','第1集','整集资产确认','记录叶总／Yoyo是否已确认第1集全部资产','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复',unistr('审核统一记录为叶总／Yoyo一项；本平台由Lipa录入最终结果。\u000a9月14日更新：第一集资产今天上传齐，明天统一记录审核意见。'),5,'2026-09-14T07:12:21.210Z','rollup-2026-09-14-ep1-send','执行制片人：Lipa','收到微信后录入');
INSERT INTO production_items VALUES('rollup-2026-09-14-ep2-review','2026-09-16','第2集','整集资产确认','记录叶总／Yoyo对第2集全部资产的审核结果','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'资产齐套后',unistr('审核统一记录为“叶总／Yoyo”，不再拆成两项。\u000a9月14日更新：第二集资产齐套后由Lipa提报，再统一记录叶总／Yoyo审核意见。'),10,'2026-09-12T12:12:47.631Z','rollup-2026-09-14-ep2-send','执行制片人：Lipa','收到微信后录入');
INSERT INTO production_items VALUES('2026-09-12-gen','2026-09-16','第1集','正式镜头','生成第1集正式镜头 · 第1天','AIGC抽卡师','叶总／Yoyo','未开始',1,0,'19:00','只统计审核可用镜头',100,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_items VALUES('2026-09-12-script','2026-09-16','第2—3集','剧本','编写第2—3集 · 第1天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',102,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-09-12-prep','2026-09-16','第2—3集','场景图','提报第2—3集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',103,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-09-12-review','2026-09-16','第1集 / 第2—3集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',105,'2026-09-12T12:12:47.631Z','2026-09-12-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-09-12-lipa','2026-09-16','第1集 / 第2—3集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',106,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-09-13-gen','2026-09-17','第1集','正式镜头','生成第1集正式镜头 · 第2天','AIGC抽卡师','叶总／Yoyo','未开始',1,0,'19:00','本集全部素材齐套，当晚同步剪辑',104,'2026-09-12T12:12:47.631Z','','剪辑','20:00');
INSERT INTO production_items VALUES('2026-09-13-script','2026-09-17','第2—3集','剧本','编写第2—3集 · 第2天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',106,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-09-13-prep','2026-09-17','第2—3集','场景图','提报第2—3集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',107,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-09-13-review','2026-09-17','第1集 / 第2—3集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',109,'2026-09-12T12:12:47.631Z','2026-09-13-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-09-13-lipa','2026-09-17','第1集 / 第2—3集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',110,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-09-14-rough','2026-09-18','第1集','初剪','接收第1集全部素材并完成初剪','剪辑','叶总／Yoyo','未开始',1,0,'21:00','素材齐套后预留1天完成初剪',108,'2026-09-12T12:12:47.631Z','2026-09-13-gen','执行制片人：Lipa','21:15');
INSERT INTO production_items VALUES('2026-09-14-script','2026-09-18','第2—3集','剧本','编写第2—3集 · 第3天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',110,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-09-14-prep','2026-09-18','第2—3集','场景图','提报第2—3集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',111,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-09-14-review','2026-09-18','第1集 / 第2—3集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',113,'2026-09-12T12:12:47.631Z','2026-09-14-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-09-14-lipa','2026-09-18','第1集 / 第2—3集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',114,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-09-15-final','2026-09-19','第1集','成片','完成第1集修改版与成片','剪辑','叶总／Yoyo','未开始',1,0,'21:00','初剪反馈后预留1天修改与交片',112,'2026-09-12T12:12:47.631Z','2026-09-14-rough','执行制片人：Lipa','21:15');
INSERT INTO production_items VALUES('2026-09-15-script','2026-09-19','第2—3集','剧本','锁定第2—3集全部剧本','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',114,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-09-15-prep','2026-09-19','第2—3集','场景图','提报第2—3集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',115,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-09-15-review','2026-09-19','第1集 / 第2—3集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',117,'2026-09-12T12:12:47.631Z','2026-09-15-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-09-15-lipa','2026-09-19','第1集 / 第2—3集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',118,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-09-17-gen','2026-09-21','第2—3集','正式镜头','生成第2—3集正式镜头 · 第1天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','只统计审核可用镜头',130,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_items VALUES('2026-09-17-script','2026-09-21','第4—5集','剧本','编写第4—5集 · 第1天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',132,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-09-17-prep','2026-09-21','第4—5集','场景图','提报第4—5集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',133,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-09-17-review','2026-09-21','第2—3集 / 第4—5集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',135,'2026-09-12T12:12:47.631Z','2026-09-17-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-09-17-lipa','2026-09-21','第2—3集 / 第4—5集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',136,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-09-18-gen','2026-09-22','第2—3集','正式镜头','生成第2—3集正式镜头 · 第2天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','只统计审核可用镜头',134,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_items VALUES('2026-09-18-script','2026-09-22','第4—5集','剧本','编写第4—5集 · 第2天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',136,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-09-18-prep','2026-09-22','第4—5集','场景图','提报第4—5集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',137,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-09-18-review','2026-09-22','第2—3集 / 第4—5集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',139,'2026-09-12T12:12:47.631Z','2026-09-18-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-09-18-lipa','2026-09-22','第2—3集 / 第4—5集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',140,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-09-19-gen','2026-09-23','第2—3集','正式镜头','生成第2—3集正式镜头 · 第3天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','只统计审核可用镜头',138,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_items VALUES('2026-09-19-script','2026-09-23','第4—5集','剧本','编写第4—5集 · 第3天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',140,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-09-19-prep','2026-09-23','第4—5集','场景图','提报第4—5集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',141,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-09-19-review','2026-09-23','第2—3集 / 第4—5集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',143,'2026-09-12T12:12:47.631Z','2026-09-19-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-09-19-lipa','2026-09-23','第2—3集 / 第4—5集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',144,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-09-20-gen','2026-09-24','第2—3集','正式镜头','生成第2—3集正式镜头 · 第4天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','本集全部素材齐套，当晚同步剪辑',142,'2026-09-12T12:12:47.631Z','','剪辑','20:00');
INSERT INTO production_items VALUES('2026-09-20-script','2026-09-24','第4—5集','剧本','编写第4—5集 · 第4天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',144,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-09-20-prep','2026-09-24','第4—5集','场景图','提报第4—5集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',145,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-09-20-review','2026-09-24','第2—3集 / 第4—5集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',147,'2026-09-12T12:12:47.631Z','2026-09-20-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-09-20-lipa','2026-09-24','第2—3集 / 第4—5集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',148,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-09-21-rough','2026-09-25','第2—3集','初剪','接收第2—3集全部素材并完成初剪','剪辑','叶总／Yoyo','未开始',1,0,'21:00','素材齐套后预留1天完成初剪',146,'2026-09-12T12:12:47.631Z','2026-09-20-gen','执行制片人：Lipa','21:15');
INSERT INTO production_items VALUES('2026-09-21-script','2026-09-25','第4—5集','剧本','编写第4—5集 · 第5天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',148,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-09-21-prep','2026-09-25','第4—5集','场景图','提报第4—5集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',149,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-09-21-review','2026-09-25','第2—3集 / 第4—5集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',151,'2026-09-12T12:12:47.631Z','2026-09-21-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-09-21-lipa','2026-09-25','第2—3集 / 第4—5集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',152,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-09-22-final','2026-09-26','第2—3集','成片','完成第2—3集修改版与成片','剪辑','叶总／Yoyo','未开始',1,0,'21:00','初剪反馈后预留1天修改与交片',150,'2026-09-12T12:12:47.631Z','2026-09-21-rough','执行制片人：Lipa','21:15');
INSERT INTO production_items VALUES('2026-09-22-script','2026-09-26','第4—5集','剧本','锁定第4—5集全部剧本','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',152,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-09-22-prep','2026-09-26','第4—5集','场景图','提报第4—5集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',153,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-09-22-review','2026-09-26','第2—3集 / 第4—5集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',155,'2026-09-12T12:12:47.631Z','2026-09-22-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-09-22-lipa','2026-09-26','第2—3集 / 第4—5集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',156,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-09-24-gen','2026-09-28','第4—5集','正式镜头','生成第4—5集正式镜头 · 第1天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','只统计审核可用镜头',160,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_items VALUES('2026-09-24-script','2026-09-28','第6—7集','剧本','编写第6—7集 · 第1天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',162,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-09-24-prep','2026-09-28','第6—7集','场景图','提报第6—7集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',163,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-09-24-review','2026-09-28','第4—5集 / 第6—7集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',165,'2026-09-12T12:12:47.631Z','2026-09-24-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-09-24-lipa','2026-09-28','第4—5集 / 第6—7集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',166,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-09-25-gen','2026-09-29','第4—5集','正式镜头','生成第4—5集正式镜头 · 第2天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','只统计审核可用镜头',164,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_items VALUES('2026-09-25-script','2026-09-29','第6—7集','剧本','编写第6—7集 · 第2天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',166,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-09-25-prep','2026-09-29','第6—7集','场景图','提报第6—7集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',167,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-09-25-review','2026-09-29','第4—5集 / 第6—7集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',169,'2026-09-12T12:12:47.631Z','2026-09-25-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-09-25-lipa','2026-09-29','第4—5集 / 第6—7集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',170,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-09-26-gen','2026-09-30','第4—5集','正式镜头','生成第4—5集正式镜头 · 第3天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','只统计审核可用镜头',168,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_items VALUES('2026-09-26-script','2026-09-30','第6—7集','剧本','编写第6—7集 · 第3天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',170,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-09-26-prep','2026-09-30','第6—7集','场景图','提报第6—7集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',171,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-09-26-review','2026-09-30','第4—5集 / 第6—7集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',173,'2026-09-12T12:12:47.631Z','2026-09-26-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-09-26-lipa','2026-09-30','第4—5集 / 第6—7集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',174,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-09-27-gen','2026-10-08','第4—5集','正式镜头','生成第4—5集正式镜头 · 第4天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','本集全部素材齐套，当晚同步剪辑',172,'2026-09-12T12:12:47.631Z','','剪辑','20:00');
INSERT INTO production_items VALUES('2026-09-27-script','2026-10-08','第6—7集','剧本','编写第6—7集 · 第4天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',174,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-09-27-prep','2026-10-08','第6—7集','场景图','提报第6—7集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',175,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-09-27-review','2026-10-08','第4—5集 / 第6—7集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',177,'2026-09-12T12:12:47.631Z','2026-09-27-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-09-27-lipa','2026-10-08','第4—5集 / 第6—7集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',178,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-09-28-rough','2026-10-09','第4—5集','初剪','接收第4—5集全部素材并完成初剪','剪辑','叶总／Yoyo','未开始',1,0,'21:00','素材齐套后预留1天完成初剪',176,'2026-09-12T12:12:47.631Z','2026-09-27-gen','执行制片人：Lipa','21:15');
INSERT INTO production_items VALUES('2026-09-28-script','2026-10-09','第6—7集','剧本','编写第6—7集 · 第5天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',178,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-09-28-prep','2026-10-09','第6—7集','场景图','提报第6—7集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',179,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-09-28-review','2026-10-09','第4—5集 / 第6—7集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',181,'2026-09-12T12:12:47.631Z','2026-09-28-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-09-28-lipa','2026-10-09','第4—5集 / 第6—7集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',182,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-09-29-final','2026-10-10','第4—5集','成片','完成第4—5集修改版与成片','剪辑','叶总／Yoyo','未开始',1,0,'21:00','初剪反馈后预留1天修改与交片',180,'2026-09-12T12:12:47.631Z','2026-09-28-rough','执行制片人：Lipa','21:15');
INSERT INTO production_items VALUES('2026-09-29-script','2026-10-10','第6—7集','剧本','锁定第6—7集全部剧本','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',182,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-09-29-prep','2026-10-10','第6—7集','场景图','提报第6—7集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',183,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-09-29-review','2026-10-10','第4—5集 / 第6—7集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',185,'2026-09-12T12:12:47.631Z','2026-09-29-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-09-29-lipa','2026-10-10','第4—5集 / 第6—7集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',186,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-10-08-gen','2026-10-12','第6—7集','正式镜头','生成第6—7集正式镜头 · 第1天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','只统计审核可用镜头',190,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_items VALUES('2026-10-08-script','2026-10-12','第8—9集','剧本','编写第8—9集 · 第1天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',192,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-10-08-prep','2026-10-12','第8—9集','场景图','提报第8—9集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',193,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-10-08-review','2026-10-12','第6—7集 / 第8—9集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',195,'2026-09-12T12:12:47.631Z','2026-10-08-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-10-08-lipa','2026-10-12','第6—7集 / 第8—9集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',196,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-10-09-gen','2026-10-13','第6—7集','正式镜头','生成第6—7集正式镜头 · 第2天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','只统计审核可用镜头',194,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_items VALUES('2026-10-09-script','2026-10-13','第8—9集','剧本','编写第8—9集 · 第2天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',196,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-10-09-prep','2026-10-13','第8—9集','场景图','提报第8—9集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',197,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-10-09-review','2026-10-13','第6—7集 / 第8—9集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',199,'2026-09-12T12:12:47.631Z','2026-10-09-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-10-09-lipa','2026-10-13','第6—7集 / 第8—9集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',200,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-10-10-gen','2026-10-14','第6—7集','正式镜头','生成第6—7集正式镜头 · 第3天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','只统计审核可用镜头',198,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_items VALUES('2026-10-10-script','2026-10-14','第8—9集','剧本','编写第8—9集 · 第3天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',200,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-10-10-prep','2026-10-14','第8—9集','场景图','提报第8—9集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',201,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-10-10-review','2026-10-14','第6—7集 / 第8—9集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',203,'2026-09-12T12:12:47.631Z','2026-10-10-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-10-10-lipa','2026-10-14','第6—7集 / 第8—9集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',204,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-10-11-gen','2026-10-15','第6—7集','正式镜头','生成第6—7集正式镜头 · 第4天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','本集全部素材齐套，当晚同步剪辑',202,'2026-09-12T12:12:47.631Z','','剪辑','20:00');
INSERT INTO production_items VALUES('2026-10-11-script','2026-10-15','第8—9集','剧本','编写第8—9集 · 第4天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',204,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-10-11-prep','2026-10-15','第8—9集','场景图','提报第8—9集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',205,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-10-11-review','2026-10-15','第6—7集 / 第8—9集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',207,'2026-09-12T12:12:47.631Z','2026-10-11-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-10-11-lipa','2026-10-15','第6—7集 / 第8—9集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',208,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-10-12-rough','2026-10-16','第6—7集','初剪','接收第6—7集全部素材并完成初剪','剪辑','叶总／Yoyo','未开始',1,0,'21:00','素材齐套后预留1天完成初剪',206,'2026-09-12T12:12:47.631Z','2026-10-11-gen','执行制片人：Lipa','21:15');
INSERT INTO production_items VALUES('2026-10-12-script','2026-10-16','第8—9集','剧本','编写第8—9集 · 第5天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',208,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-10-12-prep','2026-10-16','第8—9集','场景图','提报第8—9集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',209,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-10-12-review','2026-10-16','第6—7集 / 第8—9集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',211,'2026-09-12T12:12:47.631Z','2026-10-12-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-10-12-lipa','2026-10-16','第6—7集 / 第8—9集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',212,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-10-13-final','2026-10-17','第6—7集','成片','完成第6—7集修改版与成片','剪辑','叶总／Yoyo','未开始',1,0,'21:00','初剪反馈后预留1天修改与交片',210,'2026-09-12T12:12:47.631Z','2026-10-12-rough','执行制片人：Lipa','21:15');
INSERT INTO production_items VALUES('2026-10-13-script','2026-10-17','第8—9集','剧本','锁定第8—9集全部剧本','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',212,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-10-13-prep','2026-10-17','第8—9集','场景图','提报第8—9集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',213,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-10-13-review','2026-10-17','第6—7集 / 第8—9集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',215,'2026-09-12T12:12:47.631Z','2026-10-13-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-10-13-lipa','2026-10-17','第6—7集 / 第8—9集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',216,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-10-15-gen','2026-10-19','第8—9集','正式镜头','生成第8—9集正式镜头 · 第1天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','只统计审核可用镜头',220,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_items VALUES('2026-10-15-script','2026-10-19','第10集','剧本','编写第10集 · 第1天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',222,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-10-15-prep','2026-10-19','第10集','场景图','提报第10集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',223,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-10-15-review','2026-10-19','第8—9集 / 第10集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',225,'2026-09-12T12:12:47.631Z','2026-10-15-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-10-15-lipa','2026-10-19','第8—9集 / 第10集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',226,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-10-16-gen','2026-10-20','第8—9集','正式镜头','生成第8—9集正式镜头 · 第2天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','本集全部素材齐套，当晚同步剪辑',224,'2026-09-12T12:12:47.631Z','','剪辑','20:00');
INSERT INTO production_items VALUES('2026-10-16-script','2026-10-20','第10集','剧本','编写第10集 · 第2天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',226,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-10-16-prep','2026-10-20','第10集','场景图','提报第10集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',227,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-10-16-review','2026-10-20','第8—9集 / 第10集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',229,'2026-09-12T12:12:47.631Z','2026-10-16-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-10-16-lipa','2026-10-20','第8—9集 / 第10集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',230,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-10-17-rough','2026-10-21','第8—9集','初剪','接收第8—9集全部素材并完成初剪','剪辑','叶总／Yoyo','未开始',1,0,'21:00','素材齐套后预留1天完成初剪',228,'2026-09-12T12:12:47.631Z','2026-10-16-gen','执行制片人：Lipa','21:15');
INSERT INTO production_items VALUES('2026-10-17-script','2026-10-21','第10集','剧本','编写第10集 · 第3天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',230,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-10-17-prep','2026-10-21','第10集','场景图','提报第10集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',231,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-10-17-review','2026-10-21','第8—9集 / 第10集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',233,'2026-09-12T12:12:47.631Z','2026-10-17-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-10-17-lipa','2026-10-21','第8—9集 / 第10集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',234,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-10-18-final','2026-10-22','第8—9集','成片','完成第8—9集修改版与成片','剪辑','叶总／Yoyo','未开始',1,0,'21:00','初剪反馈后预留1天修改与交片',232,'2026-09-12T12:12:47.631Z','2026-10-17-rough','执行制片人：Lipa','21:15');
INSERT INTO production_items VALUES('2026-10-18-script','2026-10-22','第10集','剧本','锁定第10集全部剧本','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',234,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_items VALUES('2026-10-18-prep','2026-10-22','第10集','场景图','提报第10集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',235,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_items VALUES('2026-10-18-review','2026-10-22','第8—9集 / 第10集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',237,'2026-09-12T12:12:47.631Z','2026-10-18-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-10-18-lipa','2026-10-22','第8—9集 / 第10集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',238,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-10-19-gen','2026-10-23','第10集','正式镜头','生成第10集正式镜头 · 第1天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','本集全部素材齐套，当晚同步剪辑',250,'2026-09-12T12:12:47.631Z','','剪辑','20:00');
INSERT INTO production_items VALUES('2026-10-19-finish','2026-10-23','全片','精剪','全片精剪、声音与视觉统一','剪辑','叶总／Yoyo','未开始',1,0,'22:00','成片前总检查',252,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','22:15');
INSERT INTO production_items VALUES('2026-10-19-review','2026-10-23','第10集 / 全片','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',255,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-10-19-lipa','2026-10-23','第10集 / 全片','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',256,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-10-20-rough','2026-10-24','第10集','初剪','接收第10集全部素材并完成初剪','剪辑','叶总／Yoyo','未开始',1,0,'21:00','素材齐套后预留1天完成初剪',254,'2026-09-12T12:12:47.631Z','2026-10-19-gen','执行制片人：Lipa','21:15');
INSERT INTO production_items VALUES('2026-10-20-finish','2026-10-24','全片','精剪','全片精剪、声音与视觉统一','剪辑','叶总／Yoyo','未开始',1,0,'22:00','成片前总检查',256,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','22:15');
INSERT INTO production_items VALUES('2026-10-20-review','2026-10-24','第10集 / 全片','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',259,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-10-20-lipa','2026-10-24','第10集 / 全片','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',260,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('2026-10-21-final','2026-10-26','第10集','成片','完成第10集修改版与成片','剪辑','叶总／Yoyo','未开始',1,0,'21:00','初剪反馈后预留1天修改与交片',258,'2026-09-12T12:12:47.631Z','2026-10-20-rough','执行制片人：Lipa','21:15');
INSERT INTO production_items VALUES('2026-10-21-finish','2026-10-26','全片','精剪','全片精剪、声音与视觉统一','剪辑','叶总／Yoyo','未开始',1,0,'22:00','成片前总检查',260,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','22:15');
INSERT INTO production_items VALUES('2026-10-21-review','2026-10-26','第10集 / 全片','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',263,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_items VALUES('2026-10-21-lipa','2026-10-26','第10集 / 全片','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',264,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_items VALUES('1021-delivery','2026-10-26','全片','成片','全片总审、修正与最终交付','执行制片人：Lipa','叶总／Yoyo','未开始',10,0,'20:00',unistr('9月14日正式开工，其余大计划从9月15日起顺延接续。\u000a9月14日更新：9月14日正式开工，9月15日先过剧本，原大计划从9月16日起顺延接续。'),999,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','20:00');
INSERT INTO production_items VALUES('review-scripts-2026-09-15','2026-09-15','第1—2集','剧本审核','与叶总／Yoyo过第1、2集剧本并确认定稿','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'上传第二集资产前','过稿通过后，在编剧页面选择定稿，再开始第二集资产上传。',0,'2026-09-09T09:00:00.000Z','rollup-2026-09-14-ep2-script','主美、服化道副导演','过稿后立即开始');
CREATE TABLE `scenes` (
	`id` text PRIMARY KEY NOT NULL,
	`episode` text NOT NULL,
	`scene_no` integer NOT NULL,
	`title` text NOT NULL,
	`location` text NOT NULL,
	`owner` text NOT NULL,
	`script_status` text DEFAULT '未开始' NOT NULL,
	`character_status` text DEFAULT '未开始' NOT NULL,
	`location_status` text DEFAULT '未开始' NOT NULL,
	`wardrobe_status` text DEFAULT '未开始' NOT NULL,
	`white_model_status` text DEFAULT '未开始' NOT NULL,
	`shot_status` text DEFAULT '未开始' NOT NULL,
	`rough_cut_status` text DEFAULT '未开始' NOT NULL,
	`final_status` text DEFAULT '未开始' NOT NULL,
	`updated_at` text NOT NULL
);
INSERT INTO scenes VALUES('ep1-s1','第1集',1,'戏中戏受虐与真实身份翻面','南庭影视城·玄幻剧片场／婚姻闪回空间','主美','进行中','未开始','未开始','未开始','未开始','未开始','未开始','未开始','2026-09-10T11:45:07.965Z');
INSERT INTO scenes VALUES('ep1-s2','第1集',2,'白鸽复苏与第一次代价','玄幻剧片场·廊柱后候场区','主美','进行中','未开始','未开始','未开始','未开始','未开始','未开始','未开始','2026-09-10T11:45:07.965Z');
INSERT INTO scenes VALUES('ep1-s3','第1集',3,'相触预见陆文川死亡','影视城棚间小巷','主美','进行中','未开始','未开始','未开始','未开始','未开始','未开始','未开始','2026-09-10T11:45:07.965Z');
INSERT INTO scenes VALUES('ep1-s4','第1集',4,'火警成真与逆行选择','东方庭院外围','主美','进行中','未开始','未开始','未开始','未开始','未开始','未开始','未开始','2026-09-10T11:45:07.965Z');
INSERT INTO scenes VALUES('ep1-s5','第1集',5,'六十秒救回陆文川','东方庭院·临水巷道','主美','进行中','未开始','未开始','未开始','未开始','未开始','未开始','未开始','2026-09-10T11:45:07.965Z');
INSERT INTO scenes VALUES('ep1-s6','第1集',6,'监控剪辑与幕后操盘','影视城监控室','主美','进行中','未开始','未开始','未开始','未开始','未开始','未开始','未开始','2026-09-10T11:45:07.965Z');
INSERT INTO scenes VALUES('ep1-s7','第1集',7,'陆文川醒来追查缺失一分钟','医院病房','主美','进行中','未开始','未开始','未开始','未开始','未开始','未开始','未开始','2026-09-10T11:45:07.965Z');
INSERT INTO scenes VALUES('ep1-s8','第1集',8,'面摊爆红、前夫与黑车双钩子','上塘城·姑妈面摊／街边黑色轿车','主美','进行中','未开始','未开始','未开始','未开始','未开始','未开始','未开始','2026-09-10T11:45:07.965Z');
CREATE TABLE `script_analyses` (
	`id` text PRIMARY KEY NOT NULL,
	`episode` text NOT NULL,
	`scene_no` integer NOT NULL,
	`scene_title` text NOT NULL,
	`script_text` text NOT NULL,
	`scene_summary` text DEFAULT '' NOT NULL,
	`location` text DEFAULT '' NOT NULL,
	`created_at` text NOT NULL,
	`updated_at` text NOT NULL
, script_version_id TEXT NOT NULL DEFAULT '', is_active INTEGER NOT NULL DEFAULT 1);
INSERT INTO script_analyses VALUES('ep1-v3-s1','第1集',1,'南庭影视城·复古教堂片场　日　内',unistr('1. 南庭影视城·复古教堂片场　日　内\u000a人物：顾丽乔、怪物演员、前夫（闪回）、导演、制片主任、群头、陆文川、助理、视察人员\u000a顾丽乔狼狈地被怪物按在破旧祭坛前，身上的白色长裙满是破损和血迹。她嘴角带血，长发遮住半张脸。\u000a怪物冲上前，一只手恶狠狠掐住她的脖子。\u000a【以下vo对话，建议只台词给，做旁白，不给对应的口型。做残忍打人的画面对切，加快节奏】\u000a前夫（VO）：拍这种照片，你是想勾引谁！\u000a顾丽乔看着怪物，眼前闪过几个极短的画面。\u000a前夫满身酒气，夺走她的手机；镜子撞裂；她的手臂挡在脸前，浑身是伤。\u000a顾丽乔（VO）：这是模特照，我是为了替你还赌债。\u000a前夫（VO）：替我？我的债就是你的债！\u000a前夫抡起酒瓶，就要朝她砸来。\u000a【叠化】\u000a现实中，怪物的手狠狠挥下。\u000a导演：卡！\u000a教堂顶灯亮起，怪物的手僵在半空。\u000a所有演员齐刷刷往镜头方向的导演看去，数十个片场工作人员穿着冬天的衣服，陆陆续续从阴影里走出来往导演方向聚过去（丧尸演员整理妆容 摘头套）。\u000a所有人围着导演看回放，导演盯着回放，很不满意。\u000a导演：不行，这最后一下感觉不够。辛苦一下替身，再来一条，真撞啊！真撞。（对执行导演）把人脸遮一点，别穿帮。\u000a有人给丧尸演员递上衣服（打女主的那个），丝毫没人关注冻得发抖的顾丽乔。\u000a群头走来，下令。\u000a群演头子：注意点，别把脸露出来。\u000a顾丽乔：通告里可说好的没有真撞。这要加两百风险钱。\u000a群演头子：就轻轻打一下，要得了两百？二十，这行就这样，能干干。不行，以后我这里的戏，你就别来了。\u000a顾丽乔的手微微攥紧，压抑着心中的愤怒，心跳也越来越快。\u000a群演头子：知道你缺钱，欠债，连房租都快付不起了。劝你，有一点，是一点。眼光也要放长远一点。\u000a群头的话听似是关切，实则是警告。\u000a顾丽乔听着更加愤怒，心跳声越来越快，越来越重。\u000a她正要说话，片场入口忽然热闹起来，导演迅速站起身从她面前经过，朝着门口走去。\u000a门口，陆文川带着助理、安全、法务和项目人员走进来。\u000a导演、制片主任已经迎了上去。\u000a导演：陆总，您怎么亲自来了？\u000a顾丽乔被人群挤到景片边，差点摔倒，顾问穿下意识拉了她一把。\u000a两人的手腕相触，四周的声音骤然消失。\u000a顾丽乔眼前出现幻觉。\u000a【预言画面】\u000a临水回廊被冲出来的水淹没；\u000a警铃大响；\u000a墙上的电子钟停在 12:17；\u000a一个人影迅速从控制开关的小路离开（仅背影或局部，不能太明显透露出是陈默）；\u000a陆文川淹死在水中，已经没了气息。\u000a【预言画面结束】\u000a顾丽乔从环境中苏醒，猛地吸了一口气。\u000a陆文川已经抽回手，正要离开。\u000a顾丽乔：不要去东方庭院。\u000a陆文川困惑地看着顾丽乔。\u000a陆文川：你什么意思。\u000a群头怕顾丽乔是要攀附，把顾丽乔拉回布景。\u000a群头：开拍了！赶紧的。别动那种歪心思。\u000a顾丽乔再抬头时，陆文川已随视察队走远。'),'顾丽乔狼狈地被怪物按在破旧祭坛前，身上的白色长裙满是破损和血迹。她嘴角带血，长发遮住半张脸。 怪物冲上前，一只手恶狠狠掐住她的脖子。 【以下vo对话，建议只台词给，做旁白，不给对应的口型。做残忍打人的画面对切，加快节奏】','南庭影视城·复古教堂片场　日　内','2026-09-10T11:45:16.540Z','2026-09-11T16:56:33.690Z','script-version-807c4b22-827a-4517-9598-3258096744fe',1);
INSERT INTO script_analyses VALUES('ep1-v3-s2','第1集',2,'东方庭院·临水巷道　日　内',unistr('2. 东方庭院·临水巷道　日　内\u000a人物：陆文川\u000a东方庭院内部，陆文川独自走在现场，正中的湖边还停着一艘乌篷船。\u000a陆文川走到乌篷船边，小心翼翼地乘船想仔细查看。\u000a他刚踏上乌篷船，就听远处传来“咔。”地一声，远处突然传来一声机械启动的声音。原本平静的水面突然开始剧烈涌动。\u000a下一秒，大量积水从旁边的楼体内部冲出。\u000a陆文川根本来不及反应，巨大的水流撞上乌篷船，船身猛地一歪。\u000a陆文川直接被掀进水里。'),'东方庭院内部，陆文川独自走在现场，正中的湖边还停着一艘乌篷船。 陆文川走到乌篷船边，小心翼翼地乘船想仔细查看。 他刚踏上乌篷船，就听远处传来“咔。”地一声，远处突然传来一声机械启动的声音。原本平静的水面突然开始剧烈涌动。','东方庭院·临水巷道　日　内','2026-09-10T11:45:16.540Z','2026-09-11T16:56:33.690Z','script-version-807c4b22-827a-4517-9598-3258096744fe',1);
INSERT INTO script_analyses VALUES('ep1-v3-s3','第1集',3,'东方庭院外围候场区　日　外',unistr('3. 东方庭院外围候场区　日　外\u000a人物：顾丽乔、群头、导演、群演\u000a顾丽乔坐在临河布景外等重拍，寒冬的夜冷得呼气都是白雾，她还沉浸在幻觉之中。\u000a顾丽乔：真是冻昏头了，那些怎么可能是真的。\u000a顾丽乔还是担忧地看着手机，已经到了12:15。\u000a群头：开拍了！都准备好！\u000a顾丽乔正要进棚，突然远处警铃骤响。\u000a月洞门“咔”地落栓。\u000a顾丽乔的表情严肃，带着惊恐。\u000a身后人群都涌了上来，导演也凑到前排。\u000a导演：哪儿出事了？东方庭院！快点，拍戏了。\u000a众人纷纷进入棚内，顾丽乔却有些犹疑，转身朝着东方庭院跑去。\u000a群头：诶！干嘛去！拍戏呢！'),'顾丽乔坐在临河布景外等重拍，寒冬的夜冷得呼气都是白雾，她还沉浸在幻觉之中。 顾丽乔还是担忧地看着手机，已经到了12:15。 顾丽乔正要进棚，突然远处警铃骤响。','东方庭院外围候场区　日　外','2026-09-10T11:45:16.540Z','2026-09-11T16:56:33.690Z','script-version-807c4b22-827a-4517-9598-3258096744fe',1);
INSERT INTO script_analyses VALUES('ep1-v3-s4','第1集',4,'东方庭院·临水巷道　日　内',unistr('4.东方庭院·临水巷道　日　内\u000a人物：陆文川、顾丽乔\u000a陆文川被掀进水里，他不会游泳，落水的一瞬间，下意识伸手想抓住船沿，却被水流狠狠冲开。\u000a他被水流带着撞向墙面，又撞上水中的房屋栏杆，挣扎着想浮出水面，却根本控制不住身体。\u000a他试图呼救，刚张嘴，水便灌了进去。\u000a缺氧，让他的视线开始模糊。\u000a他最后一次抬头，看见的是被水流冲得不断摇晃的乌篷船。\u000a陆文川的身体渐渐失去力气，彻底失去意识。\u000a此时，一道白色身影跳入了水中。\u000a正是穿着戏服的顾丽乔，她朝陆文川游过去，一把抓住他的衣服，拍了拍他的脸，可人已经彻底失去了意识。\u000a水流不断冲击着两人四处摇晃，几乎要将两人冲散，顾丽乔伸手抓住他，手意外抵在了他的心口。\u000a周围突然安静下来，巨大的水声消失，所有声音全部停止，原本疯狂冲出的水流，在这一刻仿佛被按下暂停键，变得极其缓慢。\u000a顾丽乔看见自己的手心亮起一道光。\u000a似有一阵气流，以她的手掌为中心，一圈一圈荡开涟漪，水如同被惊动般荡漾出去。\u000a顾丽乔诧异地看着自己的手，她不知道发生了什么。\u000a光继续向四周扩散，下一秒，所有光芒骤然收回，尽数进入陆文川的身体。\u000a陆文川猛地睁开眼睛，竟然活了过来，第一眼看到的，就是近在咫尺的顾丽乔。\u000a顾丽乔也愣住了，眼看陆文川又要窒息，顾丽乔回过神，立刻抓住他朝水面上乌篷船游去。\u000a两人终于抓住船沿，顾丽乔用尽力气，将陆文川托上乌篷船。\u000a两个人狼狈地趴在船里，大口喘气。\u000a顾丽乔躺在船上，已经力竭，她看了一眼自己的手心，没有异常的光亮。\u000a她也没注意到头发中，有一缕已经变成白发。\u000a镜头慢慢拉远，一处不起眼的监控摄像头正对着这里。'),'陆文川被掀进水里，他不会游泳，落水的一瞬间，下意识伸手想抓住船沿，却被水流狠狠冲开。 他被水流带着撞向墙面，又撞上水中的房屋栏杆，挣扎着想浮出水面，却根本控制不住身体。 他试图呼救，刚张嘴，水便灌了进去。','东方庭院·临水巷道　日　内','2026-09-10T11:45:16.540Z','2026-09-11T16:56:33.690Z','script-version-807c4b22-827a-4517-9598-3258096744fe',1);
INSERT INTO script_analyses VALUES('ep1-v3-s5','第1集',5,'影视城监控室　夜　内',unistr('4. 影视城监控室　夜　内\u000a人物：监控外包负责人、神秘人（电话声）\u000a屏幕上的正是：顾丽乔和陆文川躺在船上，力竭喘气的模样。\u000a监控外包负责人接起电话。\u000a神秘人（电话声）：线路、开关那几段，都剪掉。快点。\u000a监控外包负责人：那救人的呢？\u000a神秘人（电话声）：先留下。这是个机会。\u000a电话挂断。'),'监控外包负责人接起电话。 电话挂断。','影视城监控室　夜　内','2026-09-10T11:45:16.540Z','2026-09-11T16:56:33.690Z','script-version-807c4b22-827a-4517-9598-3258096744fe',1);
INSERT INTO script_analyses VALUES('ep1-v3-s6','第1集',6,'医院病房　深夜　内',unistr('5. 医院病房　深夜　内\u000a人物：陆文川、助理\u000a陆文川睁开眼。监护仪恢复稳定节奏。\u000a助理守在床边。\u000a陆文川：救我出来的那个人在哪里？\u000a助理把手机递给他。\u000a助理：当场就走了，她是一个替身演员。现场登记只有名字，叫顾丽乔。\u000a手机上，是顾丽乔跳入水中救人，和陆文川躺在船上的剪辑视频。评论和转发飞快上涨。\u000a【评论：这俩人也太配了吧！】\u000a【评论：这碗饭我先吃为敬】\u000a【评论：都醒醒，这场意外就是因为两人剧组私会，还好没出意外】\u000a陆文川：去把原始监控留下。\u000a助理：事情发生后已经都拷走了，但有几段没了。\u000a陆文川抬眼看着助理。\u000a陆文川：先找到她。丢的那些视频的事，接着查。'),'陆文川睁开眼。监护仪恢复稳定节奏。 助理守在床边。 助理把手机递给他。','医院病房　深夜　内','2026-09-10T11:45:16.540Z','2026-09-11T16:56:33.690Z','script-version-807c4b22-827a-4517-9598-3258096744fe',1);
INSERT INTO script_analyses VALUES('ep1-v3-s7','第1集',7,'群演酒店标间　深夜　内',unistr('6. 群演酒店标间　深夜　内\u000a人物：顾丽乔、沈糯\u000a狭小房间里，摆着许多衣服，空间非常狭窄。\u000a唯一一张较为宽阔的桌上，架着两盏补光灯和手机。\u000a沈糯敷着面膜，正在调灯，听到门开，着急地催促着。\u000a门开，顾丽乔已经换回了自己的衣服，疲惫地走了进来。\u000a沈糯：你终于回来了，马上到时间直播了。三百粉也是粉，可不能迟到。\u000a等顾丽乔走近，沈糯才看见顾丽乔手臂上的擦伤，立刻摘下面膜，很是心疼。\u000a沈糯：怎么又受伤了？又让你拍危险的戏份了？给钱了吗？\u000a顾丽乔：不是拍戏伤的。\u000a顾丽乔没再多说，她坐到灯前，简单整理就打开了直播，却看见镜子里自己多了一缕白发，她对此很困惑。\u000a沈糯的手机震动了一下，她打开手机一看，惊呼一声。\u000a沈糯：小乔，这是不是你？\u000a顾丽乔看见手机中的正是，救人的视频。\u000a同时，她看见直播界面上，许多人在刷嘉年华等礼物，评论不断翻滚着，一条接一条地弹出。\u000a评论飞快刷新、\u000a【评论：是这姐吧！这姐真敢冲。】\u000a【评论：那视频是不是摆拍啊？一个替身怎么会提前知道里面有人？】\u000a【评论：才三百粉？？？】\u000a【评论：老婆！老婆太帅了！】\u000a【评论：姐姐，你救人的样子，比剧里的女主角还像女主角！必须给我红！】\u000a顾丽乔看着屏幕上，观看人数已经高达十几万，不敢相信。\u000a沈糯把手机转向顾丽乔，微博界面上，已经‘替身女演员勇救光禾影业少爷’上了热搜一。\u000a沈糯：这，还播吗？\u000a顾丽乔：播。\u000a顾丽乔（对手机）：大家好，我是顾丽乔。今天下戏有点晚……\u000a她的声音很稳，桌下的手却在发抖。\u000a镜头外，直播的观看数字还在继续攀升。\u000a深夜的城市全貌，上空不断漂浮着话题：#顾丽乔是谁#；#光禾影业股价大涨#；#替身X少爷文学#；#顾丽乔替身演员#；#美救英雄#；#东方庭院意外#……\u000a深夜的城市，沸腾着。'),'狭小房间里，摆着许多衣服，空间非常狭窄。 唯一一张较为宽阔的桌上，架着两盏补光灯和手机。 沈糯敷着面膜，正在调灯，听到门开，着急地催促着。','群演酒店标间　深夜　内','2026-09-10T11:45:16.540Z','2026-09-11T16:56:33.690Z','script-version-807c4b22-827a-4517-9598-3258096744fe',1);
INSERT INTO script_analyses VALUES('ep1-v3-s8','第1集',8,'面摊爆红、前夫与黑车双钩子',unistr('第一集《六十秒》V3（2026-09-05）\u000a雨后街边面摊承接温情与后果；手机舆论、前夫留言和车内观察完成双钩子。'),'顾丽乔带着救人的身体代价回到姑妈面摊，账号突然爆红；前夫留言找到她，黑车里的神秘人同时观察她。','上塘城·姑妈面摊／街边黑色轿车｜深夜｜外','2026-09-10T11:45:16.540Z','2026-09-11T16:56:33.690Z','',0);
CREATE TABLE `script_analysis_items` (
	`id` text PRIMARY KEY NOT NULL,
	`analysis_id` text NOT NULL,
	`category` text NOT NULL,
	`name` text NOT NULL,
	`detail` text DEFAULT '' NOT NULL,
	`visual_brief` text DEFAULT '' NOT NULL,
	`yoyo_approved` integer DEFAULT false NOT NULL,
	`sort_order` integer DEFAULT 0 NOT NULL,
	`updated_at` text NOT NULL
, `producer_approved` integer DEFAULT false NOT NULL, is_active INTEGER NOT NULL DEFAULT 1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s7-i01','ep1-v3-s7','场景','医院单人病房','深夜，监护仪稳定，整体克制安静；能容纳床边助理递手机。','一个场景上传位：先放完整氛围图，再追加局部与不同角度，不按文字拆多个场景项。',0,0,'2026-09-14 08:27:00',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s7-i02','ep1-v3-s7','人物','陆文川｜人脸、妆造、梳发','刚从溺水复苏，虚弱但判断清晰；按住心口感受残留触感。','本场人脸、妆造、梳发集中在此，可上传多张备选。',0,2,'2026-09-14 08:27:00',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s7-i03','ep1-v3-s7','服装','陆文川病服','从落水服装切换为病服，保持深夜急救后的真实感。','出病服全身/半身方案；颜色与医院空间配套，待核准。',0,3,'2026-09-14 08:27:00',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s7-i04','ep1-v3-s7','人物','助理病房状态','向陆文川汇报顾丽乔身份、热视频和监控缺失。','沿用第3场助理，服装可保持视察造型或增加外套湿痕，连续性待核准。',0,4,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s7-i07','ep1-v3-s7','美术图','寻找顾丽乔的决定','陆文川看视频后命令“找到顾丽乔。还有那一分钟。”','出床上陆文川、手机视频和助理同框关键帧，重点是目光与决断。',0,7,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s8-i01','ep1-v3-s8','场景','上塘城姑妈面摊','雨后深夜，街边只剩一盏摊灯；锅、棚、桌凳形成温暖但清贫的生活入口。','一个场景上传位：先放完整氛围图，再追加局部与不同角度，不按文字拆多个场景项。',0,0,'2026-09-11T08:53:57.659Z',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s8-i02','ep1-v3-s8','场景','远处黑色轿车内部','车辆停在可观察面摊的位置，屏幕反光遮住车内人的脸。','一个场景上传位：先放完整氛围图，再追加局部与不同角度，不按文字拆多个场景项。',0,0,'2026-09-11T08:53:57.659Z',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s8-i03','ep1-v3-s8','人物','姑妈基础形象','经营夜间面摊，第一反应是扶住顾丽乔并检查发热与白发。','出正面、侧面、摊位工作状态人物图；年龄、围裙与日常衣着待核准。',0,3,'2026-09-11T08:53:57.659Z',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s8-i04','ep1-v3-s8','人物','顾丽乔｜人脸、妆造、梳发','浑身湿透、脸色惨白、发烧腿软；黑色短发里已有明显白发。','本场人脸、妆造、梳发集中在此，可上传多张备选。',0,4,'2026-09-11T08:53:57.659Z',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s8-i05','ep1-v3-s8','服装','姑妈面摊工作服','实用、防雨、带围裙或袖套，体现长期经营摊位。','出全身工作造型；色彩应与暖灯协调但不能过度戏服化。',0,5,'2026-09-11T08:53:57.659Z',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s8-i06','ep1-v3-s8','人物','白鸽伤口已合拢','同一只白鸽落在摊棚边，翅膀留血迹但伤口已经闭合。','出停在棚边的全身图与翅膀近景，和第2、4场保持同一只鸽子的特征。',0,6,'2026-09-11T08:53:57.659Z',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s8-i07','ep1-v3-s8','道具','面摊锅、灯与餐具','姑妈掀锅盖迎接顾丽乔，锅和灯承担生活感与温度。','出锅灶、摊灯、桌椅餐具组合图，保证可重复生成。',0,7,'2026-09-11T08:53:57.659Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s8-i08','ep1-v3-s8','道具','爆红手机界面','粉丝从3,126快速上涨，私信、关注、品牌邀约和辱骂同时涌入。','出粉丝增长、私信列表和热视频弹幕三种手机UI；核心文字按剧本保留。',0,8,'2026-09-11T08:53:57.659Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s8-i09','ep1-v3-s8','道具','前夫置顶评论','评论“顾丽乔，你以为跑到上塘城，我就找不到你？”头像为前夫。','出评论置顶近景，头像需沿用第1场前夫形象，文字完整可读。',0,9,'2026-09-11T08:53:57.659Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s8-i10','ep1-v3-s8','美术图','面摊双钩子收尾','前景是顾丽乔盯手机，远处黑车内的人看她白发定格画面，反光遮脸。','出面摊人物层、手机层、黑车观察层三层构图；既看清威胁又不揭露神秘人。',0,10,'2026-09-11T08:53:57.659Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s1-auto-1','ep1-v3-s1','人物','顾丽乔｜人脸、妆造、梳发','顾丽乔狼狈地被怪物按在破旧祭坛前，身上的白色长裙满是破损和血迹。她嘴角带血，长发遮住半张脸。 有人给丧尸演员递上衣服（打女主的那个），丝毫没人关注冻得发抖的顾丽乔。','本场人脸、妆造、梳发集中在此，可上传多张备选。',0,1,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s1-auto-2','ep1-v3-s1','人物','怪物演员｜人物造型','根据本场身份、情绪和前后场连续性确定怪物演员的妆发与人物状态。','怪物演员本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,2,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s1-auto-3','ep1-v3-s1','人物','前夫（闪回）｜人物造型','前夫满身酒气，夺走她的手机；镜子撞裂；她的手臂挡在脸前，浑身是伤。','前夫（闪回）本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,3,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s1-auto-4','ep1-v3-s1','人物','导演｜人物造型','所有演员齐刷刷往镜头方向的导演看去，数十个片场工作人员穿着冬天的衣服，陆陆续续从阴影里走出来往导演方向聚过去（丧尸演员整理妆容 摘头套）。','导演本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,4,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s1-auto-5','ep1-v3-s1','人物','制片主任｜人物造型','根据本场身份、情绪和前后场连续性确定制片主任的妆发与人物状态。','制片主任本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,5,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s1-auto-6','ep1-v3-s1','人物','群头｜人物造型','根据本场身份、情绪和前后场连续性确定群头的妆发与人物状态。','群头本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,6,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s1-auto-7','ep1-v3-s1','人物','陆文川｜人脸、妆造、梳发','陆文川淹死在水中，已经没了气息。','本场人脸、妆造、梳发集中在此，可上传多张备选。',0,7,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s1-auto-8','ep1-v3-s1','人物','助理｜人物造型','根据本场身份、情绪和前后场连续性确定助理的妆发与人物状态。','助理本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,8,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s1-auto-9','ep1-v3-s1','人物','视察人员｜人物造型','根据本场身份、情绪和前后场连续性确定视察人员的妆发与人物状态。','视察人员本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,9,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s1-auto-10','ep1-v3-s1','服装','历史服装备选（待确认角色）','保留原有全部上传图与作者，尚未人工确认角色归属；不擅自当成女主或男主服装。','Lipa可把图片移到对应角色服装项。',0,850,'2026-09-14 10:55:46',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s1-auto-11','ep1-v3-s1','服装','历史服装备选（待确认角色）','保留原有全部上传图与作者，尚未人工确认角色归属；不擅自当成女主或男主服装。','Lipa可把图片移到对应角色服装项。',0,850,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s1-auto-20','ep1-v3-s1','场景','南庭影视城·复古教堂片场　日　内｜场景图','顾丽乔狼狈地被怪物按在破旧祭坛前，身上的白色长裙满是破损和血迹。她嘴角带血，长发遮住半张脸。 教堂顶灯亮起，怪物的手僵在半空。 所有演员齐刷刷往镜头方向的导演看去，数十个片场工作人员穿着冬天的衣服，陆陆续续从阴影里走出来往导演方向聚过去（丧尸演员整理妆容 摘头套）。 她正要说话，片场入口忽然热闹起来，导演迅速站起身从她面前经过，朝着门口走去。 门口，陆文川带着助理、安全、法务和项目人员走进来。 顾丽乔被人群挤到景片边，差点摔倒，顾问穿下意识拉了她一把。','一个场景上传位：先放完整氛围图，再追加局部与不同角度，不按文字拆多个场景项。',0,0,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s2-auto-1','ep1-v3-s2','人物','陆文川｜人脸、妆造、梳发','根据本场身份、情绪和前后场连续性确定陆文川的妆发与人物状态。','本场人脸、妆造、梳发集中在此，可上传多张备选。',0,1,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s2-auto-2','ep1-v3-s2','服装','本场服装连续性','剧本没有写明具体服装，需根据人物身份、时间地点和前后场确定。','主美补充本场完整穿搭图并标注与前后场是否连戏。',0,2,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s2-auto-4','ep1-v3-s2','场景','东方庭院·临水巷道　日　内｜场景图','东方庭院内部，陆文川独自走在现场，正中的湖边还停着一艘乌篷船。 陆文川走到乌篷船边，小心翼翼地乘船想仔细查看。 他刚踏上乌篷船，就听远处传来“咔。”地一声，远处突然传来一声机械启动的声音。原本平静的水面突然开始剧烈涌动。 下一秒，大量积水从旁边的楼体内部冲出。 陆文川根本来不及反应，巨大的水流撞上乌篷船，船身猛地一歪。 陆文川直接被掀进水里。','一个场景上传位：先放完整氛围图，再追加局部与不同角度，不按文字拆多个场景项。',0,0,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s3-auto-1','ep1-v3-s3','人物','顾丽乔｜人脸、妆造、梳发','根据本场身份、情绪和前后场连续性确定顾丽乔的妆发与人物状态。','本场人脸、妆造、梳发集中在此，可上传多张备选。',0,1,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s3-auto-2','ep1-v3-s3','人物','群头｜人物造型','根据本场身份、情绪和前后场连续性确定群头的妆发与人物状态。','群头本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,2,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s3-auto-3','ep1-v3-s3','人物','导演｜人物造型','根据本场身份、情绪和前后场连续性确定导演的妆发与人物状态。','导演本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,3,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s3-auto-4','ep1-v3-s3','人物','群演｜人物造型','根据本场身份、情绪和前后场连续性确定群演的妆发与人物状态。','群演本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,4,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s3-auto-5','ep1-v3-s3','服装','本场服装连续性','剧本没有写明具体服装，需根据人物身份、时间地点和前后场确定。','主美补充本场完整穿搭图并标注与前后场是否连戏。',0,5,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s3-auto-8','ep1-v3-s3','场景','东方庭院外围候场区　日　外｜场景图','顾丽乔坐在临河布景外等重拍，寒冬的夜冷得呼气都是白雾，她还沉浸在幻觉之中。 月洞门“咔”地落栓。 众人纷纷进入棚内，顾丽乔却有些犹疑，转身朝着东方庭院跑去。','一个场景上传位：先放完整氛围图，再追加局部与不同角度，不按文字拆多个场景项。',0,0,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s4-auto-1','ep1-v3-s4','人物','监控外包负责人｜人物造型','根据本场身份、情绪和前后场连续性确定监控外包负责人的妆发与人物状态。','监控外包负责人本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,1,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s4-auto-2','ep1-v3-s4','人物','神秘人（电话声）｜人物造型','根据本场身份、情绪和前后场连续性确定神秘人（电话声）的妆发与人物状态。','神秘人（电话声）本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,2,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s4-auto-3','ep1-v3-s4','服装','本场服装连续性','剧本没有写明具体服装，需根据人物身份、时间地点和前后场确定。','主美补充本场完整穿搭图并标注与前后场是否连戏。',0,3,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s4-auto-7','ep1-v3-s5','场景','影视城监控室　夜　内｜场景图','根据场头“影视城监控室　夜　内”建立本场空间。','一个场景上传位：先放完整氛围图，再追加局部与不同角度，不按文字拆多个场景项。',0,0,'2026-09-14 08:27:00',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s5-auto-1','ep1-v3-s6','人物','陆文川｜人脸、妆造、梳发','根据本场身份、情绪和前后场连续性确定陆文川的妆发与人物状态。','本场人脸、妆造、梳发集中在此，可上传多张备选。',0,10,'2026-09-14 08:27:00',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s5-auto-2','ep1-v3-s5','人物','助理｜人物造型','根据本场身份、情绪和前后场连续性确定助理的妆发与人物状态。','助理本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,2,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s5-auto-3','ep1-v3-s5','服装','本场服装连续性','剧本没有写明具体服装，需根据人物身份、时间地点和前后场确定。','主美补充本场完整穿搭图并标注与前后场是否连戏。',0,3,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s5-auto-4','ep1-v3-s5','道具','手机','助理把手机递给他。','生成“手机”设定图；标明外形、材质、尺寸及剧中使用状态。',0,4,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s5-auto-7','ep1-v3-s6','场景','医院病房　深夜　内｜场景图','根据场头“医院病房　深夜　内”建立本场空间。','一个场景上传位：先放完整氛围图，再追加局部与不同角度，不按文字拆多个场景项。',0,0,'2026-09-14 08:27:00',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s6-auto-1','ep1-v3-s7','人物','顾丽乔｜人脸、妆造、梳发','等顾丽乔走近，沈糯才看见顾丽乔手臂上的擦伤，立刻摘下面膜，很是心疼。 顾丽乔：不是拍戏伤的。 顾丽乔没再多说，她坐到灯前，简单整理就打开了直播，却看见镜子里自己多了一缕白发，她对此很困惑。','本场人脸、妆造、梳发集中在此，可上传多张备选。',0,10,'2026-09-14 08:27:00',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s6-auto-2','ep1-v3-s6','人物','沈糯｜人物造型','沈糯敷着面膜，正在调灯，听到门开，着急地催促着。 等顾丽乔走近，沈糯才看见顾丽乔手臂上的擦伤，立刻摘下面膜，很是心疼。 沈糯：怎么又受伤了？又让你拍危险的戏份了？给钱了吗？','沈糯本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,2,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s6-auto-3','ep1-v3-s6','服装','本场服装连续性','剧本没有写明具体服装，需根据人物身份、时间地点和前后场确定。','主美补充本场完整穿搭图并标注与前后场是否连戏。',0,3,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s6-auto-4','ep1-v3-s6','道具','手机','唯一一张较为宽阔的桌上，架着两盏补光灯和手机。','生成“手机”设定图；标明外形、材质、尺寸及剧中使用状态。',0,4,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s6-auto-9','ep1-v3-s7','场景','群演酒店标间　深夜　内｜场景图','根据场头“群演酒店标间　深夜　内”建立本场空间。','一个场景上传位：先放完整氛围图，再追加局部与不同角度，不按文字拆多个场景项。',0,0,'2026-09-14 08:27:00',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s1-overall-cast','ep1-v3-s1','服装','配角与群演｜整体参考','本场配角、群演整体形象与服装集中上传；历史参考全部保留。','一个整体参考上传位，可追加多张备选，不逐人拆分。',0,800,'2026-09-14 07:37:10',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s3-overall-cast','ep1-v3-s3','服装','配角与群演｜整体参考','本场配角、群演整体形象与服装集中上传；历史参考全部保留。','一个整体参考上传位，可追加多张备选，不逐人拆分。',0,800,'2026-09-14 07:37:10',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s4-overall-cast','ep1-v3-s5','服装','配角与群演｜整体参考','本场配角、群演整体形象与服装集中上传；历史参考全部保留。','一个整体参考上传位，可追加多张备选，不逐人拆分。',0,800,'2026-09-14 08:27:00',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s5-overall-cast','ep1-v3-s6','服装','配角与群演｜整体参考','本场配角、群演整体形象与服装集中上传；历史参考全部保留。','一个整体参考上传位，可追加多张备选，不逐人拆分。',0,800,'2026-09-14 08:27:00',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s6-overall-cast','ep1-v3-s7','服装','配角与群演｜整体参考','本场配角、群演整体形象与服装集中上传；历史参考全部保留。','一个整体参考上传位，可追加多张备选，不逐人拆分。',0,800,'2026-09-14 08:27:00',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s7-overall-cast','ep1-v3-s7','服装','配角与群演｜整体参考','本场配角、群演整体形象与服装集中上传；历史参考全部保留。','一个整体参考上传位，可追加多张备选，不逐人拆分。',0,800,'2026-09-14 08:27:00',0,0);
INSERT INTO script_analysis_items VALUES('ep1-v3-s1-heroine-wardrobe','ep1-v3-s1','服装','顾丽乔｜服装','第一场顾丽乔的服装参考，可上传多套备选并由 Lipa 选择定稿。','同一上传位可放多张服装图，不按剧本句子拆分。',0,11,'2026-09-14 11:06:45',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s1-hero-wardrobe','ep1-v3-s1','服装','陆文川｜服装','本场该角色服装，请团队上传完整穿搭与备选。','同一上传位可放多张服装图，不按剧本句子拆分。',0,21,'2026-09-14 07:37:10',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s2-hero-wardrobe','ep1-v3-s2','服装','陆文川｜服装','本场该角色服装，请团队上传完整穿搭与备选。','同一上传位可放多张服装图，不按剧本句子拆分。',0,21,'2026-09-14 07:37:10',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s3-heroine-wardrobe','ep1-v3-s3','服装','顾丽乔｜服装','本场该角色服装，请团队上传完整穿搭与备选。','同一上传位可放多张服装图，不按剧本句子拆分。',0,11,'2026-09-14 07:37:10',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s5-hero-wardrobe','ep1-v3-s6','服装','陆文川｜服装','本场该角色服装，请团队上传完整穿搭与备选。','同一上传位可放多张服装图，不按剧本句子拆分。',0,21,'2026-09-14 08:27:00',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s6-heroine-wardrobe','ep1-v3-s7','服装','顾丽乔｜服装','本场该角色服装，请团队上传完整穿搭与备选。','同一上传位可放多张服装图，不按剧本句子拆分。',0,11,'2026-09-14 08:27:00',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s4-current-scene','ep1-v3-s4','场景','东方庭院·临水巷道　日　内｜场景图','根据场头“东方庭院·临水巷道　日　内”建立本场空间。','一个场景上传位：先放完整氛围图，再追加局部与不同角度，不按文字拆多个场景项。',0,0,'2026-09-14 08:27:00',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s4-current-heroine','ep1-v3-s4','人物','顾丽乔｜人脸、妆造、梳发','本场顾丽乔的人脸、妆造、梳发统一参考。','本场人脸、妆造、梳发集中在此，可上传多张备选。',0,10,'2026-09-14 08:27:00',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s4-current-heroine-wardrobe','ep1-v3-s4','服装','顾丽乔｜服装','本场顾丽乔的完整穿搭。','同一上传位可放多张服装图，不按剧本句子拆分。',0,11,'2026-09-14 08:27:00',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s4-current-hero','ep1-v3-s4','人物','陆文川｜人脸、妆造、梳发','本场陆文川的人脸、妆造、梳发统一参考。','本场人脸、妆造、梳发集中在此，可上传多张备选。',0,20,'2026-09-14 08:27:00',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s4-current-hero-wardrobe','ep1-v3-s4','服装','陆文川｜服装','本场陆文川的完整穿搭。','同一上传位可放多张服装图，不按剧本句子拆分。',0,21,'2026-09-14 08:27:00',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s1-i02','ep1-v3-s1','场景','闪回｜20岁顾丽乔被前夫家暴的小家','20岁的顾丽乔在逼仄的小家里被前夫家暴；这是第一场正文中的闪回空间，与复古教堂片场分开审核。','单独上传小家完整空间、压迫氛围与必要局部；后续闪回和蒙太奇也各自建立独立场景项。',0,2,'2026-09-14 12:06:18',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s1-i12','ep1-v3-s1','服装','闪回｜20岁顾丽乔穿搭','20岁顾丽乔在小家遭遇家暴时的完整穿搭，与片场服装分开审核。','上传完整穿搭参考，可追加正侧背、材质与受损状态；不要混入当前时空服装。',0,3,'2026-09-14 12:06:18',0,1);
INSERT INTO script_analysis_items VALUES('ep1-v3-s1-flashback-abuser-wardrobe','ep1-v3-s1','服装','闪回｜家暴男（前夫）穿搭','家暴男（前夫）在小家闪回中的完整穿搭。','上传完整穿搭参考，可追加正侧背和细节；与顾丽乔穿搭分开审核。',0,4,'2026-09-14 12:06:18',0,1);
CREATE TABLE `daily_reports` (
	`id` text PRIMARY KEY NOT NULL,
	`work_date` text NOT NULL,
	`completed_count` integer DEFAULT 0 NOT NULL,
	`incomplete_count` integer DEFAULT 0 NOT NULL,
	`rollover_count` integer DEFAULT 0 NOT NULL,
	`summary_json` text NOT NULL,
	`created_at` text NOT NULL,
	`updated_at` text NOT NULL
);
CREATE TABLE `team_members` (
	`user_id` text PRIMARY KEY NOT NULL,
	`email` text NOT NULL,
	`name` text NOT NULL,
	`phone` text NOT NULL,
	`role` text NOT NULL,
	`active` integer DEFAULT true NOT NULL,
	`created_at` text NOT NULL,
	`updated_at` text NOT NULL
);
CREATE TABLE `member_accounts` (
	`id` text PRIMARY KEY NOT NULL,
	`username` text NOT NULL,
	`password_hash` text NOT NULL,
	`password_salt` text NOT NULL,
	`password_iterations` integer DEFAULT 120000 NOT NULL,
	`name` text NOT NULL,
	`role` text NOT NULL,
	`is_admin` integer DEFAULT false NOT NULL,
	`active` integer DEFAULT true NOT NULL,
	`failed_attempts` integer DEFAULT 0 NOT NULL,
	`locked_until` text DEFAULT '' NOT NULL,
	`created_at` text NOT NULL,
	`updated_at` text NOT NULL
);
CREATE TABLE `member_sessions` (
	`id` text PRIMARY KEY NOT NULL,
	`account_id` text NOT NULL,
	`token_hash` text NOT NULL,
	`expires_at` text NOT NULL,
	`created_at` text NOT NULL,
	`last_seen_at` text NOT NULL
);
CREATE TABLE `art_submission_details` (
	`item_id` text PRIMARY KEY NOT NULL,
	`assigned_to` text DEFAULT '主美小金' NOT NULL,
	`due_at` text DEFAULT '' NOT NULL,
	`handoff_to` text DEFAULT 'Lipa' NOT NULL,
	`done_definition` text DEFAULT '' NOT NULL,
	`status` text DEFAULT '待上传' NOT NULL,
	`submission_note` text DEFAULT '' NOT NULL,
	`review_note` text DEFAULT '' NOT NULL,
	`submitted_at` text DEFAULT '' NOT NULL,
	`reviewed_at` text DEFAULT '' NOT NULL,
	`updated_at` text NOT NULL
, `selected_file_id` text DEFAULT '' NOT NULL);
INSERT INTO art_submission_details VALUES('ep1-v3-s1-i01','主美小金','2026-09-10T18:00','Lipa','确认片场完整空间、主机位和俯视调度关系。','已上传','片场／教堂空间参考已入库，待整集微信确认。','','2026-09-10T14:00:00.000Z','','2026-09-10T14:00:00.000Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-i02','主美小金','2026-09-10T18:00','Lipa','上传小家完整空间、压迫氛围与必要局部，并与教堂片场分开审核。','已上传','家暴出租屋场景参考已入库，待整集微信确认。','','2026-09-10T14:00:00.000Z','','2026-09-14 11:50:31','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-i04','主美小金','2026-09-10T18:00','Lipa','对比教堂片场白衣与粉色长发Option A—C。','已上传','三个独立服装发型Option已入库，尚未锁定。','','2026-09-10T14:00:00.000Z','','2026-09-10T14:00:00.000Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-i12','主美小金','2026-09-10T18:00','Lipa','上传20岁顾丽乔在家暴闪回中的完整穿搭，与片场服装分开审核。','已上传','五个独立Option已入库，尚未锁定。','','2026-09-10T14:00:00.000Z','','2026-09-14 12:06:18','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-i13','主美小金','2026-09-10T18:00','Lipa','对比女主现居出租屋的日夜氛围、家具布局和主机位。','已上传','五张空间视角已入库，与家暴出租屋分组显示。','','2026-09-10T14:00:00.000Z','','2026-09-10T14:00:00.000Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s3-i08','主美小金','2026-09-10T18:00','Lipa','对比女主下班后日常穿搭Option A—J，最终锁定一套及备选顺序。','已上传','十个独立Option已入库，尚未锁定。','','2026-09-10T14:00:00.000Z','','2026-09-10T14:00:00.000Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s4-i01','主美小金','2026-09-10T18:00','Lipa','确认东方庭院总布局、水道、月洞门和调度线。','已上传','庭院场景参考已入库，待整集微信确认。','','2026-09-10T14:00:00.000Z','','2026-09-10T14:00:00.000Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s4-i03','主美小金','2026-09-10T18:00','Lipa','庭院场沿用教堂片场的白衣与粉发Option A—C。','已上传','与教堂片场一致的三个Option已入库，尚未锁定。','','2026-09-10T14:00:00.000Z','','2026-09-10T14:00:00.000Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s3-i09','主美小金','2026-09-11T18:00','Lipa','对比男主陆出场人脸Option A—D，最终锁定一张脸及黑色短发方向。','已上传','四组人脸Option已入库，尚未锁定。','','2026-09-11T10:00:00.000Z','','2026-09-11T10:00:00.000Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s3-i10','主美小金','2026-09-11T18:00','Lipa','对比男主陆出场服装Option A—M，最终锁定一套及备选顺序。','已上传','十三组服装Option已入库，尚未锁定。','','2026-09-11T10:00:00.000Z','','2026-09-11T10:00:00.000Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-i03','主美小金','','Lipa','正面、侧面、三分之二身人物定妆图；脸、身形和黑色短发作为全剧连续性基准。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-i05','主美小金','','Lipa','同一机位出戴粉色长假发、摘下假发两张对照图；粉色色相、长度、卷直程度待核准。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-i06','主美小金','','Lipa','出三名怪物同框比例图与单人造型图；轮廓需有差异，避免全身细碎附件影响动作生成。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-i07','主美小金','','Lipa','分别出半身人物设定；年龄、职业质感和服装色系待核准。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-i08','主美小金','','Lipa','出导演、制片主任、群头三人区分图及工作人员群像气氛图。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-i09','主美小金','','Lipa','出三件道具的近景设定与破损状态；血量尺度待核准。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-i10','主美小金','','Lipa','出可直接用于画面的手机UI两版：催收通知、姑妈语音；文字必须保持剧本信息准确。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-i11','主美小金','','Lipa','用同角度生成“戏中戏成立／喊卡后穿帮”两张配对关键帧，供Yoyo判断反差是否够强。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s2-i01','主美小金','','Lipa','出一张中景：廊柱遮挡、杂物间、道具堆和片场漏光；标明顾丽乔坐位及白鸽坠落点。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s2-i02','主美小金','','Lipa','沿用第1场脸与服装，新增坐姿、双手拢鸽、扶柱三种动作参考。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s2-i03','主美小金','','Lipa','出发根极近景，白发变化清楚但不能夸张成大片漂白。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s2-i04','主美小金','','Lipa','出受伤、静止、重新喘气三种连续状态；白鸽体型和羽毛特征须固定。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s2-i05','主美小金','','Lipa','出手机背壳夹钱状态和账号拍摄界面；数字需可读。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s2-i06','主美小金','','Lipa','出可辨识但不过度醒目的线缠翅膀近景，以及沾血卸妆棉状态。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s2-i07','主美小金','','Lipa','出掌心与白鸽的特写关键帧；白光克制、非大法术特效，亮度和形态待Yoyo确认。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s3-i01','主美小金','','Lipa','出纵深小巷定调图与俯视调度图；明确移动灯倾倒方向、两人接触点和视察队行进线。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s3-i02','主美小金','','Lipa','正面、侧面、三分之二身人物定妆图；面部与身材作为后续落水、病房连续性基准。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s3-i03','主美小金','','Lipa','出全身服装方案；外套需要在第5场脱下捂口鼻，层次和材质须清楚。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s3-i04','主美小金','','Lipa','出全身连续性图，明确假发抱法、服装血迹位置和不明显的一根白发。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s3-i05','主美小金','','Lipa','出助理与安全负责人区分明确的半身图，以及3—5人视察群像。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s3-i06','主美小金','','Lipa','出灯具结构、支架和倒向示意；确保动作逻辑可信。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s3-i07','主美小金','','Lipa','做一组6格预见关键帧，统一冷、碎、短促的视觉语法；字幕“22:17”单独出样。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s4-i02','主美小金','','Lipa','出群演层次和逆行构图参考，保证顾丽乔在手机画幅内一眼可读。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s4-i04','主美小金','','Lipa','出贴水飞行侧视图，固定羽毛特征与受伤翅膀状态。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s4-i05','主美小金','','Lipa','出手部近景，钱、结算单和退还动作清晰；结算单信息不需写满。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s4-i06','主美小金','','Lipa','出月洞门铁栓落下近景与警铃亮起状态。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s4-i07','主美小金','','Lipa','出竖屏/手机端可读的中心构图：人群向外、顾丽乔向内、粉色假发落地。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s5-i01','主美小金','','Lipa','出燃烧前基础图、起火状态图和俯视调度图；明确门、桥、两条乌篷船、落水点和出口。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s5-i02','主美小金','','Lipa','出下水前、拖人、CPR、划船四个动作状态；同一张脸、血迹和白发增长必须连续。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s5-i03','主美小金','','Lipa','出清醒、溺水闭眼、复苏呛咳三状态，湿发和服装层次保持一致。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s5-i04','主美小金','','Lipa','出白发扩散三个阶段近景；是否发根先白、白发面积与鼻血量待Yoyo核准。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s5-i05','主美小金','','Lipa','出灭火器、断栓、压门景片的连续动作参考。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s5-i06','主美小金','','Lipa','出船型统一设定、翻覆状态、船桨和缆绳烧断近景；船与桥尺度必须可执行。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s5-i07','主美小金','','Lipa','出工作证正反面及烧黑版；倒计时字幕与手机时间统一字形和位置。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s5-i08','主美小金','','Lipa','出特效前后对照关键帧；效果应诡异克制，不做大范围仙术光效。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s5-i09','主美小金','','Lipa','出三张连续动作图，确认身体位置、视线、船内空间与镜头轴线。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s5-i10','主美小金','','Lipa','出陆文川主观视角和高位监控视角各一张，保留粉色纤维、白发和红灯。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s6-i01','主美小金','','Lipa','出监控室总图与操作者主观屏幕图；光源以屏幕冷光为主，空间规模待核准。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s6-i02','主美小金','','Lipa','出半身造型图和操作台坐姿；年龄与性别剧本未定，标记待核准。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s6-i03','主美小金','','Lipa','本场不出正脸；只需为后续建立声音/来电界面标识，来电名称保持匿名。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s6-i04','主美小金','','Lipa','出四格监控UI、时间码和放大框样式；避免界面信息过密。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s6-i05','主美小金','','Lipa','出匿名通话界面和上传100%画面，可直接用于合成。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s6-i06','主美小金','','Lipa','出剪辑前四格、删减后单画面、标题发布页三步组图，供Yoyo判断幕后操盘是否清楚。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s7-i01','主美小金','2026-09-11T18:00','Lipa','出病房总图和床侧双人构图；医院等级、窗外环境和灯光色温待核准。','已上传','','','2026-09-14T08:13:21.308Z','','2026-09-14T08:13:43.283Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s7-i02','主美小金','2026-09-11T18:00','Lipa','沿用第3、5场脸，出湿发处理后的病床状态和按心口动作近景。','待上传','','','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s7-i03','主美小金','2026-09-11T18:00','Lipa','出病服全身/半身方案；颜色与医院空间配套，待核准。','已上传','','','2026-09-14T06:22:23.455Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s7-i04','主美小金','2026-09-11T18:00','Lipa','沿用第3场助理，服装可保持视察造型或增加外套湿痕，连续性待核准。','待上传','','','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s7-i07','主美小金','2026-09-11T18:00','Lipa','出床上陆文川、手机视频和助理同框关键帧，重点是目光与决断。','待上传','','','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s8-i01','主美小金','2026-09-11T18:00','Lipa','出街道远景、面摊总图和桌边近景；一盏暖灯对比湿冷街面，招牌文字待核准。','待上传','','','','','2026-09-11T12:49:56.466Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s8-i02','主美小金','2026-09-11T18:00','Lipa','出外部停车关系图与车内肩后视角；车型、距离和人物遮脸方式待核准。','待上传','','','','','2026-09-11T12:49:56.466Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s8-i03','主美小金','2026-09-11T18:00','Lipa','出正面、侧面、摊位工作状态人物图；年龄、围裙与日常衣着待核准。','待上传','','','','','2026-09-11T12:49:56.466Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s8-i04','主美小金','2026-09-11T18:00','Lipa','沿用第5场连续状态，出被姑妈扶住、摸白发、看手机三张动作图。','待上传','','','','','2026-09-11T12:49:56.466Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s8-i05','主美小金','2026-09-11T18:00','Lipa','出全身工作造型；色彩应与暖灯协调但不能过度戏服化。','待上传','','','','','2026-09-11T12:49:56.466Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s8-i06','主美小金','2026-09-11T18:00','Lipa','出停在棚边的全身图与翅膀近景，和第2、4场保持同一只鸽子的特征。','待上传','','','','','2026-09-11T12:49:56.466Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s8-i07','主美小金','2026-09-11T18:00','Lipa','出锅灶、摊灯、桌椅餐具组合图，保证可重复生成。','待上传','','','','','2026-09-11T12:49:56.466Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s8-i08','主美小金','2026-09-11T18:00','Lipa','出粉丝增长、私信列表和热视频弹幕三种手机UI；核心文字按剧本保留。','待上传','','','','','2026-09-11T12:49:56.466Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s8-i09','主美小金','2026-09-11T18:00','Lipa','出评论置顶近景，头像需沿用第1场前夫形象，文字完整可读。','待上传','','','','','2026-09-11T12:49:56.466Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s8-i10','主美小金','2026-09-11T18:00','Lipa','出面摊人物层、手机层、黑车观察层三层构图；既看清威胁又不揭露神秘人。','待上传','','','','','2026-09-11T12:49:56.466Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-auto-1','主美小金','2026-09-11T18:00','Lipa','顾丽乔本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T10:58:07.106Z','','2026-09-14T10:58:07.106Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-auto-2','主美小金','2026-09-11T18:00','Lipa','怪物演员本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T05:48:25.008Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-auto-3','主美小金','2026-09-11T18:00','Lipa','前夫（闪回）本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-11T11:44:29.148Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-auto-4','主美小金','2026-09-11T18:00','Lipa','导演本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-11T11:43:25.750Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-auto-5','主美小金','2026-09-11T18:00','Lipa','制片主任本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-11T11:49:48.161Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-auto-6','主美小金','2026-09-11T18:00','Lipa','群头本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-11T11:44:45.961Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-auto-7','主美小金','2026-09-11T18:00','Lipa','陆文川本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T07:11:11.783Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-auto-8','主美小金','2026-09-11T18:00','Lipa','助理本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T06:03:34.272Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-auto-9','主美小金','2026-09-11T18:00','Lipa','视察人员本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T06:05:32.458Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-auto-10','玉冰','2026-09-11T18:00','Lipa','按这条剧本信息生成完整穿搭图，标清内外层、鞋袜、配饰、颜色、材质和连续性。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T06:52:45.692Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-auto-11','主美小金','2026-09-11T18:00','Lipa','按这条剧本信息生成完整穿搭图，标清内外层、鞋袜、配饰、颜色、材质和连续性。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T06:32:03.873Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-auto-20','主美小金','2026-09-11T18:00','Lipa','生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T06:43:49.875Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s2-auto-1','主美小金','2026-09-11T18:00','Lipa','陆文川本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s2-auto-2','主美小金','2026-09-11T18:00','Lipa','主美补充本场完整穿搭图并标注与前后场是否连戏。','待上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T06:41:41.475Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s2-auto-4','主美小金','2026-09-11T18:00','Lipa','生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T06:47:22.416Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s3-auto-1','主美小金','2026-09-11T18:00','Lipa','顾丽乔本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s3-auto-2','主美小金','2026-09-11T18:00','Lipa','群头本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s3-auto-3','主美小金','2026-09-11T18:00','Lipa','导演本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s3-auto-4','主美小金','2026-09-11T18:00','Lipa','群演本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s3-auto-5','主美小金','2026-09-11T18:00','Lipa','主美补充本场完整穿搭图并标注与前后场是否连戏。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s3-auto-8','主美小金','2026-09-11T18:00','Lipa','生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T11:00:00.744Z','','2026-09-14T11:00:00.744Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s4-auto-1','主美小金','2026-09-11T18:00','Lipa','监控外包负责人本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s4-auto-2','主美小金','2026-09-11T18:00','Lipa','神秘人（电话声）本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s4-auto-3','主美小金','2026-09-11T18:00','Lipa','主美补充本场完整穿搭图并标注与前后场是否连戏。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s4-auto-7','主美小金','2026-09-11T18:00','Lipa','生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。','已上传','','','2026-09-14T08:18:36.944Z','','2026-09-14 08:27:00','');
INSERT INTO art_submission_details VALUES('ep1-v3-s5-auto-1','主美小金','2026-09-11T18:00','Lipa','陆文川本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','待上传','','','','','2026-09-14 08:27:00','');
INSERT INTO art_submission_details VALUES('ep1-v3-s5-auto-2','主美小金','2026-09-11T18:00','Lipa','助理本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s5-auto-3','主美小金','2026-09-11T18:00','Lipa','主美补充本场完整穿搭图并标注与前后场是否连戏。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s5-auto-4','主美小金','2026-09-11T18:00','Lipa','生成“手机”设定图；标明外形、材质、尺寸及剧中使用状态。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s5-auto-7','主美小金','2026-09-11T18:00','Lipa','生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。','已上传','','','2026-09-14T09:10:23.018Z','','2026-09-14T09:10:23.018Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s6-auto-1','主美小金','2026-09-11T18:00','Lipa','顾丽乔本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','待上传','','','','','2026-09-14 08:27:00','');
INSERT INTO art_submission_details VALUES('ep1-v3-s6-auto-2','主美小金','2026-09-11T18:00','Lipa','沈糯本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s6-auto-3','主美小金','2026-09-11T18:00','Lipa','主美补充本场完整穿搭图并标注与前后场是否连戏。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s6-auto-4','主美小金','2026-09-11T18:00','Lipa','生成“手机”设定图；标明外形、材质、尺寸及剧中使用状态。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s6-auto-9','主美小金','2026-09-11T18:00','Lipa','生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。','已上传','','','2026-09-14T05:41:23.314Z','','2026-09-14 08:27:00','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-overall-cast','','2026-09-14T20:00','Lipa','一个整体参考上传位，可追加多张备选，不逐人拆分。','已上传','','','','','2026-09-14T11:30:04.042Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s3-overall-cast','王承恺','2026-09-14T20:00','Lipa','一个整体参考上传位，可追加多张备选，不逐人拆分。','已上传','','','2026-09-14T11:09:24.696Z','','2026-09-14T11:09:24.696Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s4-overall-cast','王承恺','2026-09-14T20:00','Lipa','一个整体参考上传位，可追加多张备选，不逐人拆分。','已上传','','','2026-09-14T11:09:54.232Z','','2026-09-14T11:09:54.232Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s5-overall-cast','王承恺','2026-09-14T20:00','Lipa','一个整体参考上传位，可追加多张备选，不逐人拆分。','已上传','','','2026-09-14T11:17:19.752Z','','2026-09-14T11:17:19.752Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s6-overall-cast','王承恺','2026-09-14T20:00','Lipa','一个整体参考上传位，可追加多张备选，不逐人拆分。','已上传','','','2026-09-14T11:17:58.258Z','','2026-09-14T11:17:58.258Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s7-overall-cast','','2026-09-14T20:00','Lipa','一个整体参考上传位，可追加多张备选，不逐人拆分。','待上传','','','','','2026-09-14 07:37:10','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-heroine-wardrobe','','2026-09-14T20:00','Lipa','同一上传位可放多张服装图，不按剧本句子拆分。','需复核','','','','2026-09-14T11:12:24.499Z','2026-09-14T11:12:24.491Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-hero-wardrobe','玉冰','2026-09-14T20:00','Lipa','同一上传位可放多张服装图，不按剧本句子拆分。','已上传','','','2026-09-14T11:39:36.395Z','','2026-09-14T11:39:36.395Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s2-hero-wardrobe','','2026-09-14T20:00','Lipa','同一上传位可放多张服装图，不按剧本句子拆分。','待上传','','','','','2026-09-14 07:37:10','');
INSERT INTO art_submission_details VALUES('ep1-v3-s3-heroine-wardrobe','','2026-09-14T20:00','Lipa','同一上传位可放多张服装图，不按剧本句子拆分。','待上传','','','','','2026-09-14 07:37:10','');
INSERT INTO art_submission_details VALUES('ep1-v3-s5-hero-wardrobe','','2026-09-14T20:00','Lipa','同一上传位可放多张服装图，不按剧本句子拆分。','已上传','','','','','2026-09-14 08:27:00','');
INSERT INTO art_submission_details VALUES('ep1-v3-s6-heroine-wardrobe','','2026-09-14T20:00','Lipa','同一上传位可放多张服装图，不按剧本句子拆分。','待上传','','','','','2026-09-14 08:27:00','');
INSERT INTO art_submission_details VALUES('ep1-v3-s4-current-scene','','2026-09-14T20:00','Lipa','一个场景上传位：先放完整氛围图，再追加局部与不同角度，不按文字拆多个场景项。','待上传','','','','','2026-09-14 08:27:00','');
INSERT INTO art_submission_details VALUES('ep1-v3-s4-current-heroine','','2026-09-14T20:00','Lipa','本场人脸、妆造、梳发集中在此，可上传多张备选。','待上传','','','','','2026-09-14 08:27:00','');
INSERT INTO art_submission_details VALUES('ep1-v3-s4-current-heroine-wardrobe','','2026-09-14T20:00','Lipa','同一上传位可放多张服装图，不按剧本句子拆分。','待上传','','','','','2026-09-14 08:27:00','');
INSERT INTO art_submission_details VALUES('ep1-v3-s4-current-hero','','2026-09-14T20:00','Lipa','本场人脸、妆造、梳发集中在此，可上传多张备选。','待上传','','','','','2026-09-14 08:27:00','');
INSERT INTO art_submission_details VALUES('ep1-v3-s4-current-hero-wardrobe','王承恺','2026-09-14T20:00','Lipa','同一上传位可放多张服装图，不按剧本句子拆分。','已上传','','','2026-09-14T11:19:06.617Z','','2026-09-14T11:19:06.617Z','');
INSERT INTO art_submission_details VALUES('ep1-v3-s1-flashback-abuser-wardrobe','','2026-09-14T20:00','Lipa','上传家暴男（前夫）在小家闪回中的完整穿搭。','待上传','','','','','2026-09-14 12:06:18','');
CREATE TABLE `art_submission_files` (
	`id` text PRIMARY KEY NOT NULL,
	`item_id` text NOT NULL,
	`object_key` text NOT NULL,
	`file_name` text NOT NULL,
	`content_type` text NOT NULL,
	`byte_size` integer NOT NULL,
	`uploaded_by` text NOT NULL,
	`sort_order` integer DEFAULT 0 NOT NULL,
	`created_at` text NOT NULL
, `file_data` blob);
INSERT INTO art_submission_files VALUES('curated-s1-set-01','ep1-v3-s1-i01','static:/reference-assets/episode-1/scene-1-set-01.png','片场参考 01｜带工作人员与机位','image/png',1702155,'Lipa',1,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-s1-set-02','ep1-v3-s1-i01','static:/reference-assets/episode-1/scene-1-set-02.jpg','片场参考 02｜教堂空间与尸体血迹','image/jpeg',2587531,'Lipa',2,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-s1-wardrobe-a','ep1-v3-s1-i04','static:/reference-assets/episode-1/scene-1-wardrobe-a.png','教堂片场 Option A｜长款白色吊带裙＋粉色长发','image/png',1744223,'Lipa',1,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-s1-wardrobe-b','ep1-v3-s1-i04','static:/reference-assets/episode-1/scene-1-wardrobe-b.png','教堂片场 Option B｜收腰白色缎面中长裙＋粉色长发','image/png',1711169,'Lipa',2,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-s1-wardrobe-c','ep1-v3-s1-i04','static:/reference-assets/episode-1/scene-1-wardrobe-c.png','教堂片场 Option C｜白色短款伞摆裙＋粉色长发','image/png',1716944,'Lipa',3,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-s1-domestic-set-01','ep1-v3-s1-i02','static:/reference-assets/episode-1/scene-1-domestic-set-01.png','家暴出租屋｜破损房间与黄昏光线参考','image/png',1667327,'Lipa',1,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-s1-domestic-wardrobe-a','ep1-v3-s1-i12','static:/reference-assets/episode-1/scene-1-domestic-wardrobe-a.jpg','家暴出租屋 Option A｜灰蓝长袖长裤家居服','image/jpeg',65154,'Lipa',1,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-s1-domestic-wardrobe-b','ep1-v3-s1-i12','static:/reference-assets/episode-1/scene-1-domestic-wardrobe-b.jpg','家暴出租屋 Option B｜浅色长袖短裤家居服','image/jpeg',65511,'Lipa',2,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-s1-domestic-wardrobe-c','ep1-v3-s1-i12','static:/reference-assets/episode-1/scene-1-domestic-wardrobe-c.jpg','家暴出租屋 Option C｜深灰长袖长裤家居服','image/jpeg',59698,'Lipa',3,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-s1-domestic-wardrobe-d','ep1-v3-s1-i12','static:/reference-assets/episode-1/scene-1-domestic-wardrobe-d.jpg','家暴出租屋 Option D｜白色长袖长裤家居服','image/jpeg',70948,'Lipa',4,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-s1-domestic-wardrobe-e','ep1-v3-s1-i12','static:/reference-assets/episode-1/scene-1-domestic-wardrobe-e.jpg','家暴出租屋 Option E｜蓝色背心＋白色下装组合','image/jpeg',527200,'Lipa',5,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-hero-rental-set-01','ep1-v3-s1-i13','static:/reference-assets/episode-1/hero-rental-set-01.png','女主出租屋｜空间参考 01','image/png',2267102,'Lipa',1,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-hero-rental-set-02','ep1-v3-s1-i13','static:/reference-assets/episode-1/hero-rental-set-02.png','女主出租屋｜空间参考 02','image/png',2569710,'Lipa',2,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-hero-rental-set-03','ep1-v3-s1-i13','static:/reference-assets/episode-1/hero-rental-set-03.jpg','女主出租屋｜空间参考 03','image/jpeg',240986,'Lipa',3,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-hero-rental-set-04','ep1-v3-s1-i13','static:/reference-assets/episode-1/hero-rental-set-04.png','女主出租屋｜空间参考 04','image/png',2360564,'Lipa',4,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-hero-rental-set-05','ep1-v3-s1-i13','static:/reference-assets/episode-1/hero-rental-set-05.png','女主出租屋｜空间参考 05','image/png',2403051,'Lipa',5,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-offwork-a','ep1-v3-s3-i08','static:/reference-assets/episode-1/offwork-wardrobe-a.png','下班后 Option A｜连帽卫衣＋破洞牛仔长裤','image/png',2120606,'Lipa',1,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-offwork-b','ep1-v3-s3-i08','static:/reference-assets/episode-1/offwork-wardrobe-b.jpg','下班后 Option B｜短款连帽卫衣＋破洞牛仔长裤','image/jpeg',183307,'Lipa',2,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-offwork-c','ep1-v3-s3-i08','static:/reference-assets/episode-1/offwork-wardrobe-c.jpg','下班后 Option C｜白色短上衣＋黑色层叠短裙','image/jpeg',195765,'Lipa',3,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-offwork-d','ep1-v3-s3-i08','static:/reference-assets/episode-1/offwork-wardrobe-d.png','下班后 Option D｜白色立体上衣＋黑色层叠短裙','image/png',2360309,'Lipa',4,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-offwork-e','ep1-v3-s3-i08','static:/reference-assets/episode-1/offwork-wardrobe-e.png','下班后 Option E｜白色海军领上衣＋黑色短裙','image/png',2000742,'Lipa',5,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-offwork-f','ep1-v3-s3-i08','static:/reference-assets/episode-1/offwork-wardrobe-f.png','下班后 Option F｜印花短袖衬衫＋短裙长靴','image/png',2219299,'Lipa',6,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-offwork-g','ep1-v3-s3-i08','static:/reference-assets/episode-1/offwork-wardrobe-g.png','下班后 Option G｜黑色长外套＋围巾叠穿','image/png',2136822,'Lipa',7,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-offwork-h','ep1-v3-s3-i08','static:/reference-assets/episode-1/offwork-wardrobe-h.png','下班后 Option H｜牛仔外套＋牛仔长裤','image/png',2058772,'Lipa',8,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-offwork-i','ep1-v3-s3-i08','static:/reference-assets/episode-1/offwork-wardrobe-i.png','下班后 Option I｜针织开衫＋卫衣＋破洞牛仔裤','image/png',2243414,'Lipa',9,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-offwork-j','ep1-v3-s3-i08','static:/reference-assets/episode-1/offwork-wardrobe-j.png','下班后 Option J｜黑色吊带＋牛仔短裤＋堆叠长靴','image/png',1969555,'Lipa',10,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-s4-set-01','ep1-v3-s4-i01','static:/reference-assets/episode-1/scene-4-courtyard-set-01.jpg','东方庭院｜建筑、水道与月洞门参考','image/jpeg',175523,'Lipa',1,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-s4-wardrobe-a','ep1-v3-s4-i03','static:/reference-assets/episode-1/scene-4-wardrobe-a.jpg','庭院沿用 Option A｜白色短款伞摆裙＋粉色长发','image/jpeg',106701,'Lipa',1,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-s4-wardrobe-b','ep1-v3-s4-i03','static:/reference-assets/episode-1/scene-4-wardrobe-b.jpg','庭院沿用 Option B｜长款白色吊带裙＋粉色长发','image/jpeg',101820,'Lipa',2,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-s4-wardrobe-c','ep1-v3-s4-i03','static:/reference-assets/episode-1/scene-4-wardrobe-c.png','庭院沿用 Option C｜收腰白色缎面中长裙＋粉色长发','image/png',1711169,'Lipa',3,'2026-09-10T14:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-male-lu-face-a','ep1-v3-s3-i09','static:/reference-assets/episode-1/male-lu-face-a.jpg','男主陆·人脸 Option A｜黑发冷感·白衬衫黑西装','image/jpeg',149837,'Lipa',1,'2026-09-11T10:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-male-lu-face-b','ep1-v3-s3-i09','static:/reference-assets/episode-1/male-lu-face-b.jpg','男主陆·人脸 Option B｜黑发冷感·全黑西装','image/jpeg',145250,'Lipa',2,'2026-09-11T10:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-male-lu-face-c','ep1-v3-s3-i09','static:/reference-assets/episode-1/male-lu-face-c.jpg','男主陆·人脸 Option C｜锐利眉眼·松散领带','image/jpeg',160347,'Lipa',3,'2026-09-11T10:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-male-lu-face-d','ep1-v3-s3-i09','static:/reference-assets/episode-1/male-lu-face-d.jpg','男主陆·人脸 Option D｜成熟骨相·正侧近景','image/jpeg',136887,'Lipa',4,'2026-09-11T10:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-male-lu-wardrobe-a','ep1-v3-s3-i10','static:/reference-assets/episode-1/male-lu-wardrobe-a.jpg','男主陆·服装 Option A｜卡其收腰猎装夹克','image/jpeg',89591,'Lipa',1,'2026-09-11T10:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-male-lu-wardrobe-b','ep1-v3-s3-i10','static:/reference-assets/episode-1/male-lu-wardrobe-b.jpg','男主陆·服装 Option B｜棕灰短外套＋宽松长裤','image/jpeg',110296,'Lipa',2,'2026-09-11T10:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-male-lu-wardrobe-c','ep1-v3-s3-i10','static:/reference-assets/episode-1/male-lu-wardrobe-c.jpg','男主陆·服装 Option C｜棕色绞花针织＋阔腿裤','image/jpeg',140306,'Lipa',3,'2026-09-11T10:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-male-lu-wardrobe-d','ep1-v3-s3-i10','static:/reference-assets/episode-1/male-lu-wardrobe-d.jpg','男主陆·服装 Option D｜橄榄绿腰带猎装套装','image/jpeg',148704,'Lipa',4,'2026-09-11T10:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-male-lu-wardrobe-e','ep1-v3-s3-i10','static:/reference-assets/episode-1/male-lu-wardrobe-e.jpg','男主陆·服装 Option E｜浅灰双排扣西装＋阔腿裤','image/jpeg',61936,'Lipa',5,'2026-09-11T10:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-male-lu-wardrobe-f','ep1-v3-s3-i10','static:/reference-assets/episode-1/male-lu-wardrobe-f.jpg','男主陆·服装 Option F｜格纹西装＋酒红针织层叠','image/jpeg',84941,'Lipa',6,'2026-09-11T10:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-male-lu-wardrobe-g','ep1-v3-s3-i10','static:/reference-assets/episode-1/male-lu-wardrobe-g.jpg','男主陆·服装 Option G｜蓝灰工装外套＋针织裤','image/jpeg',85602,'Lipa',7,'2026-09-11T10:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-male-lu-wardrobe-h','ep1-v3-s3-i10','static:/reference-assets/episode-1/male-lu-wardrobe-h.jpg','男主陆·服装 Option H｜棕色针织开衫＋白色阔腿裤','image/jpeg',74995,'Lipa',8,'2026-09-11T10:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-male-lu-wardrobe-i','ep1-v3-s3-i10','static:/reference-assets/episode-1/male-lu-wardrobe-i.jpg','男主陆·服装 Option I｜九套大地色造型方向','image/jpeg',108255,'Lipa',9,'2026-09-11T10:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-male-lu-wardrobe-j','ep1-v3-s3-i10','static:/reference-assets/episode-1/male-lu-wardrobe-j.jpg','男主陆·服装 Option J｜九套秋冬层叠方向','image/jpeg',118701,'Lipa',10,'2026-09-11T10:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-male-lu-wardrobe-k','ep1-v3-s3-i10','static:/reference-assets/episode-1/male-lu-wardrobe-k.jpg','男主陆·服装 Option K｜卡其收腰猎装四视图','image/jpeg',160485,'Lipa',11,'2026-09-11T10:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-male-lu-wardrobe-l','ep1-v3-s3-i10','static:/reference-assets/episode-1/male-lu-wardrobe-l.jpg','男主陆·服装 Option L｜米白西装＋粉色衬衫四视图','image/jpeg',171953,'Lipa',12,'2026-09-11T10:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('curated-male-lu-wardrobe-m','ep1-v3-s3-i10','static:/reference-assets/episode-1/male-lu-wardrobe-m.jpg','男主陆·服装 Option M｜米白西装完整四视图','image/jpeg',162350,'Lipa',13,'2026-09-11T10:00:00.000Z',NULL);
INSERT INTO art_submission_files VALUES('87bf8357-1ec3-4de5-9afe-2df47de82d21','ep1-v3-s1-overall-cast','d1:87bf8357-1ec3-4de5-9afe-2df47de82d21','图片 - 2026-09-04T162506.963.jpg','image/jpeg',632956,'王承恺',1,'2026-09-11T11:43:25.750Z',NULL);
INSERT INTO art_submission_files VALUES('195bc710-6b90-440c-8340-186ca232242d','ep1-v3-s1-overall-cast','d1:195bc710-6b90-440c-8340-186ca232242d','使用老机型iPhone全身 噪点略糊没有背景虚化：豪华公寓中20岁中国男人，帅气俊朗健身男性，身材健硕，胸前带口袋设计的T恤袖，下身是西裤皮.jpg','image/jpeg',176836,'王承恺',1,'2026-09-11T11:44:29.148Z',NULL);
INSERT INTO art_submission_files VALUES('5f26c4b9-9b2d-4f1a-8fa6-5dc5aea6eccc','ep1-v3-s1-overall-cast','d1:5f26c4b9-9b2d-4f1a-8fa6-5dc5aea6eccc','图片 - 2026-09-11T180707.728.jpg','image/jpeg',666764,'王承恺',1,'2026-09-11T11:44:45.961Z',NULL);
INSERT INTO art_submission_files VALUES('279e72db-07c8-45b8-80e4-5576df238e0f','ep1-v3-s1-overall-cast','d1:279e72db-07c8-45b8-80e4-5576df238e0f','图片 - 2026-09-11T182558.740.jpg','image/jpeg',677970,'王承恺',1,'2026-09-11T11:49:48.161Z',NULL);
INSERT INTO art_submission_files VALUES('dae10025-c8a8-4b6d-9b5f-f6e3c3b3cdd1','ep1-v3-s1-auto-7','d1:dae10025-c8a8-4b6d-9b5f-f6e3c3b3cdd1','34e82df325c99ed1a126f49d6cb008f9.png','image/png',1395685,'王承恺',1,'2026-09-11T11:50:27.821Z',NULL);
INSERT INTO art_submission_files VALUES('1ed41dc3-642f-40d4-8aa7-04b61613d897','ep1-v3-s1-auto-7','d1:1ed41dc3-642f-40d4-8aa7-04b61613d897','韩国男性白幼瘦帅哥博主，25岁。东亚男性，韩国男明星英俊帅气。立体骨相，高挺笔直鼻梁，山根自然不突兀，不明显双眼皮眼型偏长，眼尾微微收，不肿.jpg','image/jpeg',179774,'王承恺',2,'2026-09-11T11:50:59.359Z',NULL);
INSERT INTO art_submission_files VALUES('3ebaad51-2ac6-4021-9f0b-831d97a5523c','ep1-v3-s1-auto-7','d1:3ebaad51-2ac6-4021-9f0b-831d97a5523c','图片 - 2026-09-11T160305.320.jpg','image/jpeg',815440,'王承恺',3,'2026-09-11T11:51:32.585Z',NULL);
INSERT INTO art_submission_files VALUES('66bc6579-ef7c-486d-aa97-ac61c7c1451f','ep1-v3-s1-heroine-wardrobe','d1:66bc6579-ef7c-486d-aa97-ac61c7c1451f','0c813fa85480efcab802842d3e4a2082.jpg','image/jpeg',145391,'玉冰',1,'2026-09-14T05:34:41.705Z',NULL);
INSERT INTO art_submission_files VALUES('94d97cf1-e4b2-4809-aca6-376ed79d5177','ep1-v3-s1-heroine-wardrobe','d1:94d97cf1-e4b2-4809-aca6-376ed79d5177','5eb11628a9267d18545909fae4843fdf.jpg','image/jpeg',81283,'玉冰',2,'2026-09-14T05:34:44.133Z',NULL);
INSERT INTO art_submission_files VALUES('78991d4a-07ca-4ecc-85d3-3da238223c29','ep1-v3-s1-heroine-wardrobe','d1:78991d4a-07ca-4ecc-85d3-3da238223c29','89234c34ce1ecd3cebc19a265772dd53.jpg','image/jpeg',142602,'玉冰',3,'2026-09-14T05:34:46.392Z',NULL);
INSERT INTO art_submission_files VALUES('48178c8c-6d41-4963-bcd3-804ff865fafd','ep1-v3-s1-heroine-wardrobe','d1:48178c8c-6d41-4963-bcd3-804ff865fafd','a36995e93f74cc5aab3e572f59698a97.jpg','image/jpeg',91779,'玉冰',4,'2026-09-14T05:34:48.341Z',NULL);
INSERT INTO art_submission_files VALUES('ec1a0394-0b80-4293-b0a7-af9fee8223c1','ep1-v3-s1-heroine-wardrobe','d1:ec1a0394-0b80-4293-b0a7-af9fee8223c1','e00ec71d56da89f16455b1eeb6a02848.jpg','image/jpeg',131324,'玉冰',5,'2026-09-14T05:34:50.630Z',NULL);
INSERT INTO art_submission_files VALUES('e4a964cc-629e-4641-bd89-192485c7a05f','ep1-v3-s6-auto-9','d1:e4a964cc-629e-4641-bd89-192485c7a05f','图片 - 2026-09-10T174138.885-web.jpg','image/jpeg',223154,'王承恺',1,'2026-09-14T05:41:23.314Z',NULL);
INSERT INTO art_submission_files VALUES('50e489a6-665a-4e24-ae46-b19f1d000618','ep1-v3-s1-overall-cast','d1:50e489a6-665a-4e24-ae46-b19f1d000618','图片 - 2026-09-14T131555.437.jpg','image/jpeg',682581,'王承恺',1,'2026-09-14T05:45:08.494Z',NULL);
INSERT INTO art_submission_files VALUES('b239780a-45ef-4ec8-8515-7b0dd114b4d5','ep1-v3-s1-overall-cast','d1:b239780a-45ef-4ec8-8515-7b0dd114b4d5','图片 - 2026-09-14T132026.982.jpg','image/jpeg',677191,'王承恺',2,'2026-09-14T05:45:33.810Z',NULL);
INSERT INTO art_submission_files VALUES('aae49962-5e18-4228-871d-8fb448f5c20e','ep1-v3-s1-overall-cast','d1:aae49962-5e18-4228-871d-8fb448f5c20e','图片 - 2026-09-14T131746.495.jpg','image/jpeg',627828,'王承恺',3,'2026-09-14T05:48:09.129Z',NULL);
INSERT INTO art_submission_files VALUES('75373a3e-bc9b-4c8d-b73c-b2265c1ee70b','ep1-v3-s1-auto-7','d1:75373a3e-bc9b-4c8d-b73c-b2265c1ee70b','图片 - 2026-09-12T193423.622.jpg','image/jpeg',639042,'王承恺',4,'2026-09-14T05:49:49.072Z',NULL);
INSERT INTO art_submission_files VALUES('55102b50-b512-47b9-9056-e476071822cb','ep1-v3-s1-heroine-wardrobe','d1:55102b50-b512-47b9-9056-e476071822cb','IMG_0500.JPG','image/jpeg',629176,'罗新姗',6,'2026-09-14T05:51:16.824Z',NULL);
INSERT INTO art_submission_files VALUES('72c5724c-63c5-493c-81d7-07b0ab88fd22','ep1-v3-s1-heroine-wardrobe','d1:72c5724c-63c5-493c-81d7-07b0ab88fd22','IMG_0499.JPG','image/jpeg',643147,'罗新姗',7,'2026-09-14T05:51:19.194Z',NULL);
INSERT INTO art_submission_files VALUES('db1b1e4f-b0eb-4976-aa75-46bb2899b6db','ep1-v3-s1-heroine-wardrobe','d1:db1b1e4f-b0eb-4976-aa75-46bb2899b6db','IMG_0498.jpg','image/jpeg',136905,'罗新姗',8,'2026-09-14T05:51:21.325Z',NULL);
INSERT INTO art_submission_files VALUES('c2083cf0-c800-4894-8ed7-a6c80fc2a121','ep1-v3-s1-heroine-wardrobe','d1:c2083cf0-c800-4894-8ed7-a6c80fc2a121','IMG_0497.jpg','image/jpeg',385064,'罗新姗',9,'2026-09-14T05:51:23.027Z',NULL);
INSERT INTO art_submission_files VALUES('bdee9268-700a-403a-a48f-7226f9c802c5','ep1-v3-s1-heroine-wardrobe','d1:bdee9268-700a-403a-a48f-7226f9c802c5','IMG_0495-web.jpg','image/jpeg',310804,'罗新姗',10,'2026-09-14T05:51:25.200Z',NULL);
INSERT INTO art_submission_files VALUES('0d18421a-2a5e-4d88-89c4-a6eb985cd0bd','ep1-v3-s1-heroine-wardrobe','d1:0d18421a-2a5e-4d88-89c4-a6eb985cd0bd','IMG_0494-web.jpg','image/jpeg',317453,'罗新姗',11,'2026-09-14T05:51:27.216Z',NULL);
INSERT INTO art_submission_files VALUES('b5eb5594-6b0b-4123-87a0-7173d41feb5d','ep1-v3-s5-hero-wardrobe','d1:b5eb5594-6b0b-4123-87a0-7173d41feb5d','7871eed29fc0557369ef0845bca4b547.jpg','image/jpeg',230315,'玉冰',1,'2026-09-14T05:57:19.358Z',NULL);
INSERT INTO art_submission_files VALUES('e7c24f0b-f710-4e9e-84aa-cb79446f9f56','ep1-v3-s5-hero-wardrobe','d1:e7c24f0b-f710-4e9e-84aa-cb79446f9f56','c8d6f05b5a1850c07b3cd3667d78e86c.jpg','image/jpeg',304692,'玉冰',2,'2026-09-14T05:57:22.268Z',NULL);
INSERT INTO art_submission_files VALUES('71f8271f-694e-416b-9985-6e39deac28b0','ep1-v3-s1-overall-cast','d1:71f8271f-694e-416b-9985-6e39deac28b0','图片 - 2026-09-14T140227.702.jpg','image/jpeg',629847,'王承恺',1,'2026-09-14T06:03:12.659Z',NULL);
INSERT INTO art_submission_files VALUES('8450096b-3cfc-4ed8-aeac-25f5be456030','ep1-v3-s1-overall-cast','d1:8450096b-3cfc-4ed8-aeac-25f5be456030','图片 - 2026-09-14T140044.487.jpg','image/jpeg',617199,'王承恺',1,'2026-09-14T06:03:20.769Z',NULL);
INSERT INTO art_submission_files VALUES('71e8b32e-c3ae-476e-8d22-27f2905f5615','ep1-v3-s1-overall-cast','d1:71e8b32e-c3ae-476e-8d22-27f2905f5615','图片 - 2026-09-14T135926.626.jpg','image/jpeg',649124,'王承恺',2,'2026-09-14T06:03:34.272Z',NULL);
INSERT INTO art_submission_files VALUES('82bc2b56-cbe2-4cca-8ce4-8be099892cba','ep1-v3-s1-overall-cast','d1:82bc2b56-cbe2-4cca-8ce4-8be099892cba','图片 - 2026-09-14T140115.174.jpg','image/jpeg',631636,'王承恺',2,'2026-09-14T06:05:32.458Z',NULL);
INSERT INTO art_submission_files VALUES('5d1856da-34c3-4c11-9c8b-136e3050acef','ep1-v3-s5-auto-7','d1:5d1856da-34c3-4c11-9c8b-136e3050acef','IMG_0507.JPG','image/jpeg',310617,'罗新姗',1,'2026-09-14T06:09:16.278Z',NULL);
INSERT INTO art_submission_files VALUES('6dbd33f9-6868-4832-a799-2c8351b9da13','ep1-v3-s5-auto-7','d1:6dbd33f9-6868-4832-a799-2c8351b9da13','IMG_0506.JPG','image/jpeg',1050041,'罗新姗',2,'2026-09-14T06:09:18.797Z',NULL);
INSERT INTO art_submission_files VALUES('6cb351c9-942e-4748-87bf-ee103f18ef8a','ep1-v3-s5-auto-7','d1:6cb351c9-942e-4748-87bf-ee103f18ef8a','28cb3986d21dacb5ac8f3d660d1bb331.jpg','image/jpeg',133591,'玉冰',3,'2026-09-14T06:09:20.218Z',NULL);
INSERT INTO art_submission_files VALUES('182ad487-9f33-4b2c-80df-4d4e1ba1269f','ep1-v3-s5-auto-7','d1:182ad487-9f33-4b2c-80df-4d4e1ba1269f','IMG_0505.JPG','image/jpeg',1119747,'罗新姗',4,'2026-09-14T06:09:21.329Z',NULL);
INSERT INTO art_submission_files VALUES('0b8db1cf-560d-4380-95a2-ce637d1cea47','ep1-v3-s5-auto-7','d1:0b8db1cf-560d-4380-95a2-ce637d1cea47','85a3671004a61724de177288cb5041e6.jpg','image/jpeg',142210,'玉冰',5,'2026-09-14T06:09:23.022Z',NULL);
INSERT INTO art_submission_files VALUES('ee1de1e2-8b75-41e9-8775-e16bed271876','ep1-v3-s5-auto-7','d1:ee1de1e2-8b75-41e9-8775-e16bed271876','IMG_0504.JPG','image/jpeg',144792,'罗新姗',5,'2026-09-14T06:09:23.792Z',NULL);
INSERT INTO art_submission_files VALUES('83563063-2c3e-48d0-b1aa-b7cf0f922a3b','ep1-v3-s5-auto-7','d1:83563063-2c3e-48d0-b1aa-b7cf0f922a3b','c88124b172e72cc1fff259b0af64b43c.jpg','image/jpeg',189903,'玉冰',6,'2026-09-14T06:09:25.620Z',NULL);
INSERT INTO art_submission_files VALUES('58f8082d-06a6-4488-a723-a88a8ed1925b','ep1-v3-s5-auto-7','d1:58f8082d-06a6-4488-a723-a88a8ed1925b','1aece3bb68dd2f9950a402b548ae64b2.jpg','image/jpeg',210515,'玉冰',7,'2026-09-14T06:09:40.431Z',NULL);
INSERT INTO art_submission_files VALUES('dfa8522b-33e7-4578-b0f6-694d29ba8106','ep1-v3-s5-auto-7','d1:dfa8522b-33e7-4578-b0f6-694d29ba8106','64721185ba4e059022764bc6d9aceb00.jpg','image/jpeg',219681,'玉冰',8,'2026-09-14T06:09:42.963Z',NULL);
INSERT INTO art_submission_files VALUES('17c10d75-7b36-4309-b972-1a4fee9edc8f','ep1-v3-s5-auto-7','d1:17c10d75-7b36-4309-b972-1a4fee9edc8f','38031c83a5a5f22c5e75bc72cc403410.jpg','image/jpeg',158959,'玉冰',9,'2026-09-14T06:09:45.457Z',NULL);
INSERT INTO art_submission_files VALUES('228a0145-722b-4011-923e-0583b90028c1','ep1-v3-s5-auto-7','d1:228a0145-722b-4011-923e-0583b90028c1','16f85cdea6400ab45679d2ac1e1bfeb4.jpg','image/jpeg',177241,'玉冰',10,'2026-09-14T06:10:35.671Z',NULL);
INSERT INTO art_submission_files VALUES('db6531be-718d-4359-a91f-5b6a1633cc99','ep1-v3-s5-auto-7','d1:db6531be-718d-4359-a91f-5b6a1633cc99','b17c5bfbf860a97f29d2de9d617d3fca.jpg','image/jpeg',176454,'玉冰',11,'2026-09-14T06:10:39.290Z',NULL);
INSERT INTO art_submission_files VALUES('8f3acbff-28ed-406e-866b-e74f0de7f348','ep1-v3-s5-auto-7','d1:8f3acbff-28ed-406e-866b-e74f0de7f348','79cf0582b6f793ca4c668c57605b03e5.jpg','image/jpeg',208426,'玉冰',12,'2026-09-14T06:10:50.691Z',NULL);
INSERT INTO art_submission_files VALUES('fcb322ab-867a-44fa-a103-60a17666d36b','ep1-v3-s5-auto-7','d1:fcb322ab-867a-44fa-a103-60a17666d36b','b0a0b97315a5cad66e3fd87f4b2a3892.jpg','image/jpeg',153709,'玉冰',13,'2026-09-14T06:10:58.035Z',NULL);
INSERT INTO art_submission_files VALUES('3a37a9ca-ce51-4105-9409-13c3b692a406','ep1-v3-s5-auto-7','d1:3a37a9ca-ce51-4105-9409-13c3b692a406','4e7c8e1b5191b90560b6f8ef1110afb2.jpg','image/jpeg',124761,'玉冰',14,'2026-09-14T06:12:25.439Z',NULL);
INSERT INTO art_submission_files VALUES('f0f2a575-e7be-4591-b450-2bbc8e642f80','ep1-v3-s5-auto-7','d1:f0f2a575-e7be-4591-b450-2bbc8e642f80','20318d68479db6282d56c143b07555f6.jpg','image/jpeg',184963,'玉冰',15,'2026-09-14T06:12:29.606Z',NULL);
INSERT INTO art_submission_files VALUES('76e7788f-74a7-4162-bb73-fd9495c2d7d8','ep1-v3-s5-auto-7','d1:76e7788f-74a7-4162-bb73-fd9495c2d7d8','d92d086c7c2e67531205cf4fa5caf306.jpg','image/jpeg',184249,'玉冰',16,'2026-09-14T06:12:35.899Z',NULL);
INSERT INTO art_submission_files VALUES('9d080b36-1e7c-456b-9578-99bb59ed4482','ep1-v3-s5-auto-7','d1:9d080b36-1e7c-456b-9578-99bb59ed4482','bbd3e3a7fd4732cd7e23be5aa7f10364.jpg','image/jpeg',125195,'玉冰',17,'2026-09-14T06:12:59.712Z',NULL);
INSERT INTO art_submission_files VALUES('6ec855e3-79b7-40ee-ae4b-bacb9acfd047','ep1-v3-s5-auto-7','d1:6ec855e3-79b7-40ee-ae4b-bacb9acfd047','4526eb5e228e8addf0957f5e35814a76.jpg','image/jpeg',114445,'玉冰',18,'2026-09-14T06:13:02.451Z',NULL);
INSERT INTO art_submission_files VALUES('f64448e5-6b00-4703-b8e6-ecfbd842497e','ep1-v3-s1-overall-cast','d1:f64448e5-6b00-4703-b8e6-ecfbd842497e','图片 - 2026-09-14T142156.710.jpg','image/jpeg',663138,'王承恺',1,'2026-09-14T06:22:16.713Z',NULL);
INSERT INTO art_submission_files VALUES('33885290-7473-4638-8e81-311921c4b9e0','ep1-v3-s5-hero-wardrobe','d1:33885290-7473-4638-8e81-311921c4b9e0','IMG_0511.jpg','image/jpeg',101217,'罗新姗',3,'2026-09-14T06:22:21.371Z',NULL);
INSERT INTO art_submission_files VALUES('c77d0282-e97c-4f7d-b9d3-1e849fb3b08c','ep1-v3-s5-hero-wardrobe','d1:c77d0282-e97c-4f7d-b9d3-1e849fb3b08c','IMG_0510.jpg','image/jpeg',160081,'罗新姗',4,'2026-09-14T06:22:23.455Z',NULL);
INSERT INTO art_submission_files VALUES('f004c2f6-313f-4037-80ce-d1377b4a45b7','ep1-v3-s1-overall-cast','d1:f004c2f6-313f-4037-80ce-d1377b4a45b7','图片 - 2026-09-14T143054.419.jpg','image/jpeg',641942,'王承恺',2,'2026-09-14T06:31:12.659Z',NULL);
INSERT INTO art_submission_files VALUES('6b48a2d2-4c9a-431d-adf0-bb278bfc55ef','ep1-v3-s1-auto-20','d1:6b48a2d2-4c9a-431d-adf0-bb278bfc55ef','图片 - 2026-09-14T143134.745.jpg','image/jpeg',790014,'王承恺',1,'2026-09-14T06:31:50.647Z',NULL);
INSERT INTO art_submission_files VALUES('56b4c63d-3e53-45ba-8cd8-9d0ffaf3ce48','ep1-v3-s1-heroine-wardrobe','d1:56b4c63d-3e53-45ba-8cd8-9d0ffaf3ce48','IMG_0512-web.jpg','image/jpeg',452647,'罗新姗',3,'2026-09-14T06:32:03.873Z',NULL);
INSERT INTO art_submission_files VALUES('b788eeb8-6ec6-4e51-8911-b1cb99ad2323','ep1-v3-s1-auto-20','d1:b788eeb8-6ec6-4e51-8911-b1cb99ad2323','图片 - 2026-09-14T144306.507.jpg','image/jpeg',811399,'王承恺',2,'2026-09-14T06:43:49.875Z',NULL);
INSERT INTO art_submission_files VALUES('43bebf5d-bfc6-4881-b306-df81757aba76','ep1-v3-s2-auto-4','d1:43bebf5d-bfc6-4881-b306-df81757aba76','图片 - 2026-09-10T143809.164-web.jpg','image/jpeg',203741,'王承恺',1,'2026-09-14T06:47:22.416Z',NULL);
INSERT INTO art_submission_files VALUES('81d9d08b-f5a2-452f-8e88-ac14397509dc','ep1-v3-s1-heroine-wardrobe','d1:81d9d08b-f5a2-452f-8e88-ac14397509dc','3FXl29iRGihq0Rg2wl-0EqW6M0UxL1A5rMa819ghIFHt0po9Ma9L8xOnPKH18E-kDuEp-PhrJflHuaNyYO4bKDnwIQkEr49pDqHyB_UNhiCGZVtpLjpRiB7muaBZr532Fs2xkwA0pwx0tiJi2qRu7k3WOkyNK_EGn4xoRXbEuDS2axhxG8Q6','image/jpeg',122878,'胖胖',12,'2026-09-14T06:50:56.479Z',NULL);
INSERT INTO art_submission_files VALUES('78676931-85e0-4121-87fa-22e394328aa3','ep1-v3-s1-heroine-wardrobe','d1:78676931-85e0-4121-87fa-22e394328aa3','DP329151-web.jpg','image/jpeg',166154,'胖胖',16,'2026-09-14T06:51:01.493Z',NULL);
INSERT INTO art_submission_files VALUES('66604019-6c7a-44bb-90b2-f6791ce31252','ep1-v3-s1-heroine-wardrobe','d1:66604019-6c7a-44bb-90b2-f6791ce31252','gc3CRefyAYioNJort_cJ_tZRfeyV0ISKRr5FwLBbcegZcw8Drjs5l2kYkoguXc27_TtWZku8PSGMmOk3Y3esbkb8p2SfFSRbDNpEfYj5Vnd-BfuoJZ026UNy3pITj2yEKFcdDM0jExWDFvBo4TsJ9vfTvrpQwHgEK7spr0KCd6gyozgmdRD8','image/jpeg',99134,'胖胖',22,'2026-09-14T06:51:08.604Z',NULL);
INSERT INTO art_submission_files VALUES('c915aeda-87f9-4a40-9bc1-24a60234ded4','ep1-v3-s1-heroine-wardrobe','d1:c915aeda-87f9-4a40-9bc1-24a60234ded4','h3VJiQWSoP6bcWmeGkNSCNWIZiTaG3a-pLnHAdTHCZQuvDalsfYQd9jQSxM8ir5ERWVq8kttaCzsYn_T0hOStOoqiSHvlNJDf2iRvSXyfcrwQkRgmDI63p_OP9xYxWHojrb0SGF0XlbjRswnGO3xWo0vy20U1vegfqt30ujMW8XD95iyjyla','image/jpeg',166358,'胖胖',23,'2026-09-14T06:51:10.594Z',NULL);
INSERT INTO art_submission_files VALUES('f7fdee75-bd50-480d-9820-43c780b8a716','ep1-v3-s1-heroine-wardrobe','d1:f7fdee75-bd50-480d-9820-43c780b8a716','GGrD3BiHCdP3TBZJEaqyw9ECSHTME9RdnK4qUxTAPTJYzpXsqYnfvvSvb6gRKOVMVTsLvIKrgpdvk4l_7KQ1zkW6J6Xr330RFSowxI3frcTYpvJhzjPhtImYXQoLjMTot9k6iSjZBDs9di4ZhX7QLq98oGYFa9T2sfr6ku9D1Q-8uJ-r8uyW','image/jpeg',185757,'胖胖',23,'2026-09-14T06:51:10.554Z',NULL);
INSERT INTO art_submission_files VALUES('124174a0-d627-4f77-83e9-a7ad4ad7f1db','ep1-v3-s1-heroine-wardrobe','d1:124174a0-d627-4f77-83e9-a7ad4ad7f1db','L6zzgdcxfvRGbHLQyjyQOy_sqvqzkryHIhFu2Uhip4tZ5o96rJMcLbRtWZPHLzFvh5zVw38NpaZW-9sIZmUChob20dUIIeYrLSnHNbIcijFCshzF1SW9DhrbeszHN0QyQ-U4ptsEldE-9Wi4kMXqDVcYNsRf30nOGCnyk6776sOXMpcINfop','image/jpeg',116060,'胖胖',26,'2026-09-14T06:51:17.873Z',NULL);
INSERT INTO art_submission_files VALUES('5d85cd42-8d03-4361-b8c2-aa0c76b72efc','ep1-v3-s1-heroine-wardrobe','d1:5d85cd42-8d03-4361-b8c2-aa0c76b72efc','lKHCXThffZNoCJ9KvB6v9j8OxHFJSdJPvjjB3W1MfiAwRBOtEpesQOAq8H-SednqAqb78UF4d5n2zE8IWE6dLH2pk19vUXJb9JVhMkH9i_mXCdhfa8lXZOsUZ41iZq-z3w8Bo1TYmb37LTDxHujtzeFqVGHJB5gW7RwyX-V2rzPzG9d2FZU_','image/jpeg',116169,'胖胖',27,'2026-09-14T06:51:19.610Z',NULL);
INSERT INTO art_submission_files VALUES('39d63a15-2ed2-4301-aea1-69695a6274f8','ep1-v3-s1-heroine-wardrobe','d1:39d63a15-2ed2-4301-aea1-69695a6274f8','MUmtaFheaqa-zL2yA8fUXwCWRuDmRTU2tMwvKvfBtaPfO0pOOJgf8d0yYMWxSCs1i2ZttO6QnRCp3LUrP57GZOw2Qv19WO-npHikqlkVbNtjKPvDf-gUdZTOWsQh1-ocsWKFU1gKQphPIpqqcpUcstGt4p3BQdZrQAzGHr4VBVYjQRHgbPXn','image/jpeg',84172,'胖胖',27,'2026-09-14T06:51:19.611Z',NULL);
INSERT INTO art_submission_files VALUES('2a05b8ba-1752-4fce-be52-e51d3ff46f33','ep1-v3-s1-heroine-wardrobe','d1:2a05b8ba-1752-4fce-be52-e51d3ff46f33','lDwPZNx2ySF8bgaW7NAqpxTWD7tgSUy336-PCAC9OcjwY1gdffz89RN9yrLkQeACZLAeTy2sXAOpEEqsISJALHts18GaOzs-_9snazTyQW7kKCCU4bCeUarFlAoi7jvPWrtT1jTtdVq60TJ5hRaydph2H8VALG6E6cwXrR4XpT8N2tAc9n1i','image/jpeg',761993,'胖胖',28,'2026-09-14T06:51:20.705Z',NULL);
INSERT INTO art_submission_files VALUES('9e7c2bbf-e656-4e25-9268-4500dc7fc0f2','ep1-v3-s1-heroine-wardrobe','d1:9e7c2bbf-e656-4e25-9268-4500dc7fc0f2','nxEsD9pQ-5FEHrjIcR-V_Ql7JP_aG50YOKBWwc5jFuEtq1j3pNhenxpSXZ61H8rYd1930Y1LnRzExRVumawzjeq9dNZNYnUh66KtHdZPoO8p-wOYaHfPgTchyMX-Zn01BtlERi505sjTnxXZb5kDwvTtE30-1nPPXKZ-1D9cg0hC7y9tzVEI','image/jpeg',269098,'胖胖',29,'2026-09-14T06:51:22.875Z',NULL);
INSERT INTO art_submission_files VALUES('64f84f63-bded-4652-8767-36fa6e40190f','ep1-v3-s1-heroine-wardrobe','d1:64f84f63-bded-4652-8767-36fa6e40190f','sKp52dlO-GkJ9p4APYnpRk9uS5KJDDeH8T5ItIxRwzVZPg4PaItdiiCYtg0cJlU57PSQLapNl3Re4GWBaohLWTXJTh0RWL-HKAmmPCbwO6AZwcGG60SF01ziZ2cP7_4vu5ElPkJN2xdTse8IToWjyEVEaGE4aVcy7AqqwgGhHVxq9eJ9rBrP','image/jpeg',54310,'胖胖',33,'2026-09-14T06:51:28.228Z',NULL);
INSERT INTO art_submission_files VALUES('978d2eae-7391-48fd-90eb-774d237e1821','ep1-v3-s1-heroine-wardrobe','d1:978d2eae-7391-48fd-90eb-774d237e1821','UpgfK781YxJoZzqFOunv5qNB-Lmd5UDFRp71DamrZyRg3ATlsPfiTkyt-sRWJtvfbcNCfEW0H4-CrxbuyXzh9azn9QpBZWIvcoJijEmc9GhrQO8MWtXgUO7v1gD8pVACBmiTplda6qemMkSHfoUl9Zn8qJK17oA5i8m92j3RUEynZ_F4W56O','image/jpeg',95861,'胖胖',35,'2026-09-14T06:51:29.941Z',NULL);
INSERT INTO art_submission_files VALUES('636f94f7-a1ad-4f41-b229-236366d97749','ep1-v3-s1-heroine-wardrobe','d1:636f94f7-a1ad-4f41-b229-236366d97749','Whzb-CShAB4a6JaLGDIYN8EcH_NLMMXQHfppewxrsxiB4tPWjUYhCOfdijo6GSuG5F02ofnbfytu5K71PRIzvg06Hx8V_eSN7neUIYDVJtUOzXSldYnzamYQV6LXFqTMoxnpZyq7e48nlz3TiSEGZuhU-6TymJH3Yc4e8C6UkcwJx3UygKm4','image/jpeg',187346,'胖胖',37,'2026-09-14T06:51:32.005Z',NULL);
INSERT INTO art_submission_files VALUES('aa575347-de1d-4f6c-afe2-b7d73c4d08a0','ep1-v3-s1-heroine-wardrobe','d1:aa575347-de1d-4f6c-afe2-b7d73c4d08a0','wKzh4SRsyrNHjP18bv5DDWvtuQoPWEMowiStNQSKmrt8cd-D8sNZ_HTEsG10PKDERqgiZfYNcOpQae-iEXRA7BzC5GVfG_XjoFsRcdFnvRPxbE0aql8xkXEkU10ac_8aPDnoI-zfTUAaBE7EPePf1qbawRJBaZULfhJWimMCSwU_iX51RB6P','image/jpeg',101322,'胖胖',38,'2026-09-14T06:51:34.093Z',NULL);
INSERT INTO art_submission_files VALUES('8c5656b7-bbcc-4eb1-8b2a-b659e57f2763','ep1-v3-s1-heroine-wardrobe','d1:8c5656b7-bbcc-4eb1-8b2a-b659e57f2763','微信图片_20260914144522_2005_22.jpg','image/jpeg',63734,'胖胖',42,'2026-09-14T06:51:38.586Z',NULL);
INSERT INTO art_submission_files VALUES('bbbbb0f6-7506-4a29-b411-f48d02face5e','ep1-v3-s1-heroine-wardrobe','d1:bbbbb0f6-7506-4a29-b411-f48d02face5e','微信图片_20260914144522_2006_22.jpg','image/jpeg',113657,'胖胖',43,'2026-09-14T06:51:39.513Z',NULL);
INSERT INTO art_submission_files VALUES('a689d2a3-ffa9-4a1b-9ce1-d49bf1637677','ep1-v3-s1-heroine-wardrobe','d1:a689d2a3-ffa9-4a1b-9ce1-d49bf1637677','微信图片_20260914144522_2007_22.jpg','image/jpeg',102201,'胖胖',43,'2026-09-14T06:51:39.545Z',NULL);
INSERT INTO art_submission_files VALUES('ceee1bb2-bf4a-4fa7-a205-41e7a09187cb','ep1-v3-s1-heroine-wardrobe','d1:ceee1bb2-bf4a-4fa7-a205-41e7a09187cb','微信图片_20260914144522_2008_22.jpg','image/jpeg',65841,'胖胖',44,'2026-09-14T06:51:42.841Z',NULL);
INSERT INTO art_submission_files VALUES('4706554b-772d-462d-9f70-1495e52a4741','ep1-v3-s1-heroine-wardrobe','d1:4706554b-772d-462d-9f70-1495e52a4741','微信图片_20260914144522_2009_22.jpg','image/jpeg',70315,'胖胖',45,'2026-09-14T06:51:43.691Z',NULL);
INSERT INTO art_submission_files VALUES('fb3ad5da-7484-490f-9222-c4711c745dc4','ep1-v3-s1-heroine-wardrobe','d1:fb3ad5da-7484-490f-9222-c4711c745dc4','微信图片_20260914144522_2010_22.jpg','image/jpeg',118717,'胖胖',45,'2026-09-14T06:51:43.729Z',NULL);
INSERT INTO art_submission_files VALUES('232f38f6-b07c-4cc2-8879-f2e6c6735238','ep1-v3-s1-heroine-wardrobe','d1:232f38f6-b07c-4cc2-8879-f2e6c6735238','微信图片_20260914144522_2011_22.jpg','image/jpeg',66190,'胖胖',46,'2026-09-14T06:51:44.943Z',NULL);
INSERT INTO art_submission_files VALUES('bac0881e-9426-4e0c-a51d-22e5c0fc06a4','ep1-v3-s1-heroine-wardrobe','d1:bac0881e-9426-4e0c-a51d-22e5c0fc06a4','微信图片_20260914144522_2012_22.jpg','image/jpeg',73530,'胖胖',46,'2026-09-14T06:51:45.219Z',NULL);
INSERT INTO art_submission_files VALUES('bdbb3a8d-8972-45cc-b09d-240750006353','ep1-v3-s1-heroine-wardrobe','d1:bdbb3a8d-8972-45cc-b09d-240750006353','微信图片_20260914144522_2013_22.jpg','image/jpeg',243703,'胖胖',47,'2026-09-14T06:51:46.020Z',NULL);
INSERT INTO art_submission_files VALUES('9e3fb7fb-e777-45db-9359-c5ef010ff3f6','ep1-v3-s1-heroine-wardrobe','d1:9e3fb7fb-e777-45db-9359-c5ef010ff3f6','微信图片_20260914144522_2015_22.jpg','image/jpeg',270143,'胖胖',48,'2026-09-14T06:51:46.915Z',NULL);
INSERT INTO art_submission_files VALUES('d6b756dc-d516-44dd-b02c-030dccf0685d','ep1-v3-s1-heroine-wardrobe','d1:d6b756dc-d516-44dd-b02c-030dccf0685d','微信图片_20260914144522_2014_22.jpg','image/jpeg',310967,'胖胖',48,'2026-09-14T06:51:46.902Z',NULL);
INSERT INTO art_submission_files VALUES('d0902c5e-8877-477b-af40-764d692256b5','ep1-v3-s1-heroine-wardrobe','d1:d0902c5e-8877-477b-af40-764d692256b5','微信图片_20260914144522_2016_22.jpg','image/jpeg',232155,'胖胖',49,'2026-09-14T06:51:48.264Z',NULL);
INSERT INTO art_submission_files VALUES('1f8d2c29-aaba-49a7-a4c0-63bf3ae0a9b9','ep1-v3-s1-heroine-wardrobe','d1:1f8d2c29-aaba-49a7-a4c0-63bf3ae0a9b9','微信图片_20260914144522_2018_22.jpg','image/jpeg',169540,'胖胖',50,'2026-09-14T06:51:49.337Z',NULL);
INSERT INTO art_submission_files VALUES('488f4f4a-6818-4c73-859e-788685b9cab7','ep1-v3-s1-heroine-wardrobe','d1:488f4f4a-6818-4c73-859e-788685b9cab7','微信图片_20260914144522_2017_22.jpg','image/jpeg',209589,'胖胖',50,'2026-09-14T06:51:49.500Z',NULL);
INSERT INTO art_submission_files VALUES('1b9688b0-19c2-4452-bec6-3afbe5bb6cda','ep1-v3-s1-heroine-wardrobe','d1:1b9688b0-19c2-4452-bec6-3afbe5bb6cda','微信图片_20260914144522_2021_22.jpg','image/jpeg',192891,'胖胖',52,'2026-09-14T06:51:52.251Z',NULL);
INSERT INTO art_submission_files VALUES('c7d093ef-5ea2-4a75-ae8e-dd33f06af732','ep1-v3-s1-heroine-wardrobe','d1:c7d093ef-5ea2-4a75-ae8e-dd33f06af732','微信图片_20260914144522_2020_22.jpg','image/jpeg',284935,'胖胖',53,'2026-09-14T06:51:53.670Z',NULL);
INSERT INTO art_submission_files VALUES('f786439e-b0e4-4682-88aa-92de57eddae2','ep1-v3-s1-heroine-wardrobe','d1:f786439e-b0e4-4682-88aa-92de57eddae2','微信图片_20260914144522_2022_22.jpg','image/jpeg',74302,'胖胖',53,'2026-09-14T06:51:53.976Z',NULL);
INSERT INTO art_submission_files VALUES('a14cf2ca-e57f-4997-9c3c-109d72c8a380','ep1-v3-s1-heroine-wardrobe','d1:a14cf2ca-e57f-4997-9c3c-109d72c8a380','微信图片_20260914144522_2023_22.jpg','image/jpeg',68898,'胖胖',53,'2026-09-14T06:51:53.967Z',NULL);
INSERT INTO art_submission_files VALUES('6b88ae5a-1d2b-4a55-8d19-c565f9348acd','ep1-v3-s1-heroine-wardrobe','d1:6b88ae5a-1d2b-4a55-8d19-c565f9348acd','微信图片_20260914144522_2024_22.jpg','image/jpeg',85027,'胖胖',54,'2026-09-14T06:51:55.465Z',NULL);
INSERT INTO art_submission_files VALUES('8bb9f69a-7643-47b3-998a-929319b91da8','ep1-v3-s1-heroine-wardrobe','d1:8bb9f69a-7643-47b3-998a-929319b91da8','微信图片_20260914144522_2028_22.jpg','image/jpeg',318248,'胖胖',57,'2026-09-14T06:51:59.812Z',NULL);
INSERT INTO art_submission_files VALUES('f4669b8c-bceb-47e8-bd78-6c18d756caaf','ep1-v3-s1-heroine-wardrobe','d1:f4669b8c-bceb-47e8-bd78-6c18d756caaf','微信图片_20260914144522_2037_22.jpg','image/jpeg',109546,'胖胖',62,'2026-09-14T06:52:10.389Z',NULL);
INSERT INTO art_submission_files VALUES('102f9bd1-c456-4642-a928-4f296cd423fe','ep1-v3-s1-heroine-wardrobe','d1:102f9bd1-c456-4642-a928-4f296cd423fe','微信图片_20260914144522_2039_22.jpg','image/jpeg',164031,'胖胖',62,'2026-09-14T06:52:10.574Z',NULL);
INSERT INTO art_submission_files VALUES('e1d64053-8d7a-4e0d-a8f9-0f10328fad78','ep1-v3-s1-heroine-wardrobe','d1:e1d64053-8d7a-4e0d-a8f9-0f10328fad78','微信图片_20260914144522_2040_22.jpg','image/jpeg',148642,'胖胖',63,'2026-09-14T06:52:13.342Z',NULL);
INSERT INTO art_submission_files VALUES('7e759486-2bc8-4b80-afea-14c4bd284fcc','ep1-v3-s1-heroine-wardrobe','d1:7e759486-2bc8-4b80-afea-14c4bd284fcc','微信图片_20260914144522_2042_22.jpg','image/jpeg',124331,'胖胖',63,'2026-09-14T06:52:13.340Z',NULL);
INSERT INTO art_submission_files VALUES('619c49b6-b63c-4116-b1b7-67bd97b4ce5a','ep1-v3-s1-heroine-wardrobe','d1:619c49b6-b63c-4116-b1b7-67bd97b4ce5a','微信图片_20260914144522_2041_22.jpg','image/jpeg',152268,'胖胖',63,'2026-09-14T06:52:13.335Z',NULL);
INSERT INTO art_submission_files VALUES('06a7d8dc-de7e-46e6-b5c3-9ac3d5dc641a','ep1-v3-s1-heroine-wardrobe','d1:06a7d8dc-de7e-46e6-b5c3-9ac3d5dc641a','微信图片_20260914144522_2043_22.jpg','image/jpeg',67913,'胖胖',64,'2026-09-14T06:52:15.326Z',NULL);
INSERT INTO art_submission_files VALUES('c80882ee-2194-47d5-8cc7-6d883c900aff','ep1-v3-s1-heroine-wardrobe','d1:c80882ee-2194-47d5-8cc7-6d883c900aff','微信图片_20260914144522_2045_22.jpg','image/jpeg',136616,'胖胖',64,'2026-09-14T06:52:15.393Z',NULL);
INSERT INTO art_submission_files VALUES('6ce5ab18-5eb1-4c32-bbbf-488ae9e1bf9c','ep1-v3-s1-heroine-wardrobe','d1:6ce5ab18-5eb1-4c32-bbbf-488ae9e1bf9c','微信图片_20260914144522_2046_22.jpg','image/jpeg',129405,'胖胖',66,'2026-09-14T06:52:16.895Z',NULL);
INSERT INTO art_submission_files VALUES('0c7a5c9b-893a-498d-9708-8998a9b3b055','ep1-v3-s1-heroine-wardrobe','d1:0c7a5c9b-893a-498d-9708-8998a9b3b055','微信图片_20260914144522_2049_22.jpg','image/jpeg',154623,'胖胖',67,'2026-09-14T06:52:18.897Z',NULL);
INSERT INTO art_submission_files VALUES('5630e975-b6b7-454b-a875-70be7b386498','ep1-v3-s1-heroine-wardrobe','d1:5630e975-b6b7-454b-a875-70be7b386498','微信图片_20260914144522_2048_22.jpg','image/jpeg',104543,'胖胖',67,'2026-09-14T06:52:18.701Z',NULL);
INSERT INTO art_submission_files VALUES('e7a4750a-96c9-4ec3-b717-ce2601ba5811','ep1-v3-s1-heroine-wardrobe','d1:e7a4750a-96c9-4ec3-b717-ce2601ba5811','微信图片_20260914144522_2050_22.jpg','image/jpeg',218309,'胖胖',68,'2026-09-14T06:52:20.482Z',NULL);
INSERT INTO art_submission_files VALUES('336a9253-bcba-4a8d-bc1c-fe0d3591da3e','ep1-v3-s1-heroine-wardrobe','d1:336a9253-bcba-4a8d-bc1c-fe0d3591da3e','微信图片_20260914144522_2052_22.jpg','image/jpeg',254111,'胖胖',68,'2026-09-14T06:52:20.836Z',NULL);
INSERT INTO art_submission_files VALUES('30fe8a44-1f68-4fe4-84ed-1a5f6e14163f','ep1-v3-s1-heroine-wardrobe','d1:30fe8a44-1f68-4fe4-84ed-1a5f6e14163f','微信图片_20260914144522_2051_22.jpg','image/jpeg',211555,'胖胖',68,'2026-09-14T06:52:20.708Z',NULL);
INSERT INTO art_submission_files VALUES('b55ab793-9918-40dd-add6-319c4e8a10a4','ep1-v3-s1-heroine-wardrobe','d1:b55ab793-9918-40dd-add6-319c4e8a10a4','微信图片_20260914144522_2053_22.jpg','image/jpeg',103194,'胖胖',69,'2026-09-14T06:52:22.114Z',NULL);
INSERT INTO art_submission_files VALUES('18bfdf1c-7ef4-4e14-ba41-506c754fedf1','ep1-v3-s1-heroine-wardrobe','d1:18bfdf1c-7ef4-4e14-ba41-506c754fedf1','微信图片_20260914144522_2055_22.jpg','image/jpeg',175635,'胖胖',69,'2026-09-14T06:52:22.415Z',NULL);
INSERT INTO art_submission_files VALUES('abf30ac7-7116-4767-9252-2f15a2e56054','ep1-v3-s1-heroine-wardrobe','d1:abf30ac7-7116-4767-9252-2f15a2e56054','微信图片_20260914144522_2054_22.jpg','image/jpeg',137574,'胖胖',69,'2026-09-14T06:52:22.387Z',NULL);
INSERT INTO art_submission_files VALUES('dce5fbc8-10db-43f8-964a-b824a23c8e0c','ep1-v3-s1-heroine-wardrobe','d1:dce5fbc8-10db-43f8-964a-b824a23c8e0c','微信图片_20260914144522_2056_22.jpg','image/jpeg',289410,'胖胖',70,'2026-09-14T06:52:23.911Z',NULL);
INSERT INTO art_submission_files VALUES('b4d21e02-5c41-4b01-808c-b80d4ccfa14e','ep1-v3-s1-heroine-wardrobe','d1:b4d21e02-5c41-4b01-808c-b80d4ccfa14e','微信图片_20260914144522_2057_22.jpg','image/jpeg',300140,'胖胖',70,'2026-09-14T06:52:24.203Z',NULL);
INSERT INTO art_submission_files VALUES('e47a9fb7-42bb-47cd-bbaa-d879c724f4c3','ep1-v3-s1-heroine-wardrobe','d1:e47a9fb7-42bb-47cd-bbaa-d879c724f4c3','微信图片_20260914144522_2058_22.jpg','image/jpeg',340816,'胖胖',71,'2026-09-14T06:52:25.518Z',NULL);
INSERT INTO art_submission_files VALUES('d5209c8f-3be4-4204-a5cc-1a800b0c7563','ep1-v3-s1-heroine-wardrobe','d1:d5209c8f-3be4-4204-a5cc-1a800b0c7563','微信图片_20260914144522_2060_22.jpg','image/jpeg',149422,'胖胖',72,'2026-09-14T06:52:26.123Z',NULL);
INSERT INTO art_submission_files VALUES('4cf816c6-0cc1-4046-8c13-9dfb0b260ced','ep1-v3-s1-heroine-wardrobe','d1:4cf816c6-0cc1-4046-8c13-9dfb0b260ced','微信图片_20260914144522_2059_22.jpg','image/jpeg',152835,'胖胖',71,'2026-09-14T06:52:25.724Z',NULL);
INSERT INTO art_submission_files VALUES('52887c83-e5cf-4be6-8d25-42714699b0d9','ep1-v3-s1-heroine-wardrobe','d1:52887c83-e5cf-4be6-8d25-42714699b0d9','微信图片_20260914144522_2063_22.jpg','image/jpeg',85719,'胖胖',73,'2026-09-14T06:52:27.896Z',NULL);
INSERT INTO art_submission_files VALUES('11072865-e078-4bba-a7a6-79a6a3fc8baa','ep1-v3-s1-heroine-wardrobe','d1:11072865-e078-4bba-a7a6-79a6a3fc8baa','微信图片_20260914144522_2062_22.jpg','image/jpeg',173606,'胖胖',73,'2026-09-14T06:52:27.903Z',NULL);
INSERT INTO art_submission_files VALUES('cea86304-ecc6-40f9-acac-97386298d1b2','ep1-v3-s1-heroine-wardrobe','d1:cea86304-ecc6-40f9-acac-97386298d1b2','微信图片_20260914144522_2061_22.jpg','image/jpeg',298103,'胖胖',73,'2026-09-14T06:52:27.915Z',NULL);
INSERT INTO art_submission_files VALUES('ddfbe91d-f7ca-4e43-bc2e-da26a34071b9','ep1-v3-s1-heroine-wardrobe','d1:ddfbe91d-f7ca-4e43-bc2e-da26a34071b9','微信图片_20260914144522_2064_22.jpg','image/jpeg',107255,'胖胖',74,'2026-09-14T06:52:30.248Z',NULL);
INSERT INTO art_submission_files VALUES('d6f9d003-5a9f-48d4-90df-9b78067270c0','ep1-v3-s1-heroine-wardrobe','d1:d6f9d003-5a9f-48d4-90df-9b78067270c0','微信图片_20260914144522_2065_22.jpg','image/jpeg',231758,'胖胖',75,'2026-09-14T06:52:31.983Z',NULL);
INSERT INTO art_submission_files VALUES('90f40f71-021f-4be0-bd76-658256187c3c','ep1-v3-s1-heroine-wardrobe','d1:90f40f71-021f-4be0-bd76-658256187c3c','微信图片_20260914144522_2066_22.jpg','image/jpeg',221827,'胖胖',75,'2026-09-14T06:52:32.018Z',NULL);
INSERT INTO art_submission_files VALUES('7834c7bd-2ad1-44eb-bd62-aa2c7b77bdc4','ep1-v3-s1-heroine-wardrobe','d1:7834c7bd-2ad1-44eb-bd62-aa2c7b77bdc4','微信图片_20260914144522_2068_22.jpg','image/jpeg',99069,'胖胖',76,'2026-09-14T06:52:33.671Z',NULL);
INSERT INTO art_submission_files VALUES('75010c7c-2e36-4843-a434-0175353fc39e','ep1-v3-s1-heroine-wardrobe','d1:75010c7c-2e36-4843-a434-0175353fc39e','微信图片_20260914144522_2067_22.jpg','image/jpeg',199318,'胖胖',76,'2026-09-14T06:52:33.866Z',NULL);
INSERT INTO art_submission_files VALUES('99a3c05d-9576-44b2-a316-e5be578cee19','ep1-v3-s1-heroine-wardrobe','d1:99a3c05d-9576-44b2-a316-e5be578cee19','微信图片_20260914144522_2069_22.jpg','image/jpeg',353682,'胖胖',77,'2026-09-14T06:52:35.624Z',NULL);
INSERT INTO art_submission_files VALUES('1d82a4b6-6b71-4151-9796-294a0c1d9b86','ep1-v3-s1-heroine-wardrobe','d1:1d82a4b6-6b71-4151-9796-294a0c1d9b86','微信图片_20260914144522_2071_22.jpg','image/jpeg',261022,'胖胖',77,'2026-09-14T06:52:36.314Z',NULL);
INSERT INTO art_submission_files VALUES('08d3ed05-dc9a-4768-9b7c-d1c2317c9493','ep1-v3-s1-heroine-wardrobe','d1:08d3ed05-dc9a-4768-9b7c-d1c2317c9493','微信图片_20260914144522_2070_22.jpg','image/jpeg',323582,'胖胖',77,'2026-09-14T06:52:36.014Z',NULL);
INSERT INTO art_submission_files VALUES('be9c172f-8d0e-4e36-b3bc-e3c60983a058','ep1-v3-s1-heroine-wardrobe','d1:be9c172f-8d0e-4e36-b3bc-e3c60983a058','微信图片_20260914144522_2072_22.jpg','image/jpeg',247896,'胖胖',78,'2026-09-14T06:52:37.822Z',NULL);
INSERT INTO art_submission_files VALUES('82859475-93a8-4d72-8206-61666409f219','ep1-v3-s1-heroine-wardrobe','d1:82859475-93a8-4d72-8206-61666409f219','微信图片_20260914144522_2073_22.jpg','image/jpeg',237673,'胖胖',79,'2026-09-14T06:52:38.678Z',NULL);
INSERT INTO art_submission_files VALUES('32b52ecd-92e9-4d74-ae84-200fd74ecd03','ep1-v3-s1-heroine-wardrobe','d1:32b52ecd-92e9-4d74-ae84-200fd74ecd03','微信图片_20260914144522_2074_22.jpg','image/jpeg',269888,'胖胖',80,'2026-09-14T06:52:40.316Z',NULL);
INSERT INTO art_submission_files VALUES('7d76a4f0-4bf5-4ab6-a61c-1969cfa7e79e','ep1-v3-s1-heroine-wardrobe','d1:7d76a4f0-4bf5-4ab6-a61c-1969cfa7e79e','微信图片_20260914144522_2075_22.jpg','image/jpeg',240831,'胖胖',81,'2026-09-14T06:52:41.294Z',NULL);
INSERT INTO art_submission_files VALUES('0730514c-4dd5-4595-97e0-cb0ae26d6aae','ep1-v3-s1-heroine-wardrobe','d1:0730514c-4dd5-4595-97e0-cb0ae26d6aae','微信图片_20260914144522_2079_22.jpg','image/jpeg',216937,'胖胖',82,'2026-09-14T06:52:43.774Z',NULL);
INSERT INTO art_submission_files VALUES('d4d9449d-8d6f-472b-8470-c88e25bc877b','ep1-v3-s1-heroine-wardrobe','d1:d4d9449d-8d6f-472b-8470-c88e25bc877b','微信图片_20260914144522_2078_22.jpg','image/jpeg',205101,'胖胖',82,'2026-09-14T06:52:43.767Z',NULL);
INSERT INTO art_submission_files VALUES('3078a7ca-aba7-41f2-8057-c967561fe565','ep1-v3-s1-heroine-wardrobe','d1:3078a7ca-aba7-41f2-8057-c967561fe565','微信图片_20260914144522_2081_22.jpg','image/jpeg',126593,'胖胖',83,'2026-09-14T06:52:45.484Z',NULL);
INSERT INTO art_submission_files VALUES('b4bc5eee-37d9-4abb-88ee-996c37bc99be','ep1-v3-s1-heroine-wardrobe','d1:b4bc5eee-37d9-4abb-88ee-996c37bc99be','微信图片_20260914144522_2080_22.jpg','image/jpeg',235000,'胖胖',83,'2026-09-14T06:52:45.692Z',NULL);
INSERT INTO art_submission_files VALUES('22b8b9b4-92f2-4a5e-8d0b-a6aa64c057f6','ep1-v3-s5-auto-7','d1:22b8b9b4-92f2-4a5e-8d0b-a6aa64c057f6','图片 - 2026-09-14T161253.881.jpg','image/jpeg',690196,'王承恺',20,'2026-09-14T08:13:21.111Z',NULL);
INSERT INTO art_submission_files VALUES('9ebcedd6-c55a-4851-9b77-3eadd4fd43ca','ep1-v3-s5-auto-7','d1:9ebcedd6-c55a-4851-9b77-3eadd4fd43ca','图片 - 2026-09-14T161248.479.jpg','image/jpeg',726117,'王承恺',20,'2026-09-14T08:13:21.308Z',NULL);
INSERT INTO art_submission_files VALUES('8d9ac9dc-4295-4b3e-9804-d0e4bbe059e4','ep1-v3-s4-auto-7','d1:8d9ac9dc-4295-4b3e-9804-d0e4bbe059e4','图片 - 2026-09-14T160922.307.jpg','image/jpeg',635812,'王承恺',1,'2026-09-14T08:17:36.235Z',NULL);
INSERT INTO art_submission_files VALUES('d7c588fe-3cb2-4d3d-9ca4-62d5451e2a3e','ep1-v3-s4-auto-7','d1:d7c588fe-3cb2-4d3d-9ca4-62d5451e2a3e','静帧 2026-09-14 155557_1.4.3-web.jpg','image/jpeg',125365,'王承恺',2,'2026-09-14T08:18:36.944Z',NULL);
INSERT INTO art_submission_files VALUES('59d8cb89-f595-4c73-af55-7bf3fe4c198c','ep1-v3-s5-auto-7','d1:59d8cb89-f595-4c73-af55-7bf3fe4c198c','图片 - 2026-09-14T170936.365.jpg','image/jpeg',620934,'王承恺',21,'2026-09-14T09:10:23.018Z',NULL);
INSERT INTO art_submission_files VALUES('981ca381-0d1b-497c-a40f-a82f6f4165f7','ep1-v3-s1-auto-1','d1:981ca381-0d1b-497c-a40f-a82f6f4165f7','IMG_2520-web.jpg','image/jpeg',168698,'王承恺',1,'2026-09-14T10:58:07.106Z',NULL);
INSERT INTO art_submission_files VALUES('5320c385-97d6-40c0-a34d-70a712887685','ep1-v3-s3-auto-8','d1:5320c385-97d6-40c0-a34d-70a712887685','图片 - 2026-09-10T162342.848-web.jpg','image/jpeg',522021,'王承恺',1,'2026-09-14T11:00:00.744Z',NULL);
INSERT INTO art_submission_files VALUES('2ba67fff-80d2-4326-8860-34597c0514bd','ep1-v3-s3-overall-cast','d1:2ba67fff-80d2-4326-8860-34597c0514bd','图片 - 2026-09-14T190820.705.jpg','image/jpeg',623716,'王承恺',1,'2026-09-14T11:09:24.696Z',NULL);
INSERT INTO art_submission_files VALUES('19adf828-b38e-4606-95b1-55f970537b67','ep1-v3-s4-overall-cast','d1:19adf828-b38e-4606-95b1-55f970537b67','图片 - 2026-09-14T190820.705.jpg','image/jpeg',623716,'王承恺',1,'2026-09-14T11:09:54.232Z',NULL);
INSERT INTO art_submission_files VALUES('87ab0b9d-706a-4ec6-bd41-4e48a3b14c61','ep1-v3-s1-hero-wardrobe','d1:87ab0b9d-706a-4ec6-bd41-4e48a3b14c61','IMG_8386.JPG','image/jpeg',212664,'玉冰',1,'2026-09-14T11:11:27.609Z',NULL);
INSERT INTO art_submission_files VALUES('dc1d377f-bc98-4f69-a5d0-8978742bf958','ep1-v3-s1-hero-wardrobe','d1:dc1d377f-bc98-4f69-a5d0-8978742bf958','IMG_8385.JPG','image/jpeg',351584,'玉冰',1,'2026-09-14T11:11:28.052Z',NULL);
INSERT INTO art_submission_files VALUES('e750bad8-b7c6-49c5-929a-0e1e382c2921','ep1-v3-s1-hero-wardrobe','d1:e750bad8-b7c6-49c5-929a-0e1e382c2921','IMG_8382.JPG','image/jpeg',460005,'玉冰',1,'2026-09-14T11:11:28.271Z',NULL);
INSERT INTO art_submission_files VALUES('9aa0dc9e-9163-42b5-87ce-bff18b15bd6e','ep1-v3-s1-hero-wardrobe','d1:9aa0dc9e-9163-42b5-87ce-bff18b15bd6e','IMG_8383-web.jpg','image/jpeg',91344,'玉冰',2,'2026-09-14T11:11:31.084Z',NULL);
INSERT INTO art_submission_files VALUES('41a8946b-bf1f-47c5-aeca-7639f00736c5','ep1-v3-s1-hero-wardrobe','d1:41a8946b-bf1f-47c5-aeca-7639f00736c5','IMG_8381-web.jpg','image/jpeg',120663,'玉冰',2,'2026-09-14T11:11:31.623Z',NULL);
INSERT INTO art_submission_files VALUES('7772efa8-2911-4bba-8d60-b409602024b8','ep1-v3-s1-hero-wardrobe','d1:7772efa8-2911-4bba-8d60-b409602024b8','IMG_8380-web.jpg','image/jpeg',139800,'玉冰',2,'2026-09-14T11:11:31.641Z',NULL);
INSERT INTO art_submission_files VALUES('f300e35c-fe9b-4595-8a2b-327af458865a','ep1-v3-s1-hero-wardrobe','d1:f300e35c-fe9b-4595-8a2b-327af458865a','IMG_0537.jpg','image/jpeg',143074,'罗新姗',3,'2026-09-14T11:11:45.607Z',NULL);
INSERT INTO art_submission_files VALUES('e73b87f7-189a-4d0e-be08-98d27ce6cdeb','ep1-v3-s1-hero-wardrobe','d1:e73b87f7-189a-4d0e-be08-98d27ce6cdeb','IMG_0538.jpg','image/jpeg',468798,'罗新姗',4,'2026-09-14T11:11:47.687Z',NULL);
INSERT INTO art_submission_files VALUES('5464f265-0db3-4dd1-a347-f97415964dcc','ep1-v3-s1-hero-wardrobe','d1:5464f265-0db3-4dd1-a347-f97415964dcc','IMG_0539.jpg','image/jpeg',498470,'罗新姗',4,'2026-09-14T11:11:47.751Z',NULL);
INSERT INTO art_submission_files VALUES('af521a4f-7b4a-49e3-85d2-d9705e6ab524','ep1-v3-s1-hero-wardrobe','d1:af521a4f-7b4a-49e3-85d2-d9705e6ab524','IMG_0540.jpg','image/jpeg',412715,'罗新姗',5,'2026-09-14T11:12:26.768Z',NULL);
INSERT INTO art_submission_files VALUES('1143aff1-669e-4f44-a370-39ed33bf4219','ep1-v3-s5-overall-cast','d1:1143aff1-669e-4f44-a370-39ed33bf4219','图片 - 2026-09-14T135620.198.jpg','image/jpeg',668515,'王承恺',1,'2026-09-14T11:17:19.752Z',NULL);
INSERT INTO art_submission_files VALUES('08531755-8a15-4fce-88a8-fcbe3eb50d48','ep1-v3-s6-overall-cast','d1:08531755-8a15-4fce-88a8-fcbe3eb50d48','截屏2026-08-24 20.55.48-web.jpg','image/jpeg',175337,'王承恺',1,'2026-09-14T11:17:58.258Z',NULL);
INSERT INTO art_submission_files VALUES('e3a86eb8-e152-4e0d-9c73-0198234ef8ce','ep1-v3-s4-current-hero-wardrobe','d1:e3a86eb8-e152-4e0d-9c73-0198234ef8ce','图片 - 2026-09-14T191826.436.jpg','image/jpeg',601278,'王承恺',1,'2026-09-14T11:19:06.647Z',NULL);
INSERT INTO art_submission_files VALUES('2a318656-5eec-454f-baaa-fc2032dbc27c','ep1-v3-s4-current-hero-wardrobe','d1:2a318656-5eec-454f-baaa-fc2032dbc27c','图片 - 2026-09-14T191832.702.jpg','image/jpeg',584505,'王承恺',1,'2026-09-14T11:19:06.617Z',NULL);
INSERT INTO art_submission_files VALUES('de08aed6-bb3c-478b-8659-b034df4cdb92','ep1-v3-s1-hero-wardrobe','d1:de08aed6-bb3c-478b-8659-b034df4cdb92','图片 - 2026-09-14T191826.436.jpg','image/jpeg',601278,'王承恺',6,'2026-09-14T11:20:04.965Z',NULL);
INSERT INTO art_submission_files VALUES('2875c29f-9249-4c03-89f3-120b0e373cc9','ep1-v3-s1-hero-wardrobe','d1:2875c29f-9249-4c03-89f3-120b0e373cc9','图片 - 2026-09-14T191832.702.jpg','image/jpeg',584505,'王承恺',6,'2026-09-14T11:20:05.429Z',NULL);
INSERT INTO art_submission_files VALUES('c038739f-9e4d-46c4-8e3e-49a55dea29f1','ep1-v3-s1-hero-wardrobe','d1:c038739f-9e4d-46c4-8e3e-49a55dea29f1','微信图片_20260914190637_2099_22.jpg','image/jpeg',80617,'胖胖',7,'2026-09-14T11:39:20.481Z',NULL);
INSERT INTO art_submission_files VALUES('cbe2b366-0b33-4768-9b11-3f50a2f081ce','ep1-v3-s1-hero-wardrobe','d1:cbe2b366-0b33-4768-9b11-3f50a2f081ce','微信图片_20260914190637_2100_22.jpg','image/jpeg',138544,'胖胖',7,'2026-09-14T11:39:20.637Z',NULL);
INSERT INTO art_submission_files VALUES('098e9db9-2884-4235-ac90-b51665e3b3b4','ep1-v3-s1-hero-wardrobe','d1:098e9db9-2884-4235-ac90-b51665e3b3b4','微信图片_20260914190637_2101_22.jpg','image/jpeg',147366,'胖胖',7,'2026-09-14T11:39:20.630Z',NULL);
INSERT INTO art_submission_files VALUES('273780bf-d493-4582-9684-a759a7131cb3','ep1-v3-s1-hero-wardrobe','d1:273780bf-d493-4582-9684-a759a7131cb3','微信图片_20260914190637_2103_22.jpg','image/jpeg',175501,'胖胖',8,'2026-09-14T11:39:22.542Z',NULL);
INSERT INTO art_submission_files VALUES('6d626447-7a55-4cfb-899c-ec09197de867','ep1-v3-s1-hero-wardrobe','d1:6d626447-7a55-4cfb-899c-ec09197de867','微信图片_20260914190637_2102_22.jpg','image/jpeg',254359,'胖胖',8,'2026-09-14T11:39:22.558Z',NULL);
INSERT INTO art_submission_files VALUES('0312fe35-ceaa-4852-afbd-276d03346be6','ep1-v3-s1-hero-wardrobe','d1:0312fe35-ceaa-4852-afbd-276d03346be6','微信图片_20260914190637_2104_22.jpg','image/jpeg',261617,'胖胖',9,'2026-09-14T11:39:23.434Z',NULL);
INSERT INTO art_submission_files VALUES('feb3a002-3d15-4956-a71e-3010ca9d4760','ep1-v3-s1-hero-wardrobe','d1:feb3a002-3d15-4956-a71e-3010ca9d4760','微信图片_20260914191133_2106_22.jpg','image/jpeg',192154,'胖胖',10,'2026-09-14T11:39:24.898Z',NULL);
INSERT INTO art_submission_files VALUES('a6096580-7b73-471b-a095-12a26c1b4a84','ep1-v3-s1-hero-wardrobe','d1:a6096580-7b73-471b-a095-12a26c1b4a84','微信图片_20260914191133_2105_22.jpg','image/jpeg',188451,'胖胖',10,'2026-09-14T11:39:24.799Z',NULL);
INSERT INTO art_submission_files VALUES('8f170acb-e25e-41b8-bd3f-abc0846db3b3','ep1-v3-s1-hero-wardrobe','d1:8f170acb-e25e-41b8-bd3f-abc0846db3b3','微信图片_20260914191133_2107_22.jpg','image/jpeg',181278,'胖胖',10,'2026-09-14T11:39:25.473Z',NULL);
INSERT INTO art_submission_files VALUES('043856f9-e750-476d-b614-6cb21f74ef0c','ep1-v3-s1-hero-wardrobe','d1:043856f9-e750-476d-b614-6cb21f74ef0c','微信图片_20260914191133_2108_22.jpg','image/jpeg',172556,'胖胖',11,'2026-09-14T11:39:27.200Z',NULL);
INSERT INTO art_submission_files VALUES('5d9edbe2-efa0-44d3-90c8-c8ea8fee0c6a','ep1-v3-s1-hero-wardrobe','d1:5d9edbe2-efa0-44d3-90c8-c8ea8fee0c6a','微信图片_20260914191133_2109_22.jpg','image/jpeg',391291,'胖胖',11,'2026-09-14T11:39:28.137Z',NULL);
INSERT INTO art_submission_files VALUES('d2a122c2-15e7-41c5-8fcb-e4076bfff0d8','ep1-v3-s1-hero-wardrobe','d1:d2a122c2-15e7-41c5-8fcb-e4076bfff0d8','微信图片_20260914191133_2110_22.jpg','image/jpeg',314090,'胖胖',11,'2026-09-14T11:39:28.495Z',NULL);
INSERT INTO art_submission_files VALUES('8a28f271-6304-4b30-9fbc-01de57404abe','ep1-v3-s1-hero-wardrobe','d1:8a28f271-6304-4b30-9fbc-01de57404abe','微信图片_20260914191133_2111_22.jpg','image/jpeg',477399,'胖胖',12,'2026-09-14T11:39:30.316Z',NULL);
INSERT INTO art_submission_files VALUES('6f619f8c-ebb2-4bd1-9fee-fe65eca5269b','ep1-v3-s1-hero-wardrobe','d1:6f619f8c-ebb2-4bd1-9fee-fe65eca5269b','微信图片_20260914191133_2113_22.jpg','image/jpeg',267391,'胖胖',12,'2026-09-14T11:39:31.205Z',NULL);
INSERT INTO art_submission_files VALUES('976bb7a1-af99-496b-b814-46dc872db981','ep1-v3-s1-hero-wardrobe','d1:976bb7a1-af99-496b-b814-46dc872db981','微信图片_20260914191133_2112_22.jpg','image/jpeg',299355,'胖胖',12,'2026-09-14T11:39:31.043Z',NULL);
INSERT INTO art_submission_files VALUES('9785e60a-96ff-4df2-bd33-698ebd932007','ep1-v3-s1-hero-wardrobe','d1:9785e60a-96ff-4df2-bd33-698ebd932007','微信图片_20260914191133_2114_22.jpg','image/jpeg',218052,'胖胖',13,'2026-09-14T11:39:33.394Z',NULL);
INSERT INTO art_submission_files VALUES('efc8067a-c730-4310-849e-f414216a8ded','ep1-v3-s1-hero-wardrobe','d1:efc8067a-c730-4310-849e-f414216a8ded','微信图片_20260914191133_2116_22.jpg','image/jpeg',233081,'胖胖',14,'2026-09-14T11:39:33.972Z',NULL);
INSERT INTO art_submission_files VALUES('5923776c-5ab2-47ba-9728-557563a4e934','ep1-v3-s1-hero-wardrobe','d1:5923776c-5ab2-47ba-9728-557563a4e934','微信图片_20260914191133_2115_22.jpg','image/jpeg',353119,'胖胖',14,'2026-09-14T11:39:33.971Z',NULL);
INSERT INTO art_submission_files VALUES('704a998c-5114-41e2-98f5-339d9edc812f','ep1-v3-s1-hero-wardrobe','d1:704a998c-5114-41e2-98f5-339d9edc812f','微信图片_20260914191133_2117_22.jpg','image/jpeg',257890,'胖胖',15,'2026-09-14T11:39:36.395Z',NULL);
CREATE TABLE `script_versions` (
	`id` text PRIMARY KEY NOT NULL,
	`episode` text NOT NULL,
	`version_no` integer NOT NULL,
	`file_name` text DEFAULT '' NOT NULL,
	`source_text` text NOT NULL,
	`change_summary` text DEFAULT '' NOT NULL,
	`work_date` text NOT NULL,
	`submitted_by` text NOT NULL,
	`scene_count` integer DEFAULT 0 NOT NULL,
	`item_count` integer DEFAULT 0 NOT NULL,
	`created_at` text NOT NULL
, is_final INTEGER NOT NULL DEFAULT 0, finalized_at TEXT NOT NULL DEFAULT '', finalized_by TEXT NOT NULL DEFAULT '');
INSERT INTO script_versions VALUES('script-version-6c81d998-407c-4dfa-8a5e-00090c9b253c','第1集',1,'《折叠庭院的她》第一集0911（丙）.docx',unistr('《折叠庭院的她》\u000a\u000a第一集：这是第一次，被看见\u000a\u000a单集时长：3—4 分钟\u000a\u000a本集核心：顾丽乔为了挣二十元风险钱被迫重拍，却在预见成真后放弃当天的钱，冲进火场，在陆文川死亡后的六十秒内将他救回；她第一次被全网看见，也第一次付出衰老的代价。\u000a\u000a\u000a\u000a1. 南庭影视城·复古教堂片场　日　内\u000a\u000a人物：顾丽乔、怪物演员、前夫（闪回）、导演、制片主任、群头、陆文川、助理、视察人员\u000a\u000a顾丽乔狼狈地被怪物按在破旧祭坛前，身上的白色长裙满是破损和血迹。她嘴角带血，长发遮住半张脸。\u000a\u000a怪物冲上前，一只手恶狠狠掐住她的脖子。\u000a\u000a【以下vo对话，建议只台词给，做旁白，不给对应的口型。做残忍打人的画面对切，加快节奏】\u000a\u000a前夫（VO）：拍这种照片，你是想勾引谁！\u000a\u000a顾丽乔看着怪物，眼前闪过几个极短的画面。\u000a\u000a前夫满身酒气，夺走她的手机；镜子撞裂；她的手臂挡在脸前，浑身是伤。\u000a\u000a顾丽乔（VO）：这是模特照，我是为了替你还赌债。\u000a\u000a前夫（VO）：替我？我的债就是你的债！\u000a\u000a前夫抡起酒瓶，就要朝她砸来。\u000a\u000a【叠化】\u000a\u000a现实中，怪物的手狠狠挥下。\u000a\u000a导演：卡！\u000a\u000a教堂顶灯亮起，怪物的手僵在半空。\u000a\u000a所有演员齐刷刷往镜头方向的导演看去，数十个片场工作人员穿着冬天的衣服，陆陆续续从阴影里走出来往导演方向聚过去（丧尸演员整理妆容 摘头套）。\u000a\u000a所有人围着导演看回放，导演盯着回放，很不满意。\u000a\u000a导演：不行，这最后一下感觉不够。辛苦一下替身，再来一条，真撞啊！真撞。（对执行导演）把人脸遮一点，别穿帮。\u000a\u000a有人给丧尸演员递上衣服（打女主的那个），丝毫没人关注冻得发抖的顾丽乔。\u000a\u000a群头走来，下令。\u000a\u000a群演头子：注意点，别把脸露出来。\u000a\u000a顾丽乔：通告里可说好的没有真撞。这要加两百风险钱。\u000a\u000a群演头子：就轻轻打一下，要得了两百？二十，这行就这样，能干干。不行，以后我这里的戏，你就别来了。\u000a\u000a顾丽乔的手微微攥紧，压抑着心中的愤怒，心跳也越来越快。\u000a\u000a群演头子：知道你缺钱，欠债，连房租都快付不起了。劝你，有一点，是一点。眼光也要放长远一点。\u000a\u000a群头的话听似是关切，实则是警告。\u000a\u000a顾丽乔听着更加愤怒，心跳声越来越快，越来越重。\u000a\u000a她正要说话，片场入口忽然热闹起来，导演迅速站起身从她面前经过，朝着门口走去。\u000a\u000a门口，陆文川带着助理、安全、法务和项目人员走进来。\u000a\u000a导演、制片主任已经迎了上去。\u000a\u000a导演：陆总，您怎么亲自来了？\u000a\u000a顾丽乔被人群挤到景片边，差点摔倒，顾问穿下意识拉了她一把。\u000a\u000a两人的手腕相触，四周的声音骤然消失。\u000a\u000a顾丽乔眼前出现幻觉。\u000a\u000a【预言画面】\u000a\u000a临水回廊被冲出来的水淹没；\u000a\u000a警铃大响；\u000a\u000a墙上的电子钟停在 12:17；\u000a\u000a一个人影迅速从控制开关的小路离开（仅背影或局部，不能太明显透露出是陈默）；\u000a\u000a陆文川淹死在水中，已经没了气息。\u000a\u000a【预言画面结束】\u000a\u000a顾丽乔从环境中苏醒，猛地吸了一口气。\u000a\u000a陆文川已经抽回手，正要离开。\u000a\u000a顾丽乔：不要去东方庭院。\u000a\u000a陆文川困惑地看着顾丽乔。\u000a\u000a陆文川：你什么意思。\u000a\u000a群头怕顾丽乔是要攀附，把顾丽乔拉回布景。\u000a\u000a群头：开拍了！赶紧的。别动那种歪心思。\u000a\u000a顾丽乔再抬头时，陆文川已随视察队走远。\u000a\u000a\u000a\u000a2. 东方庭院·临水巷道　日　内\u000a\u000a人物：陆文川\u000a\u000a东方庭院内部，陆文川独自走在现场，正中的湖边还停着一艘乌篷船。\u000a\u000a陆文川走到乌篷船边，小心翼翼地乘船想仔细查看。\u000a\u000a他刚踏上乌篷船，就听远处传来“咔。”地一声，远处突然传来一声机械启动的声音。原本平静的水面突然开始剧烈涌动。\u000a\u000a下一秒，大量积水从旁边的楼体内部冲出。\u000a\u000a陆文川根本来不及反应，巨大的水流撞上乌篷船，船身猛地一歪。\u000a\u000a陆文川直接被掀进水里。\u000a\u000a\u000a\u000a3. 东方庭院外围候场区　日　外\u000a\u000a人物：顾丽乔、群头、导演、群演\u000a\u000a顾丽乔坐在临河布景外等重拍，寒冬的夜冷得呼气都是白雾，她还沉浸在幻觉之中。\u000a\u000a顾丽乔：真是冻昏头了，那些怎么可能是真的。\u000a\u000a顾丽乔还是担忧地看着手机，已经到了12:15。\u000a\u000a群头：开拍了！都准备好！\u000a\u000a顾丽乔正要进棚，突然远处警铃骤响。\u000a\u000a月洞门“咔”地落栓。\u000a\u000a顾丽乔的表情严肃，带着惊恐。\u000a\u000a身后人群都涌了上来，导演也凑到前排。\u000a\u000a导演：哪儿出事了？东方庭院！快点，拍戏了。\u000a\u000a众人纷纷进入棚内，顾丽乔却有些犹疑，转身朝着东方庭院跑去。\u000a\u000a群头：诶！干嘛去！拍戏呢！\u000a\u000a  \u000a\u000a4.东方庭院·临水巷道　日　内\u000a\u000a人物：陆文川、顾丽乔\u000a\u000a陆文川被掀进水里，他不会游泳，落水的一瞬间，下意识伸手想抓住船沿，却被水流狠狠冲开。\u000a\u000a他被水流带着撞向墙面，又撞上水中的房屋栏杆，挣扎着想浮出水面，却根本控制不住身体。\u000a\u000a他试图呼救，刚张嘴，水便灌了进去。\u000a\u000a缺氧，让他的视线开始模糊。\u000a\u000a他最后一次抬头，看见的是被水流冲得不断摇晃的乌篷船。\u000a\u000a陆文川的身体渐渐失去力气，彻底失去意识。\u000a\u000a此时，一道白色身影跳入了水中。\u000a\u000a正是穿着戏服的顾丽乔，她朝陆文川游过去，一把抓住他的衣服，拍了拍他的脸，可人已经彻底失去了意识。\u000a\u000a水流不断冲击着两人四处摇晃，几乎要将两人冲散，顾丽乔伸手抓住他，手意外抵在了他的心口。\u000a\u000a周围突然安静下来，巨大的水声消失，所有声音全部停止，原本疯狂冲出的水流，在这一刻仿佛被按下暂停键，变得极其缓慢。\u000a\u000a顾丽乔看见自己的手心亮起一道光。\u000a\u000a似有一阵气流，以她的手掌为中心，一圈一圈荡开涟漪，水如同被惊动般荡漾出去。\u000a\u000a顾丽乔诧异地看着自己的手，她不知道发生了什么。\u000a\u000a光继续向四周扩散，下一秒，所有光芒骤然收回，尽数进入陆文川的身体。\u000a\u000a陆文川猛地睁开眼睛，竟然活了过来，第一眼看到的，就是近在咫尺的顾丽乔。\u000a\u000a顾丽乔也愣住了，眼看陆文川又要窒息，顾丽乔回过神，立刻抓住他朝水面上乌篷船游去。\u000a\u000a两人终于抓住船沿，顾丽乔用尽力气，将陆文川托上乌篷船。\u000a\u000a两个人狼狈地趴在船里，大口喘气。\u000a\u000a顾丽乔躺在船上，已经力竭，她看了一眼自己的手心，没有异常的光亮。\u000a\u000a她也没注意到头发中，有一缕已经变成白发。\u000a\u000a镜头慢慢拉远，一处不起眼的监控摄像头正对着这里。\u000a\u000a\u000a\u000a4. 影视城监控室　夜　内\u000a\u000a人物：监控外包负责人、神秘人（电话声）\u000a\u000a屏幕上的正是：顾丽乔和陆文川躺在船上，力竭喘气的模样。\u000a\u000a监控外包负责人接起电话。\u000a\u000a神秘人（电话声）：线路、开关那几段，都剪掉。快点。\u000a\u000a监控外包负责人：那救人的呢？\u000a\u000a神秘人（电话声）：先留下。这是个机会。\u000a\u000a电话挂断。\u000a\u000a\u000a\u000a5. 医院病房　深夜　内\u000a\u000a人物：陆文川、助理\u000a\u000a陆文川睁开眼。监护仪恢复稳定节奏。\u000a\u000a助理守在床边。\u000a\u000a陆文川：救我出来的那个人在哪里？\u000a\u000a助理把手机递给他。\u000a\u000a助理：当场就走了，她是一个替身演员。现场登记只有名字，叫顾丽乔。\u000a\u000a手机上，是顾丽乔跳入水中救人，和陆文川躺在船上的剪辑视频。评论和转发飞快上涨。\u000a\u000a【评论：这俩人也太配了吧！】\u000a\u000a【评论：这碗饭我先吃为敬】\u000a\u000a【评论：都醒醒，这场意外就是因为两人剧组私会，还好没出意外】\u000a\u000a陆文川：去把原始监控留下。\u000a\u000a助理：事情发生后已经都拷走了，但有几段没了。\u000a\u000a陆文川抬眼看着助理。\u000a\u000a陆文川：先找到她。丢的那些视频的事，接着查。\u000a\u000a\u000a\u000a6. 群演酒店标间　深夜　内\u000a\u000a人物：顾丽乔、沈糯\u000a\u000a狭小房间里，摆着许多衣服，空间非常狭窄。\u000a\u000a唯一一张较为宽阔的桌上，架着两盏补光灯和手机。\u000a\u000a沈糯敷着面膜，正在调灯，听到门开，着急地催促着。\u000a\u000a门开，顾丽乔已经换回了自己的衣服，疲惫地走了进来。\u000a\u000a沈糯：你终于回来了，马上到时间直播了。三百粉也是粉，可不能迟到。\u000a\u000a等顾丽乔走近，沈糯才看见顾丽乔手臂上的擦伤，立刻摘下面膜，很是心疼。\u000a\u000a沈糯：怎么又受伤了？又让你拍危险的戏份了？给钱了吗？\u000a\u000a顾丽乔：不是拍戏伤的。\u000a\u000a顾丽乔没再多说，她坐到灯前，简单整理就打开了直播，却看见镜子里自己多了一缕白发，她对此很困惑。\u000a\u000a沈糯的手机震动了一下，她打开手机一看，惊呼一声。\u000a\u000a沈糯：小乔，这是不是你？\u000a\u000a顾丽乔看见手机中的正是，救人的视频。\u000a\u000a同时，她看见直播界面上，许多人在刷嘉年华等礼物，评论不断翻滚着，一条接一条地弹出。\u000a\u000a评论飞快刷新、\u000a\u000a【评论：是这姐吧！这姐真敢冲。】\u000a\u000a【评论：那视频是不是摆拍啊？一个替身怎么会提前知道里面有人？】\u000a\u000a【评论：才三百粉？？？】\u000a\u000a【评论：老婆！老婆太帅了！】\u000a\u000a【评论：姐姐，你救人的样子，比剧里的女主角还像女主角！必须给我红！】\u000a\u000a顾丽乔看着屏幕上，观看人数已经高达十几万，不敢相信。\u000a\u000a沈糯把手机转向顾丽乔，微博界面上，已经‘替身女演员勇救光禾影业少爷’上了热搜一。\u000a\u000a沈糯：这，还播吗？\u000a\u000a顾丽乔：播。\u000a\u000a顾丽乔（对手机）：大家好，我是顾丽乔。今天下戏有点晚……\u000a\u000a她的声音很稳，桌下的手却在发抖。\u000a\u000a镜头外，直播的观看数字还在继续攀升。\u000a\u000a深夜的城市全貌，上空不断漂浮着话题：#顾丽乔是谁#；#光禾影业股价大涨#；#替身X少爷文学#；#顾丽乔替身演员#；#美救英雄#；#东方庭院意外#……\u000a\u000a深夜的城市，沸腾着。\u000a\u000a\u000a\u000a第一集完\u000a\u000a'),'首次单集提报','2026-09-10','Lipa',7,61,'2026-09-11T06:33:38.594Z',0,'','');
INSERT INTO script_versions VALUES('script-version-8aaa5763-36da-4eda-93b6-de2284874cb9','第1集',2,'《折叠庭院的她》第一集0911（丙）.docx',unistr('《折叠庭院的她》\u000a\u000a第一集：这是第一次，被看见\u000a\u000a单集时长：3—4 分钟\u000a\u000a本集核心：顾丽乔为了挣二十元风险钱被迫重拍，却在预见成真后放弃当天的钱，冲进火场，在陆文川死亡后的六十秒内将他救回；她第一次被全网看见，也第一次付出衰老的代价。\u000a\u000a\u000a\u000a1. 南庭影视城·复古教堂片场　日　内\u000a\u000a人物：顾丽乔、怪物演员、前夫（闪回）、导演、制片主任、群头、陆文川、助理、视察人员\u000a\u000a顾丽乔狼狈地被怪物按在破旧祭坛前，身上的白色长裙满是破损和血迹。她嘴角带血，长发遮住半张脸。\u000a\u000a怪物冲上前，一只手恶狠狠掐住她的脖子。\u000a\u000a【以下vo对话，建议只台词给，做旁白，不给对应的口型。做残忍打人的画面对切，加快节奏】\u000a\u000a前夫（VO）：拍这种照片，你是想勾引谁！\u000a\u000a顾丽乔看着怪物，眼前闪过几个极短的画面。\u000a\u000a前夫满身酒气，夺走她的手机；镜子撞裂；她的手臂挡在脸前，浑身是伤。\u000a\u000a顾丽乔（VO）：这是模特照，我是为了替你还赌债。\u000a\u000a前夫（VO）：替我？我的债就是你的债！\u000a\u000a前夫抡起酒瓶，就要朝她砸来。\u000a\u000a【叠化】\u000a\u000a现实中，怪物的手狠狠挥下。\u000a\u000a导演：卡！\u000a\u000a教堂顶灯亮起，怪物的手僵在半空。\u000a\u000a所有演员齐刷刷往镜头方向的导演看去，数十个片场工作人员穿着冬天的衣服，陆陆续续从阴影里走出来往导演方向聚过去（丧尸演员整理妆容 摘头套）。\u000a\u000a所有人围着导演看回放，导演盯着回放，很不满意。\u000a\u000a导演：不行，这最后一下感觉不够。辛苦一下替身，再来一条，真撞啊！真撞。（对执行导演）把人脸遮一点，别穿帮。\u000a\u000a有人给丧尸演员递上衣服（打女主的那个），丝毫没人关注冻得发抖的顾丽乔。\u000a\u000a群头走来，下令。\u000a\u000a群演头子：注意点，别把脸露出来。\u000a\u000a顾丽乔：通告里可说好的没有真撞。这要加两百风险钱。\u000a\u000a群演头子：就轻轻打一下，要得了两百？二十，这行就这样，能干干。不行，以后我这里的戏，你就别来了。\u000a\u000a顾丽乔的手微微攥紧，压抑着心中的愤怒，心跳也越来越快。\u000a\u000a群演头子：知道你缺钱，欠债，连房租都快付不起了。劝你，有一点，是一点。眼光也要放长远一点。\u000a\u000a群头的话听似是关切，实则是警告。\u000a\u000a顾丽乔听着更加愤怒，心跳声越来越快，越来越重。\u000a\u000a她正要说话，片场入口忽然热闹起来，导演迅速站起身从她面前经过，朝着门口走去。\u000a\u000a门口，陆文川带着助理、安全、法务和项目人员走进来。\u000a\u000a导演、制片主任已经迎了上去。\u000a\u000a导演：陆总，您怎么亲自来了？\u000a\u000a顾丽乔被人群挤到景片边，差点摔倒，顾问穿下意识拉了她一把。\u000a\u000a两人的手腕相触，四周的声音骤然消失。\u000a\u000a顾丽乔眼前出现幻觉。\u000a\u000a【预言画面】\u000a\u000a临水回廊被冲出来的水淹没；\u000a\u000a警铃大响；\u000a\u000a墙上的电子钟停在 12:17；\u000a\u000a一个人影迅速从控制开关的小路离开（仅背影或局部，不能太明显透露出是陈默）；\u000a\u000a陆文川淹死在水中，已经没了气息。\u000a\u000a【预言画面结束】\u000a\u000a顾丽乔从环境中苏醒，猛地吸了一口气。\u000a\u000a陆文川已经抽回手，正要离开。\u000a\u000a顾丽乔：不要去东方庭院。\u000a\u000a陆文川困惑地看着顾丽乔。\u000a\u000a陆文川：你什么意思。\u000a\u000a群头怕顾丽乔是要攀附，把顾丽乔拉回布景。\u000a\u000a群头：开拍了！赶紧的。别动那种歪心思。\u000a\u000a顾丽乔再抬头时，陆文川已随视察队走远。\u000a\u000a\u000a\u000a2. 东方庭院·临水巷道　日　内\u000a\u000a人物：陆文川\u000a\u000a东方庭院内部，陆文川独自走在现场，正中的湖边还停着一艘乌篷船。\u000a\u000a陆文川走到乌篷船边，小心翼翼地乘船想仔细查看。\u000a\u000a他刚踏上乌篷船，就听远处传来“咔。”地一声，远处突然传来一声机械启动的声音。原本平静的水面突然开始剧烈涌动。\u000a\u000a下一秒，大量积水从旁边的楼体内部冲出。\u000a\u000a陆文川根本来不及反应，巨大的水流撞上乌篷船，船身猛地一歪。\u000a\u000a陆文川直接被掀进水里。\u000a\u000a\u000a\u000a3. 东方庭院外围候场区　日　外\u000a\u000a人物：顾丽乔、群头、导演、群演\u000a\u000a顾丽乔坐在临河布景外等重拍，寒冬的夜冷得呼气都是白雾，她还沉浸在幻觉之中。\u000a\u000a顾丽乔：真是冻昏头了，那些怎么可能是真的。\u000a\u000a顾丽乔还是担忧地看着手机，已经到了12:15。\u000a\u000a群头：开拍了！都准备好！\u000a\u000a顾丽乔正要进棚，突然远处警铃骤响。\u000a\u000a月洞门“咔”地落栓。\u000a\u000a顾丽乔的表情严肃，带着惊恐。\u000a\u000a身后人群都涌了上来，导演也凑到前排。\u000a\u000a导演：哪儿出事了？东方庭院！快点，拍戏了。\u000a\u000a众人纷纷进入棚内，顾丽乔却有些犹疑，转身朝着东方庭院跑去。\u000a\u000a群头：诶！干嘛去！拍戏呢！\u000a\u000a  \u000a\u000a4.东方庭院·临水巷道　日　内\u000a\u000a人物：陆文川、顾丽乔\u000a\u000a陆文川被掀进水里，他不会游泳，落水的一瞬间，下意识伸手想抓住船沿，却被水流狠狠冲开。\u000a\u000a他被水流带着撞向墙面，又撞上水中的房屋栏杆，挣扎着想浮出水面，却根本控制不住身体。\u000a\u000a他试图呼救，刚张嘴，水便灌了进去。\u000a\u000a缺氧，让他的视线开始模糊。\u000a\u000a他最后一次抬头，看见的是被水流冲得不断摇晃的乌篷船。\u000a\u000a陆文川的身体渐渐失去力气，彻底失去意识。\u000a\u000a此时，一道白色身影跳入了水中。\u000a\u000a正是穿着戏服的顾丽乔，她朝陆文川游过去，一把抓住他的衣服，拍了拍他的脸，可人已经彻底失去了意识。\u000a\u000a水流不断冲击着两人四处摇晃，几乎要将两人冲散，顾丽乔伸手抓住他，手意外抵在了他的心口。\u000a\u000a周围突然安静下来，巨大的水声消失，所有声音全部停止，原本疯狂冲出的水流，在这一刻仿佛被按下暂停键，变得极其缓慢。\u000a\u000a顾丽乔看见自己的手心亮起一道光。\u000a\u000a似有一阵气流，以她的手掌为中心，一圈一圈荡开涟漪，水如同被惊动般荡漾出去。\u000a\u000a顾丽乔诧异地看着自己的手，她不知道发生了什么。\u000a\u000a光继续向四周扩散，下一秒，所有光芒骤然收回，尽数进入陆文川的身体。\u000a\u000a陆文川猛地睁开眼睛，竟然活了过来，第一眼看到的，就是近在咫尺的顾丽乔。\u000a\u000a顾丽乔也愣住了，眼看陆文川又要窒息，顾丽乔回过神，立刻抓住他朝水面上乌篷船游去。\u000a\u000a两人终于抓住船沿，顾丽乔用尽力气，将陆文川托上乌篷船。\u000a\u000a两个人狼狈地趴在船里，大口喘气。\u000a\u000a顾丽乔躺在船上，已经力竭，她看了一眼自己的手心，没有异常的光亮。\u000a\u000a她也没注意到头发中，有一缕已经变成白发。\u000a\u000a镜头慢慢拉远，一处不起眼的监控摄像头正对着这里。\u000a\u000a\u000a\u000a4. 影视城监控室　夜　内\u000a\u000a人物：监控外包负责人、神秘人（电话声）\u000a\u000a屏幕上的正是：顾丽乔和陆文川躺在船上，力竭喘气的模样。\u000a\u000a监控外包负责人接起电话。\u000a\u000a神秘人（电话声）：线路、开关那几段，都剪掉。快点。\u000a\u000a监控外包负责人：那救人的呢？\u000a\u000a神秘人（电话声）：先留下。这是个机会。\u000a\u000a电话挂断。\u000a\u000a\u000a\u000a5. 医院病房　深夜　内\u000a\u000a人物：陆文川、助理\u000a\u000a陆文川睁开眼。监护仪恢复稳定节奏。\u000a\u000a助理守在床边。\u000a\u000a陆文川：救我出来的那个人在哪里？\u000a\u000a助理把手机递给他。\u000a\u000a助理：当场就走了，她是一个替身演员。现场登记只有名字，叫顾丽乔。\u000a\u000a手机上，是顾丽乔跳入水中救人，和陆文川躺在船上的剪辑视频。评论和转发飞快上涨。\u000a\u000a【评论：这俩人也太配了吧！】\u000a\u000a【评论：这碗饭我先吃为敬】\u000a\u000a【评论：都醒醒，这场意外就是因为两人剧组私会，还好没出意外】\u000a\u000a陆文川：去把原始监控留下。\u000a\u000a助理：事情发生后已经都拷走了，但有几段没了。\u000a\u000a陆文川抬眼看着助理。\u000a\u000a陆文川：先找到她。丢的那些视频的事，接着查。\u000a\u000a\u000a\u000a6. 群演酒店标间　深夜　内\u000a\u000a人物：顾丽乔、沈糯\u000a\u000a狭小房间里，摆着许多衣服，空间非常狭窄。\u000a\u000a唯一一张较为宽阔的桌上，架着两盏补光灯和手机。\u000a\u000a沈糯敷着面膜，正在调灯，听到门开，着急地催促着。\u000a\u000a门开，顾丽乔已经换回了自己的衣服，疲惫地走了进来。\u000a\u000a沈糯：你终于回来了，马上到时间直播了。三百粉也是粉，可不能迟到。\u000a\u000a等顾丽乔走近，沈糯才看见顾丽乔手臂上的擦伤，立刻摘下面膜，很是心疼。\u000a\u000a沈糯：怎么又受伤了？又让你拍危险的戏份了？给钱了吗？\u000a\u000a顾丽乔：不是拍戏伤的。\u000a\u000a顾丽乔没再多说，她坐到灯前，简单整理就打开了直播，却看见镜子里自己多了一缕白发，她对此很困惑。\u000a\u000a沈糯的手机震动了一下，她打开手机一看，惊呼一声。\u000a\u000a沈糯：小乔，这是不是你？\u000a\u000a顾丽乔看见手机中的正是，救人的视频。\u000a\u000a同时，她看见直播界面上，许多人在刷嘉年华等礼物，评论不断翻滚着，一条接一条地弹出。\u000a\u000a评论飞快刷新、\u000a\u000a【评论：是这姐吧！这姐真敢冲。】\u000a\u000a【评论：那视频是不是摆拍啊？一个替身怎么会提前知道里面有人？】\u000a\u000a【评论：才三百粉？？？】\u000a\u000a【评论：老婆！老婆太帅了！】\u000a\u000a【评论：姐姐，你救人的样子，比剧里的女主角还像女主角！必须给我红！】\u000a\u000a顾丽乔看着屏幕上，观看人数已经高达十几万，不敢相信。\u000a\u000a沈糯把手机转向顾丽乔，微博界面上，已经‘替身女演员勇救光禾影业少爷’上了热搜一。\u000a\u000a沈糯：这，还播吗？\u000a\u000a顾丽乔：播。\u000a\u000a顾丽乔（对手机）：大家好，我是顾丽乔。今天下戏有点晚……\u000a\u000a她的声音很稳，桌下的手却在发抖。\u000a\u000a镜头外，直播的观看数字还在继续攀升。\u000a\u000a深夜的城市全貌，上空不断漂浮着话题：#顾丽乔是谁#；#光禾影业股价大涨#；#替身X少爷文学#；#顾丽乔替身演员#；#美救英雄#；#东方庭院意外#……\u000a\u000a深夜的城市，沸腾着。\u000a\u000a\u000a\u000a第一集完\u000a\u000a'),'调整第一集台词及人物状态，开场火戏改水戏','2026-09-11','李明鑫',7,61,'2026-09-11T11:11:27.893Z',0,'','');
INSERT INTO script_versions VALUES('script-version-807c4b22-827a-4517-9598-3258096744fe','第1集',3,'《折叠庭院的她》第一集0911（丙）.docx',unistr('《折叠庭院的她》\u000a\u000a第一集：这是第一次，被看见\u000a\u000a单集时长：3—4 分钟\u000a\u000a本集核心：顾丽乔为了挣二十元风险钱被迫重拍，却在预见成真后放弃当天的钱，冲进火场，在陆文川死亡后的六十秒内将他救回；她第一次被全网看见，也第一次付出衰老的代价。\u000a\u000a\u000a\u000a1. 南庭影视城·复古教堂片场　日　内\u000a\u000a人物：顾丽乔、怪物演员、前夫（闪回）、导演、制片主任、群头、陆文川、助理、视察人员\u000a\u000a顾丽乔狼狈地被怪物按在破旧祭坛前，身上的白色长裙满是破损和血迹。她嘴角带血，长发遮住半张脸。\u000a\u000a怪物冲上前，一只手恶狠狠掐住她的脖子。\u000a\u000a【以下vo对话，建议只台词给，做旁白，不给对应的口型。做残忍打人的画面对切，加快节奏】\u000a\u000a前夫（VO）：拍这种照片，你是想勾引谁！\u000a\u000a顾丽乔看着怪物，眼前闪过几个极短的画面。\u000a\u000a前夫满身酒气，夺走她的手机；镜子撞裂；她的手臂挡在脸前，浑身是伤。\u000a\u000a顾丽乔（VO）：这是模特照，我是为了替你还赌债。\u000a\u000a前夫（VO）：替我？我的债就是你的债！\u000a\u000a前夫抡起酒瓶，就要朝她砸来。\u000a\u000a【叠化】\u000a\u000a现实中，怪物的手狠狠挥下。\u000a\u000a导演：卡！\u000a\u000a教堂顶灯亮起，怪物的手僵在半空。\u000a\u000a所有演员齐刷刷往镜头方向的导演看去，数十个片场工作人员穿着冬天的衣服，陆陆续续从阴影里走出来往导演方向聚过去（丧尸演员整理妆容 摘头套）。\u000a\u000a所有人围着导演看回放，导演盯着回放，很不满意。\u000a\u000a导演：不行，这最后一下感觉不够。辛苦一下替身，再来一条，真撞啊！真撞。（对执行导演）把人脸遮一点，别穿帮。\u000a\u000a有人给丧尸演员递上衣服（打女主的那个），丝毫没人关注冻得发抖的顾丽乔。\u000a\u000a群头走来，下令。\u000a\u000a群演头子：注意点，别把脸露出来。\u000a\u000a顾丽乔：通告里可说好的没有真撞。这要加两百风险钱。\u000a\u000a群演头子：就轻轻打一下，要得了两百？二十，这行就这样，能干干。不行，以后我这里的戏，你就别来了。\u000a\u000a顾丽乔的手微微攥紧，压抑着心中的愤怒，心跳也越来越快。\u000a\u000a群演头子：知道你缺钱，欠债，连房租都快付不起了。劝你，有一点，是一点。眼光也要放长远一点。\u000a\u000a群头的话听似是关切，实则是警告。\u000a\u000a顾丽乔听着更加愤怒，心跳声越来越快，越来越重。\u000a\u000a她正要说话，片场入口忽然热闹起来，导演迅速站起身从她面前经过，朝着门口走去。\u000a\u000a门口，陆文川带着助理、安全、法务和项目人员走进来。\u000a\u000a导演、制片主任已经迎了上去。\u000a\u000a导演：陆总，您怎么亲自来了？\u000a\u000a顾丽乔被人群挤到景片边，差点摔倒，顾问穿下意识拉了她一把。\u000a\u000a两人的手腕相触，四周的声音骤然消失。\u000a\u000a顾丽乔眼前出现幻觉。\u000a\u000a【预言画面】\u000a\u000a临水回廊被冲出来的水淹没；\u000a\u000a警铃大响；\u000a\u000a墙上的电子钟停在 12:17；\u000a\u000a一个人影迅速从控制开关的小路离开（仅背影或局部，不能太明显透露出是陈默）；\u000a\u000a陆文川淹死在水中，已经没了气息。\u000a\u000a【预言画面结束】\u000a\u000a顾丽乔从环境中苏醒，猛地吸了一口气。\u000a\u000a陆文川已经抽回手，正要离开。\u000a\u000a顾丽乔：不要去东方庭院。\u000a\u000a陆文川困惑地看着顾丽乔。\u000a\u000a陆文川：你什么意思。\u000a\u000a群头怕顾丽乔是要攀附，把顾丽乔拉回布景。\u000a\u000a群头：开拍了！赶紧的。别动那种歪心思。\u000a\u000a顾丽乔再抬头时，陆文川已随视察队走远。\u000a\u000a\u000a\u000a2. 东方庭院·临水巷道　日　内\u000a\u000a人物：陆文川\u000a\u000a东方庭院内部，陆文川独自走在现场，正中的湖边还停着一艘乌篷船。\u000a\u000a陆文川走到乌篷船边，小心翼翼地乘船想仔细查看。\u000a\u000a他刚踏上乌篷船，就听远处传来“咔。”地一声，远处突然传来一声机械启动的声音。原本平静的水面突然开始剧烈涌动。\u000a\u000a下一秒，大量积水从旁边的楼体内部冲出。\u000a\u000a陆文川根本来不及反应，巨大的水流撞上乌篷船，船身猛地一歪。\u000a\u000a陆文川直接被掀进水里。\u000a\u000a\u000a\u000a3. 东方庭院外围候场区　日　外\u000a\u000a人物：顾丽乔、群头、导演、群演\u000a\u000a顾丽乔坐在临河布景外等重拍，寒冬的夜冷得呼气都是白雾，她还沉浸在幻觉之中。\u000a\u000a顾丽乔：真是冻昏头了，那些怎么可能是真的。\u000a\u000a顾丽乔还是担忧地看着手机，已经到了12:15。\u000a\u000a群头：开拍了！都准备好！\u000a\u000a顾丽乔正要进棚，突然远处警铃骤响。\u000a\u000a月洞门“咔”地落栓。\u000a\u000a顾丽乔的表情严肃，带着惊恐。\u000a\u000a身后人群都涌了上来，导演也凑到前排。\u000a\u000a导演：哪儿出事了？东方庭院！快点，拍戏了。\u000a\u000a众人纷纷进入棚内，顾丽乔却有些犹疑，转身朝着东方庭院跑去。\u000a\u000a群头：诶！干嘛去！拍戏呢！\u000a\u000a  \u000a\u000a4.东方庭院·临水巷道　日　内\u000a\u000a人物：陆文川、顾丽乔\u000a\u000a陆文川被掀进水里，他不会游泳，落水的一瞬间，下意识伸手想抓住船沿，却被水流狠狠冲开。\u000a\u000a他被水流带着撞向墙面，又撞上水中的房屋栏杆，挣扎着想浮出水面，却根本控制不住身体。\u000a\u000a他试图呼救，刚张嘴，水便灌了进去。\u000a\u000a缺氧，让他的视线开始模糊。\u000a\u000a他最后一次抬头，看见的是被水流冲得不断摇晃的乌篷船。\u000a\u000a陆文川的身体渐渐失去力气，彻底失去意识。\u000a\u000a此时，一道白色身影跳入了水中。\u000a\u000a正是穿着戏服的顾丽乔，她朝陆文川游过去，一把抓住他的衣服，拍了拍他的脸，可人已经彻底失去了意识。\u000a\u000a水流不断冲击着两人四处摇晃，几乎要将两人冲散，顾丽乔伸手抓住他，手意外抵在了他的心口。\u000a\u000a周围突然安静下来，巨大的水声消失，所有声音全部停止，原本疯狂冲出的水流，在这一刻仿佛被按下暂停键，变得极其缓慢。\u000a\u000a顾丽乔看见自己的手心亮起一道光。\u000a\u000a似有一阵气流，以她的手掌为中心，一圈一圈荡开涟漪，水如同被惊动般荡漾出去。\u000a\u000a顾丽乔诧异地看着自己的手，她不知道发生了什么。\u000a\u000a光继续向四周扩散，下一秒，所有光芒骤然收回，尽数进入陆文川的身体。\u000a\u000a陆文川猛地睁开眼睛，竟然活了过来，第一眼看到的，就是近在咫尺的顾丽乔。\u000a\u000a顾丽乔也愣住了，眼看陆文川又要窒息，顾丽乔回过神，立刻抓住他朝水面上乌篷船游去。\u000a\u000a两人终于抓住船沿，顾丽乔用尽力气，将陆文川托上乌篷船。\u000a\u000a两个人狼狈地趴在船里，大口喘气。\u000a\u000a顾丽乔躺在船上，已经力竭，她看了一眼自己的手心，没有异常的光亮。\u000a\u000a她也没注意到头发中，有一缕已经变成白发。\u000a\u000a镜头慢慢拉远，一处不起眼的监控摄像头正对着这里。\u000a\u000a\u000a\u000a4. 影视城监控室　夜　内\u000a\u000a人物：监控外包负责人、神秘人（电话声）\u000a\u000a屏幕上的正是：顾丽乔和陆文川躺在船上，力竭喘气的模样。\u000a\u000a监控外包负责人接起电话。\u000a\u000a神秘人（电话声）：线路、开关那几段，都剪掉。快点。\u000a\u000a监控外包负责人：那救人的呢？\u000a\u000a神秘人（电话声）：先留下。这是个机会。\u000a\u000a电话挂断。\u000a\u000a\u000a\u000a5. 医院病房　深夜　内\u000a\u000a人物：陆文川、助理\u000a\u000a陆文川睁开眼。监护仪恢复稳定节奏。\u000a\u000a助理守在床边。\u000a\u000a陆文川：救我出来的那个人在哪里？\u000a\u000a助理把手机递给他。\u000a\u000a助理：当场就走了，她是一个替身演员。现场登记只有名字，叫顾丽乔。\u000a\u000a手机上，是顾丽乔跳入水中救人，和陆文川躺在船上的剪辑视频。评论和转发飞快上涨。\u000a\u000a【评论：这俩人也太配了吧！】\u000a\u000a【评论：这碗饭我先吃为敬】\u000a\u000a【评论：都醒醒，这场意外就是因为两人剧组私会，还好没出意外】\u000a\u000a陆文川：去把原始监控留下。\u000a\u000a助理：事情发生后已经都拷走了，但有几段没了。\u000a\u000a陆文川抬眼看着助理。\u000a\u000a陆文川：先找到她。丢的那些视频的事，接着查。\u000a\u000a\u000a\u000a6. 群演酒店标间　深夜　内\u000a\u000a人物：顾丽乔、沈糯\u000a\u000a狭小房间里，摆着许多衣服，空间非常狭窄。\u000a\u000a唯一一张较为宽阔的桌上，架着两盏补光灯和手机。\u000a\u000a沈糯敷着面膜，正在调灯，听到门开，着急地催促着。\u000a\u000a门开，顾丽乔已经换回了自己的衣服，疲惫地走了进来。\u000a\u000a沈糯：你终于回来了，马上到时间直播了。三百粉也是粉，可不能迟到。\u000a\u000a等顾丽乔走近，沈糯才看见顾丽乔手臂上的擦伤，立刻摘下面膜，很是心疼。\u000a\u000a沈糯：怎么又受伤了？又让你拍危险的戏份了？给钱了吗？\u000a\u000a顾丽乔：不是拍戏伤的。\u000a\u000a顾丽乔没再多说，她坐到灯前，简单整理就打开了直播，却看见镜子里自己多了一缕白发，她对此很困惑。\u000a\u000a沈糯的手机震动了一下，她打开手机一看，惊呼一声。\u000a\u000a沈糯：小乔，这是不是你？\u000a\u000a顾丽乔看见手机中的正是，救人的视频。\u000a\u000a同时，她看见直播界面上，许多人在刷嘉年华等礼物，评论不断翻滚着，一条接一条地弹出。\u000a\u000a评论飞快刷新、\u000a\u000a【评论：是这姐吧！这姐真敢冲。】\u000a\u000a【评论：那视频是不是摆拍啊？一个替身怎么会提前知道里面有人？】\u000a\u000a【评论：才三百粉？？？】\u000a\u000a【评论：老婆！老婆太帅了！】\u000a\u000a【评论：姐姐，你救人的样子，比剧里的女主角还像女主角！必须给我红！】\u000a\u000a顾丽乔看着屏幕上，观看人数已经高达十几万，不敢相信。\u000a\u000a沈糯把手机转向顾丽乔，微博界面上，已经‘替身女演员勇救光禾影业少爷’上了热搜一。\u000a\u000a沈糯：这，还播吗？\u000a\u000a顾丽乔：播。\u000a\u000a顾丽乔（对手机）：大家好，我是顾丽乔。今天下戏有点晚……\u000a\u000a她的声音很稳，桌下的手却在发抖。\u000a\u000a镜头外，直播的观看数字还在继续攀升。\u000a\u000a深夜的城市全貌，上空不断漂浮着话题：#顾丽乔是谁#；#光禾影业股价大涨#；#替身X少爷文学#；#顾丽乔替身演员#；#美救英雄#；#东方庭院意外#……\u000a\u000a深夜的城市，沸腾着。\u000a\u000a\u000a\u000a第一集完\u000a\u000a'),'首次单集提报','2026-09-11','Lipa',7,61,'2026-09-11T11:11:51.980Z',1,'2026-09-11T16:56:33.690Z','Lipa');
INSERT INTO script_versions VALUES('script-version-dd139383-52bb-48a8-893e-cfed19bceb7d','第1集',4,'《折叠庭院的她》第一集0912.docx',unistr('《折叠庭院的她》\u000a\u000a第一集：这是第一次，被看见\u000a\u000a单集时长：3—4 分钟\u000a\u000a本集核心：顾丽乔为了挣二十元风险钱被迫重拍，却在预见成真后放弃当天的钱，冲进火场，在陆文川死亡后的六十秒内将他救回；她第一次被全网看见，也第一次付出衰老的代价。\u000a\u000a\u000a\u000a1. 南庭影视城·复古教堂片场　日　内\u000a\u000a人物：顾丽乔、怪物演员、前夫（闪回）、导演、制片主任、群头、陆文川、助理、视察人员\u000a\u000a顾丽乔狼狈地被怪物按在破旧祭坛前，身上的白色长裙满是破损和血迹。她嘴角带血，长发遮住半张脸。\u000a\u000a怪物冲上前，一只手恶狠狠掐住她的脖子。\u000a\u000a【以下vo对话，建议只台词给，做旁白，不给对应的口型。做残忍打人的画面对切，加快节奏】\u000a\u000a前夫（VO）：拍这种照片，你是想勾引谁！\u000a\u000a顾丽乔看着怪物，眼前闪过几个极短的画面。\u000a\u000a前夫满身酒气，夺走她的手机；镜子撞裂；她的手臂挡在脸前，浑身是伤。\u000a\u000a顾丽乔（VO）：这是模特照，我是为了替你还赌债。\u000a\u000a前夫（VO）：替我？我的债就是你的债！\u000a\u000a前夫抡起酒瓶，就要朝她砸来。\u000a\u000a【叠化】\u000a\u000a现实中，怪物的手狠狠挥下。\u000a\u000a导演：卡！\u000a\u000a教堂顶灯亮起，怪物的手僵在半空。\u000a\u000a所有演员齐刷刷往镜头方向的导演看去，数十个片场工作人员陆陆续续从阴影里走出来往导演方向聚过去（丧尸演员整理妆容 摘头套）。\u000a\u000a所有人围着导演看回放，导演盯着回放，很不满意。\u000a\u000a导演：不行，这最后一下感觉不够。辛苦一下替身，再来一条，真撞啊！真撞。（对执行导演）把人脸遮一点，别穿帮。\u000a\u000a有人给丧尸演员（打女主的那个）递风扇、送水，丝毫没人关注趴在地上的顾丽乔。\u000a\u000a群头走来，下令。\u000a\u000a群演头子：注意点，别把脸露出来。\u000a\u000a顾丽乔：通告里可说好的没有真撞。这要加两百风险钱。\u000a\u000a群演头子：就轻轻打一下，要得了两百？二十，这行就这样，能干干。不行，以后我这里的戏，你就别来了。\u000a\u000a顾丽乔的手微微攥紧，压抑着心中的愤怒，心跳也越来越快。\u000a\u000a群演头子：知道你缺钱，欠债，连房租都快付不起了。劝你，有一点，是一点。眼光也要放长远一点。\u000a\u000a群头的话听似是关切，实则是警告。\u000a\u000a顾丽乔愤怒地攥紧了手，正要说话。\u000a\u000a片场入口忽然热闹起来，导演迅速站起身从她面前经过，朝着门口走去。\u000a\u000a门口，陆文川带着助理、安全、法务和项目人员走进来。\u000a\u000a导演、制片主任已经迎了上去。\u000a\u000a导演：陆总，您怎么亲自来了？\u000a\u000a陆文川：来看看方导对我们的棚用得满不满意。\u000a\u000a导演：当然满意。上澜影都置景是最讲究的了。\u000a\u000a陆文川听得出这是奉承，笑了笑没有接话。\u000a\u000a导演等人簇拥上去，将顾丽乔挤到一边，顾丽乔被地上的电线绊住了脚，身体一歪就要摔倒。\u000a\u000a陆文川看见，一把抓住了顾丽乔的手臂，将她拉了回来。\u000a\u000a惯性作用下，两人面对面贴在一起，远远看去像是抱住了彼此。\u000a\u000a顾丽乔抬头，嘴唇几乎碰到陆文川的喉结。\u000a\u000a顾丽乔因为差点摔倒，心跳声猛烈，突然心跳声扭曲，四周的声音骤然消失，奔涌的水声传来。\u000a\u000a顾丽乔眼前出现幻觉。\u000a\u000a【预言画面】\u000a\u000a临水回廊被冲出来的水淹没；\u000a\u000a警铃大响；\u000a\u000a墙上的电子钟停在 12:17；\u000a\u000a一个人影迅速从控制开关的小路离开（仅背影或局部，不能太明显透露出是陈默）；\u000a\u000a陆文川淹死在水中，已经没了气息。\u000a\u000a【预言画面结束】\u000a\u000a顾丽乔从环境中苏醒，猛地吸了一口气。\u000a\u000a陆文川已经收回手，正要离开。\u000a\u000a顾丽乔：不要去东方庭院。\u000a\u000a陆文川困惑地看着顾丽乔。\u000a\u000a陆文川：你什么意思。\u000a\u000a群头怕顾丽乔是要攀附，把顾丽乔拉回布景。\u000a\u000a群头：开拍了！赶紧的。别动那种歪心思。\u000a\u000a顾丽乔再抬头时，陆文川已随视察队走远。\u000a\u000a\u000a\u000a2. 东方庭院·临水巷道　日　内\u000a\u000a人物：陆文川\u000a\u000a东方庭院内部，陆文川独自走在现场，正中的湖边还停着一艘乌篷船。\u000a\u000a陆文川走到乌篷船边，小心翼翼地乘船想仔细查看。\u000a\u000a他刚踏上乌篷船，就听远处传来“咔。”地一声，远处突然传来一声机械启动的声音。原本平静的水面突然开始剧烈涌动。\u000a\u000a下一秒，大量积水从旁边的楼体内部冲出。\u000a\u000a陆文川根本来不及反应，巨大的水流撞上乌篷船，船身猛地一歪。\u000a\u000a陆文川直接被掀进水里。\u000a\u000a\u000a\u000a3. 东方庭院外围候场区　日　外\u000a\u000a人物：顾丽乔、群头、导演、群演\u000a\u000a顾丽乔坐在临河布景外的阴凉处等重拍，她看着水面，还沉浸在幻觉之中。\u000a\u000a顾丽乔：真是热昏头了，那些怎么可能是真的。\u000a\u000a顾丽乔还是担忧地看着手机，已经到了12:15。\u000a\u000a群头：开拍了！都准备好！\u000a\u000a顾丽乔正要进棚，突然远处警铃骤响。\u000a\u000a月洞门“咔”地落栓。\u000a\u000a顾丽乔的表情严肃，带着惊恐。\u000a\u000a身后人群都涌了上来，导演也凑到前排。\u000a\u000a导演：哪儿出事了？东方庭院！快点，拍戏了。\u000a\u000a众人纷纷进入棚内，顾丽乔却有些犹疑，转身朝着东方庭院跑去。\u000a\u000a群头：诶！干嘛去！拍戏呢！\u000a\u000a  \u000a\u000a4.东方庭院·临水巷道　日　内\u000a\u000a人物：陆文川、顾丽乔\u000a\u000a陆文川被掀进水里，他不会游泳，落水的一瞬间，下意识伸手想抓住船沿，却被水流狠狠冲开。\u000a\u000a他被水流带着撞向墙面，又撞上水中的房屋栏杆，挣扎着想浮出水面，却根本控制不住身体。\u000a\u000a他试图呼救，刚张嘴，水便灌了进去。\u000a\u000a缺氧，让他的视线开始模糊。\u000a\u000a他最后一次抬头，看见的是被水流冲得不断摇晃的乌篷船。\u000a\u000a陆文川的身体渐渐失去力气，彻底失去意识。\u000a\u000a此时，一道白色身影跳入了水中。\u000a\u000a正是穿着戏服的顾丽乔，她朝陆文川游过去，一把抓住他的衣服，拍了拍他的脸，可人已经彻底失去了意识。\u000a\u000a水流不断冲击着两人四处摇晃，几乎要将两人冲散，顾丽乔伸手抓住他，手意外抵在了他的心口。\u000a\u000a周围突然安静下来，巨大的水声消失，所有声音全部停止，原本疯狂冲出的水流，在这一刻仿佛被按下暂停键，变得极其缓慢。\u000a\u000a顾丽乔看见自己的手心亮起一道光。\u000a\u000a似有一阵气流，以她的手掌为中心，一圈一圈荡开涟漪，水如同被惊动般荡漾出去。\u000a\u000a顾丽乔诧异地看着自己的手，她不知道发生了什么。\u000a\u000a光继续向四周扩散，下一秒，所有光芒骤然收回，尽数进入陆文川的身体。\u000a\u000a陆文川猛地睁开眼睛，竟然活了过来，第一眼看到的，就是近在咫尺的顾丽乔。\u000a\u000a顾丽乔也愣住了，眼看陆文川又要窒息，顾丽乔回过神，立刻抓住他朝水面上乌篷船游去。\u000a\u000a两人终于抓住船沿，顾丽乔用尽力气，将陆文川托上乌篷船。\u000a\u000a两个人狼狈地趴在船里，大口喘气。\u000a\u000a顾丽乔躺在船上，已经力竭，她看了一眼自己的手心，没有异常的光亮。\u000a\u000a她也没注意到头发中，有一缕已经变成白发。\u000a\u000a镜头慢慢拉远，一处不起眼的监控摄像头正对着这里。\u000a\u000a\u000a\u000a4. 影视城监控室　夜　内\u000a\u000a人物：监控外包负责人、神秘人（电话声）\u000a\u000a屏幕上的正是：顾丽乔和陆文川躺在船上，力竭喘气的模样。\u000a\u000a监控外包负责人接起电话。\u000a\u000a神秘人（电话声）：线路、开关那几段，都剪掉。快点。\u000a\u000a监控外包负责人：那救人的呢？\u000a\u000a神秘人（电话声）：先留下。这也是个机会。\u000a\u000a电话挂断。\u000a\u000a\u000a\u000a5. 医院病房　深夜　内\u000a\u000a人物：陆文川、助理\u000a\u000a陆文川睁开眼。监护仪恢复稳定节奏。\u000a\u000a助理守在床边。\u000a\u000a陆文川：救我出来的那个人在哪里？\u000a\u000a助理把手机递给他。\u000a\u000a助理：当场就走了，她是一个替身演员。现场登记只有名字，叫顾丽乔。\u000a\u000a手机上，是顾丽乔跳入水中救人，和陆文川躺在船上的剪辑视频。评论和转发飞快上涨。\u000a\u000a【评论：这俩人也太配了吧！】\u000a\u000a【评论：这碗饭我先吃为敬】\u000a\u000a【评论：都醒醒，这场意外就是因为两人剧组私会，还好没出意外】\u000a\u000a陆文川：去把原始监控留下。\u000a\u000a助理：事情发生后已经都拷走了，但开关附近有一段没了。\u000a\u000a陆文川抬眼看着助理。\u000a\u000a陆文川：先找到她。丢的那些视频，接着查。\u000a\u000a\u000a\u000a6. 群演酒店标间　深夜　内\u000a\u000a人物：顾丽乔、郑允书\u000a\u000a狭小房间里，摆着许多衣服，空间非常狭窄。\u000a\u000a唯一一张较为宽阔的桌上，架着两盏补光灯和手机。\u000a\u000a郑允书敷着面膜，正在调灯，听到门开，着急地催促着。\u000a\u000a门开，顾丽乔已经换回了自己的衣服，疲惫地走了进来。\u000a\u000a郑允书：你终于回来了，马上到时间直播了。三百粉也是粉，可不能迟到。\u000a\u000a等顾丽乔走近，郑允书才看见顾丽乔手臂上的擦伤，立刻摘下面膜，很是心疼。\u000a\u000a郑允书：怎么又受伤了？又让你拍危险的戏份了？给钱了吗？\u000a\u000a顾丽乔：不是拍戏伤的。\u000a\u000a顾丽乔没再多说，她坐到灯前，简单整理就打开了直播，却看见镜子里自己多了一缕白发，她对此很困惑。\u000a\u000a郑允书的手机震动了一下，她打开手机一看，惊呼一声。\u000a\u000a郑允书：小乔，这是不是你？\u000a\u000a顾丽乔看见手机中的正是，救人的视频。\u000a\u000a同时，她看见直播界面上，许多人在刷嘉年华等礼物，评论不断翻滚着，一条接一条地弹出。\u000a\u000a评论飞快刷新、\u000a\u000a【评论：是这姐吧！这姐真敢冲。】\u000a\u000a【评论：那视频是不是摆拍啊？一个替身怎么会提前知道里面有人？】\u000a\u000a【评论：才三百粉？？？】\u000a\u000a【评论：老婆！老婆太帅了！】\u000a\u000a【评论：姐姐，你救人的样子，比剧里的女主角还像女主角！必须给我红！】\u000a\u000a顾丽乔看着屏幕上，观看人数已经高达十几万，不敢相信。\u000a\u000a郑允书把手机转向顾丽乔，微博界面上，已经‘替身女演员勇救上澜影都少爷’上了热搜一。\u000a\u000a郑允书：这，还播吗？\u000a\u000a顾丽乔：播。\u000a\u000a顾丽乔（对手机）：大家好，我是顾丽乔。今天下戏有点晚……\u000a\u000a她的声音很稳，桌下的手却在发抖。\u000a\u000a镜头外，直播的观看数字还在继续攀升。\u000a\u000a深夜的城市全貌，上空不断漂浮着话题：#顾丽乔是谁#；#上澜影都股价大涨#；#替身X少爷文学#；#顾丽乔替身演员#；#美救英雄#；#东方庭院意外#……\u000a\u000a深夜的城市，沸腾着。\u000a\u000a\u000a\u000a第一集完\u000a\u000a'),'第一集剧本，调整季节、增加男女主初见面互动','2026-09-13','李明鑫',7,60,'2026-09-13T07:51:23.172Z',0,'','');
ANALYZE sqlite_schema;
INSERT INTO sqlite_stat1 VALUES('member_accounts','member_accounts_username_unique','2 1');
INSERT INTO sqlite_stat1 VALUES('member_accounts','sqlite_autoindex_member_accounts_1','2 1');
INSERT INTO sqlite_stat1 VALUES('script_analysis_items','sqlite_autoindex_script_analysis_items_1','65 1');
INSERT INTO sqlite_stat1 VALUES('script_analyses','sqlite_autoindex_script_analyses_1','8 1');
INSERT INTO sqlite_stat1 VALUES('plan_batches','sqlite_autoindex_plan_batches_1','13 1');
INSERT INTO sqlite_stat1 VALUES('member_sessions','member_sessions_token_hash_unique','3 1');
INSERT INTO sqlite_stat1 VALUES('member_sessions','sqlite_autoindex_member_sessions_1','3 1');
INSERT INTO sqlite_stat1 VALUES('production_items','sqlite_autoindex_production_items_1','175 1');
INSERT INTO sqlite_stat1 VALUES('_cf_KV','_cf_KV','1 1');
INSERT INTO sqlite_stat1 VALUES('scenes','sqlite_autoindex_scenes_1','8 1');
INSERT INTO sqlite_stat1 VALUES('app_settings','sqlite_autoindex_app_settings_1','13 1');
INSERT INTO sqlite_stat1 VALUES('d1_migrations','sqlite_autoindex_d1_migrations_1','7 1');
INSERT INTO sqlite_stat1 VALUES('art_submission_details','sqlite_autoindex_art_submission_details_1','8 1');
INSERT INTO sqlite_stat1 VALUES('art_submission_files','idx_art_submission_files_item','30 4 1');
INSERT INTO sqlite_stat1 VALUES('art_submission_files','art_submission_files_object_key_unique','30 1');
INSERT INTO sqlite_stat1 VALUES('art_submission_files','sqlite_autoindex_art_submission_files_1','30 1');
INSERT INTO sqlite_stat1 VALUES('daily_scene_assignments','idx_daily_scene_assignments_work_date','20 7');
INSERT INTO sqlite_stat1 VALUES('daily_scene_assignments','daily_scene_assignments_date_analysis_unique','20 7 1');
INSERT INTO sqlite_stat1 VALUES('daily_scene_assignments','sqlite_autoindex_daily_scene_assignments_1','20 1');
INSERT INTO sqlite_stat1 VALUES('script_versions','idx_script_versions_episode_created','3 3 1');
INSERT INTO sqlite_stat1 VALUES('script_versions','script_versions_episode_version_unique','3 3 1');
INSERT INTO sqlite_stat1 VALUES('script_versions','sqlite_autoindex_script_versions_1','3 1');
CREATE TABLE `daily_scene_assignments` (
	`id` text PRIMARY KEY NOT NULL,
	`work_date` text NOT NULL,
	`analysis_id` text NOT NULL,
	`script_version_id` text DEFAULT '' NOT NULL,
	`assigned_by` text NOT NULL,
	`created_at` text NOT NULL
);
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-10-ep1-v3-s1','2026-09-10','ep1-v3-s1','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-11T16:56:33.690Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-11-ep1-v3-s1','2026-09-11','ep1-v3-s1','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-11T16:56:33.690Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-10-ep1-v3-s2','2026-09-10','ep1-v3-s2','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-11T16:56:33.690Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-11-ep1-v3-s2','2026-09-11','ep1-v3-s2','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-11T16:56:33.690Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-10-ep1-v3-s3','2026-09-10','ep1-v3-s3','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-11T16:56:33.690Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-11-ep1-v3-s3','2026-09-11','ep1-v3-s3','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-11T16:56:33.690Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-10-ep1-v3-s4','2026-09-10','ep1-v3-s4','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-11T16:56:33.690Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-11-ep1-v3-s4','2026-09-11','ep1-v3-s4','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-11T16:56:33.690Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-10-ep1-v3-s5','2026-09-10','ep1-v3-s5','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-11T16:56:33.690Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-11-ep1-v3-s5','2026-09-11','ep1-v3-s5','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-11T16:56:33.690Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-10-ep1-v3-s6','2026-09-10','ep1-v3-s6','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-11T16:56:33.690Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-11-ep1-v3-s6','2026-09-11','ep1-v3-s6','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-11T16:56:33.690Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-11-ep1-v3-s7','2026-09-11','ep1-v3-s7','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-11T16:56:33.690Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-12-ep1-v3-s1','2026-09-12','ep1-v3-s1','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-11T16:58:51.402Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-12-ep1-v3-s2','2026-09-12','ep1-v3-s2','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-11T16:58:51.402Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-12-ep1-v3-s3','2026-09-12','ep1-v3-s3','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-11T16:58:51.402Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-12-ep1-v3-s4','2026-09-12','ep1-v3-s4','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-11T16:58:51.402Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-12-ep1-v3-s5','2026-09-12','ep1-v3-s5','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-11T16:58:51.402Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-12-ep1-v3-s6','2026-09-12','ep1-v3-s6','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-11T16:58:51.402Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-12-ep1-v3-s7','2026-09-12','ep1-v3-s7','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-11T16:58:51.402Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-14-ep1-v3-s1','2026-09-14','ep1-v3-s1','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-14T07:12:21.210Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-14-ep1-v3-s2','2026-09-14','ep1-v3-s2','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-14T07:12:21.210Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-14-ep1-v3-s3','2026-09-14','ep1-v3-s3','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-14T07:12:21.210Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-14-ep1-v3-s4','2026-09-14','ep1-v3-s4','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-14T07:12:21.210Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-14-ep1-v3-s5','2026-09-14','ep1-v3-s5','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-14T07:12:21.210Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-14-ep1-v3-s6','2026-09-14','ep1-v3-s6','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-14T07:12:21.210Z');
INSERT INTO daily_scene_assignments VALUES('daily-scene-2026-09-14-ep1-v3-s7','2026-09-14','ep1-v3-s7','script-version-807c4b22-827a-4517-9598-3258096744fe','Lipa','2026-09-14T07:12:21.210Z');
CREATE TABLE art_reference_exclusions (
  item_id TEXT NOT NULL,
  file_id TEXT NOT NULL,
  removed_by TEXT NOT NULL,
  created_at TEXT NOT NULL,
  PRIMARY KEY (item_id, file_id)
);
CREATE TABLE art_structure_backup_0914(
  id TEXT,
  analysis_id TEXT,
  category TEXT,
  name TEXT,
  detail TEXT,
  visual_brief TEXT,
  yoyo_approved INT,
  sort_order INT,
  updated_at TEXT,
  producer_approved INT,
  is_active INT
);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s7-i01','ep1-v3-s7','场景','医院单人病房','深夜，监护仪稳定，整体克制安静；能容纳床边助理递手机。','出病房总图和床侧双人构图；医院等级、窗外环境和灯光色温待核准。',0,1,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s7-i02','ep1-v3-s7','人物','陆文川病后状态','刚从溺水复苏，虚弱但判断清晰；按住心口感受残留触感。','沿用第3、5场脸，出湿发处理后的病床状态和按心口动作近景。',0,2,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s7-i03','ep1-v3-s7','服装','陆文川病服','从落水服装切换为病服，保持深夜急救后的真实感。','出病服全身/半身方案；颜色与医院空间配套，待核准。',0,3,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s7-i04','ep1-v3-s7','人物','助理病房状态','向陆文川汇报顾丽乔身份、热视频和监控缺失。','沿用第3场助理，服装可保持视察造型或增加外套湿痕，连续性待核准。',0,4,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s7-i07','ep1-v3-s7','美术图','寻找顾丽乔的决定','陆文川看视频后命令“找到顾丽乔。还有那一分钟。”','出床上陆文川、手机视频和助理同框关键帧，重点是目光与决断。',0,7,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s8-i01','ep1-v3-s8','场景','上塘城姑妈面摊','雨后深夜，街边只剩一盏摊灯；锅、棚、桌凳形成温暖但清贫的生活入口。','出街道远景、面摊总图和桌边近景；一盏暖灯对比湿冷街面，招牌文字待核准。',0,1,'2026-09-11T08:53:57.659Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s8-i02','ep1-v3-s8','场景','远处黑色轿车内部','车辆停在可观察面摊的位置，屏幕反光遮住车内人的脸。','出外部停车关系图与车内肩后视角；车型、距离和人物遮脸方式待核准。',0,2,'2026-09-11T08:53:57.659Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s8-i03','ep1-v3-s8','人物','姑妈基础形象','经营夜间面摊，第一反应是扶住顾丽乔并检查发热与白发。','出正面、侧面、摊位工作状态人物图；年龄、围裙与日常衣着待核准。',0,3,'2026-09-11T08:53:57.659Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s8-i04','ep1-v3-s8','人物','顾丽乔救援后状态','浑身湿透、脸色惨白、发烧腿软；黑色短发里已有明显白发。','沿用第5场连续状态，出被姑妈扶住、摸白发、看手机三张动作图。',0,4,'2026-09-11T08:53:57.659Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s8-i05','ep1-v3-s8','服装','姑妈面摊工作服','实用、防雨、带围裙或袖套，体现长期经营摊位。','出全身工作造型；色彩应与暖灯协调但不能过度戏服化。',0,5,'2026-09-11T08:53:57.659Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s8-i06','ep1-v3-s8','人物','白鸽伤口已合拢','同一只白鸽落在摊棚边，翅膀留血迹但伤口已经闭合。','出停在棚边的全身图与翅膀近景，和第2、4场保持同一只鸽子的特征。',0,6,'2026-09-11T08:53:57.659Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s8-i07','ep1-v3-s8','道具','面摊锅、灯与餐具','姑妈掀锅盖迎接顾丽乔，锅和灯承担生活感与温度。','出锅灶、摊灯、桌椅餐具组合图，保证可重复生成。',0,7,'2026-09-11T08:53:57.659Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s8-i08','ep1-v3-s8','道具','爆红手机界面','粉丝从3,126快速上涨，私信、关注、品牌邀约和辱骂同时涌入。','出粉丝增长、私信列表和热视频弹幕三种手机UI；核心文字按剧本保留。',0,8,'2026-09-11T08:53:57.659Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s8-i09','ep1-v3-s8','道具','前夫置顶评论','评论“顾丽乔，你以为跑到上塘城，我就找不到你？”头像为前夫。','出评论置顶近景，头像需沿用第1场前夫形象，文字完整可读。',0,9,'2026-09-11T08:53:57.659Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s8-i10','ep1-v3-s8','美术图','面摊双钩子收尾','前景是顾丽乔盯手机，远处黑车内的人看她白发定格画面，反光遮脸。','出面摊人物层、手机层、黑车观察层三层构图；既看清威胁又不揭露神秘人。',0,10,'2026-09-11T08:53:57.659Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s1-auto-1','ep1-v3-s1','人物','顾丽乔｜人物造型','顾丽乔狼狈地被怪物按在破旧祭坛前，身上的白色长裙满是破损和血迹。她嘴角带血，长发遮住半张脸。 有人给丧尸演员递上衣服（打女主的那个），丝毫没人关注冻得发抖的顾丽乔。','顾丽乔本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,1,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s1-auto-2','ep1-v3-s1','人物','怪物演员｜人物造型','根据本场身份、情绪和前后场连续性确定怪物演员的妆发与人物状态。','怪物演员本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,2,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s1-auto-3','ep1-v3-s1','人物','前夫（闪回）｜人物造型','前夫满身酒气，夺走她的手机；镜子撞裂；她的手臂挡在脸前，浑身是伤。','前夫（闪回）本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,3,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s1-auto-4','ep1-v3-s1','人物','导演｜人物造型','所有演员齐刷刷往镜头方向的导演看去，数十个片场工作人员穿着冬天的衣服，陆陆续续从阴影里走出来往导演方向聚过去（丧尸演员整理妆容 摘头套）。','导演本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,4,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s1-auto-5','ep1-v3-s1','人物','制片主任｜人物造型','根据本场身份、情绪和前后场连续性确定制片主任的妆发与人物状态。','制片主任本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,5,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s1-auto-6','ep1-v3-s1','人物','群头｜人物造型','根据本场身份、情绪和前后场连续性确定群头的妆发与人物状态。','群头本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,6,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s1-auto-7','ep1-v3-s1','人物','陆文川｜人物造型','陆文川淹死在水中，已经没了气息。','陆文川本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,7,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s1-auto-8','ep1-v3-s1','人物','助理｜人物造型','根据本场身份、情绪和前后场连续性确定助理的妆发与人物状态。','助理本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,8,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s1-auto-9','ep1-v3-s1','人物','视察人员｜人物造型','根据本场身份、情绪和前后场连续性确定视察人员的妆发与人物状态。','视察人员本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,9,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s1-auto-10','ep1-v3-s1','服装','本场服装1','顾丽乔狼狈地被怪物按在破旧祭坛前，身上的白色长裙满是破损和血迹。她嘴角带血，长发遮住半张脸。','按这条剧本信息生成完整穿搭图，标清内外层、鞋袜、配饰、颜色、材质和连续性。',0,10,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s1-auto-11','ep1-v3-s1','服装','本场服装2','所有演员齐刷刷往镜头方向的导演看去，数十个片场工作人员穿着冬天的衣服，陆陆续续从阴影里走出来往导演方向聚过去（丧尸演员整理妆容 摘头套）。','按这条剧本信息生成完整穿搭图，标清内外层、鞋袜、配饰、颜色、材质和连续性。',0,11,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s1-auto-20','ep1-v3-s1','场景','南庭影视城·复古教堂片场　日　内｜场景图','顾丽乔狼狈地被怪物按在破旧祭坛前，身上的白色长裙满是破损和血迹。她嘴角带血，长发遮住半张脸。 教堂顶灯亮起，怪物的手僵在半空。 所有演员齐刷刷往镜头方向的导演看去，数十个片场工作人员穿着冬天的衣服，陆陆续续从阴影里走出来往导演方向聚过去（丧尸演员整理妆容 摘头套）。 她正要说话，片场入口忽然热闹起来，导演迅速站起身从她面前经过，朝着门口走去。 门口，陆文川带着助理、安全、法务和项目人员走进来。 顾丽乔被人群挤到景片边，差点摔倒，顾问穿下意识拉了她一把。','生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。',0,20,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s2-auto-1','ep1-v3-s2','人物','陆文川｜人物造型','根据本场身份、情绪和前后场连续性确定陆文川的妆发与人物状态。','陆文川本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,1,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s2-auto-2','ep1-v3-s2','服装','本场服装连续性','剧本没有写明具体服装，需根据人物身份、时间地点和前后场确定。','主美补充本场完整穿搭图并标注与前后场是否连戏。',0,2,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s2-auto-4','ep1-v3-s2','场景','东方庭院·临水巷道　日　内｜场景图','东方庭院内部，陆文川独自走在现场，正中的湖边还停着一艘乌篷船。 陆文川走到乌篷船边，小心翼翼地乘船想仔细查看。 他刚踏上乌篷船，就听远处传来“咔。”地一声，远处突然传来一声机械启动的声音。原本平静的水面突然开始剧烈涌动。 下一秒，大量积水从旁边的楼体内部冲出。 陆文川根本来不及反应，巨大的水流撞上乌篷船，船身猛地一歪。 陆文川直接被掀进水里。','生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。',0,4,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s3-auto-1','ep1-v3-s3','人物','顾丽乔｜人物造型','根据本场身份、情绪和前后场连续性确定顾丽乔的妆发与人物状态。','顾丽乔本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,1,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s3-auto-2','ep1-v3-s3','人物','群头｜人物造型','根据本场身份、情绪和前后场连续性确定群头的妆发与人物状态。','群头本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,2,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s3-auto-3','ep1-v3-s3','人物','导演｜人物造型','根据本场身份、情绪和前后场连续性确定导演的妆发与人物状态。','导演本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,3,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s3-auto-4','ep1-v3-s3','人物','群演｜人物造型','根据本场身份、情绪和前后场连续性确定群演的妆发与人物状态。','群演本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,4,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s3-auto-5','ep1-v3-s3','服装','本场服装连续性','剧本没有写明具体服装，需根据人物身份、时间地点和前后场确定。','主美补充本场完整穿搭图并标注与前后场是否连戏。',0,5,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s3-auto-8','ep1-v3-s3','场景','东方庭院外围候场区　日　外｜场景图','顾丽乔坐在临河布景外等重拍，寒冬的夜冷得呼气都是白雾，她还沉浸在幻觉之中。 月洞门“咔”地落栓。 众人纷纷进入棚内，顾丽乔却有些犹疑，转身朝着东方庭院跑去。','生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。',0,8,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s4-auto-1','ep1-v3-s4','人物','监控外包负责人｜人物造型','根据本场身份、情绪和前后场连续性确定监控外包负责人的妆发与人物状态。','监控外包负责人本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,1,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s4-auto-2','ep1-v3-s4','人物','神秘人（电话声）｜人物造型','根据本场身份、情绪和前后场连续性确定神秘人（电话声）的妆发与人物状态。','神秘人（电话声）本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,2,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s4-auto-3','ep1-v3-s4','服装','本场服装连续性','剧本没有写明具体服装，需根据人物身份、时间地点和前后场确定。','主美补充本场完整穿搭图并标注与前后场是否连戏。',0,3,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s4-auto-7','ep1-v3-s4','场景','影视城监控室　夜　内｜场景图','根据场头“影视城监控室　夜　内”建立本场空间。','生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。',0,7,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s5-auto-1','ep1-v3-s5','人物','陆文川｜人物造型','根据本场身份、情绪和前后场连续性确定陆文川的妆发与人物状态。','陆文川本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,1,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s5-auto-2','ep1-v3-s5','人物','助理｜人物造型','根据本场身份、情绪和前后场连续性确定助理的妆发与人物状态。','助理本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,2,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s5-auto-3','ep1-v3-s5','服装','本场服装连续性','剧本没有写明具体服装，需根据人物身份、时间地点和前后场确定。','主美补充本场完整穿搭图并标注与前后场是否连戏。',0,3,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s5-auto-4','ep1-v3-s5','道具','手机','助理把手机递给他。','生成“手机”设定图；标明外形、材质、尺寸及剧中使用状态。',0,4,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s5-auto-7','ep1-v3-s5','场景','医院病房　深夜　内｜场景图','手机上，是顾丽乔跳入水中救人，和陆文川躺在船上的剪辑视频。评论和转发飞快上涨。','生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。',0,7,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s6-auto-1','ep1-v3-s6','人物','顾丽乔｜人物造型','等顾丽乔走近，沈糯才看见顾丽乔手臂上的擦伤，立刻摘下面膜，很是心疼。 顾丽乔：不是拍戏伤的。 顾丽乔没再多说，她坐到灯前，简单整理就打开了直播，却看见镜子里自己多了一缕白发，她对此很困惑。','顾丽乔本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,1,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s6-auto-2','ep1-v3-s6','人物','沈糯｜人物造型','沈糯敷着面膜，正在调灯，听到门开，着急地催促着。 等顾丽乔走近，沈糯才看见顾丽乔手臂上的擦伤，立刻摘下面膜，很是心疼。 沈糯：怎么又受伤了？又让你拍危险的戏份了？给钱了吗？','沈糯本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,2,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s6-auto-3','ep1-v3-s6','服装','本场服装连续性','剧本没有写明具体服装，需根据人物身份、时间地点和前后场确定。','主美补充本场完整穿搭图并标注与前后场是否连戏。',0,3,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s6-auto-4','ep1-v3-s6','道具','手机','唯一一张较为宽阔的桌上，架着两盏补光灯和手机。','生成“手机”设定图；标明外形、材质、尺寸及剧中使用状态。',0,4,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_structure_backup_0914 VALUES('ep1-v3-s6-auto-9','ep1-v3-s6','场景','群演酒店标间　深夜　内｜场景图','狭小房间里，摆着许多衣服，空间非常狭窄。 唯一一张较为宽阔的桌上，架着两盏补光灯和手机。 沈糯敷着面膜，正在调灯，听到门开，着急地催促着。 门开，顾丽乔已经换回了自己的衣服，疲惫地走了进来。 顾丽乔没再多说，她坐到灯前，简单整理就打开了直播，却看见镜子里自己多了一缕白发，她对此很困惑。','生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。',0,9,'2026-09-11T16:56:33.690Z',0,1);
CREATE TABLE art_detail_backup_0914(
  item_id TEXT,
  assigned_to TEXT,
  due_at TEXT,
  handoff_to TEXT,
  done_definition TEXT,
  status TEXT,
  submission_note TEXT,
  review_note TEXT,
  submitted_at TEXT,
  reviewed_at TEXT,
  updated_at TEXT,
  selected_file_id TEXT
);
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-i01','主美小金','2026-09-10T18:00','Lipa','确认片场完整空间、主机位和俯视调度关系。','已上传','片场／教堂空间参考已入库，待整集微信确认。','','2026-09-10T14:00:00.000Z','','2026-09-10T14:00:00.000Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-i02','主美小金','2026-09-10T18:00','Lipa','确认家暴出租屋空间、破损状态和黄昏光线。','已上传','家暴出租屋场景参考已入库，待整集微信确认。','','2026-09-10T14:00:00.000Z','','2026-09-10T14:00:00.000Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-i04','主美小金','2026-09-10T18:00','Lipa','对比教堂片场白衣与粉色长发Option A—C。','已上传','三个独立服装发型Option已入库，尚未锁定。','','2026-09-10T14:00:00.000Z','','2026-09-10T14:00:00.000Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-i12','主美小金','2026-09-10T18:00','Lipa','对比家暴出租屋穿搭Option A—E，明确衣长、材质、受损状态与发型。','已上传','五个独立Option已入库，尚未锁定。','','2026-09-10T14:00:00.000Z','','2026-09-10T14:00:00.000Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-i13','主美小金','2026-09-10T18:00','Lipa','对比女主现居出租屋的日夜氛围、家具布局和主机位。','已上传','五张空间视角已入库，与家暴出租屋分组显示。','','2026-09-10T14:00:00.000Z','','2026-09-10T14:00:00.000Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s3-i08','主美小金','2026-09-10T18:00','Lipa','对比女主下班后日常穿搭Option A—J，最终锁定一套及备选顺序。','已上传','十个独立Option已入库，尚未锁定。','','2026-09-10T14:00:00.000Z','','2026-09-10T14:00:00.000Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s4-i01','主美小金','2026-09-10T18:00','Lipa','确认东方庭院总布局、水道、月洞门和调度线。','已上传','庭院场景参考已入库，待整集微信确认。','','2026-09-10T14:00:00.000Z','','2026-09-10T14:00:00.000Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s4-i03','主美小金','2026-09-10T18:00','Lipa','庭院场沿用教堂片场的白衣与粉发Option A—C。','已上传','与教堂片场一致的三个Option已入库，尚未锁定。','','2026-09-10T14:00:00.000Z','','2026-09-10T14:00:00.000Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s3-i09','主美小金','2026-09-11T18:00','Lipa','对比男主陆出场人脸Option A—D，最终锁定一张脸及黑色短发方向。','已上传','四组人脸Option已入库，尚未锁定。','','2026-09-11T10:00:00.000Z','','2026-09-11T10:00:00.000Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s3-i10','主美小金','2026-09-11T18:00','Lipa','对比男主陆出场服装Option A—M，最终锁定一套及备选顺序。','已上传','十三组服装Option已入库，尚未锁定。','','2026-09-11T10:00:00.000Z','','2026-09-11T10:00:00.000Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-i03','主美小金','','Lipa','正面、侧面、三分之二身人物定妆图；脸、身形和黑色短发作为全剧连续性基准。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-i05','主美小金','','Lipa','同一机位出戴粉色长假发、摘下假发两张对照图；粉色色相、长度、卷直程度待核准。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-i06','主美小金','','Lipa','出三名怪物同框比例图与单人造型图；轮廓需有差异，避免全身细碎附件影响动作生成。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-i07','主美小金','','Lipa','分别出半身人物设定；年龄、职业质感和服装色系待核准。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-i08','主美小金','','Lipa','出导演、制片主任、群头三人区分图及工作人员群像气氛图。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-i09','主美小金','','Lipa','出三件道具的近景设定与破损状态；血量尺度待核准。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-i10','主美小金','','Lipa','出可直接用于画面的手机UI两版：催收通知、姑妈语音；文字必须保持剧本信息准确。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-i11','主美小金','','Lipa','用同角度生成“戏中戏成立／喊卡后穿帮”两张配对关键帧，供Yoyo判断反差是否够强。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s2-i01','主美小金','','Lipa','出一张中景：廊柱遮挡、杂物间、道具堆和片场漏光；标明顾丽乔坐位及白鸽坠落点。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s2-i02','主美小金','','Lipa','沿用第1场脸与服装，新增坐姿、双手拢鸽、扶柱三种动作参考。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s2-i03','主美小金','','Lipa','出发根极近景，白发变化清楚但不能夸张成大片漂白。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s2-i04','主美小金','','Lipa','出受伤、静止、重新喘气三种连续状态；白鸽体型和羽毛特征须固定。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s2-i05','主美小金','','Lipa','出手机背壳夹钱状态和账号拍摄界面；数字需可读。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s2-i06','主美小金','','Lipa','出可辨识但不过度醒目的线缠翅膀近景，以及沾血卸妆棉状态。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s2-i07','主美小金','','Lipa','出掌心与白鸽的特写关键帧；白光克制、非大法术特效，亮度和形态待Yoyo确认。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s3-i01','主美小金','','Lipa','出纵深小巷定调图与俯视调度图；明确移动灯倾倒方向、两人接触点和视察队行进线。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s3-i02','主美小金','','Lipa','正面、侧面、三分之二身人物定妆图；面部与身材作为后续落水、病房连续性基准。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s3-i03','主美小金','','Lipa','出全身服装方案；外套需要在第5场脱下捂口鼻，层次和材质须清楚。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s3-i04','主美小金','','Lipa','出全身连续性图，明确假发抱法、服装血迹位置和不明显的一根白发。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s3-i05','主美小金','','Lipa','出助理与安全负责人区分明确的半身图，以及3—5人视察群像。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s3-i06','主美小金','','Lipa','出灯具结构、支架和倒向示意；确保动作逻辑可信。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s3-i07','主美小金','','Lipa','做一组6格预见关键帧，统一冷、碎、短促的视觉语法；字幕“22:17”单独出样。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s4-i02','主美小金','','Lipa','出群演层次和逆行构图参考，保证顾丽乔在手机画幅内一眼可读。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s4-i04','主美小金','','Lipa','出贴水飞行侧视图，固定羽毛特征与受伤翅膀状态。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s4-i05','主美小金','','Lipa','出手部近景，钱、结算单和退还动作清晰；结算单信息不需写满。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s4-i06','主美小金','','Lipa','出月洞门铁栓落下近景与警铃亮起状态。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s4-i07','主美小金','','Lipa','出竖屏/手机端可读的中心构图：人群向外、顾丽乔向内、粉色假发落地。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s5-i01','主美小金','','Lipa','出燃烧前基础图、起火状态图和俯视调度图；明确门、桥、两条乌篷船、落水点和出口。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s5-i02','主美小金','','Lipa','出下水前、拖人、CPR、划船四个动作状态；同一张脸、血迹和白发增长必须连续。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s5-i03','主美小金','','Lipa','出清醒、溺水闭眼、复苏呛咳三状态，湿发和服装层次保持一致。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s5-i04','主美小金','','Lipa','出白发扩散三个阶段近景；是否发根先白、白发面积与鼻血量待Yoyo核准。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s5-i05','主美小金','','Lipa','出灭火器、断栓、压门景片的连续动作参考。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s5-i06','主美小金','','Lipa','出船型统一设定、翻覆状态、船桨和缆绳烧断近景；船与桥尺度必须可执行。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s5-i07','主美小金','','Lipa','出工作证正反面及烧黑版；倒计时字幕与手机时间统一字形和位置。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s5-i08','主美小金','','Lipa','出特效前后对照关键帧；效果应诡异克制，不做大范围仙术光效。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s5-i09','主美小金','','Lipa','出三张连续动作图，确认身体位置、视线、船内空间与镜头轴线。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s5-i10','主美小金','','Lipa','出陆文川主观视角和高位监控视角各一张，保留粉色纤维、白发和红灯。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s6-i01','主美小金','','Lipa','出监控室总图与操作者主观屏幕图；光源以屏幕冷光为主，空间规模待核准。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s6-i02','主美小金','','Lipa','出半身造型图和操作台坐姿；年龄与性别剧本未定，标记待核准。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s6-i03','主美小金','','Lipa','本场不出正脸；只需为后续建立声音/来电界面标识，来电名称保持匿名。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s6-i04','主美小金','','Lipa','出四格监控UI、时间码和放大框样式；避免界面信息过密。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s6-i05','主美小金','','Lipa','出匿名通话界面和上传100%画面，可直接用于合成。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s6-i06','主美小金','','Lipa','出剪辑前四格、删减后单画面、标题发布页三步组图，供Yoyo判断幕后操盘是否清楚。','待上传','','','','','2026-09-11T06:33:13.620Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s7-i01','主美小金','2026-09-11T18:00','Lipa','出病房总图和床侧双人构图；医院等级、窗外环境和灯光色温待核准。','已上传','','','2026-09-14T06:13:02.451Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s7-i02','主美小金','2026-09-11T18:00','Lipa','沿用第3、5场脸，出湿发处理后的病床状态和按心口动作近景。','待上传','','','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s7-i03','主美小金','2026-09-11T18:00','Lipa','出病服全身/半身方案；颜色与医院空间配套，待核准。','已上传','','','2026-09-14T06:22:23.455Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s7-i04','主美小金','2026-09-11T18:00','Lipa','沿用第3场助理，服装可保持视察造型或增加外套湿痕，连续性待核准。','待上传','','','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s7-i07','主美小金','2026-09-11T18:00','Lipa','出床上陆文川、手机视频和助理同框关键帧，重点是目光与决断。','待上传','','','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s8-i01','主美小金','2026-09-11T18:00','Lipa','出街道远景、面摊总图和桌边近景；一盏暖灯对比湿冷街面，招牌文字待核准。','待上传','','','','','2026-09-11T12:49:56.466Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s8-i02','主美小金','2026-09-11T18:00','Lipa','出外部停车关系图与车内肩后视角；车型、距离和人物遮脸方式待核准。','待上传','','','','','2026-09-11T12:49:56.466Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s8-i03','主美小金','2026-09-11T18:00','Lipa','出正面、侧面、摊位工作状态人物图；年龄、围裙与日常衣着待核准。','待上传','','','','','2026-09-11T12:49:56.466Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s8-i04','主美小金','2026-09-11T18:00','Lipa','沿用第5场连续状态，出被姑妈扶住、摸白发、看手机三张动作图。','待上传','','','','','2026-09-11T12:49:56.466Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s8-i05','主美小金','2026-09-11T18:00','Lipa','出全身工作造型；色彩应与暖灯协调但不能过度戏服化。','待上传','','','','','2026-09-11T12:49:56.466Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s8-i06','主美小金','2026-09-11T18:00','Lipa','出停在棚边的全身图与翅膀近景，和第2、4场保持同一只鸽子的特征。','待上传','','','','','2026-09-11T12:49:56.466Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s8-i07','主美小金','2026-09-11T18:00','Lipa','出锅灶、摊灯、桌椅餐具组合图，保证可重复生成。','待上传','','','','','2026-09-11T12:49:56.466Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s8-i08','主美小金','2026-09-11T18:00','Lipa','出粉丝增长、私信列表和热视频弹幕三种手机UI；核心文字按剧本保留。','待上传','','','','','2026-09-11T12:49:56.466Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s8-i09','主美小金','2026-09-11T18:00','Lipa','出评论置顶近景，头像需沿用第1场前夫形象，文字完整可读。','待上传','','','','','2026-09-11T12:49:56.466Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s8-i10','主美小金','2026-09-11T18:00','Lipa','出面摊人物层、手机层、黑车观察层三层构图；既看清威胁又不揭露神秘人。','待上传','','','','','2026-09-11T12:49:56.466Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-auto-1','主美小金','2026-09-11T18:00','Lipa','顾丽乔本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','2026-09-11T06:36:46.479Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-auto-2','主美小金','2026-09-11T18:00','Lipa','怪物演员本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T05:48:25.008Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-auto-3','主美小金','2026-09-11T18:00','Lipa','前夫（闪回）本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-11T11:44:29.148Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-auto-4','主美小金','2026-09-11T18:00','Lipa','导演本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-11T11:43:25.750Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-auto-5','主美小金','2026-09-11T18:00','Lipa','制片主任本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-11T11:49:48.161Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-auto-6','主美小金','2026-09-11T18:00','Lipa','群头本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-11T11:44:45.961Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-auto-7','主美小金','2026-09-11T18:00','Lipa','陆文川本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T07:11:11.783Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-auto-8','主美小金','2026-09-11T18:00','Lipa','助理本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T06:03:34.272Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-auto-9','主美小金','2026-09-11T18:00','Lipa','视察人员本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T06:05:32.458Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-auto-10','玉冰','2026-09-11T18:00','Lipa','按这条剧本信息生成完整穿搭图，标清内外层、鞋袜、配饰、颜色、材质和连续性。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T06:52:45.692Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-auto-11','主美小金','2026-09-11T18:00','Lipa','按这条剧本信息生成完整穿搭图，标清内外层、鞋袜、配饰、颜色、材质和连续性。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T06:32:03.873Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s1-auto-20','主美小金','2026-09-11T18:00','Lipa','生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T06:43:49.875Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s2-auto-1','主美小金','2026-09-11T18:00','Lipa','陆文川本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s2-auto-2','主美小金','2026-09-11T18:00','Lipa','主美补充本场完整穿搭图并标注与前后场是否连戏。','待上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T06:41:41.475Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s2-auto-4','主美小金','2026-09-11T18:00','Lipa','生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T06:47:22.416Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s3-auto-1','主美小金','2026-09-11T18:00','Lipa','顾丽乔本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s3-auto-2','主美小金','2026-09-11T18:00','Lipa','群头本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s3-auto-3','主美小金','2026-09-11T18:00','Lipa','导演本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s3-auto-4','主美小金','2026-09-11T18:00','Lipa','群演本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s3-auto-5','主美小金','2026-09-11T18:00','Lipa','主美补充本场完整穿搭图并标注与前后场是否连戏。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s3-auto-8','主美小金','2026-09-11T18:00','Lipa','生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s4-auto-1','主美小金','2026-09-11T18:00','Lipa','监控外包负责人本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s4-auto-2','主美小金','2026-09-11T18:00','Lipa','神秘人（电话声）本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s4-auto-3','主美小金','2026-09-11T18:00','Lipa','主美补充本场完整穿搭图并标注与前后场是否连戏。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s4-auto-7','主美小金','2026-09-11T18:00','Lipa','生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s5-auto-1','主美小金','2026-09-11T18:00','Lipa','陆文川本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s5-auto-2','主美小金','2026-09-11T18:00','Lipa','助理本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s5-auto-3','主美小金','2026-09-11T18:00','Lipa','主美补充本场完整穿搭图并标注与前后场是否连戏。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s5-auto-4','主美小金','2026-09-11T18:00','Lipa','生成“手机”设定图；标明外形、材质、尺寸及剧中使用状态。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s5-auto-7','主美小金','2026-09-11T18:00','Lipa','生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s6-auto-1','主美小金','2026-09-11T18:00','Lipa','顾丽乔本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s6-auto-2','主美小金','2026-09-11T18:00','Lipa','沈糯本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s6-auto-3','主美小金','2026-09-11T18:00','Lipa','主美补充本场完整穿搭图并标注与前后场是否连戏。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s6-auto-4','主美小金','2026-09-11T18:00','Lipa','生成“手机”设定图；标明外形、材质、尺寸及剧中使用状态。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_detail_backup_0914 VALUES('ep1-v3-s6-auto-9','主美小金','2026-09-11T18:00','Lipa','生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T05:41:23.314Z','','2026-09-14T07:12:21.210Z','');
CREATE TABLE art_file_ownership_backup_0914(
  id TEXT,
  item_id TEXT,
  uploaded_by TEXT,
  file_name TEXT
);
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-s1-set-01','ep1-v3-s1-i01','Lipa','片场参考 01｜带工作人员与机位');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-s1-set-02','ep1-v3-s1-i01','Lipa','片场参考 02｜教堂空间与尸体血迹');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-s1-wardrobe-a','ep1-v3-s1-i04','Lipa','教堂片场 Option A｜长款白色吊带裙＋粉色长发');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-s1-wardrobe-b','ep1-v3-s1-i04','Lipa','教堂片场 Option B｜收腰白色缎面中长裙＋粉色长发');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-s1-wardrobe-c','ep1-v3-s1-i04','Lipa','教堂片场 Option C｜白色短款伞摆裙＋粉色长发');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-s1-domestic-set-01','ep1-v3-s1-i02','Lipa','家暴出租屋｜破损房间与黄昏光线参考');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-s1-domestic-wardrobe-a','ep1-v3-s1-i12','Lipa','家暴出租屋 Option A｜灰蓝长袖长裤家居服');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-s1-domestic-wardrobe-b','ep1-v3-s1-i12','Lipa','家暴出租屋 Option B｜浅色长袖短裤家居服');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-s1-domestic-wardrobe-c','ep1-v3-s1-i12','Lipa','家暴出租屋 Option C｜深灰长袖长裤家居服');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-s1-domestic-wardrobe-d','ep1-v3-s1-i12','Lipa','家暴出租屋 Option D｜白色长袖长裤家居服');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-s1-domestic-wardrobe-e','ep1-v3-s1-i12','Lipa','家暴出租屋 Option E｜蓝色背心＋白色下装组合');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-hero-rental-set-01','ep1-v3-s1-i13','Lipa','女主出租屋｜空间参考 01');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-hero-rental-set-02','ep1-v3-s1-i13','Lipa','女主出租屋｜空间参考 02');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-hero-rental-set-03','ep1-v3-s1-i13','Lipa','女主出租屋｜空间参考 03');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-hero-rental-set-04','ep1-v3-s1-i13','Lipa','女主出租屋｜空间参考 04');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-hero-rental-set-05','ep1-v3-s1-i13','Lipa','女主出租屋｜空间参考 05');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-offwork-a','ep1-v3-s3-i08','Lipa','下班后 Option A｜连帽卫衣＋破洞牛仔长裤');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-offwork-b','ep1-v3-s3-i08','Lipa','下班后 Option B｜短款连帽卫衣＋破洞牛仔长裤');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-offwork-c','ep1-v3-s3-i08','Lipa','下班后 Option C｜白色短上衣＋黑色层叠短裙');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-offwork-d','ep1-v3-s3-i08','Lipa','下班后 Option D｜白色立体上衣＋黑色层叠短裙');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-offwork-e','ep1-v3-s3-i08','Lipa','下班后 Option E｜白色海军领上衣＋黑色短裙');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-offwork-f','ep1-v3-s3-i08','Lipa','下班后 Option F｜印花短袖衬衫＋短裙长靴');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-offwork-g','ep1-v3-s3-i08','Lipa','下班后 Option G｜黑色长外套＋围巾叠穿');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-offwork-h','ep1-v3-s3-i08','Lipa','下班后 Option H｜牛仔外套＋牛仔长裤');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-offwork-i','ep1-v3-s3-i08','Lipa','下班后 Option I｜针织开衫＋卫衣＋破洞牛仔裤');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-offwork-j','ep1-v3-s3-i08','Lipa','下班后 Option J｜黑色吊带＋牛仔短裤＋堆叠长靴');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-s4-set-01','ep1-v3-s4-i01','Lipa','东方庭院｜建筑、水道与月洞门参考');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-s4-wardrobe-a','ep1-v3-s4-i03','Lipa','庭院沿用 Option A｜白色短款伞摆裙＋粉色长发');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-s4-wardrobe-b','ep1-v3-s4-i03','Lipa','庭院沿用 Option B｜长款白色吊带裙＋粉色长发');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-s4-wardrobe-c','ep1-v3-s4-i03','Lipa','庭院沿用 Option C｜收腰白色缎面中长裙＋粉色长发');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-male-lu-face-a','ep1-v3-s3-i09','Lipa','男主陆·人脸 Option A｜黑发冷感·白衬衫黑西装');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-male-lu-face-b','ep1-v3-s3-i09','Lipa','男主陆·人脸 Option B｜黑发冷感·全黑西装');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-male-lu-face-c','ep1-v3-s3-i09','Lipa','男主陆·人脸 Option C｜锐利眉眼·松散领带');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-male-lu-face-d','ep1-v3-s3-i09','Lipa','男主陆·人脸 Option D｜成熟骨相·正侧近景');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-male-lu-wardrobe-a','ep1-v3-s3-i10','Lipa','男主陆·服装 Option A｜卡其收腰猎装夹克');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-male-lu-wardrobe-b','ep1-v3-s3-i10','Lipa','男主陆·服装 Option B｜棕灰短外套＋宽松长裤');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-male-lu-wardrobe-c','ep1-v3-s3-i10','Lipa','男主陆·服装 Option C｜棕色绞花针织＋阔腿裤');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-male-lu-wardrobe-d','ep1-v3-s3-i10','Lipa','男主陆·服装 Option D｜橄榄绿腰带猎装套装');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-male-lu-wardrobe-e','ep1-v3-s3-i10','Lipa','男主陆·服装 Option E｜浅灰双排扣西装＋阔腿裤');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-male-lu-wardrobe-f','ep1-v3-s3-i10','Lipa','男主陆·服装 Option F｜格纹西装＋酒红针织层叠');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-male-lu-wardrobe-g','ep1-v3-s3-i10','Lipa','男主陆·服装 Option G｜蓝灰工装外套＋针织裤');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-male-lu-wardrobe-h','ep1-v3-s3-i10','Lipa','男主陆·服装 Option H｜棕色针织开衫＋白色阔腿裤');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-male-lu-wardrobe-i','ep1-v3-s3-i10','Lipa','男主陆·服装 Option I｜九套大地色造型方向');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-male-lu-wardrobe-j','ep1-v3-s3-i10','Lipa','男主陆·服装 Option J｜九套秋冬层叠方向');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-male-lu-wardrobe-k','ep1-v3-s3-i10','Lipa','男主陆·服装 Option K｜卡其收腰猎装四视图');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-male-lu-wardrobe-l','ep1-v3-s3-i10','Lipa','男主陆·服装 Option L｜米白西装＋粉色衬衫四视图');
INSERT INTO art_file_ownership_backup_0914 VALUES('curated-male-lu-wardrobe-m','ep1-v3-s3-i10','Lipa','男主陆·服装 Option M｜米白西装完整四视图');
INSERT INTO art_file_ownership_backup_0914 VALUES('04258e60-9590-40b4-9cb1-7b0045ebab52','ep1-v3-s1-auto-1','Lipa','5572bf0ef3eebabfd439dc20fff35c73.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('87bf8357-1ec3-4de5-9afe-2df47de82d21','ep1-v3-s1-auto-4','王承恺','图片 - 2026-09-04T162506.963.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('195bc710-6b90-440c-8340-186ca232242d','ep1-v3-s1-auto-3','王承恺','使用老机型iPhone全身 噪点略糊没有背景虚化：豪华公寓中20岁中国男人，帅气俊朗健身男性，身材健硕，胸前带口袋设计的T恤袖，下身是西裤皮.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('5f26c4b9-9b2d-4f1a-8fa6-5dc5aea6eccc','ep1-v3-s1-auto-6','王承恺','图片 - 2026-09-11T180707.728.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('279e72db-07c8-45b8-80e4-5576df238e0f','ep1-v3-s1-auto-5','王承恺','图片 - 2026-09-11T182558.740.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('dae10025-c8a8-4b6d-9b5f-f6e3c3b3cdd1','ep1-v3-s1-auto-7','王承恺','34e82df325c99ed1a126f49d6cb008f9.png');
INSERT INTO art_file_ownership_backup_0914 VALUES('1ed41dc3-642f-40d4-8aa7-04b61613d897','ep1-v3-s1-auto-7','王承恺','韩国男性白幼瘦帅哥博主，25岁。东亚男性，韩国男明星英俊帅气。立体骨相，高挺笔直鼻梁，山根自然不突兀，不明显双眼皮眼型偏长，眼尾微微收，不肿.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('3ebaad51-2ac6-4021-9f0b-831d97a5523c','ep1-v3-s1-auto-7','王承恺','图片 - 2026-09-11T160305.320.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('66bc6579-ef7c-486d-aa97-ac61c7c1451f','ep1-v3-s1-auto-10','玉冰','0c813fa85480efcab802842d3e4a2082.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('94d97cf1-e4b2-4809-aca6-376ed79d5177','ep1-v3-s1-auto-10','玉冰','5eb11628a9267d18545909fae4843fdf.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('78991d4a-07ca-4ecc-85d3-3da238223c29','ep1-v3-s1-auto-10','玉冰','89234c34ce1ecd3cebc19a265772dd53.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('48178c8c-6d41-4963-bcd3-804ff865fafd','ep1-v3-s1-auto-10','玉冰','a36995e93f74cc5aab3e572f59698a97.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('ec1a0394-0b80-4293-b0a7-af9fee8223c1','ep1-v3-s1-auto-10','玉冰','e00ec71d56da89f16455b1eeb6a02848.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('e4a964cc-629e-4641-bd89-192485c7a05f','ep1-v3-s6-auto-9','王承恺','图片 - 2026-09-10T174138.885-web.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('50e489a6-665a-4e24-ae46-b19f1d000618','ep1-v3-s1-auto-2','王承恺','图片 - 2026-09-14T131555.437.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('b239780a-45ef-4ec8-8515-7b0dd114b4d5','ep1-v3-s1-auto-2','王承恺','图片 - 2026-09-14T132026.982.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('aae49962-5e18-4228-871d-8fb448f5c20e','ep1-v3-s1-auto-2','王承恺','图片 - 2026-09-14T131746.495.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('d0742bf6-34f9-4f33-9c93-ad438302c167','ep1-v3-s1-auto-2','王承恺','图片 - 2026-09-14T131759.502.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('75373a3e-bc9b-4c8d-b73c-b2265c1ee70b','ep1-v3-s1-auto-7','王承恺','图片 - 2026-09-12T193423.622.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('55102b50-b512-47b9-9056-e476071822cb','ep1-v3-s1-auto-10','罗新姗','IMG_0500.JPG');
INSERT INTO art_file_ownership_backup_0914 VALUES('72c5724c-63c5-493c-81d7-07b0ab88fd22','ep1-v3-s1-auto-10','罗新姗','IMG_0499.JPG');
INSERT INTO art_file_ownership_backup_0914 VALUES('db1b1e4f-b0eb-4976-aa75-46bb2899b6db','ep1-v3-s1-auto-10','罗新姗','IMG_0498.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('c2083cf0-c800-4894-8ed7-a6c80fc2a121','ep1-v3-s1-auto-10','罗新姗','IMG_0497.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('bdee9268-700a-403a-a48f-7226f9c802c5','ep1-v3-s1-auto-10','罗新姗','IMG_0495-web.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('0d18421a-2a5e-4d88-89c4-a6eb985cd0bd','ep1-v3-s1-auto-10','罗新姗','IMG_0494-web.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('b5eb5594-6b0b-4123-87a0-7173d41feb5d','ep1-v3-s7-i03','玉冰','7871eed29fc0557369ef0845bca4b547.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('e7c24f0b-f710-4e9e-84aa-cb79446f9f56','ep1-v3-s7-i03','玉冰','c8d6f05b5a1850c07b3cd3667d78e86c.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('71f8271f-694e-416b-9985-6e39deac28b0','ep1-v3-s1-auto-9','王承恺','图片 - 2026-09-14T140227.702.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('8450096b-3cfc-4ed8-aeac-25f5be456030','ep1-v3-s1-auto-8','王承恺','图片 - 2026-09-14T140044.487.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('71e8b32e-c3ae-476e-8d22-27f2905f5615','ep1-v3-s1-auto-8','王承恺','图片 - 2026-09-14T135926.626.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('82bc2b56-cbe2-4cca-8ce4-8be099892cba','ep1-v3-s1-auto-9','王承恺','图片 - 2026-09-14T140115.174.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('5d1856da-34c3-4c11-9c8b-136e3050acef','ep1-v3-s7-i01','罗新姗','IMG_0507.JPG');
INSERT INTO art_file_ownership_backup_0914 VALUES('6dbd33f9-6868-4832-a799-2c8351b9da13','ep1-v3-s7-i01','罗新姗','IMG_0506.JPG');
INSERT INTO art_file_ownership_backup_0914 VALUES('6cb351c9-942e-4748-87bf-ee103f18ef8a','ep1-v3-s7-i01','玉冰','28cb3986d21dacb5ac8f3d660d1bb331.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('182ad487-9f33-4b2c-80df-4d4e1ba1269f','ep1-v3-s7-i01','罗新姗','IMG_0505.JPG');
INSERT INTO art_file_ownership_backup_0914 VALUES('0b8db1cf-560d-4380-95a2-ce637d1cea47','ep1-v3-s7-i01','玉冰','85a3671004a61724de177288cb5041e6.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('ee1de1e2-8b75-41e9-8775-e16bed271876','ep1-v3-s7-i01','罗新姗','IMG_0504.JPG');
INSERT INTO art_file_ownership_backup_0914 VALUES('83563063-2c3e-48d0-b1aa-b7cf0f922a3b','ep1-v3-s7-i01','玉冰','c88124b172e72cc1fff259b0af64b43c.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('58f8082d-06a6-4488-a723-a88a8ed1925b','ep1-v3-s7-i01','玉冰','1aece3bb68dd2f9950a402b548ae64b2.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('dfa8522b-33e7-4578-b0f6-694d29ba8106','ep1-v3-s7-i01','玉冰','64721185ba4e059022764bc6d9aceb00.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('17c10d75-7b36-4309-b972-1a4fee9edc8f','ep1-v3-s7-i01','玉冰','38031c83a5a5f22c5e75bc72cc403410.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('228a0145-722b-4011-923e-0583b90028c1','ep1-v3-s7-i01','玉冰','16f85cdea6400ab45679d2ac1e1bfeb4.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('db6531be-718d-4359-a91f-5b6a1633cc99','ep1-v3-s7-i01','玉冰','b17c5bfbf860a97f29d2de9d617d3fca.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('8f3acbff-28ed-406e-866b-e74f0de7f348','ep1-v3-s7-i01','玉冰','79cf0582b6f793ca4c668c57605b03e5.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('fcb322ab-867a-44fa-a103-60a17666d36b','ep1-v3-s7-i01','玉冰','b0a0b97315a5cad66e3fd87f4b2a3892.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('3a37a9ca-ce51-4105-9409-13c3b692a406','ep1-v3-s7-i01','玉冰','4e7c8e1b5191b90560b6f8ef1110afb2.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('f0f2a575-e7be-4591-b450-2bbc8e642f80','ep1-v3-s7-i01','玉冰','20318d68479db6282d56c143b07555f6.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('76e7788f-74a7-4162-bb73-fd9495c2d7d8','ep1-v3-s7-i01','玉冰','d92d086c7c2e67531205cf4fa5caf306.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('9d080b36-1e7c-456b-9578-99bb59ed4482','ep1-v3-s7-i01','玉冰','bbd3e3a7fd4732cd7e23be5aa7f10364.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('6ec855e3-79b7-40ee-ae4b-bacb9acfd047','ep1-v3-s7-i01','玉冰','4526eb5e228e8addf0957f5e35814a76.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('f64448e5-6b00-4703-b8e6-ecfbd842497e','ep1-v3-s1-auto-11','王承恺','图片 - 2026-09-14T142156.710.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('33885290-7473-4638-8e81-311921c4b9e0','ep1-v3-s7-i03','罗新姗','IMG_0511.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('c77d0282-e97c-4f7d-b9d3-1e849fb3b08c','ep1-v3-s7-i03','罗新姗','IMG_0510.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('f004c2f6-313f-4037-80ce-d1377b4a45b7','ep1-v3-s1-auto-11','王承恺','图片 - 2026-09-14T143054.419.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('6b48a2d2-4c9a-431d-adf0-bb278bfc55ef','ep1-v3-s1-auto-20','王承恺','图片 - 2026-09-14T143134.745.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('56b4c63d-3e53-45ba-8cd8-9d0ffaf3ce48','ep1-v3-s1-auto-11','罗新姗','IMG_0512-web.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('b788eeb8-6ec6-4e51-8911-b1cb99ad2323','ep1-v3-s1-auto-20','王承恺','图片 - 2026-09-14T144306.507.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('43bebf5d-bfc6-4881-b306-df81757aba76','ep1-v3-s2-auto-4','王承恺','图片 - 2026-09-10T143809.164-web.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('81d9d08b-f5a2-452f-8e88-ac14397509dc','ep1-v3-s1-auto-10','胖胖','3FXl29iRGihq0Rg2wl-0EqW6M0UxL1A5rMa819ghIFHt0po9Ma9L8xOnPKH18E-kDuEp-PhrJflHuaNyYO4bKDnwIQkEr49pDqHyB_UNhiCGZVtpLjpRiB7muaBZr532Fs2xkwA0pwx0tiJi2qRu7k3WOkyNK_EGn4xoRXbEuDS2axhxG8Q6');
INSERT INTO art_file_ownership_backup_0914 VALUES('78676931-85e0-4121-87fa-22e394328aa3','ep1-v3-s1-auto-10','胖胖','DP329151-web.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('66604019-6c7a-44bb-90b2-f6791ce31252','ep1-v3-s1-auto-10','胖胖','gc3CRefyAYioNJort_cJ_tZRfeyV0ISKRr5FwLBbcegZcw8Drjs5l2kYkoguXc27_TtWZku8PSGMmOk3Y3esbkb8p2SfFSRbDNpEfYj5Vnd-BfuoJZ026UNy3pITj2yEKFcdDM0jExWDFvBo4TsJ9vfTvrpQwHgEK7spr0KCd6gyozgmdRD8');
INSERT INTO art_file_ownership_backup_0914 VALUES('c915aeda-87f9-4a40-9bc1-24a60234ded4','ep1-v3-s1-auto-10','胖胖','h3VJiQWSoP6bcWmeGkNSCNWIZiTaG3a-pLnHAdTHCZQuvDalsfYQd9jQSxM8ir5ERWVq8kttaCzsYn_T0hOStOoqiSHvlNJDf2iRvSXyfcrwQkRgmDI63p_OP9xYxWHojrb0SGF0XlbjRswnGO3xWo0vy20U1vegfqt30ujMW8XD95iyjyla');
INSERT INTO art_file_ownership_backup_0914 VALUES('f7fdee75-bd50-480d-9820-43c780b8a716','ep1-v3-s1-auto-10','胖胖','GGrD3BiHCdP3TBZJEaqyw9ECSHTME9RdnK4qUxTAPTJYzpXsqYnfvvSvb6gRKOVMVTsLvIKrgpdvk4l_7KQ1zkW6J6Xr330RFSowxI3frcTYpvJhzjPhtImYXQoLjMTot9k6iSjZBDs9di4ZhX7QLq98oGYFa9T2sfr6ku9D1Q-8uJ-r8uyW');
INSERT INTO art_file_ownership_backup_0914 VALUES('124174a0-d627-4f77-83e9-a7ad4ad7f1db','ep1-v3-s1-auto-10','胖胖','L6zzgdcxfvRGbHLQyjyQOy_sqvqzkryHIhFu2Uhip4tZ5o96rJMcLbRtWZPHLzFvh5zVw38NpaZW-9sIZmUChob20dUIIeYrLSnHNbIcijFCshzF1SW9DhrbeszHN0QyQ-U4ptsEldE-9Wi4kMXqDVcYNsRf30nOGCnyk6776sOXMpcINfop');
INSERT INTO art_file_ownership_backup_0914 VALUES('5d85cd42-8d03-4361-b8c2-aa0c76b72efc','ep1-v3-s1-auto-10','胖胖','lKHCXThffZNoCJ9KvB6v9j8OxHFJSdJPvjjB3W1MfiAwRBOtEpesQOAq8H-SednqAqb78UF4d5n2zE8IWE6dLH2pk19vUXJb9JVhMkH9i_mXCdhfa8lXZOsUZ41iZq-z3w8Bo1TYmb37LTDxHujtzeFqVGHJB5gW7RwyX-V2rzPzG9d2FZU_');
INSERT INTO art_file_ownership_backup_0914 VALUES('39d63a15-2ed2-4301-aea1-69695a6274f8','ep1-v3-s1-auto-10','胖胖','MUmtaFheaqa-zL2yA8fUXwCWRuDmRTU2tMwvKvfBtaPfO0pOOJgf8d0yYMWxSCs1i2ZttO6QnRCp3LUrP57GZOw2Qv19WO-npHikqlkVbNtjKPvDf-gUdZTOWsQh1-ocsWKFU1gKQphPIpqqcpUcstGt4p3BQdZrQAzGHr4VBVYjQRHgbPXn');
INSERT INTO art_file_ownership_backup_0914 VALUES('2a05b8ba-1752-4fce-be52-e51d3ff46f33','ep1-v3-s1-auto-10','胖胖','lDwPZNx2ySF8bgaW7NAqpxTWD7tgSUy336-PCAC9OcjwY1gdffz89RN9yrLkQeACZLAeTy2sXAOpEEqsISJALHts18GaOzs-_9snazTyQW7kKCCU4bCeUarFlAoi7jvPWrtT1jTtdVq60TJ5hRaydph2H8VALG6E6cwXrR4XpT8N2tAc9n1i');
INSERT INTO art_file_ownership_backup_0914 VALUES('9e7c2bbf-e656-4e25-9268-4500dc7fc0f2','ep1-v3-s1-auto-10','胖胖','nxEsD9pQ-5FEHrjIcR-V_Ql7JP_aG50YOKBWwc5jFuEtq1j3pNhenxpSXZ61H8rYd1930Y1LnRzExRVumawzjeq9dNZNYnUh66KtHdZPoO8p-wOYaHfPgTchyMX-Zn01BtlERi505sjTnxXZb5kDwvTtE30-1nPPXKZ-1D9cg0hC7y9tzVEI');
INSERT INTO art_file_ownership_backup_0914 VALUES('64f84f63-bded-4652-8767-36fa6e40190f','ep1-v3-s1-auto-10','胖胖','sKp52dlO-GkJ9p4APYnpRk9uS5KJDDeH8T5ItIxRwzVZPg4PaItdiiCYtg0cJlU57PSQLapNl3Re4GWBaohLWTXJTh0RWL-HKAmmPCbwO6AZwcGG60SF01ziZ2cP7_4vu5ElPkJN2xdTse8IToWjyEVEaGE4aVcy7AqqwgGhHVxq9eJ9rBrP');
INSERT INTO art_file_ownership_backup_0914 VALUES('978d2eae-7391-48fd-90eb-774d237e1821','ep1-v3-s1-auto-10','胖胖','UpgfK781YxJoZzqFOunv5qNB-Lmd5UDFRp71DamrZyRg3ATlsPfiTkyt-sRWJtvfbcNCfEW0H4-CrxbuyXzh9azn9QpBZWIvcoJijEmc9GhrQO8MWtXgUO7v1gD8pVACBmiTplda6qemMkSHfoUl9Zn8qJK17oA5i8m92j3RUEynZ_F4W56O');
INSERT INTO art_file_ownership_backup_0914 VALUES('636f94f7-a1ad-4f41-b229-236366d97749','ep1-v3-s1-auto-10','胖胖','Whzb-CShAB4a6JaLGDIYN8EcH_NLMMXQHfppewxrsxiB4tPWjUYhCOfdijo6GSuG5F02ofnbfytu5K71PRIzvg06Hx8V_eSN7neUIYDVJtUOzXSldYnzamYQV6LXFqTMoxnpZyq7e48nlz3TiSEGZuhU-6TymJH3Yc4e8C6UkcwJx3UygKm4');
INSERT INTO art_file_ownership_backup_0914 VALUES('aa575347-de1d-4f6c-afe2-b7d73c4d08a0','ep1-v3-s1-auto-10','胖胖','wKzh4SRsyrNHjP18bv5DDWvtuQoPWEMowiStNQSKmrt8cd-D8sNZ_HTEsG10PKDERqgiZfYNcOpQae-iEXRA7BzC5GVfG_XjoFsRcdFnvRPxbE0aql8xkXEkU10ac_8aPDnoI-zfTUAaBE7EPePf1qbawRJBaZULfhJWimMCSwU_iX51RB6P');
INSERT INTO art_file_ownership_backup_0914 VALUES('8c5656b7-bbcc-4eb1-8b2a-b659e57f2763','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2005_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('bbbbb0f6-7506-4a29-b411-f48d02face5e','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2006_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('a689d2a3-ffa9-4a1b-9ce1-d49bf1637677','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2007_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('ceee1bb2-bf4a-4fa7-a205-41e7a09187cb','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2008_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('4706554b-772d-462d-9f70-1495e52a4741','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2009_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('fb3ad5da-7484-490f-9222-c4711c745dc4','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2010_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('232f38f6-b07c-4cc2-8879-f2e6c6735238','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2011_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('bac0881e-9426-4e0c-a51d-22e5c0fc06a4','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2012_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('bdbb3a8d-8972-45cc-b09d-240750006353','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2013_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('9e3fb7fb-e777-45db-9359-c5ef010ff3f6','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2015_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('d6b756dc-d516-44dd-b02c-030dccf0685d','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2014_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('d0902c5e-8877-477b-af40-764d692256b5','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2016_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('1f8d2c29-aaba-49a7-a4c0-63bf3ae0a9b9','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2018_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('488f4f4a-6818-4c73-859e-788685b9cab7','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2017_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('1b9688b0-19c2-4452-bec6-3afbe5bb6cda','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2021_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('c7d093ef-5ea2-4a75-ae8e-dd33f06af732','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2020_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('f786439e-b0e4-4682-88aa-92de57eddae2','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2022_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('a14cf2ca-e57f-4997-9c3c-109d72c8a380','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2023_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('6b88ae5a-1d2b-4a55-8d19-c565f9348acd','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2024_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('8bb9f69a-7643-47b3-998a-929319b91da8','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2028_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('f4669b8c-bceb-47e8-bd78-6c18d756caaf','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2037_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('102f9bd1-c456-4642-a928-4f296cd423fe','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2039_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('e1d64053-8d7a-4e0d-a8f9-0f10328fad78','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2040_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('7e759486-2bc8-4b80-afea-14c4bd284fcc','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2042_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('619c49b6-b63c-4116-b1b7-67bd97b4ce5a','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2041_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('06a7d8dc-de7e-46e6-b5c3-9ac3d5dc641a','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2043_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('c80882ee-2194-47d5-8cc7-6d883c900aff','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2045_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('6ce5ab18-5eb1-4c32-bbbf-488ae9e1bf9c','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2046_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('0c7a5c9b-893a-498d-9708-8998a9b3b055','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2049_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('5630e975-b6b7-454b-a875-70be7b386498','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2048_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('e7a4750a-96c9-4ec3-b717-ce2601ba5811','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2050_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('336a9253-bcba-4a8d-bc1c-fe0d3591da3e','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2052_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('30fe8a44-1f68-4fe4-84ed-1a5f6e14163f','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2051_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('b55ab793-9918-40dd-add6-319c4e8a10a4','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2053_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('18bfdf1c-7ef4-4e14-ba41-506c754fedf1','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2055_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('abf30ac7-7116-4767-9252-2f15a2e56054','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2054_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('dce5fbc8-10db-43f8-964a-b824a23c8e0c','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2056_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('b4d21e02-5c41-4b01-808c-b80d4ccfa14e','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2057_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('e47a9fb7-42bb-47cd-bbaa-d879c724f4c3','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2058_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('d5209c8f-3be4-4204-a5cc-1a800b0c7563','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2060_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('4cf816c6-0cc1-4046-8c13-9dfb0b260ced','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2059_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('52887c83-e5cf-4be6-8d25-42714699b0d9','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2063_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('11072865-e078-4bba-a7a6-79a6a3fc8baa','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2062_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('cea86304-ecc6-40f9-acac-97386298d1b2','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2061_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('ddfbe91d-f7ca-4e43-bc2e-da26a34071b9','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2064_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('d6f9d003-5a9f-48d4-90df-9b78067270c0','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2065_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('90f40f71-021f-4be0-bd76-658256187c3c','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2066_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('7834c7bd-2ad1-44eb-bd62-aa2c7b77bdc4','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2068_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('75010c7c-2e36-4843-a434-0175353fc39e','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2067_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('99a3c05d-9576-44b2-a316-e5be578cee19','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2069_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('1d82a4b6-6b71-4151-9796-294a0c1d9b86','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2071_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('08d3ed05-dc9a-4768-9b7c-d1c2317c9493','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2070_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('be9c172f-8d0e-4e36-b3bc-e3c60983a058','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2072_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('82859475-93a8-4d72-8206-61666409f219','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2073_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('32b52ecd-92e9-4d74-ae84-200fd74ecd03','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2074_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('7d76a4f0-4bf5-4ab6-a61c-1969cfa7e79e','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2075_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('0730514c-4dd5-4595-97e0-cb0ae26d6aae','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2079_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('d4d9449d-8d6f-472b-8470-c88e25bc877b','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2078_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('3078a7ca-aba7-41f2-8057-c967561fe565','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2081_22.jpg');
INSERT INTO art_file_ownership_backup_0914 VALUES('b4bc5eee-37d9-4abb-88ee-996c37bc99be','ep1-v3-s1-auto-10','胖胖','微信图片_20260914144522_2080_22.jpg');
CREATE TABLE production_plan_backup_0914(
  id TEXT,
  work_date TEXT,
  episode TEXT,
  category TEXT,
  title TEXT,
  owner TEXT,
  reviewer TEXT,
  status TEXT,
  planned_qty INT,
  completed_qty INT,
  due_time TEXT,
  note TEXT,
  sort_order INT,
  updated_at TEXT,
  depends_on_id TEXT,
  handoff_to TEXT,
  handoff_deadline TEXT
);
INSERT INTO production_plan_backup_0914 VALUES('rollup-2026-09-14-ep1-script','2026-09-14','第1集','剧本','交付第1集完整剧本','编剧','叶总／Yoyo','已通过',1,1,'12:00','整集一次交付，不再按7个场次分别确认，也不参与美术资产审核。',1,'2026-09-14T07:12:21.210Z','','执行制片人：Lipa','交付后继续下一集');
INSERT INTO production_plan_backup_0914 VALUES('rollup-2026-09-14-ep2-script','2026-09-14','第2集','剧本','提交第2集完整剧本给Lipa','编剧','叶总／Yoyo','未开始',1,0,'13:00','上传完整稿，由Lipa选择定稿后生成本集生产与美术清单。',2,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','提交后立即定稿');
INSERT INTO production_plan_backup_0914 VALUES('rollup-2026-09-14-ep1-art','2026-09-14','第1集','美术清单','生成并上传第1集全部主美资产','主美','叶总／Yoyo','未开始',29,0,'18:00','点开生产手册查看7场、共40项人物造型/服装/道具/场景图清单；不逐项做审核勾选。',2,'2026-09-14T07:12:21.210Z','rollup-2026-09-14-ep1-script','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('rollup-2026-09-14-ep2-art','2026-09-14','第2集','美术清单','生成并上传第2集全部美术资产','主美','叶总／Yoyo','未开始',0,0,'20:00','人物造型、服装、道具、场景全部生成并上传；按最终剧本清单逐项完成。',4,'2026-09-12T12:12:47.631Z','rollup-2026-09-14-ep2-script','执行制片人：Lipa','20:15');
INSERT INTO production_plan_backup_0914 VALUES('rollup-2026-09-14-ep1-wardrobe','2026-09-14','第1集','场景服装清单','上传第1集全部场景与每个角色服装图','服化道副导演','叶总／Yoyo','已通过',40,1,'18:00','与主美并行，负责场景和每个角色的服装；图片自动记录实际上传人。',3,'2026-09-14T07:12:21.210Z','rollup-2026-09-14-ep1-script','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('rollup-2026-09-14-ep2-wardrobe','2026-09-14','第2集','场景服装清单','上传第2集全部场景与每个角色服装图','服化道副导演','叶总／Yoyo','未开始',1,0,'20:00','与主美并行；负责场景和每个角色的服装，图片自动记录实际上传人。',6,'2026-09-12T12:12:47.631Z','rollup-2026-09-14-ep2-script','执行制片人：Lipa','20:15');
INSERT INTO production_plan_backup_0914 VALUES('rollup-2026-09-14-ep1-send','2026-09-14','第1集','资产提报','整理第1集完整资产包并上传给Yoyo','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'18:30','确认主美与服化道副导演已上传完整；整集提报，不逐项拆开确认。',4,'2026-09-14T07:12:21.210Z','rollup-2026-09-14-ep1-wardrobe','叶总／Yoyo','发出后等待微信确认');
INSERT INTO production_plan_backup_0914 VALUES('rollup-2026-09-14-ep2-send','2026-09-14','第2集','资产提报','整理第2集全部图片并上传给Yoyo','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','确认主美与服化道副导演已传齐，再生成美术提报H5／PDF并上传Yoyo。',8,'2026-09-12T12:12:47.631Z','rollup-2026-09-14-ep2-wardrobe','叶总／Yoyo','发出后等待回复');
INSERT INTO production_plan_backup_0914 VALUES('rollup-2026-09-14-ep1-review','2026-09-14','第1集','整集资产确认','记录叶总／Yoyo是否已确认第1集全部资产','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一记录为叶总／Yoyo一项；本平台由Lipa录入最终结果。',5,'2026-09-14T07:12:21.210Z','rollup-2026-09-14-ep1-send','执行制片人：Lipa','收到微信后录入');
INSERT INTO production_plan_backup_0914 VALUES('rollup-2026-09-14-ep2-review','2026-09-14','第2集','整集资产确认','记录叶总／Yoyo对第2集全部资产的审核结果','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一记录为“叶总／Yoyo”，不再拆成两项。',10,'2026-09-12T12:12:47.631Z','rollup-2026-09-14-ep2-send','执行制片人：Lipa','收到微信后录入');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-12-gen','2026-09-15','第1集','正式镜头','生成第1集正式镜头 · 第1天','AIGC抽卡师','叶总／Yoyo','未开始',1,0,'19:00','只统计审核可用镜头',100,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-12-script','2026-09-15','第2—3集','剧本','编写第2—3集 · 第1天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',102,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-12-prep','2026-09-15','第2—3集','场景图','提报第2—3集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',103,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-12-review','2026-09-15','第1集 / 第2—3集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',105,'2026-09-12T12:12:47.631Z','2026-09-12-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-12-lipa','2026-09-15','第1集 / 第2—3集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',106,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-13-gen','2026-09-16','第1集','正式镜头','生成第1集正式镜头 · 第2天','AIGC抽卡师','叶总／Yoyo','未开始',1,0,'19:00','本集全部素材齐套，当晚同步剪辑',104,'2026-09-12T12:12:47.631Z','','剪辑','20:00');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-13-script','2026-09-16','第2—3集','剧本','编写第2—3集 · 第2天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',106,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-13-prep','2026-09-16','第2—3集','场景图','提报第2—3集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',107,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-13-review','2026-09-16','第1集 / 第2—3集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',109,'2026-09-12T12:12:47.631Z','2026-09-13-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-13-lipa','2026-09-16','第1集 / 第2—3集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',110,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-14-rough','2026-09-17','第1集','初剪','接收第1集全部素材并完成初剪','剪辑','叶总／Yoyo','未开始',1,0,'21:00','素材齐套后预留1天完成初剪',108,'2026-09-12T12:12:47.631Z','2026-09-13-gen','执行制片人：Lipa','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-14-script','2026-09-17','第2—3集','剧本','编写第2—3集 · 第3天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',110,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-14-prep','2026-09-17','第2—3集','场景图','提报第2—3集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',111,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-14-review','2026-09-17','第1集 / 第2—3集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',113,'2026-09-12T12:12:47.631Z','2026-09-14-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-14-lipa','2026-09-17','第1集 / 第2—3集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',114,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-15-final','2026-09-18','第1集','成片','完成第1集修改版与成片','剪辑','叶总／Yoyo','未开始',1,0,'21:00','初剪反馈后预留1天修改与交片',112,'2026-09-12T12:12:47.631Z','2026-09-14-rough','执行制片人：Lipa','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-15-script','2026-09-18','第2—3集','剧本','锁定第2—3集全部剧本','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',114,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-15-prep','2026-09-18','第2—3集','场景图','提报第2—3集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',115,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-15-review','2026-09-18','第1集 / 第2—3集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',117,'2026-09-12T12:12:47.631Z','2026-09-15-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-15-lipa','2026-09-18','第1集 / 第2—3集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',118,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-17-gen','2026-09-19','第2—3集','正式镜头','生成第2—3集正式镜头 · 第1天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','只统计审核可用镜头',130,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-17-script','2026-09-19','第4—5集','剧本','编写第4—5集 · 第1天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',132,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-17-prep','2026-09-19','第4—5集','场景图','提报第4—5集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',133,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-17-review','2026-09-19','第2—3集 / 第4—5集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',135,'2026-09-12T12:12:47.631Z','2026-09-17-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-17-lipa','2026-09-19','第2—3集 / 第4—5集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',136,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-18-gen','2026-09-21','第2—3集','正式镜头','生成第2—3集正式镜头 · 第2天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','只统计审核可用镜头',134,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-18-script','2026-09-21','第4—5集','剧本','编写第4—5集 · 第2天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',136,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-18-prep','2026-09-21','第4—5集','场景图','提报第4—5集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',137,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-18-review','2026-09-21','第2—3集 / 第4—5集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',139,'2026-09-12T12:12:47.631Z','2026-09-18-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-18-lipa','2026-09-21','第2—3集 / 第4—5集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',140,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-19-gen','2026-09-22','第2—3集','正式镜头','生成第2—3集正式镜头 · 第3天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','只统计审核可用镜头',138,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-19-script','2026-09-22','第4—5集','剧本','编写第4—5集 · 第3天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',140,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-19-prep','2026-09-22','第4—5集','场景图','提报第4—5集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',141,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-19-review','2026-09-22','第2—3集 / 第4—5集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',143,'2026-09-12T12:12:47.631Z','2026-09-19-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-19-lipa','2026-09-22','第2—3集 / 第4—5集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',144,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-20-gen','2026-09-23','第2—3集','正式镜头','生成第2—3集正式镜头 · 第4天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','本集全部素材齐套，当晚同步剪辑',142,'2026-09-12T12:12:47.631Z','','剪辑','20:00');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-20-script','2026-09-23','第4—5集','剧本','编写第4—5集 · 第4天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',144,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-20-prep','2026-09-23','第4—5集','场景图','提报第4—5集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',145,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-20-review','2026-09-23','第2—3集 / 第4—5集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',147,'2026-09-12T12:12:47.631Z','2026-09-20-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-20-lipa','2026-09-23','第2—3集 / 第4—5集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',148,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-21-rough','2026-09-24','第2—3集','初剪','接收第2—3集全部素材并完成初剪','剪辑','叶总／Yoyo','未开始',1,0,'21:00','素材齐套后预留1天完成初剪',146,'2026-09-12T12:12:47.631Z','2026-09-20-gen','执行制片人：Lipa','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-21-script','2026-09-24','第4—5集','剧本','编写第4—5集 · 第5天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',148,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-21-prep','2026-09-24','第4—5集','场景图','提报第4—5集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',149,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-21-review','2026-09-24','第2—3集 / 第4—5集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',151,'2026-09-12T12:12:47.631Z','2026-09-21-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-21-lipa','2026-09-24','第2—3集 / 第4—5集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',152,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-22-final','2026-09-25','第2—3集','成片','完成第2—3集修改版与成片','剪辑','叶总／Yoyo','未开始',1,0,'21:00','初剪反馈后预留1天修改与交片',150,'2026-09-12T12:12:47.631Z','2026-09-21-rough','执行制片人：Lipa','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-22-script','2026-09-25','第4—5集','剧本','锁定第4—5集全部剧本','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',152,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-22-prep','2026-09-25','第4—5集','场景图','提报第4—5集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',153,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-22-review','2026-09-25','第2—3集 / 第4—5集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',155,'2026-09-12T12:12:47.631Z','2026-09-22-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-22-lipa','2026-09-25','第2—3集 / 第4—5集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',156,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-24-gen','2026-09-26','第4—5集','正式镜头','生成第4—5集正式镜头 · 第1天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','只统计审核可用镜头',160,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-24-script','2026-09-26','第6—7集','剧本','编写第6—7集 · 第1天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',162,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-24-prep','2026-09-26','第6—7集','场景图','提报第6—7集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',163,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-24-review','2026-09-26','第4—5集 / 第6—7集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',165,'2026-09-12T12:12:47.631Z','2026-09-24-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-24-lipa','2026-09-26','第4—5集 / 第6—7集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',166,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-25-gen','2026-09-28','第4—5集','正式镜头','生成第4—5集正式镜头 · 第2天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','只统计审核可用镜头',164,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-25-script','2026-09-28','第6—7集','剧本','编写第6—7集 · 第2天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',166,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-25-prep','2026-09-28','第6—7集','场景图','提报第6—7集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',167,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-25-review','2026-09-28','第4—5集 / 第6—7集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',169,'2026-09-12T12:12:47.631Z','2026-09-25-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-25-lipa','2026-09-28','第4—5集 / 第6—7集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',170,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-26-gen','2026-09-29','第4—5集','正式镜头','生成第4—5集正式镜头 · 第3天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','只统计审核可用镜头',168,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-26-script','2026-09-29','第6—7集','剧本','编写第6—7集 · 第3天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',170,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-26-prep','2026-09-29','第6—7集','场景图','提报第6—7集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',171,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-26-review','2026-09-29','第4—5集 / 第6—7集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',173,'2026-09-12T12:12:47.631Z','2026-09-26-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-26-lipa','2026-09-29','第4—5集 / 第6—7集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',174,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-27-gen','2026-09-30','第4—5集','正式镜头','生成第4—5集正式镜头 · 第4天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','本集全部素材齐套，当晚同步剪辑',172,'2026-09-12T12:12:47.631Z','','剪辑','20:00');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-27-script','2026-09-30','第6—7集','剧本','编写第6—7集 · 第4天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',174,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-27-prep','2026-09-30','第6—7集','场景图','提报第6—7集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',175,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-27-review','2026-09-30','第4—5集 / 第6—7集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',177,'2026-09-12T12:12:47.631Z','2026-09-27-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-27-lipa','2026-09-30','第4—5集 / 第6—7集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',178,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-28-rough','2026-10-08','第4—5集','初剪','接收第4—5集全部素材并完成初剪','剪辑','叶总／Yoyo','未开始',1,0,'21:00','素材齐套后预留1天完成初剪',176,'2026-09-12T12:12:47.631Z','2026-09-27-gen','执行制片人：Lipa','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-28-script','2026-10-08','第6—7集','剧本','编写第6—7集 · 第5天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',178,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-28-prep','2026-10-08','第6—7集','场景图','提报第6—7集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',179,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-28-review','2026-10-08','第4—5集 / 第6—7集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',181,'2026-09-12T12:12:47.631Z','2026-09-28-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-28-lipa','2026-10-08','第4—5集 / 第6—7集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',182,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-29-final','2026-10-09','第4—5集','成片','完成第4—5集修改版与成片','剪辑','叶总／Yoyo','未开始',1,0,'21:00','初剪反馈后预留1天修改与交片',180,'2026-09-12T12:12:47.631Z','2026-09-28-rough','执行制片人：Lipa','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-29-script','2026-10-09','第6—7集','剧本','锁定第6—7集全部剧本','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',182,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-29-prep','2026-10-09','第6—7集','场景图','提报第6—7集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',183,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-29-review','2026-10-09','第4—5集 / 第6—7集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',185,'2026-09-12T12:12:47.631Z','2026-09-29-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-09-29-lipa','2026-10-09','第4—5集 / 第6—7集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',186,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-08-gen','2026-10-10','第6—7集','正式镜头','生成第6—7集正式镜头 · 第1天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','只统计审核可用镜头',190,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-08-script','2026-10-10','第8—9集','剧本','编写第8—9集 · 第1天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',192,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-08-prep','2026-10-10','第8—9集','场景图','提报第8—9集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',193,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-08-review','2026-10-10','第6—7集 / 第8—9集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',195,'2026-09-12T12:12:47.631Z','2026-10-08-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-08-lipa','2026-10-10','第6—7集 / 第8—9集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',196,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-09-gen','2026-10-12','第6—7集','正式镜头','生成第6—7集正式镜头 · 第2天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','只统计审核可用镜头',194,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-09-script','2026-10-12','第8—9集','剧本','编写第8—9集 · 第2天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',196,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-09-prep','2026-10-12','第8—9集','场景图','提报第8—9集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',197,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-09-review','2026-10-12','第6—7集 / 第8—9集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',199,'2026-09-12T12:12:47.631Z','2026-10-09-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-09-lipa','2026-10-12','第6—7集 / 第8—9集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',200,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-10-gen','2026-10-13','第6—7集','正式镜头','生成第6—7集正式镜头 · 第3天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','只统计审核可用镜头',198,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-10-script','2026-10-13','第8—9集','剧本','编写第8—9集 · 第3天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',200,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-10-prep','2026-10-13','第8—9集','场景图','提报第8—9集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',201,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-10-review','2026-10-13','第6—7集 / 第8—9集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',203,'2026-09-12T12:12:47.631Z','2026-10-10-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-10-lipa','2026-10-13','第6—7集 / 第8—9集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',204,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-11-gen','2026-10-14','第6—7集','正式镜头','生成第6—7集正式镜头 · 第4天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','本集全部素材齐套，当晚同步剪辑',202,'2026-09-12T12:12:47.631Z','','剪辑','20:00');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-11-script','2026-10-14','第8—9集','剧本','编写第8—9集 · 第4天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',204,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-11-prep','2026-10-14','第8—9集','场景图','提报第8—9集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',205,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-11-review','2026-10-14','第6—7集 / 第8—9集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',207,'2026-09-12T12:12:47.631Z','2026-10-11-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-11-lipa','2026-10-14','第6—7集 / 第8—9集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',208,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-12-rough','2026-10-15','第6—7集','初剪','接收第6—7集全部素材并完成初剪','剪辑','叶总／Yoyo','未开始',1,0,'21:00','素材齐套后预留1天完成初剪',206,'2026-09-12T12:12:47.631Z','2026-10-11-gen','执行制片人：Lipa','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-12-script','2026-10-15','第8—9集','剧本','编写第8—9集 · 第5天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',208,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-12-prep','2026-10-15','第8—9集','场景图','提报第8—9集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',209,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-12-review','2026-10-15','第6—7集 / 第8—9集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',211,'2026-09-12T12:12:47.631Z','2026-10-12-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-12-lipa','2026-10-15','第6—7集 / 第8—9集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',212,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-13-final','2026-10-16','第6—7集','成片','完成第6—7集修改版与成片','剪辑','叶总／Yoyo','未开始',1,0,'21:00','初剪反馈后预留1天修改与交片',210,'2026-09-12T12:12:47.631Z','2026-10-12-rough','执行制片人：Lipa','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-13-script','2026-10-16','第8—9集','剧本','锁定第8—9集全部剧本','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',212,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-13-prep','2026-10-16','第8—9集','场景图','提报第8—9集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',213,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-13-review','2026-10-16','第6—7集 / 第8—9集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',215,'2026-09-12T12:12:47.631Z','2026-10-13-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-13-lipa','2026-10-16','第6—7集 / 第8—9集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',216,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-15-gen','2026-10-17','第8—9集','正式镜头','生成第8—9集正式镜头 · 第1天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','只统计审核可用镜头',220,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','19:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-15-script','2026-10-17','第10集','剧本','编写第10集 · 第1天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',222,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-15-prep','2026-10-17','第10集','场景图','提报第10集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',223,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-15-review','2026-10-17','第8—9集 / 第10集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',225,'2026-09-12T12:12:47.631Z','2026-10-15-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-15-lipa','2026-10-17','第8—9集 / 第10集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',226,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-16-gen','2026-10-19','第8—9集','正式镜头','生成第8—9集正式镜头 · 第2天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','本集全部素材齐套，当晚同步剪辑',224,'2026-09-12T12:12:47.631Z','','剪辑','20:00');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-16-script','2026-10-19','第10集','剧本','编写第10集 · 第2天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',226,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-16-prep','2026-10-19','第10集','场景图','提报第10集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',227,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-16-review','2026-10-19','第8—9集 / 第10集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',229,'2026-09-12T12:12:47.631Z','2026-10-16-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-16-lipa','2026-10-19','第8—9集 / 第10集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',230,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-17-rough','2026-10-20','第8—9集','初剪','接收第8—9集全部素材并完成初剪','剪辑','叶总／Yoyo','未开始',1,0,'21:00','素材齐套后预留1天完成初剪',228,'2026-09-12T12:12:47.631Z','2026-10-16-gen','执行制片人：Lipa','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-17-script','2026-10-20','第10集','剧本','编写第10集 · 第3天','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',230,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-17-prep','2026-10-20','第10集','场景图','提报第10集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',231,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-17-review','2026-10-20','第8—9集 / 第10集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',233,'2026-09-12T12:12:47.631Z','2026-10-17-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-17-lipa','2026-10-20','第8—9集 / 第10集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',234,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-18-final','2026-10-21','第8—9集','成片','完成第8—9集修改版与成片','剪辑','叶总／Yoyo','未开始',1,0,'21:00','初剪反馈后预留1天修改与交片',232,'2026-09-12T12:12:47.631Z','2026-10-17-rough','执行制片人：Lipa','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-18-script','2026-10-21','第10集','剧本','锁定第10集全部剧本','编剧','叶总／Yoyo','未开始',6,0,'18:00','单集最多3天，双集5天锁定',234,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','18:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-18-prep','2026-10-21','第10集','场景图','提报第10集场景、服装、配角与白模','主美','叶总／Yoyo','未开始',2,0,'17:00','每天提报2场；发给Yoyo后继续下一场，不等待回复',235,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','完成后即提报');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-18-review','2026-10-21','第8—9集 / 第10集','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',237,'2026-09-12T12:12:47.631Z','2026-10-18-prep','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-18-lipa','2026-10-21','第8—9集 / 第10集','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',238,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-19-gen','2026-10-22','第10集','正式镜头','生成第10集正式镜头 · 第1天','AIGC抽卡师','叶总／Yoyo','未开始',2,0,'19:00','本集全部素材齐套，当晚同步剪辑',250,'2026-09-12T12:12:47.631Z','','剪辑','20:00');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-19-finish','2026-10-22','全片','精剪','全片精剪、声音与视觉统一','剪辑','叶总／Yoyo','未开始',1,0,'22:00','成片前总检查',252,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','22:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-19-review','2026-10-22','第10集 / 全片','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',255,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-19-lipa','2026-10-22','第10集 / 全片','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',256,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-20-rough','2026-10-23','第10集','初剪','接收第10集全部素材并完成初剪','剪辑','叶总／Yoyo','未开始',1,0,'21:00','素材齐套后预留1天完成初剪',254,'2026-09-12T12:12:47.631Z','2026-10-19-gen','执行制片人：Lipa','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-20-finish','2026-10-23','全片','精剪','全片精剪、声音与视觉统一','剪辑','叶总／Yoyo','未开始',1,0,'22:00','成片前总检查',256,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','22:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-20-review','2026-10-23','第10集 / 全片','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',259,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-20-lipa','2026-10-23','第10集 / 全片','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',260,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-21-final','2026-10-24','第10集','成片','完成第10集修改版与成片','剪辑','叶总／Yoyo','未开始',1,0,'21:00','初剪反馈后预留1天修改与交片',258,'2026-09-12T12:12:47.631Z','2026-10-20-rough','执行制片人：Lipa','21:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-21-finish','2026-10-24','全片','精剪','全片精剪、声音与视觉统一','剪辑','叶总／Yoyo','未开始',1,0,'22:00','成片前总检查',260,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','22:15');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-21-review','2026-10-24','第10集 / 全片','联合审核','叶总／Yoyo审核当日视觉与成片意见','叶总／Yoyo','叶总／Yoyo','未开始',1,0,'微信待回复','审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定',263,'2026-09-12T12:12:47.631Z','','执行制片人：Lipa','收到回复后更新');
INSERT INTO production_plan_backup_0914 VALUES('2026-10-21-lipa','2026-10-24','第10集 / 全片','推进统筹','更新已收到的微信意见并调整次日Rundown','执行制片人：Lipa','叶总／Yoyo','未开始',1,0,'21:00','不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排',264,'2026-09-12T12:12:47.631Z','','全组','21:15');
INSERT INTO production_plan_backup_0914 VALUES('1021-delivery','2026-10-24','全片','成片','全片总审、修正与最终交付','执行制片人：Lipa','叶总／Yoyo','未开始',10,0,'20:00','9月14日正式开工，其余大计划从9月15日起顺延接续。',999,'2026-09-12T12:12:47.631Z','','叶总／Yoyo','20:00');
CREATE TABLE plan_batches_backup_0914(
  id TEXT,
  start_date TEXT,
  end_date TEXT,
  production TEXT,
  prep TEXT,
  note TEXT,
  sort_order INT,
  updated_at TEXT
);
INSERT INTO plan_batches_backup_0914 VALUES('kickoff-0914','2026-09-14','2026-09-14','正式开工 Day 1：第1、2集剧本与全部图片当天交齐','Lipa上传Yoyo · 叶总／Yoyo统一审核','固定开工日，不可修改、不可被自动顺延。',1,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches_backup_0914 VALUES('batch-1','2026-09-15','2026-09-18','第1集 生成＋初剪＋成片','第2—3集 筹备','9月14日开工后接续原大计划。',2,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches_backup_0914 VALUES('batch-2','2026-09-19','2026-09-25','第2—3集 生成＋初剪＋成片','第4—5集 筹备','9月20日六休一，其余任务顺延接续。',3,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches_backup_0914 VALUES('rest-0920','2026-09-20','2026-09-20','全组休息','不排硬交付','从9月14日开工起按六休一计算。',4,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches_backup_0914 VALUES('batch-3','2026-09-26','2026-10-09','第4—5集 生成＋初剪＋成片','第6—7集 筹备','9月27日休息，10月1—7日国庆放假，其他任务顺延。',5,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches_backup_0914 VALUES('rest-0927','2026-09-27','2026-09-27','全组休息','不排硬交付','六休一',6,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches_backup_0914 VALUES('holiday-national-day','2026-10-01','2026-10-07','国庆放假','全组不排工作','按2026年国庆节法定安排休息7天',9,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches_backup_0914 VALUES('batch-4','2026-10-10','2026-10-16','第6—7集 生成＋初剪＋成片','第8—9集 筹备','10月11日六休一，其余任务顺延接续。',10,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches_backup_0914 VALUES('rest-1011','2026-10-11','2026-10-11','全组休息','不排硬交付','六休一',11,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches_backup_0914 VALUES('batch-5','2026-10-17','2026-10-21','第8—9集 生成＋初剪＋成片','第10集 筹备','10月18日六休一，其余任务顺延接续。',12,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches_backup_0914 VALUES('rest-1018','2026-10-18','2026-10-18','全组休息','不排硬交付','六休一',13,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches_backup_0914 VALUES('batch-6','2026-10-22','2026-10-24','第10集生成＋初剪＋成片','全片精剪与统一','第10集保留生成、初剪、修改成片三天。',14,'2026-09-12T12:12:47.631Z');
INSERT INTO plan_batches_backup_0914 VALUES('delivery','2026-10-24','2026-10-24','全片最终交付','机动修正','9月14日正式开工，后续计划顺延接续，预计10月24日交付。',99,'2026-09-12T12:12:47.631Z');
CREATE TABLE art_scene_alignment_items_backup_0914(
  id TEXT,
  analysis_id TEXT,
  category TEXT,
  name TEXT,
  detail TEXT,
  visual_brief TEXT,
  yoyo_approved INT,
  sort_order INT,
  updated_at TEXT,
  producer_approved INT,
  is_active INT
);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s7-i01','ep1-v3-s7','场景','医院单人病房','深夜，监护仪稳定，整体克制安静；能容纳床边助理递手机。','一个场景上传位：先放完整氛围图，再追加局部与不同角度，不按文字拆多个场景项。',0,0,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s7-i02','ep1-v3-s7','人物','陆文川｜人脸、妆造、梳发','刚从溺水复苏，虚弱但判断清晰；按住心口感受残留触感。','本场人脸、妆造、梳发集中在此，可上传多张备选。',0,2,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s7-i03','ep1-v3-s7','服装','陆文川病服','从落水服装切换为病服，保持深夜急救后的真实感。','出病服全身/半身方案；颜色与医院空间配套，待核准。',0,3,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s7-i04','ep1-v3-s7','人物','助理病房状态','向陆文川汇报顾丽乔身份、热视频和监控缺失。','沿用第3场助理，服装可保持视察造型或增加外套湿痕，连续性待核准。',0,4,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s7-i07','ep1-v3-s7','美术图','寻找顾丽乔的决定','陆文川看视频后命令“找到顾丽乔。还有那一分钟。”','出床上陆文川、手机视频和助理同框关键帧，重点是目光与决断。',0,7,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s4-auto-1','ep1-v3-s4','人物','监控外包负责人｜人物造型','根据本场身份、情绪和前后场连续性确定监控外包负责人的妆发与人物状态。','监控外包负责人本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,1,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s4-auto-2','ep1-v3-s4','人物','神秘人（电话声）｜人物造型','根据本场身份、情绪和前后场连续性确定神秘人（电话声）的妆发与人物状态。','神秘人（电话声）本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,2,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s4-auto-3','ep1-v3-s4','服装','本场服装连续性','剧本没有写明具体服装，需根据人物身份、时间地点和前后场确定。','主美补充本场完整穿搭图并标注与前后场是否连戏。',0,3,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s4-auto-7','ep1-v3-s4','场景','影视城监控室　夜　内｜场景图','根据场头“影视城监控室　夜　内”建立本场空间。','一个场景上传位：先放完整氛围图，再追加局部与不同角度，不按文字拆多个场景项。',0,0,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s5-auto-1','ep1-v3-s5','人物','陆文川｜人脸、妆造、梳发','根据本场身份、情绪和前后场连续性确定陆文川的妆发与人物状态。','本场人脸、妆造、梳发集中在此，可上传多张备选。',0,1,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s5-auto-2','ep1-v3-s5','人物','助理｜人物造型','根据本场身份、情绪和前后场连续性确定助理的妆发与人物状态。','助理本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,2,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s5-auto-3','ep1-v3-s5','服装','本场服装连续性','剧本没有写明具体服装，需根据人物身份、时间地点和前后场确定。','主美补充本场完整穿搭图并标注与前后场是否连戏。',0,3,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s5-auto-4','ep1-v3-s5','道具','手机','助理把手机递给他。','生成“手机”设定图；标明外形、材质、尺寸及剧中使用状态。',0,4,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s5-auto-7','ep1-v3-s5','场景','医院病房　深夜　内｜场景图','手机上，是顾丽乔跳入水中救人，和陆文川躺在船上的剪辑视频。评论和转发飞快上涨。','一个场景上传位：先放完整氛围图，再追加局部与不同角度，不按文字拆多个场景项。',0,0,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s6-auto-1','ep1-v3-s6','人物','顾丽乔｜人脸、妆造、梳发','等顾丽乔走近，沈糯才看见顾丽乔手臂上的擦伤，立刻摘下面膜，很是心疼。 顾丽乔：不是拍戏伤的。 顾丽乔没再多说，她坐到灯前，简单整理就打开了直播，却看见镜子里自己多了一缕白发，她对此很困惑。','本场人脸、妆造、梳发集中在此，可上传多张备选。',0,1,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s6-auto-2','ep1-v3-s6','人物','沈糯｜人物造型','沈糯敷着面膜，正在调灯，听到门开，着急地催促着。 等顾丽乔走近，沈糯才看见顾丽乔手臂上的擦伤，立刻摘下面膜，很是心疼。 沈糯：怎么又受伤了？又让你拍危险的戏份了？给钱了吗？','沈糯本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。',0,2,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s6-auto-3','ep1-v3-s6','服装','本场服装连续性','剧本没有写明具体服装，需根据人物身份、时间地点和前后场确定。','主美补充本场完整穿搭图并标注与前后场是否连戏。',0,3,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s6-auto-4','ep1-v3-s6','道具','手机','唯一一张较为宽阔的桌上，架着两盏补光灯和手机。','生成“手机”设定图；标明外形、材质、尺寸及剧中使用状态。',0,4,'2026-09-11T16:56:33.690Z',0,0);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s6-auto-9','ep1-v3-s6','场景','群演酒店标间　深夜　内｜场景图','狭小房间里，摆着许多衣服，空间非常狭窄。 唯一一张较为宽阔的桌上，架着两盏补光灯和手机。 沈糯敷着面膜，正在调灯，听到门开，着急地催促着。 门开，顾丽乔已经换回了自己的衣服，疲惫地走了进来。 顾丽乔没再多说，她坐到灯前，简单整理就打开了直播，却看见镜子里自己多了一缕白发，她对此很困惑。','一个场景上传位：先放完整氛围图，再追加局部与不同角度，不按文字拆多个场景项。',0,0,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s4-overall-cast','ep1-v3-s4','服装','配角与群演｜整体参考','本场配角、群演整体形象与服装集中上传；历史参考全部保留。','一个整体参考上传位，可追加多张备选，不逐人拆分。',0,800,'2026-09-14 07:37:10',0,1);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s5-overall-cast','ep1-v3-s5','服装','配角与群演｜整体参考','本场配角、群演整体形象与服装集中上传；历史参考全部保留。','一个整体参考上传位，可追加多张备选，不逐人拆分。',0,800,'2026-09-14 07:37:10',0,1);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s6-overall-cast','ep1-v3-s6','服装','配角与群演｜整体参考','本场配角、群演整体形象与服装集中上传；历史参考全部保留。','一个整体参考上传位，可追加多张备选，不逐人拆分。',0,800,'2026-09-14 07:37:10',0,1);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s7-overall-cast','ep1-v3-s7','服装','配角与群演｜整体参考','本场配角、群演整体形象与服装集中上传；历史参考全部保留。','一个整体参考上传位，可追加多张备选，不逐人拆分。',0,800,'2026-09-14 07:37:10',0,1);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s5-hero-wardrobe','ep1-v3-s5','服装','陆文川｜服装','本场该角色服装，请团队上传完整穿搭与备选。','同一上传位可放多张服装图，不按剧本句子拆分。',0,21,'2026-09-14 07:37:10',0,1);
INSERT INTO art_scene_alignment_items_backup_0914 VALUES('ep1-v3-s6-heroine-wardrobe','ep1-v3-s6','服装','顾丽乔｜服装','本场该角色服装，请团队上传完整穿搭与备选。','同一上传位可放多张服装图，不按剧本句子拆分。',0,11,'2026-09-14 07:37:10',0,1);
CREATE TABLE art_scene_alignment_details_backup_0914(
  item_id TEXT,
  assigned_to TEXT,
  due_at TEXT,
  handoff_to TEXT,
  done_definition TEXT,
  status TEXT,
  submission_note TEXT,
  review_note TEXT,
  submitted_at TEXT,
  reviewed_at TEXT,
  updated_at TEXT,
  selected_file_id TEXT
);
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s7-i01','主美小金','2026-09-11T18:00','Lipa','出病房总图和床侧双人构图；医院等级、窗外环境和灯光色温待核准。','已上传','','','2026-09-14T08:13:21.308Z','','2026-09-14T08:13:43.283Z','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s7-i02','主美小金','2026-09-11T18:00','Lipa','沿用第3、5场脸，出湿发处理后的病床状态和按心口动作近景。','待上传','','','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s7-i03','主美小金','2026-09-11T18:00','Lipa','出病服全身/半身方案；颜色与医院空间配套，待核准。','已上传','','','2026-09-14T06:22:23.455Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s7-i04','主美小金','2026-09-11T18:00','Lipa','沿用第3场助理，服装可保持视察造型或增加外套湿痕，连续性待核准。','待上传','','','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s7-i07','主美小金','2026-09-11T18:00','Lipa','出床上陆文川、手机视频和助理同框关键帧，重点是目光与决断。','待上传','','','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s4-auto-1','主美小金','2026-09-11T18:00','Lipa','监控外包负责人本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s4-auto-2','主美小金','2026-09-11T18:00','Lipa','神秘人（电话声）本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s4-auto-3','主美小金','2026-09-11T18:00','Lipa','主美补充本场完整穿搭图并标注与前后场是否连戏。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s4-auto-7','主美小金','2026-09-11T18:00','Lipa','生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T08:18:36.944Z','','2026-09-14T08:18:36.944Z','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s5-auto-1','主美小金','2026-09-11T18:00','Lipa','陆文川本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s5-auto-2','主美小金','2026-09-11T18:00','Lipa','助理本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s5-auto-3','主美小金','2026-09-11T18:00','Lipa','主美补充本场完整穿搭图并标注与前后场是否连戏。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s5-auto-4','主美小金','2026-09-11T18:00','Lipa','生成“手机”设定图；标明外形、材质、尺寸及剧中使用状态。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s5-auto-7','主美小金','2026-09-11T18:00','Lipa','生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s6-auto-1','主美小金','2026-09-11T18:00','Lipa','顾丽乔本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s6-auto-2','主美小金','2026-09-11T18:00','Lipa','沈糯本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s6-auto-3','主美小金','2026-09-11T18:00','Lipa','主美补充本场完整穿搭图并标注与前后场是否连戏。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s6-auto-4','主美小金','2026-09-11T18:00','Lipa','生成“手机”设定图；标明外形、材质、尺寸及剧中使用状态。','需复核','','剧本已更新，请按最新版本复核此项。','','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s6-auto-9','主美小金','2026-09-11T18:00','Lipa','生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T05:41:23.314Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s4-overall-cast','','2026-09-14T20:00','Lipa','一个整体参考上传位，可追加多张备选，不逐人拆分。','待上传','','','','','2026-09-14 07:37:10','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s5-overall-cast','','2026-09-14T20:00','Lipa','一个整体参考上传位，可追加多张备选，不逐人拆分。','待上传','','','','','2026-09-14 07:37:10','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s6-overall-cast','王承恺','2026-09-14T20:00','Lipa','一个整体参考上传位，可追加多张备选，不逐人拆分。','已上传','','','2026-09-14T08:15:19.855Z','','2026-09-14T08:15:19.855Z','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s7-overall-cast','','2026-09-14T20:00','Lipa','一个整体参考上传位，可追加多张备选，不逐人拆分。','待上传','','','','','2026-09-14 07:37:10','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s5-hero-wardrobe','','2026-09-14T20:00','Lipa','同一上传位可放多张服装图，不按剧本句子拆分。','待上传','','','','','2026-09-14 07:37:10','');
INSERT INTO art_scene_alignment_details_backup_0914 VALUES('ep1-v3-s6-heroine-wardrobe','','2026-09-14T20:00','Lipa','同一上传位可放多张服装图，不按剧本句子拆分。','待上传','','','','','2026-09-14 07:37:10','');
CREATE TABLE art_scene_alignment_files_backup_0914(
  id TEXT,
  item_id TEXT,
  object_key TEXT,
  file_name TEXT,
  content_type TEXT,
  byte_size INT,
  uploaded_by TEXT,
  sort_order INT,
  created_at TEXT,
  file_data
);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('e4a964cc-629e-4641-bd89-192485c7a05f','ep1-v3-s6-auto-9','d1:e4a964cc-629e-4641-bd89-192485c7a05f','图片 - 2026-09-10T174138.885-web.jpg','image/jpeg',223154,'王承恺',1,'2026-09-14T05:41:23.314Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('b5eb5594-6b0b-4123-87a0-7173d41feb5d','ep1-v3-s7-i03','d1:b5eb5594-6b0b-4123-87a0-7173d41feb5d','7871eed29fc0557369ef0845bca4b547.jpg','image/jpeg',230315,'玉冰',1,'2026-09-14T05:57:19.358Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('e7c24f0b-f710-4e9e-84aa-cb79446f9f56','ep1-v3-s7-i03','d1:e7c24f0b-f710-4e9e-84aa-cb79446f9f56','c8d6f05b5a1850c07b3cd3667d78e86c.jpg','image/jpeg',304692,'玉冰',2,'2026-09-14T05:57:22.268Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('5d1856da-34c3-4c11-9c8b-136e3050acef','ep1-v3-s7-i01','d1:5d1856da-34c3-4c11-9c8b-136e3050acef','IMG_0507.JPG','image/jpeg',310617,'罗新姗',1,'2026-09-14T06:09:16.278Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('6dbd33f9-6868-4832-a799-2c8351b9da13','ep1-v3-s7-i01','d1:6dbd33f9-6868-4832-a799-2c8351b9da13','IMG_0506.JPG','image/jpeg',1050041,'罗新姗',2,'2026-09-14T06:09:18.797Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('6cb351c9-942e-4748-87bf-ee103f18ef8a','ep1-v3-s7-i01','d1:6cb351c9-942e-4748-87bf-ee103f18ef8a','28cb3986d21dacb5ac8f3d660d1bb331.jpg','image/jpeg',133591,'玉冰',3,'2026-09-14T06:09:20.218Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('182ad487-9f33-4b2c-80df-4d4e1ba1269f','ep1-v3-s7-i01','d1:182ad487-9f33-4b2c-80df-4d4e1ba1269f','IMG_0505.JPG','image/jpeg',1119747,'罗新姗',4,'2026-09-14T06:09:21.329Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('0b8db1cf-560d-4380-95a2-ce637d1cea47','ep1-v3-s7-i01','d1:0b8db1cf-560d-4380-95a2-ce637d1cea47','85a3671004a61724de177288cb5041e6.jpg','image/jpeg',142210,'玉冰',5,'2026-09-14T06:09:23.022Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('ee1de1e2-8b75-41e9-8775-e16bed271876','ep1-v3-s7-i01','d1:ee1de1e2-8b75-41e9-8775-e16bed271876','IMG_0504.JPG','image/jpeg',144792,'罗新姗',5,'2026-09-14T06:09:23.792Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('83563063-2c3e-48d0-b1aa-b7cf0f922a3b','ep1-v3-s7-i01','d1:83563063-2c3e-48d0-b1aa-b7cf0f922a3b','c88124b172e72cc1fff259b0af64b43c.jpg','image/jpeg',189903,'玉冰',6,'2026-09-14T06:09:25.620Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('58f8082d-06a6-4488-a723-a88a8ed1925b','ep1-v3-s7-i01','d1:58f8082d-06a6-4488-a723-a88a8ed1925b','1aece3bb68dd2f9950a402b548ae64b2.jpg','image/jpeg',210515,'玉冰',7,'2026-09-14T06:09:40.431Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('dfa8522b-33e7-4578-b0f6-694d29ba8106','ep1-v3-s7-i01','d1:dfa8522b-33e7-4578-b0f6-694d29ba8106','64721185ba4e059022764bc6d9aceb00.jpg','image/jpeg',219681,'玉冰',8,'2026-09-14T06:09:42.963Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('17c10d75-7b36-4309-b972-1a4fee9edc8f','ep1-v3-s7-i01','d1:17c10d75-7b36-4309-b972-1a4fee9edc8f','38031c83a5a5f22c5e75bc72cc403410.jpg','image/jpeg',158959,'玉冰',9,'2026-09-14T06:09:45.457Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('228a0145-722b-4011-923e-0583b90028c1','ep1-v3-s7-i01','d1:228a0145-722b-4011-923e-0583b90028c1','16f85cdea6400ab45679d2ac1e1bfeb4.jpg','image/jpeg',177241,'玉冰',10,'2026-09-14T06:10:35.671Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('db6531be-718d-4359-a91f-5b6a1633cc99','ep1-v3-s7-i01','d1:db6531be-718d-4359-a91f-5b6a1633cc99','b17c5bfbf860a97f29d2de9d617d3fca.jpg','image/jpeg',176454,'玉冰',11,'2026-09-14T06:10:39.290Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('8f3acbff-28ed-406e-866b-e74f0de7f348','ep1-v3-s7-i01','d1:8f3acbff-28ed-406e-866b-e74f0de7f348','79cf0582b6f793ca4c668c57605b03e5.jpg','image/jpeg',208426,'玉冰',12,'2026-09-14T06:10:50.691Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('fcb322ab-867a-44fa-a103-60a17666d36b','ep1-v3-s7-i01','d1:fcb322ab-867a-44fa-a103-60a17666d36b','b0a0b97315a5cad66e3fd87f4b2a3892.jpg','image/jpeg',153709,'玉冰',13,'2026-09-14T06:10:58.035Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('3a37a9ca-ce51-4105-9409-13c3b692a406','ep1-v3-s7-i01','d1:3a37a9ca-ce51-4105-9409-13c3b692a406','4e7c8e1b5191b90560b6f8ef1110afb2.jpg','image/jpeg',124761,'玉冰',14,'2026-09-14T06:12:25.439Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('f0f2a575-e7be-4591-b450-2bbc8e642f80','ep1-v3-s7-i01','d1:f0f2a575-e7be-4591-b450-2bbc8e642f80','20318d68479db6282d56c143b07555f6.jpg','image/jpeg',184963,'玉冰',15,'2026-09-14T06:12:29.606Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('76e7788f-74a7-4162-bb73-fd9495c2d7d8','ep1-v3-s7-i01','d1:76e7788f-74a7-4162-bb73-fd9495c2d7d8','d92d086c7c2e67531205cf4fa5caf306.jpg','image/jpeg',184249,'玉冰',16,'2026-09-14T06:12:35.899Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('9d080b36-1e7c-456b-9578-99bb59ed4482','ep1-v3-s7-i01','d1:9d080b36-1e7c-456b-9578-99bb59ed4482','bbd3e3a7fd4732cd7e23be5aa7f10364.jpg','image/jpeg',125195,'玉冰',17,'2026-09-14T06:12:59.712Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('6ec855e3-79b7-40ee-ae4b-bacb9acfd047','ep1-v3-s7-i01','d1:6ec855e3-79b7-40ee-ae4b-bacb9acfd047','4526eb5e228e8addf0957f5e35814a76.jpg','image/jpeg',114445,'玉冰',18,'2026-09-14T06:13:02.451Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('33885290-7473-4638-8e81-311921c4b9e0','ep1-v3-s7-i03','d1:33885290-7473-4638-8e81-311921c4b9e0','IMG_0511.jpg','image/jpeg',101217,'罗新姗',3,'2026-09-14T06:22:21.371Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('c77d0282-e97c-4f7d-b9d3-1e849fb3b08c','ep1-v3-s7-i03','d1:c77d0282-e97c-4f7d-b9d3-1e849fb3b08c','IMG_0510.jpg','image/jpeg',160081,'罗新姗',4,'2026-09-14T06:22:23.455Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('22b8b9b4-92f2-4a5e-8d0b-a6aa64c057f6','ep1-v3-s7-i01','d1:22b8b9b4-92f2-4a5e-8d0b-a6aa64c057f6','图片 - 2026-09-14T161253.881.jpg','image/jpeg',690196,'王承恺',20,'2026-09-14T08:13:21.111Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('9ebcedd6-c55a-4851-9b77-3eadd4fd43ca','ep1-v3-s7-i01','d1:9ebcedd6-c55a-4851-9b77-3eadd4fd43ca','图片 - 2026-09-14T161248.479.jpg','image/jpeg',726117,'王承恺',20,'2026-09-14T08:13:21.308Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('307470df-8e4a-4f5b-9322-8599cd20c912','ep1-v3-s6-overall-cast','d1:307470df-8e4a-4f5b-9322-8599cd20c912','图片 - 2026-09-14T135620.198.jpg','image/jpeg',668515,'王承恺',1,'2026-09-14T08:15:19.855Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('8d9ac9dc-4295-4b3e-9804-d0e4bbe059e4','ep1-v3-s4-auto-7','d1:8d9ac9dc-4295-4b3e-9804-d0e4bbe059e4','图片 - 2026-09-14T160922.307.jpg','image/jpeg',635812,'王承恺',1,'2026-09-14T08:17:36.235Z',NULL);
INSERT INTO art_scene_alignment_files_backup_0914 VALUES('d7c588fe-3cb2-4d3d-9ca4-62d5451e2a3e','ep1-v3-s4-auto-7','d1:d7c588fe-3cb2-4d3d-9ca4-62d5451e2a3e','静帧 2026-09-14 155557_1.4.3-web.jpg','image/jpeg',125365,'王承恺',2,'2026-09-14T08:18:36.944Z',NULL);
CREATE TABLE art_scene1_wardrobe_items_backup_0914(
  id TEXT,
  analysis_id TEXT,
  category TEXT,
  name TEXT,
  detail TEXT,
  visual_brief TEXT,
  yoyo_approved INT,
  sort_order INT,
  updated_at TEXT,
  producer_approved INT,
  is_active INT
);
INSERT INTO art_scene1_wardrobe_items_backup_0914 VALUES('ep1-v3-s1-auto-10','ep1-v3-s1','服装','历史服装备选（待确认角色）','保留原有全部上传图与作者，尚未人工确认角色归属；不擅自当成女主或男主服装。','Lipa可把图片移到对应角色服装项。',0,850,'2026-09-11T16:56:33.690Z',0,1);
INSERT INTO art_scene1_wardrobe_items_backup_0914 VALUES('ep1-v3-s1-heroine-wardrobe','ep1-v3-s1','服装','顾丽乔｜服装','本场该角色服装，请团队上传完整穿搭与备选。','同一上传位可放多张服装图，不按剧本句子拆分。',0,11,'2026-09-14 07:37:10',0,1);
CREATE TABLE art_scene1_wardrobe_details_backup_0914(
  item_id TEXT,
  assigned_to TEXT,
  due_at TEXT,
  handoff_to TEXT,
  done_definition TEXT,
  status TEXT,
  submission_note TEXT,
  review_note TEXT,
  submitted_at TEXT,
  reviewed_at TEXT,
  updated_at TEXT,
  selected_file_id TEXT
);
INSERT INTO art_scene1_wardrobe_details_backup_0914 VALUES('ep1-v3-s1-auto-10','玉冰','2026-09-11T18:00','Lipa','按这条剧本信息生成完整穿搭图，标清内外层、鞋袜、配饰、颜色、材质和连续性。','已上传','','剧本已更新，请按最新版本复核此项。','2026-09-14T06:52:45.692Z','','2026-09-14T07:12:21.210Z','');
INSERT INTO art_scene1_wardrobe_details_backup_0914 VALUES('ep1-v3-s1-heroine-wardrobe','','2026-09-14T20:00','Lipa','同一上传位可放多张服装图，不按剧本句子拆分。','待上传','','','','','2026-09-14 07:37:10','');
CREATE TABLE art_scene1_wardrobe_files_backup_0914(
  id TEXT,
  item_id TEXT,
  object_key TEXT,
  file_name TEXT,
  content_type TEXT,
  byte_size INT,
  uploaded_by TEXT,
  sort_order INT,
  created_at TEXT,
  file_data
);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('66bc6579-ef7c-486d-aa97-ac61c7c1451f','ep1-v3-s1-auto-10','d1:66bc6579-ef7c-486d-aa97-ac61c7c1451f','0c813fa85480efcab802842d3e4a2082.jpg','image/jpeg',145391,'玉冰',1,'2026-09-14T05:34:41.705Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('f64448e5-6b00-4703-b8e6-ecfbd842497e','ep1-v3-s1-auto-10','d1:f64448e5-6b00-4703-b8e6-ecfbd842497e','图片 - 2026-09-14T142156.710.jpg','image/jpeg',663138,'王承恺',1,'2026-09-14T06:22:16.713Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('94d97cf1-e4b2-4809-aca6-376ed79d5177','ep1-v3-s1-auto-10','d1:94d97cf1-e4b2-4809-aca6-376ed79d5177','5eb11628a9267d18545909fae4843fdf.jpg','image/jpeg',81283,'玉冰',2,'2026-09-14T05:34:44.133Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('f004c2f6-313f-4037-80ce-d1377b4a45b7','ep1-v3-s1-auto-10','d1:f004c2f6-313f-4037-80ce-d1377b4a45b7','图片 - 2026-09-14T143054.419.jpg','image/jpeg',641942,'王承恺',2,'2026-09-14T06:31:12.659Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('78991d4a-07ca-4ecc-85d3-3da238223c29','ep1-v3-s1-auto-10','d1:78991d4a-07ca-4ecc-85d3-3da238223c29','89234c34ce1ecd3cebc19a265772dd53.jpg','image/jpeg',142602,'玉冰',3,'2026-09-14T05:34:46.392Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('56b4c63d-3e53-45ba-8cd8-9d0ffaf3ce48','ep1-v3-s1-auto-10','d1:56b4c63d-3e53-45ba-8cd8-9d0ffaf3ce48','IMG_0512-web.jpg','image/jpeg',452647,'罗新姗',3,'2026-09-14T06:32:03.873Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('48178c8c-6d41-4963-bcd3-804ff865fafd','ep1-v3-s1-auto-10','d1:48178c8c-6d41-4963-bcd3-804ff865fafd','a36995e93f74cc5aab3e572f59698a97.jpg','image/jpeg',91779,'玉冰',4,'2026-09-14T05:34:48.341Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('ec1a0394-0b80-4293-b0a7-af9fee8223c1','ep1-v3-s1-auto-10','d1:ec1a0394-0b80-4293-b0a7-af9fee8223c1','e00ec71d56da89f16455b1eeb6a02848.jpg','image/jpeg',131324,'玉冰',5,'2026-09-14T05:34:50.630Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('55102b50-b512-47b9-9056-e476071822cb','ep1-v3-s1-auto-10','d1:55102b50-b512-47b9-9056-e476071822cb','IMG_0500.JPG','image/jpeg',629176,'罗新姗',6,'2026-09-14T05:51:16.824Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('72c5724c-63c5-493c-81d7-07b0ab88fd22','ep1-v3-s1-auto-10','d1:72c5724c-63c5-493c-81d7-07b0ab88fd22','IMG_0499.JPG','image/jpeg',643147,'罗新姗',7,'2026-09-14T05:51:19.194Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('db1b1e4f-b0eb-4976-aa75-46bb2899b6db','ep1-v3-s1-auto-10','d1:db1b1e4f-b0eb-4976-aa75-46bb2899b6db','IMG_0498.jpg','image/jpeg',136905,'罗新姗',8,'2026-09-14T05:51:21.325Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('c2083cf0-c800-4894-8ed7-a6c80fc2a121','ep1-v3-s1-auto-10','d1:c2083cf0-c800-4894-8ed7-a6c80fc2a121','IMG_0497.jpg','image/jpeg',385064,'罗新姗',9,'2026-09-14T05:51:23.027Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('bdee9268-700a-403a-a48f-7226f9c802c5','ep1-v3-s1-auto-10','d1:bdee9268-700a-403a-a48f-7226f9c802c5','IMG_0495-web.jpg','image/jpeg',310804,'罗新姗',10,'2026-09-14T05:51:25.200Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('0d18421a-2a5e-4d88-89c4-a6eb985cd0bd','ep1-v3-s1-auto-10','d1:0d18421a-2a5e-4d88-89c4-a6eb985cd0bd','IMG_0494-web.jpg','image/jpeg',317453,'罗新姗',11,'2026-09-14T05:51:27.216Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('81d9d08b-f5a2-452f-8e88-ac14397509dc','ep1-v3-s1-auto-10','d1:81d9d08b-f5a2-452f-8e88-ac14397509dc','3FXl29iRGihq0Rg2wl-0EqW6M0UxL1A5rMa819ghIFHt0po9Ma9L8xOnPKH18E-kDuEp-PhrJflHuaNyYO4bKDnwIQkEr49pDqHyB_UNhiCGZVtpLjpRiB7muaBZr532Fs2xkwA0pwx0tiJi2qRu7k3WOkyNK_EGn4xoRXbEuDS2axhxG8Q6','image/jpeg',122878,'胖胖',12,'2026-09-14T06:50:56.479Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('78676931-85e0-4121-87fa-22e394328aa3','ep1-v3-s1-auto-10','d1:78676931-85e0-4121-87fa-22e394328aa3','DP329151-web.jpg','image/jpeg',166154,'胖胖',16,'2026-09-14T06:51:01.493Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('66604019-6c7a-44bb-90b2-f6791ce31252','ep1-v3-s1-auto-10','d1:66604019-6c7a-44bb-90b2-f6791ce31252','gc3CRefyAYioNJort_cJ_tZRfeyV0ISKRr5FwLBbcegZcw8Drjs5l2kYkoguXc27_TtWZku8PSGMmOk3Y3esbkb8p2SfFSRbDNpEfYj5Vnd-BfuoJZ026UNy3pITj2yEKFcdDM0jExWDFvBo4TsJ9vfTvrpQwHgEK7spr0KCd6gyozgmdRD8','image/jpeg',99134,'胖胖',22,'2026-09-14T06:51:08.604Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('c915aeda-87f9-4a40-9bc1-24a60234ded4','ep1-v3-s1-auto-10','d1:c915aeda-87f9-4a40-9bc1-24a60234ded4','h3VJiQWSoP6bcWmeGkNSCNWIZiTaG3a-pLnHAdTHCZQuvDalsfYQd9jQSxM8ir5ERWVq8kttaCzsYn_T0hOStOoqiSHvlNJDf2iRvSXyfcrwQkRgmDI63p_OP9xYxWHojrb0SGF0XlbjRswnGO3xWo0vy20U1vegfqt30ujMW8XD95iyjyla','image/jpeg',166358,'胖胖',23,'2026-09-14T06:51:10.594Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('f7fdee75-bd50-480d-9820-43c780b8a716','ep1-v3-s1-auto-10','d1:f7fdee75-bd50-480d-9820-43c780b8a716','GGrD3BiHCdP3TBZJEaqyw9ECSHTME9RdnK4qUxTAPTJYzpXsqYnfvvSvb6gRKOVMVTsLvIKrgpdvk4l_7KQ1zkW6J6Xr330RFSowxI3frcTYpvJhzjPhtImYXQoLjMTot9k6iSjZBDs9di4ZhX7QLq98oGYFa9T2sfr6ku9D1Q-8uJ-r8uyW','image/jpeg',185757,'胖胖',23,'2026-09-14T06:51:10.554Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('124174a0-d627-4f77-83e9-a7ad4ad7f1db','ep1-v3-s1-auto-10','d1:124174a0-d627-4f77-83e9-a7ad4ad7f1db','L6zzgdcxfvRGbHLQyjyQOy_sqvqzkryHIhFu2Uhip4tZ5o96rJMcLbRtWZPHLzFvh5zVw38NpaZW-9sIZmUChob20dUIIeYrLSnHNbIcijFCshzF1SW9DhrbeszHN0QyQ-U4ptsEldE-9Wi4kMXqDVcYNsRf30nOGCnyk6776sOXMpcINfop','image/jpeg',116060,'胖胖',26,'2026-09-14T06:51:17.873Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('5d85cd42-8d03-4361-b8c2-aa0c76b72efc','ep1-v3-s1-auto-10','d1:5d85cd42-8d03-4361-b8c2-aa0c76b72efc','lKHCXThffZNoCJ9KvB6v9j8OxHFJSdJPvjjB3W1MfiAwRBOtEpesQOAq8H-SednqAqb78UF4d5n2zE8IWE6dLH2pk19vUXJb9JVhMkH9i_mXCdhfa8lXZOsUZ41iZq-z3w8Bo1TYmb37LTDxHujtzeFqVGHJB5gW7RwyX-V2rzPzG9d2FZU_','image/jpeg',116169,'胖胖',27,'2026-09-14T06:51:19.610Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('39d63a15-2ed2-4301-aea1-69695a6274f8','ep1-v3-s1-auto-10','d1:39d63a15-2ed2-4301-aea1-69695a6274f8','MUmtaFheaqa-zL2yA8fUXwCWRuDmRTU2tMwvKvfBtaPfO0pOOJgf8d0yYMWxSCs1i2ZttO6QnRCp3LUrP57GZOw2Qv19WO-npHikqlkVbNtjKPvDf-gUdZTOWsQh1-ocsWKFU1gKQphPIpqqcpUcstGt4p3BQdZrQAzGHr4VBVYjQRHgbPXn','image/jpeg',84172,'胖胖',27,'2026-09-14T06:51:19.611Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('2a05b8ba-1752-4fce-be52-e51d3ff46f33','ep1-v3-s1-auto-10','d1:2a05b8ba-1752-4fce-be52-e51d3ff46f33','lDwPZNx2ySF8bgaW7NAqpxTWD7tgSUy336-PCAC9OcjwY1gdffz89RN9yrLkQeACZLAeTy2sXAOpEEqsISJALHts18GaOzs-_9snazTyQW7kKCCU4bCeUarFlAoi7jvPWrtT1jTtdVq60TJ5hRaydph2H8VALG6E6cwXrR4XpT8N2tAc9n1i','image/jpeg',761993,'胖胖',28,'2026-09-14T06:51:20.705Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('9e7c2bbf-e656-4e25-9268-4500dc7fc0f2','ep1-v3-s1-auto-10','d1:9e7c2bbf-e656-4e25-9268-4500dc7fc0f2','nxEsD9pQ-5FEHrjIcR-V_Ql7JP_aG50YOKBWwc5jFuEtq1j3pNhenxpSXZ61H8rYd1930Y1LnRzExRVumawzjeq9dNZNYnUh66KtHdZPoO8p-wOYaHfPgTchyMX-Zn01BtlERi505sjTnxXZb5kDwvTtE30-1nPPXKZ-1D9cg0hC7y9tzVEI','image/jpeg',269098,'胖胖',29,'2026-09-14T06:51:22.875Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('64f84f63-bded-4652-8767-36fa6e40190f','ep1-v3-s1-auto-10','d1:64f84f63-bded-4652-8767-36fa6e40190f','sKp52dlO-GkJ9p4APYnpRk9uS5KJDDeH8T5ItIxRwzVZPg4PaItdiiCYtg0cJlU57PSQLapNl3Re4GWBaohLWTXJTh0RWL-HKAmmPCbwO6AZwcGG60SF01ziZ2cP7_4vu5ElPkJN2xdTse8IToWjyEVEaGE4aVcy7AqqwgGhHVxq9eJ9rBrP','image/jpeg',54310,'胖胖',33,'2026-09-14T06:51:28.228Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('978d2eae-7391-48fd-90eb-774d237e1821','ep1-v3-s1-auto-10','d1:978d2eae-7391-48fd-90eb-774d237e1821','UpgfK781YxJoZzqFOunv5qNB-Lmd5UDFRp71DamrZyRg3ATlsPfiTkyt-sRWJtvfbcNCfEW0H4-CrxbuyXzh9azn9QpBZWIvcoJijEmc9GhrQO8MWtXgUO7v1gD8pVACBmiTplda6qemMkSHfoUl9Zn8qJK17oA5i8m92j3RUEynZ_F4W56O','image/jpeg',95861,'胖胖',35,'2026-09-14T06:51:29.941Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('636f94f7-a1ad-4f41-b229-236366d97749','ep1-v3-s1-auto-10','d1:636f94f7-a1ad-4f41-b229-236366d97749','Whzb-CShAB4a6JaLGDIYN8EcH_NLMMXQHfppewxrsxiB4tPWjUYhCOfdijo6GSuG5F02ofnbfytu5K71PRIzvg06Hx8V_eSN7neUIYDVJtUOzXSldYnzamYQV6LXFqTMoxnpZyq7e48nlz3TiSEGZuhU-6TymJH3Yc4e8C6UkcwJx3UygKm4','image/jpeg',187346,'胖胖',37,'2026-09-14T06:51:32.005Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('aa575347-de1d-4f6c-afe2-b7d73c4d08a0','ep1-v3-s1-auto-10','d1:aa575347-de1d-4f6c-afe2-b7d73c4d08a0','wKzh4SRsyrNHjP18bv5DDWvtuQoPWEMowiStNQSKmrt8cd-D8sNZ_HTEsG10PKDERqgiZfYNcOpQae-iEXRA7BzC5GVfG_XjoFsRcdFnvRPxbE0aql8xkXEkU10ac_8aPDnoI-zfTUAaBE7EPePf1qbawRJBaZULfhJWimMCSwU_iX51RB6P','image/jpeg',101322,'胖胖',38,'2026-09-14T06:51:34.093Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('8c5656b7-bbcc-4eb1-8b2a-b659e57f2763','ep1-v3-s1-auto-10','d1:8c5656b7-bbcc-4eb1-8b2a-b659e57f2763','微信图片_20260914144522_2005_22.jpg','image/jpeg',63734,'胖胖',42,'2026-09-14T06:51:38.586Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('bbbbb0f6-7506-4a29-b411-f48d02face5e','ep1-v3-s1-auto-10','d1:bbbbb0f6-7506-4a29-b411-f48d02face5e','微信图片_20260914144522_2006_22.jpg','image/jpeg',113657,'胖胖',43,'2026-09-14T06:51:39.513Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('a689d2a3-ffa9-4a1b-9ce1-d49bf1637677','ep1-v3-s1-auto-10','d1:a689d2a3-ffa9-4a1b-9ce1-d49bf1637677','微信图片_20260914144522_2007_22.jpg','image/jpeg',102201,'胖胖',43,'2026-09-14T06:51:39.545Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('ceee1bb2-bf4a-4fa7-a205-41e7a09187cb','ep1-v3-s1-auto-10','d1:ceee1bb2-bf4a-4fa7-a205-41e7a09187cb','微信图片_20260914144522_2008_22.jpg','image/jpeg',65841,'胖胖',44,'2026-09-14T06:51:42.841Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('4706554b-772d-462d-9f70-1495e52a4741','ep1-v3-s1-auto-10','d1:4706554b-772d-462d-9f70-1495e52a4741','微信图片_20260914144522_2009_22.jpg','image/jpeg',70315,'胖胖',45,'2026-09-14T06:51:43.691Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('fb3ad5da-7484-490f-9222-c4711c745dc4','ep1-v3-s1-auto-10','d1:fb3ad5da-7484-490f-9222-c4711c745dc4','微信图片_20260914144522_2010_22.jpg','image/jpeg',118717,'胖胖',45,'2026-09-14T06:51:43.729Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('232f38f6-b07c-4cc2-8879-f2e6c6735238','ep1-v3-s1-auto-10','d1:232f38f6-b07c-4cc2-8879-f2e6c6735238','微信图片_20260914144522_2011_22.jpg','image/jpeg',66190,'胖胖',46,'2026-09-14T06:51:44.943Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('bac0881e-9426-4e0c-a51d-22e5c0fc06a4','ep1-v3-s1-auto-10','d1:bac0881e-9426-4e0c-a51d-22e5c0fc06a4','微信图片_20260914144522_2012_22.jpg','image/jpeg',73530,'胖胖',46,'2026-09-14T06:51:45.219Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('bdbb3a8d-8972-45cc-b09d-240750006353','ep1-v3-s1-auto-10','d1:bdbb3a8d-8972-45cc-b09d-240750006353','微信图片_20260914144522_2013_22.jpg','image/jpeg',243703,'胖胖',47,'2026-09-14T06:51:46.020Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('9e3fb7fb-e777-45db-9359-c5ef010ff3f6','ep1-v3-s1-auto-10','d1:9e3fb7fb-e777-45db-9359-c5ef010ff3f6','微信图片_20260914144522_2015_22.jpg','image/jpeg',270143,'胖胖',48,'2026-09-14T06:51:46.915Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('d6b756dc-d516-44dd-b02c-030dccf0685d','ep1-v3-s1-auto-10','d1:d6b756dc-d516-44dd-b02c-030dccf0685d','微信图片_20260914144522_2014_22.jpg','image/jpeg',310967,'胖胖',48,'2026-09-14T06:51:46.902Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('d0902c5e-8877-477b-af40-764d692256b5','ep1-v3-s1-auto-10','d1:d0902c5e-8877-477b-af40-764d692256b5','微信图片_20260914144522_2016_22.jpg','image/jpeg',232155,'胖胖',49,'2026-09-14T06:51:48.264Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('1f8d2c29-aaba-49a7-a4c0-63bf3ae0a9b9','ep1-v3-s1-auto-10','d1:1f8d2c29-aaba-49a7-a4c0-63bf3ae0a9b9','微信图片_20260914144522_2018_22.jpg','image/jpeg',169540,'胖胖',50,'2026-09-14T06:51:49.337Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('488f4f4a-6818-4c73-859e-788685b9cab7','ep1-v3-s1-auto-10','d1:488f4f4a-6818-4c73-859e-788685b9cab7','微信图片_20260914144522_2017_22.jpg','image/jpeg',209589,'胖胖',50,'2026-09-14T06:51:49.500Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('1b9688b0-19c2-4452-bec6-3afbe5bb6cda','ep1-v3-s1-auto-10','d1:1b9688b0-19c2-4452-bec6-3afbe5bb6cda','微信图片_20260914144522_2021_22.jpg','image/jpeg',192891,'胖胖',52,'2026-09-14T06:51:52.251Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('c7d093ef-5ea2-4a75-ae8e-dd33f06af732','ep1-v3-s1-auto-10','d1:c7d093ef-5ea2-4a75-ae8e-dd33f06af732','微信图片_20260914144522_2020_22.jpg','image/jpeg',284935,'胖胖',53,'2026-09-14T06:51:53.670Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('f786439e-b0e4-4682-88aa-92de57eddae2','ep1-v3-s1-auto-10','d1:f786439e-b0e4-4682-88aa-92de57eddae2','微信图片_20260914144522_2022_22.jpg','image/jpeg',74302,'胖胖',53,'2026-09-14T06:51:53.976Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('a14cf2ca-e57f-4997-9c3c-109d72c8a380','ep1-v3-s1-auto-10','d1:a14cf2ca-e57f-4997-9c3c-109d72c8a380','微信图片_20260914144522_2023_22.jpg','image/jpeg',68898,'胖胖',53,'2026-09-14T06:51:53.967Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('6b88ae5a-1d2b-4a55-8d19-c565f9348acd','ep1-v3-s1-auto-10','d1:6b88ae5a-1d2b-4a55-8d19-c565f9348acd','微信图片_20260914144522_2024_22.jpg','image/jpeg',85027,'胖胖',54,'2026-09-14T06:51:55.465Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('8bb9f69a-7643-47b3-998a-929319b91da8','ep1-v3-s1-auto-10','d1:8bb9f69a-7643-47b3-998a-929319b91da8','微信图片_20260914144522_2028_22.jpg','image/jpeg',318248,'胖胖',57,'2026-09-14T06:51:59.812Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('f4669b8c-bceb-47e8-bd78-6c18d756caaf','ep1-v3-s1-auto-10','d1:f4669b8c-bceb-47e8-bd78-6c18d756caaf','微信图片_20260914144522_2037_22.jpg','image/jpeg',109546,'胖胖',62,'2026-09-14T06:52:10.389Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('102f9bd1-c456-4642-a928-4f296cd423fe','ep1-v3-s1-auto-10','d1:102f9bd1-c456-4642-a928-4f296cd423fe','微信图片_20260914144522_2039_22.jpg','image/jpeg',164031,'胖胖',62,'2026-09-14T06:52:10.574Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('e1d64053-8d7a-4e0d-a8f9-0f10328fad78','ep1-v3-s1-auto-10','d1:e1d64053-8d7a-4e0d-a8f9-0f10328fad78','微信图片_20260914144522_2040_22.jpg','image/jpeg',148642,'胖胖',63,'2026-09-14T06:52:13.342Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('7e759486-2bc8-4b80-afea-14c4bd284fcc','ep1-v3-s1-auto-10','d1:7e759486-2bc8-4b80-afea-14c4bd284fcc','微信图片_20260914144522_2042_22.jpg','image/jpeg',124331,'胖胖',63,'2026-09-14T06:52:13.340Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('619c49b6-b63c-4116-b1b7-67bd97b4ce5a','ep1-v3-s1-auto-10','d1:619c49b6-b63c-4116-b1b7-67bd97b4ce5a','微信图片_20260914144522_2041_22.jpg','image/jpeg',152268,'胖胖',63,'2026-09-14T06:52:13.335Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('06a7d8dc-de7e-46e6-b5c3-9ac3d5dc641a','ep1-v3-s1-auto-10','d1:06a7d8dc-de7e-46e6-b5c3-9ac3d5dc641a','微信图片_20260914144522_2043_22.jpg','image/jpeg',67913,'胖胖',64,'2026-09-14T06:52:15.326Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('c80882ee-2194-47d5-8cc7-6d883c900aff','ep1-v3-s1-auto-10','d1:c80882ee-2194-47d5-8cc7-6d883c900aff','微信图片_20260914144522_2045_22.jpg','image/jpeg',136616,'胖胖',64,'2026-09-14T06:52:15.393Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('6ce5ab18-5eb1-4c32-bbbf-488ae9e1bf9c','ep1-v3-s1-auto-10','d1:6ce5ab18-5eb1-4c32-bbbf-488ae9e1bf9c','微信图片_20260914144522_2046_22.jpg','image/jpeg',129405,'胖胖',66,'2026-09-14T06:52:16.895Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('0c7a5c9b-893a-498d-9708-8998a9b3b055','ep1-v3-s1-auto-10','d1:0c7a5c9b-893a-498d-9708-8998a9b3b055','微信图片_20260914144522_2049_22.jpg','image/jpeg',154623,'胖胖',67,'2026-09-14T06:52:18.897Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('5630e975-b6b7-454b-a875-70be7b386498','ep1-v3-s1-auto-10','d1:5630e975-b6b7-454b-a875-70be7b386498','微信图片_20260914144522_2048_22.jpg','image/jpeg',104543,'胖胖',67,'2026-09-14T06:52:18.701Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('e7a4750a-96c9-4ec3-b717-ce2601ba5811','ep1-v3-s1-auto-10','d1:e7a4750a-96c9-4ec3-b717-ce2601ba5811','微信图片_20260914144522_2050_22.jpg','image/jpeg',218309,'胖胖',68,'2026-09-14T06:52:20.482Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('336a9253-bcba-4a8d-bc1c-fe0d3591da3e','ep1-v3-s1-auto-10','d1:336a9253-bcba-4a8d-bc1c-fe0d3591da3e','微信图片_20260914144522_2052_22.jpg','image/jpeg',254111,'胖胖',68,'2026-09-14T06:52:20.836Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('30fe8a44-1f68-4fe4-84ed-1a5f6e14163f','ep1-v3-s1-auto-10','d1:30fe8a44-1f68-4fe4-84ed-1a5f6e14163f','微信图片_20260914144522_2051_22.jpg','image/jpeg',211555,'胖胖',68,'2026-09-14T06:52:20.708Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('b55ab793-9918-40dd-add6-319c4e8a10a4','ep1-v3-s1-auto-10','d1:b55ab793-9918-40dd-add6-319c4e8a10a4','微信图片_20260914144522_2053_22.jpg','image/jpeg',103194,'胖胖',69,'2026-09-14T06:52:22.114Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('18bfdf1c-7ef4-4e14-ba41-506c754fedf1','ep1-v3-s1-auto-10','d1:18bfdf1c-7ef4-4e14-ba41-506c754fedf1','微信图片_20260914144522_2055_22.jpg','image/jpeg',175635,'胖胖',69,'2026-09-14T06:52:22.415Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('abf30ac7-7116-4767-9252-2f15a2e56054','ep1-v3-s1-auto-10','d1:abf30ac7-7116-4767-9252-2f15a2e56054','微信图片_20260914144522_2054_22.jpg','image/jpeg',137574,'胖胖',69,'2026-09-14T06:52:22.387Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('dce5fbc8-10db-43f8-964a-b824a23c8e0c','ep1-v3-s1-auto-10','d1:dce5fbc8-10db-43f8-964a-b824a23c8e0c','微信图片_20260914144522_2056_22.jpg','image/jpeg',289410,'胖胖',70,'2026-09-14T06:52:23.911Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('b4d21e02-5c41-4b01-808c-b80d4ccfa14e','ep1-v3-s1-auto-10','d1:b4d21e02-5c41-4b01-808c-b80d4ccfa14e','微信图片_20260914144522_2057_22.jpg','image/jpeg',300140,'胖胖',70,'2026-09-14T06:52:24.203Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('e47a9fb7-42bb-47cd-bbaa-d879c724f4c3','ep1-v3-s1-auto-10','d1:e47a9fb7-42bb-47cd-bbaa-d879c724f4c3','微信图片_20260914144522_2058_22.jpg','image/jpeg',340816,'胖胖',71,'2026-09-14T06:52:25.518Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('4cf816c6-0cc1-4046-8c13-9dfb0b260ced','ep1-v3-s1-auto-10','d1:4cf816c6-0cc1-4046-8c13-9dfb0b260ced','微信图片_20260914144522_2059_22.jpg','image/jpeg',152835,'胖胖',71,'2026-09-14T06:52:25.724Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('d5209c8f-3be4-4204-a5cc-1a800b0c7563','ep1-v3-s1-auto-10','d1:d5209c8f-3be4-4204-a5cc-1a800b0c7563','微信图片_20260914144522_2060_22.jpg','image/jpeg',149422,'胖胖',72,'2026-09-14T06:52:26.123Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('52887c83-e5cf-4be6-8d25-42714699b0d9','ep1-v3-s1-auto-10','d1:52887c83-e5cf-4be6-8d25-42714699b0d9','微信图片_20260914144522_2063_22.jpg','image/jpeg',85719,'胖胖',73,'2026-09-14T06:52:27.896Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('11072865-e078-4bba-a7a6-79a6a3fc8baa','ep1-v3-s1-auto-10','d1:11072865-e078-4bba-a7a6-79a6a3fc8baa','微信图片_20260914144522_2062_22.jpg','image/jpeg',173606,'胖胖',73,'2026-09-14T06:52:27.903Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('cea86304-ecc6-40f9-acac-97386298d1b2','ep1-v3-s1-auto-10','d1:cea86304-ecc6-40f9-acac-97386298d1b2','微信图片_20260914144522_2061_22.jpg','image/jpeg',298103,'胖胖',73,'2026-09-14T06:52:27.915Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('ddfbe91d-f7ca-4e43-bc2e-da26a34071b9','ep1-v3-s1-auto-10','d1:ddfbe91d-f7ca-4e43-bc2e-da26a34071b9','微信图片_20260914144522_2064_22.jpg','image/jpeg',107255,'胖胖',74,'2026-09-14T06:52:30.248Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('d6f9d003-5a9f-48d4-90df-9b78067270c0','ep1-v3-s1-auto-10','d1:d6f9d003-5a9f-48d4-90df-9b78067270c0','微信图片_20260914144522_2065_22.jpg','image/jpeg',231758,'胖胖',75,'2026-09-14T06:52:31.983Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('90f40f71-021f-4be0-bd76-658256187c3c','ep1-v3-s1-auto-10','d1:90f40f71-021f-4be0-bd76-658256187c3c','微信图片_20260914144522_2066_22.jpg','image/jpeg',221827,'胖胖',75,'2026-09-14T06:52:32.018Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('7834c7bd-2ad1-44eb-bd62-aa2c7b77bdc4','ep1-v3-s1-auto-10','d1:7834c7bd-2ad1-44eb-bd62-aa2c7b77bdc4','微信图片_20260914144522_2068_22.jpg','image/jpeg',99069,'胖胖',76,'2026-09-14T06:52:33.671Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('75010c7c-2e36-4843-a434-0175353fc39e','ep1-v3-s1-auto-10','d1:75010c7c-2e36-4843-a434-0175353fc39e','微信图片_20260914144522_2067_22.jpg','image/jpeg',199318,'胖胖',76,'2026-09-14T06:52:33.866Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('99a3c05d-9576-44b2-a316-e5be578cee19','ep1-v3-s1-auto-10','d1:99a3c05d-9576-44b2-a316-e5be578cee19','微信图片_20260914144522_2069_22.jpg','image/jpeg',353682,'胖胖',77,'2026-09-14T06:52:35.624Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('1d82a4b6-6b71-4151-9796-294a0c1d9b86','ep1-v3-s1-auto-10','d1:1d82a4b6-6b71-4151-9796-294a0c1d9b86','微信图片_20260914144522_2071_22.jpg','image/jpeg',261022,'胖胖',77,'2026-09-14T06:52:36.314Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('08d3ed05-dc9a-4768-9b7c-d1c2317c9493','ep1-v3-s1-auto-10','d1:08d3ed05-dc9a-4768-9b7c-d1c2317c9493','微信图片_20260914144522_2070_22.jpg','image/jpeg',323582,'胖胖',77,'2026-09-14T06:52:36.014Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('be9c172f-8d0e-4e36-b3bc-e3c60983a058','ep1-v3-s1-auto-10','d1:be9c172f-8d0e-4e36-b3bc-e3c60983a058','微信图片_20260914144522_2072_22.jpg','image/jpeg',247896,'胖胖',78,'2026-09-14T06:52:37.822Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('82859475-93a8-4d72-8206-61666409f219','ep1-v3-s1-auto-10','d1:82859475-93a8-4d72-8206-61666409f219','微信图片_20260914144522_2073_22.jpg','image/jpeg',237673,'胖胖',79,'2026-09-14T06:52:38.678Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('32b52ecd-92e9-4d74-ae84-200fd74ecd03','ep1-v3-s1-auto-10','d1:32b52ecd-92e9-4d74-ae84-200fd74ecd03','微信图片_20260914144522_2074_22.jpg','image/jpeg',269888,'胖胖',80,'2026-09-14T06:52:40.316Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('7d76a4f0-4bf5-4ab6-a61c-1969cfa7e79e','ep1-v3-s1-auto-10','d1:7d76a4f0-4bf5-4ab6-a61c-1969cfa7e79e','微信图片_20260914144522_2075_22.jpg','image/jpeg',240831,'胖胖',81,'2026-09-14T06:52:41.294Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('0730514c-4dd5-4595-97e0-cb0ae26d6aae','ep1-v3-s1-auto-10','d1:0730514c-4dd5-4595-97e0-cb0ae26d6aae','微信图片_20260914144522_2079_22.jpg','image/jpeg',216937,'胖胖',82,'2026-09-14T06:52:43.774Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('d4d9449d-8d6f-472b-8470-c88e25bc877b','ep1-v3-s1-auto-10','d1:d4d9449d-8d6f-472b-8470-c88e25bc877b','微信图片_20260914144522_2078_22.jpg','image/jpeg',205101,'胖胖',82,'2026-09-14T06:52:43.767Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('3078a7ca-aba7-41f2-8057-c967561fe565','ep1-v3-s1-auto-10','d1:3078a7ca-aba7-41f2-8057-c967561fe565','微信图片_20260914144522_2081_22.jpg','image/jpeg',126593,'胖胖',83,'2026-09-14T06:52:45.484Z',NULL);
INSERT INTO art_scene1_wardrobe_files_backup_0914 VALUES('b4bc5eee-37d9-4abb-88ee-996c37bc99be','ep1-v3-s1-auto-10','d1:b4bc5eee-37d9-4abb-88ee-996c37bc99be','微信图片_20260914144522_2080_22.jpg','image/jpeg',235000,'胖胖',83,'2026-09-14T06:52:45.692Z',NULL);
INSERT INTO sqlite_sequence VALUES('d1_migrations',22);
INSERT INTO sqlite_sequence VALUES('activity_log',423);
CREATE UNIQUE INDEX `daily_reports_work_date_unique` ON `daily_reports` (`work_date`);
CREATE UNIQUE INDEX `member_accounts_username_unique` ON `member_accounts` (`username`);
CREATE UNIQUE INDEX `member_sessions_token_hash_unique` ON `member_sessions` (`token_hash`);
CREATE UNIQUE INDEX `art_submission_files_object_key_unique` ON `art_submission_files` (`object_key`);
CREATE INDEX `idx_art_submission_files_item` ON `art_submission_files` (`item_id`,`sort_order`);
CREATE UNIQUE INDEX `script_versions_episode_version_unique` ON `script_versions` (`episode`,`version_no`);
CREATE INDEX `idx_script_versions_episode_created` ON `script_versions` (`episode`,`created_at`);
CREATE UNIQUE INDEX `daily_scene_assignments_date_analysis_unique` ON `daily_scene_assignments` (`work_date`,`analysis_id`);
CREATE INDEX `idx_daily_scene_assignments_work_date` ON `daily_scene_assignments` (`work_date`);
COMMIT;
