# 《折叠庭院的她》在线剧本提报

公开提报页与内部协作后台共用同一个 Cloudflare Worker 和 D1 数据库。

- `/pitch`：公开提报，包含故事大纲、分集梗概、人物小传、单集剧本四个 Chapter，并可打印为 PDF。
- `/pitch-studio`：剧本提报后台；使用与项目管理系统相同的账号，只处理单集上传与版本档案。
- `/studio`：原项目管理 SOP（总制片推进台）。
- 编剧可上传 `.docx` / `.txt` 单集剧本；每次上传新增版本，不覆盖旧稿。
- 上传后系统自动拆场并写入 D1，公开提报页从 `/api/public/episodes` 自动追加新集数和新版本。
- 导演与制片人可登录查看；制片人保留排产与管理权限。

## 本地开发

```bash
npm install
npm run build
npx wrangler dev --config wrangler.standalone.jsonc
```

## 部署

```bash
npm run build
npx wrangler deploy --config wrangler.standalone.jsonc
```

静态初始提报内容保存在 `public/pitch.html`，结构化数据备份在 `lib/pitch-manifest.json`。脚本 `scripts/build-pitch-manifest.mjs` 可从新的故事大纲与分集 DOCX 重新生成结构化 Chapter 数据。


## 发行协作工作台

- `/release/calendar.html`：发行日历；现有创作账号直接登录，同域共用 HttpOnly 会话。
- `/api/release/calendar`：登录后读取全部安排 / 新增自己的任务；`/:id` 支持修改、软删除和撤销。
- 成员默认查看自己的任务，可查看整体日历；只可修改本人负责的任务，管理员可分配与调整全员任务。
- 运行 `drizzle/0025_release_workspace.sql` 初始化任务（可重复执行），不会修改已有成员或覆盖已导入任务。
- 源码与元数据公开，动态成员任务接口要求登录；账号凭据只保存在原有账号系统。
- 测试：`node --experimental-vm-modules tests/release-auth.mjs`，使用内存数据库验证真实认证模块与任务接口；`--serve` 可在 127.0.0.1:8772 启动隔离 UI 测试（测试账号只存在内存中）。
