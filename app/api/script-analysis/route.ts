import { env } from 'cloudflare:workers';
import { requireAdmin } from '@/lib/auth';

const categories = ['场景', '人物', '服装', '妆发', '道具', '美术图'] as const;

type BreakdownItem = {
  category: (typeof categories)[number];
  name: string;
  detail: string;
  visualBrief: string;
};

type Breakdown = {
  sceneTitle: string;
  sceneSummary: string;
  location: string;
  items: BreakdownItem[];
};

export async function GET() {
  try {
    const [analyses, items] = await Promise.all([
      env.DB.prepare(`SELECT id, episode, scene_no AS sceneNo, scene_title AS sceneTitle,
        script_text AS scriptText, scene_summary AS sceneSummary, location, created_at AS createdAt,
        updated_at AS updatedAt FROM script_analyses ORDER BY created_at DESC`).all(),
      env.DB.prepare(`SELECT id, analysis_id AS analysisId, category, name, detail,
        visual_brief AS visualBrief, yoyo_approved AS yoyoApproved, sort_order AS sortOrder,
        updated_at AS updatedAt FROM script_analysis_items ORDER BY analysis_id, sort_order`).all(),
    ]);
    return Response.json({ analyses: analyses.results, items: items.results, modelReady: Boolean(env.OPENAI_API_KEY) });
  } catch (error) {
    return Response.json({ analyses: [], items: [], modelReady: Boolean(env.OPENAI_API_KEY), error: error instanceof Error ? error.message : '读取失败' });
  }
}

