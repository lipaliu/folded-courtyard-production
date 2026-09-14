-- Keep one legacy clothing inbox per scene, retaining every file and its author.
UPDATE art_submission_files SET item_id=(SELECT MIN(target.id) FROM script_analysis_items source JOIN script_analysis_items target ON target.analysis_id=source.analysis_id WHERE source.id=art_submission_files.item_id AND target.is_active=1 AND target.name='历史服装备选（待确认角色）')
WHERE item_id IN (SELECT id FROM script_analysis_items WHERE is_active=1 AND name='历史服装备选（待确认角色）');
UPDATE script_analysis_items SET is_active=0 WHERE is_active=1 AND name='历史服装备选（待确认角色）' AND id<>(SELECT MIN(other.id) FROM script_analysis_items other WHERE other.analysis_id=script_analysis_items.analysis_id AND other.is_active=1 AND other.name='历史服装备选（待确认角色）');
UPDATE production_items SET planned_qty=(SELECT COUNT(*) FROM script_analysis_items i JOIN script_analyses a ON a.id=i.analysis_id WHERE a.episode=production_items.episode AND a.is_active=1 AND i.is_active=1) WHERE category='美术清单';
