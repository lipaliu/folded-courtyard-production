-- 面向制作人员的文字只写角色与用途，不暴露系统内部的临时归类名称。
UPDATE script_analysis_items
SET name='顾丽乔｜服装',
    detail='第一场顾丽乔的服装参考，可上传多套备选并由 Lipa 选择定稿。',
    visual_brief='同一上传位可放多张服装图，不按剧本句子拆分。',
    updated_at=datetime('now')
WHERE id='ep1-v3-s1-heroine-wardrobe';

