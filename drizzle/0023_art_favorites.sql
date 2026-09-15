CREATE TABLE IF NOT EXISTS art_file_favorites (
  account_id TEXT NOT NULL,
  file_id TEXT NOT NULL,
  created_at TEXT NOT NULL,
  PRIMARY KEY (account_id, file_id)
);
CREATE INDEX IF NOT EXISTS idx_art_favorites_file ON art_file_favorites(file_id);
