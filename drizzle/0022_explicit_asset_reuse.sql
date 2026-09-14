ALTER TABLE art_submission_details ADD COLUMN reuse_source_item_id TEXT NOT NULL DEFAULT '';

INSERT INTO activity_log(item_type,item_id,action,operator,created_at)
VALUES('system','asset-reuse','增加Lipa确认跨场沿用资产能力','Lipa',datetime('now'));
