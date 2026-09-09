CREATE TABLE `activity_log` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`item_type` text NOT NULL,
	`item_id` text NOT NULL,
	`action` text NOT NULL,
	`operator` text NOT NULL,
	`created_at` text NOT NULL
);
--> statement-breakpoint
CREATE TABLE `app_settings` (
	`key` text PRIMARY KEY NOT NULL,
	`value` text NOT NULL,
	`updated_at` text NOT NULL
);
--> statement-breakpoint
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
--> statement-breakpoint
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
);
--> statement-breakpoint
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
