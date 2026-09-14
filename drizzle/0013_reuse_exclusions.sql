CREATE TABLE IF NOT EXISTS art_reference_exclusions (
  item_id TEXT NOT NULL,
  file_id TEXT NOT NULL,
  removed_by TEXT NOT NULL,
  created_at TEXT NOT NULL,
  PRIMARY KEY (item_id, file_id)
);
