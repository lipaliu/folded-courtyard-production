CREATE TABLE `daily_scene_assignments` (
	`id` text PRIMARY KEY NOT NULL,
	`work_date` text NOT NULL,
	`analysis_id` text NOT NULL,
	`script_version_id` text DEFAULT '' NOT NULL,
	`assigned_by` text NOT NULL,
	`created_at` text NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `daily_scene_assignments_date_analysis_unique` ON `daily_scene_assignments` (`work_date`,`analysis_id`);--> statement-breakpoint
CREATE INDEX `idx_daily_scene_assignments_work_date` ON `daily_scene_assignments` (`work_date`);--> statement-breakpoint
PRAGMA optimize;
