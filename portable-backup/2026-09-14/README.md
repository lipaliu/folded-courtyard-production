# 折叠庭院的她｜可迁移制作数据备份

本备份包含 4 个剧本版本、222 张图片、全部美术拆解/定稿/审核记录、大计划、每日任务和历史归档表。

- `database/production-data.sqlite`：不含图片二进制的完整业务数据库。
- `database/production-data.sql`：同一数据库的通用 SQL 导出。
- `assets/uploads`：后台上传的图片原文件。
- `assets/manifest.json`：每张图的工作项、上传人、原文件名、哈希和存储路径。
- `script-versions`：各版本剧本文本和版本/定稿信息。
- `plan/production-plan.json`：大计划、每日任务、小结与场次安排。
- `exports/pdf`：已经生成过的提报 PDF 成品。

## 恢复

在仓库根目录运行：

```bash
node scripts/restore-portable-backup.mjs portable-backup/2026-09-14 /tmp/folded-courtyard-restored.sqlite
```

恢复脚本会验证全部图片 SHA-256 后，将上传图重新写入 SQLite BLOB；静态参考图继续读取仓库的 `public/reference-assets`。

## 安全说明

GitHub 仓库是公开的，因此本备份不含密码哈希、密码盐和登录会话。成员姓名与岗位仍由业务表保存；迁移后账号需重新注册或由管理员在私密环境单独迁移。
