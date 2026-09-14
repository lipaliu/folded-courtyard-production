type Asset = { id: string; analysisId: string; category: string; name: string; detail: string; visualBrief: string; sortOrder: number };
type Scene = { id: string; episode: string; sceneNo: number };
export type ReuseExclusion = { itemId: string; fileId: string };

export function characterName(name: string) {
  // Do not infer ownership from plot text: an assistant can mention the heroine.
  for (const person of ['顾丽乔', '陆文川', '沈糯', '怪物演员', '制片主任', '视察人员', '神秘人', '导演', '群演', '群头', '助理', '前夫', '姑妈', '白鸽']) {
    if (name.includes(person)) return person;
  }
  return name.split(/[｜|（(:：]/)[0].replace(/(?:人物造型|人脸.*|妆造.*|服装.*|整体参考.*)$/, '').trim();
}

function isEmbeddedNarrativeBlock(item: Asset) {
  return /^(?:闪回|回忆|蒙太奇|一组镜头|一组画面)(?:\s*\d+)?\s*[｜|]/.test(item.name.trim());
}

export function compareArtItems(a: Asset, b: Asset) {
  // A flashback/montage is its own narrative block. Finish every asset in the
  // main scene before entering that block; never lift an embedded scene above
  // the main-scene characters just because both items belong to “场景”.
  const aEmbedded = isEmbeddedNarrativeBlock(a);
  const bEmbedded = isEmbeddedNarrativeBlock(b);
  if (aEmbedded !== bEmbedded) return aEmbedded ? 1 : -1;
  // Embedded blocks are generated in script order, with each block ordered as
  // scene → character styling → wardrobe. Preserve that contiguous sequence.
  if (aEmbedded && bEmbedded) return a.sortOrder - b.sortOrder || a.name.localeCompare(b.name, 'zh-CN');

  const rank = (item: Asset) => {
    if (item.category === '场景') return 0;
    if (item.category === '道具') return 900;
    const person = characterName(item.name);
    if (/历史服装/.test(item.name)) return 850;
    const base = person === '顾丽乔' ? 10 : person === '陆文川' ? 20 : /群演|整体参考/.test(item.name) ? 800 : 100;
    return base;
  };
  return rank(a) - rank(b) || characterName(a.name).localeCompare(characterName(b.name), 'zh-CN') || (a.category === '人物' ? 0 : 1) - (b.category === '人物' ? 0 : 1) || a.sortOrder - b.sortOrder;
}
export function buildReuseMap<F extends { id: string }>(analyses: Scene[], items: Asset[], filesByItem: Map<string, F[]>, exclusions: ReuseExclusion[] = []) {
  const result = new Map<string, { sourceItemId: string; sourceSceneNo: number; files: F[] }>();
  const byId = new Map(analyses.map((scene) => [scene.id, scene]));
  const previous: Asset[] = [];
  const key = (item: Asset) => /^(本场|其他|新增|临时|全部|配角与群演|历史)/.test(item.name) ? '' : `${item.category}:${item.category === '人物' ? characterName(item.name) : item.name.replace(/｜(?:服装|场景图)$/, '').trim()}`;
  const ordered = [...items].sort((a, b) => (byId.get(a.analysisId)?.episode || '').localeCompare(byId.get(b.analysisId)?.episode || '') || (byId.get(a.analysisId)?.sceneNo || 0) - (byId.get(b.analysisId)?.sceneNo || 0) || a.sortOrder - b.sortOrder);
  for (const item of ordered) {
    const scene = byId.get(item.analysisId);
    if (!scene) continue;
    if (!(filesByItem.get(item.id)?.length) && key(item)) {
      const explicit = [...`${item.name} ${item.detail} ${item.visualBrief}`.matchAll(/第\s*(\d+)\s*场/g)].map((match) => Number(match[1]));
      const candidate = [...previous].reverse().find((other) => {
        const origin = byId.get(other.analysisId)!;
        return origin.episode === scene.episode && origin.sceneNo < scene.sceneNo && (!explicit.length || explicit.includes(origin.sceneNo)) && key(other) === key(item) && Boolean(filesByItem.get(other.id)?.length || result.get(other.id)?.files.length);
      });
      if (candidate) {
        const inherited = result.get(candidate.id);
        const files = (filesByItem.get(candidate.id) || inherited?.files || []).filter((file) => !exclusions.some((excluded) => excluded.itemId === item.id && excluded.fileId === file.id));
        if (files.length) result.set(item.id, { sourceItemId: inherited?.sourceItemId || candidate.id, sourceSceneNo: inherited?.sourceSceneNo || byId.get(candidate.analysisId)!.sceneNo, files });
      }
    }
    previous.push(item);
  }
  return result;
}