export async function POST(request: Request) {
  const admin = await requireAdmin(request);
  if (!admin) return Response.json({ error: '只有Lipa可以使用剧本拆解' }, { status: 403 });
  const body = await request.json() as Partial<{ episode: string; sceneNo: number; sceneTitle: string; scriptText: string }>;
  const scriptText = body.scriptText?.trim() || '';
  if (!body.episode?.trim() || !body.sceneNo || !scriptText) return Response.json({ error: '请填写集数、场次和剧本文字' }, { status: 400 });
  if (scriptText.length > 24000) return Response.json({ error: '单次最多分析约24,000字，请按场拆分后再提交' }, { status: 400 });
  if (!env.OPENAI_API_KEY) return Response.json({ error: '模型尚未接通，需要先安全配置OpenAI API Key' }, { status: 503 });

  const schema = {
    type: 'object',
    properties: {
      sceneTitle: { type: 'string' },
      sceneSummary: { type: 'string' },
      location: { type: 'string' },
      items: {
        type: 'array',
        items: {
          type: 'object',
          properties: {
            category: { type: 'string', enum: categories },
            name: { type: 'string' },
            detail: { type: 'string' },
            visualBrief: { type: 'string' },
          },
          required: ['category', 'name', 'detail', 'visualBrief'],
          additionalProperties: false,
        },
      },
    },
    required: ['sceneTitle', 'sceneSummary', 'location', 'items'],
    additionalProperties: false,
  };

  try {
    const response = await fetch('https://api.openai.com/v1/responses', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${env.OPENAI_API_KEY}` },
      body: JSON.stringify({
        model: env.OPENAI_MODEL || 'gpt-5-mini',
        input: [
          { role: 'system', content: '你是影视美术统筹。把用户提供的单场剧本拆成需要制作并交Yoyo逐项确认的视觉资产。必须覆盖场景、出场人物、每个人本场服装、妆发、关键道具和需要生成的美术图。相同内容不要重复；剧本没有明确写出的内容要标明“需确认”，不要擅自写死。visualBrief要能直接交给主美出图。只返回符合JSON Schema的结果。' },
          { role: 'user', content: `集数：${body.episode}\n场次：${body.sceneNo}\n场名：${body.sceneTitle || '未命名'}\n\n剧本：\n${scriptText}` },
        ],
        text: { format: { type: 'json_schema', name: 'screenplay_art_breakdown', strict: true, schema } },
        max_output_tokens: 5000,
      }),
    });
    const payload = await response.json() as Record<string, unknown>;
    if (!response.ok) {
      const error = payload.error as { message?: string } | undefined;
      return Response.json({ error: error?.message || '模型分析失败' }, { status: response.status });
    }
    const outputText = extractOutputText(payload);
    if (!outputText) return Response.json({ error: '模型没有返回可用结果，请重试' }, { status: 502 });
    const breakdown = JSON.parse(outputText) as Breakdown;
    const now = new Date().toISOString();
    const analysisId = crypto.randomUUID();
    const cleanItems = breakdown.items.filter((item) => categories.includes(item.category)).slice(0, 80);
    await env.DB.batch([
      env.DB.prepare(`INSERT INTO script_analyses
        (id, episode, scene_no, scene_title, script_text, scene_summary, location, created_at, updated_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`)
        .bind(analysisId, body.episode.trim(), body.sceneNo, breakdown.sceneTitle || body.sceneTitle || `第${body.sceneNo}场`, scriptText, breakdown.sceneSummary || '', breakdown.location || '', now, now),
      ...cleanItems.map((item, index) => env.DB.prepare(`INSERT INTO script_analysis_items
        (id, analysis_id, category, name, detail, visual_brief, yoyo_approved, sort_order, updated_at)
        VALUES (?, ?, ?, ?, ?, ?, 0, ?, ?)`)
        .bind(crypto.randomUUID(), analysisId, item.category, item.name.slice(0, 120), item.detail.slice(0, 500), item.visualBrief.slice(0, 1000), index, now)),
    ]);
    return Response.json({ ok: true, analysisId });
  } catch (error) {
    return Response.json({ error: error instanceof Error ? error.message : '分析失败' }, { status: 500 });
  }
}

export async function PATCH(request: Request) {
  const admin = await requireAdmin(request);
  if (!admin) return Response.json({ error: '只有Lipa可以修改审核项' }, { status: 403 });
  const body = await request.json() as Partial<{ id: string; yoyoApproved: boolean; name: string; detail: string; visualBrief: string }>;
  if (!body.id) return Response.json({ error: '缺少审核项ID' }, { status: 400 });
  const current = await env.DB.prepare('SELECT name, detail, visual_brief AS visualBrief, yoyo_approved AS yoyoApproved FROM script_analysis_items WHERE id = ?').bind(body.id).first<Record<string, string | number>>();
  if (!current) return Response.json({ error: '审核项不存在' }, { status: 404 });
  const updatedAt = new Date().toISOString();
  const updated = {
    name: typeof body.name === 'string' ? body.name.slice(0, 120) : String(current.name),
    detail: typeof body.detail === 'string' ? body.detail.slice(0, 500) : String(current.detail),
    visualBrief: typeof body.visualBrief === 'string' ? body.visualBrief.slice(0, 1000) : String(current.visualBrief),
    yoyoApproved: typeof body.yoyoApproved === 'boolean' ? body.yoyoApproved : Boolean(current.yoyoApproved),
  };
  await env.DB.batch([
    env.DB.prepare('UPDATE script_analysis_items SET name = ?, detail = ?, visual_brief = ?, yoyo_approved = ?, updated_at = ? WHERE id = ?')
      .bind(updated.name, updated.detail, updated.visualBrief, updated.yoyoApproved ? 1 : 0, updatedAt, body.id),
    env.DB.prepare('INSERT INTO activity_log (item_type, item_id, action, operator, created_at) VALUES (?, ?, ?, ?, ?)')
      .bind('script_analysis_item', body.id, updated.yoyoApproved ? 'Yoyo已通过' : 'Yoyo未通过', 'Lipa', updatedAt),
  ]);
  return Response.json({ ok: true, item: { ...updated, id: body.id, updatedAt } });
}

function extractOutputText(payload: Record<string, unknown>) {
  if (typeof payload.output_text === 'string') return payload.output_text;
  const output = Array.isArray(payload.output) ? payload.output : [];
  for (const item of output as Array<{ content?: Array<{ type?: string; text?: string }> }>) {
    for (const content of item.content || []) if (content.type === 'output_text' && content.text) return content.text;
  }
  return '';
}
