import { integer, sqliteTable, text } from 'drizzle-orm/sqlite-core';

export const productionItems = sqliteTable('production_items', {
  id: text('id').primaryKey(),
  workDate: text('work_date').notNull(),
  episode: text('episode').notNull(),
  category: text('category').notNull(),
  title: text('title').notNull(),
  owner: text('owner').notNull(),
  reviewer: text('reviewer').notNull().default('Yoyo'),
  status: text('status').notNull().default('未开始'),
  plannedQty: integer('planned_qty').notNull().default(1),
  completedQty: integer('completed_qty').notNull().default(0),
  dueTime: text('due_time').notNull().default('18:00'),
  dependsOnId: text('depends_on_id').notNull().default(''),
  handoffTo: text('handoff_to').notNull().default(''),
  handoffDeadline: text('handoff_deadline').notNull().default(''),
  note: text('note').notNull().default(''),
  sortOrder: integer('sort_order').notNull().default(0),
  updatedAt: text('updated_at').notNull(),
});

export const scenes = sqliteTable('scenes', {
  id: text('id').primaryKey(),
  episode: text('episode').notNull(),
  sceneNo: integer('scene_no').notNull(),
  title: text('title').notNull(),
  location: text('location').notNull(),
  owner: text('owner').notNull(),
  scriptStatus: text('script_status').notNull().default('未开始'),
  characterStatus: text('character_status').notNull().default('未开始'),
  locationStatus: text('location_status').notNull().default('未开始'),
  wardrobeStatus: text('wardrobe_status').notNull().default('未开始'),
  whiteModelStatus: text('white_model_status').notNull().default('未开始'),
  shotStatus: text('shot_status').notNull().default('未开始'),
  roughCutStatus: text('rough_cut_status').notNull().default('未开始'),
  finalStatus: text('final_status').notNull().default('未开始'),
  updatedAt: text('updated_at').notNull(),
});

export const activityLog = sqliteTable('activity_log', {
  id: integer('id').primaryKey({ autoIncrement: true }),
  itemType: text('item_type').notNull(),
  itemId: text('item_id').notNull(),
  action: text('action').notNull(),
  operator: text('operator').notNull(),
  createdAt: text('created_at').notNull(),
});

export const planBatches = sqliteTable('plan_batches', {
  id: text('id').primaryKey(),
  startDate: text('start_date').notNull(),
  endDate: text('end_date').notNull(),
  production: text('production').notNull(),
  prep: text('prep').notNull(),
  note: text('note').notNull().default(''),
  sortOrder: integer('sort_order').notNull().default(0),
  updatedAt: text('updated_at').notNull(),
});

export const appSettings = sqliteTable('app_settings', {
  key: text('key').primaryKey(),
  value: text('value').notNull(),
  updatedAt: text('updated_at').notNull(),
});
