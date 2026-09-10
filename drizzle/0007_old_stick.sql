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
);
--> statement-breakpoint
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
);
--> statement-breakpoint
CREATE UNIQUE INDEX `art_submission_files_object_key_unique` ON `art_submission_files` (`object_key`);--> statement-breakpoint
CREATE INDEX `idx_art_submission_files_item` ON `art_submission_files` (`item_id`,`sort_order`);--> statement-breakpoint
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
);
--> statement-breakpoint
CREATE UNIQUE INDEX `script_versions_episode_version_unique` ON `script_versions` (`episode`,`version_no`);--> statement-breakpoint
CREATE INDEX `idx_script_versions_episode_created` ON `script_versions` (`episode`,`created_at`);--> statement-breakpoint
PRAGMA optimize;
