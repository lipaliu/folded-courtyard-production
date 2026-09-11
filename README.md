# 《折叠庭院的她》在线剧本提报

公开提报页与内部协作后台共用同一个 Cloudflare Worker 和 D1 数据库。

- `/pitch`：公开提报，包含故事大纲、分集梗概、人物小传、单集剧本四个 Chapter，并可打印为 PDF。
- `/studio`：邀请制登录，仅限编剧、导演、制片人。
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
