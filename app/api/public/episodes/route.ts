import { env } from 'cloudflare:workers';
import { parseScriptDocument } from '@/lib/script-import';

type VersionRow = {
  id: string;
  episode: string;
  versionNo: number;
  fileName: string;
  sourceText: string;
  changeSummary: string;
  workDate: string;
  submittedBy: string;
  createdAt: string;
};

function episodeNumber(value: string) {
  const arabic = value.match(/\d+/)?.[0];
  if (arabic) return Number(arabic);
  const digits: Record<string, number> = { 一: 1, 二: 2, 三: 3, 四: 4, 五: 5, 六: 6, 七: 7, 八: 8, 九: 9 };
  const chinese = value.match(/第([一二三四五六七八九十]+)集/)?.[1] || '';
  if (chinese === '十') return 10;
  if (chinese.includes('十')) {
    const [left, right] = chinese.split('十');
    return (left ? digits[left] : 1) * 10 + (right ? digits[right] || 0 : 0);
  }
  return digits[chinese] || 0;
}

function cleanTitle(fileName: string, episode: number) {
  const value = fileName.replace(/\.(docx|txt)$/i, '').replace(/^《|》$/g, '').trim();
  return value || `第${episode}集新稿`;
}

export async function GET() {
  let rows;
  try {
    rows = await env.DB.prepare(`SELECT id, episode, version_no AS versionNo, file_name AS fileName,
      source_text AS sourceText, change_summary AS changeSummary, work_date AS workDate,
      submitted_by AS submittedBy, created_at AS createdAt
      FROM script_versions WHERE is_final = 1 ORDER BY created_at ASC LIMIT 100`).all<VersionRow>();
  } catch (error) {
    console.error('Public episode feed unavailable', error);
    return Response.json({ episodes: [] }, { headers: { 'Cache-Control': 'no-store' } });
  }
  const episodes = rows.results.flatMap((row) => {
    const episode = episodeNumber(row.episode);
    if (!episode) return [];
    const parsed = parseScriptDocument(row.sourceText, row.fileName);
    const scenes = parsed.map((scene, index) => ({
      id: `${row.id}-sc${scene.sceneNo}`,
      sourceSceneNo: String(scene.sceneNo),
      displaySceneNo: index + 1,
      heading: scene.sceneTitle,
      location: scene.location,
      time: '',
      interiorExterior: '',
      characters: [],
      summary: scene.sceneSummary,
      script: scene.scriptText,
    }));
    if (!scenes.length) return [];
    return [{
      id: row.id,
      episode,
      title: cleanTitle(row.fileName, episode),
      version: `后台 v${row.versionNo}`,
      sourceFile: row.fileName || '在线上传',
      intakeDate: row.createdAt.slice(0, 10),
      duration: '待确认',
      hook: scenes[0].summary,
      core: row.changeSummary || '团队在线上传的新一集剧本。',
      turn: `共识别 ${scenes.length} 场，等待导演与制片人审阅。`,
      endingHook: scenes.at(-1)?.summary || '',
      updateSummary: `${row.submittedBy} 在线上传 · ${row.changeSummary || '未填写更新说明'}`,
      scenes,
      continuity: [],
      issues: [],
      status: 'Lipa已定稿',
    }];
  });
  return Response.json({ episodes }, { headers: { 'Cache-Control': 'no-store' } });
}
