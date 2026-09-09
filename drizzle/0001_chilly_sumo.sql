ALTER TABLE `production_items` ADD `depends_on_id` text DEFAULT '' NOT NULL;--> statement-breakpoint
ALTER TABLE `production_items` ADD `handoff_to` text DEFAULT '' NOT NULL;--> statement-breakpoint
ALTER TABLE `production_items` ADD `handoff_deadline` text DEFAULT '' NOT NULL;
