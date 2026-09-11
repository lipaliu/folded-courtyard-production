import { blob, index, integer, sqliteTable, text, uniqueIndex } from 'drizzle-orm/sqlite-core';

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

export const teamMembers = sqliteTable('team_members', {
  userId: text('user_id').primaryKey(),
  email: text('email').notNull(),
  name: text('name').notNull(),
  phone: text('phone').notNull(),
  role: text('role').notNull(),
  active: integer('active', { mode: 'boolean' }).notNull().default(true),
  createdAt: text('created_at').notNull(),
  updatedAt: text('updated_at').notNull(),
});

export const memberAccounts = sqliteTable('member_accounts', {
  id: text('id').primaryKey(),
  username: text('username').notNull().unique(),
  passwordHash: text('password_hash').notNull(),
  passwordSalt: text('password_salt').notNull(),
  passwordIterations: integer('password_iterations').notNull().default(120000),
  name: text('name').notNull(),
  role: text('role').notNull(),
  isAdmin: integer('is_admin', { mode: 'boolean' }).notNull().default(false),
  active: integer('active', { mode: 'boolean' }).notNull().default(true),
  failedAttempts: integer('failed_attempts').notNull().default(0),
  lockedUntil: text('locked_until').notNull().default(''),
  createdAt: text('created_at').notNull(),
  updatedAt: text('updated_at').notNull(),
});

export const memberSessions = sqliteTable('member_sessions', {
  id: text('id').primaryKey(),
  accountId: text('account_id').notNull(),
  tokenHash: text('token_hash').notNull().unique(),
  expiresAt: text('expires_at').notNull(),
  createdAt: text('created_at').notNull(),
  lastSeenAt: text('last_seen_at').notNull(),
});

export const dailyReports = sqliteTable('daily_reports', {
  id: text('id').primaryKey(),
  workDate: text('work_date').notNull().unique(),
  completedCount: integer('completed_count').notNull().default(0),
  incompleteCount: integer('incomplete_count').notNull().default(0),
  rolloverCount: integer('rollover_count').notNull().default(0),
  summaryJson: text('summary_json').notNull(),
  createdAt: text('created_at').notNull(),
  updatedAt: text('updated_at').notNull(),
});

export const scriptAnalyses = sqliteTable('script_analyses', {
  id: text('id').primaryKey(),
  episode: text('episode').notNull(),
  sceneNo: integer('scene_no').notNull(),
  sceneTitle: text('scene_title').notNull(),
  scriptText: text('script_text').notNull(),
  sceneSummary: text('scene_summary').notNull().default(''),
  location: text('location').notNull().default(''),
  scriptVersionId: text('script_version_id').notNull().default(''),
  isActive: integer('is_active', { mode: 'boolean' }).notNull().default(true),
  createdAt: text('created_at').notNull(),
  updatedAt: text('updated_at').notNull(),
});

export const scriptAnalysisItems = sqliteTable('script_analysis_items', {
  id: text('id').primaryKey(),
  analysisId: text('analysis_id').notNull(),
  category: text('category').notNull(),
  name: text('name').notNull(),
  detail: text('detail').notNull().default(''),
  visualBrief: text('visual_brief').notNull().default(''),
  yoyoApproved: integer('yoyo_approved', { mode: 'boolean' }).notNull().default(false),
  producerApproved: integer('producer_approved', { mode: 'boolean' }).notNull().default(false),
  isActive: integer('is_active', { mode: 'boolean' }).notNull().default(true),
  sortOrder: integer('sort_order').notNull().default(0),
  updatedAt: text('updated_at').notNull(),
});

export const scriptVersions = sqliteTable('script_versions', {
  id: text('id').primaryKey(),
  episode: text('episode').notNull(),
  versionNo: integer('version_no').notNull(),
  fileName: text('file_name').notNull().default(''),
  sourceText: text('source_text').notNull(),
  changeSummary: text('change_summary').notNull().default(''),
  workDate: text('work_date').notNull(),
  submittedBy: text('submitted_by').notNull(),
  sceneCount: integer('scene_count').notNull().default(0),
  itemCount: integer('item_count').notNull().default(0),
  isFinal: integer('is_final', { mode: 'boolean' }).notNull().default(false),
  finalizedAt: text('finalized_at').notNull().default(''),
  finalizedBy: text('finalized_by').notNull().default(''),
  createdAt: text('created_at').notNull(),
}, (table) => [
  uniqueIndex('script_versions_episode_version_unique').on(table.episode, table.versionNo),
  index('idx_script_versions_episode_created').on(table.episode, table.createdAt),
]);

export const artSubmissionDetails = sqliteTable('art_submission_details', {
  itemId: text('item_id').primaryKey(),
  assignedTo: text('assigned_to').notNull().default('主美小金'),
  dueAt: text('due_at').notNull().default(''),
  handoffTo: text('handoff_to').notNull().default('Lipa'),
  doneDefinition: text('done_definition').notNull().default(''),
  status: text('status').notNull().default('待上传'),
  submissionNote: text('submission_note').notNull().default(''),
  reviewNote: text('review_note').notNull().default(''),
  submittedAt: text('submitted_at').notNull().default(''),
  reviewedAt: text('reviewed_at').notNull().default(''),
  updatedAt: text('updated_at').notNull(),
});

export const artSubmissionFiles = sqliteTable('art_submission_files', {
  id: text('id').primaryKey(),
  itemId: text('item_id').notNull(),
  objectKey: text('object_key').notNull().unique(),
  fileName: text('file_name').notNull(),
  contentType: text('content_type').notNull(),
  byteSize: integer('byte_size').notNull(),
  uploadedBy: text('uploaded_by').notNull(),
  sortOrder: integer('sort_order').notNull().default(0),
  fileData: blob('file_data'),
  createdAt: text('created_at').notNull(),
}, (table) => [
  index('idx_art_submission_files_item').on(table.itemId, table.sortOrder),
]);

export const dailySceneAssignments = sqliteTable('daily_scene_assignments', {
  id: text('id').primaryKey(),
  workDate: text('work_date').notNull(),
  analysisId: text('analysis_id').notNull(),
  scriptVersionId: text('script_version_id').notNull().default(''),
  assignedBy: text('assigned_by').notNull(),
  createdAt: text('created_at').notNull(),
}, (table) => [
  uniqueIndex('daily_scene_assignments_date_analysis_unique').on(table.workDate, table.analysisId),
  index('idx_daily_scene_assignments_work_date').on(table.workDate),
]);
