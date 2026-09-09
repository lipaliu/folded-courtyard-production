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
);
--> statement-breakpoint
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
);
