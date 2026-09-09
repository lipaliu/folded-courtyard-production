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
--> statement-breakpoint
CREATE UNIQUE INDEX `daily_reports_work_date_unique` ON `daily_reports` (`work_date`);