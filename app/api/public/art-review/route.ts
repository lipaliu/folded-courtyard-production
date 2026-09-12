import { env } from 'cloudflare:workers';

export async function GET(request: Request) {
  const episode = new URL(request.url).searchParams.get('episode')?.trim().slice(0, 40) || '';
  if (!episode) return Response.json({ error: '缺少集数' }, { status: 400 });
  try {
    const [analyses, items, details, files, version] = await Promise.all([
      env.DB.prepare(`SELECT id, episode, scene_no AS sceneNo, scene_title AS sceneTitle,
        scene_summary AS sceneSummary, location FROM script_analyses
        WHERE episode = ? AND is_active = 1 ORDER BY scene_no`).bind(episode).all(),
      env.DB.prepare(`SELECT i.id, i.analysis_id AS analysisId, i.category, i.name, i.detail,
        i.visual_brief AS visualBrief, i.sort_order AS sortOrder
        FROM script_analysis_items i JOIN script_analyses a ON a.id = i.analysis_id
        WHERE a.episode = ? AND a.is_active = 1 AND i.is_active = 1
        ORDER BY a.scene_no, i.sort_order`).bind(episode).all(),
      env.DB.prepare(`SELECT d.item_id AS itemId, d.status, d.submission_note AS submissionNote,
        d.review_note AS reviewNote FROM art_submission_details d
        JOIN script_analysis_items i ON i.id = d.item_id
        JOIN script_analyses a ON a.id = i.analysis_id
        WHERE a.episode = ? AND a.is_active = 1 AND i.is_active = 1`).bind(episode).all(),
      env.DB.prepare(`SELECT f.id, f.item_id AS itemId, f.file_name AS fileName,
        f.uploaded_by AS uploadedBy, f.created_at AS createdAt, f.sort_order AS sortOrder FROM art_submission_files f
        JOIN script_analysis_items i ON i.id = f.item_id
        JOIN script_analyses a ON a.id = i.analysis_id
        WHERE a.episode = ? AND a.is_active = 1 AND i.is_active = 1
        ORDER BY a.scene_no, i.sort_order, f.sort_order`).bind(episode).all<{ id: string; itemId: string; fileName: string; uploadedBy: string; createdAt: string; sortOrder: number }>(),
      env.DB.prepare(`SELECT version_no AS versionNo, finalized_at AS finalizedAt
        FROM script_versions WHERE episode = ? AND is_final = 1 LIMIT 1`).bind(episode).first(),
    ]);
    return Response.json({
      episode,
      version,
      analyses: analyses.results,
      items: items.results,
      details: details.results,
      files: files.results.map((file) => ({ ...file, url: `/api/public/art-file/${file.id}` })),
    }, { headers: { 'Cache-Control': 'no-store' } });
  } catch (error) {
    return Response.json({ error: error instanceof Error ? error.message : '读取美术提报失败' }, { status: 500 });
  }
}
