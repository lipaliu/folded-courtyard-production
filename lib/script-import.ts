export type ImportedScriptScene = {
  episode: string;
  sceneNo: number;
  sceneTitle: string;
  location: string;
  scriptText: string;
  sceneSummary: string;
  items: Array<{ category: string; name: string; detail: string; visualBrief: string }>;
};

export function parseScriptDocument(sourceText: string, fileName = ''): ImportedScriptScene[] {
  const text = sourceText.replace(/\r/g, '').replace(/\u00a0/g, ' ').trim();
  const lines = text.split('\n').map((line) => line.trim()).filter(Boolean);
  const episode = findEpisode(lines, fileName);
  const headingIndexes: number[] = [];

  lines.forEach((line, index) => {
    const match = line.match(/^(\d{1,3})[.．、]\s*(.+)$/);
    if (!match) return;
    const nearby = lines.slice(index + 1, index + 3);
    if (/(?:夜|日|晨|晚|黄昏|清晨|深夜|内|外)(?:\s|$)/.test(match[2]) || nearby.some((row) => /^人物[：:]/.test(row))) headingIndexes.push(index);
  });

  return headingIndexes.map((start, sceneIndex) => {
    const end = headingIndexes[sceneIndex + 1] ?? lines.length;
    const sceneLines = lines.slice(start, end).filter((line) => !/^第.+集完$/.test(line));
    const heading = sceneLines[0];
    const match = heading.match(/^(\d{1,3})[.．、]\s*(.+)$/);
    // Some screenplay drafts repeat a scene number after inserting a new scene.
    // Production IDs and assignments must still be unique, so the finalized
    // breakdown follows the actual document order (1..N).
    const sceneNo = sceneIndex + 1;
    const location = (match?.[2] || heading).trim();
    const peopleLine = sceneLines.find((line) => /^人物[：:]/.test(line));
    const people = peopleLine ? peopleLine.replace(/^人物[：:]/, '').split(/[、，,]/).map((name) => name.trim()).filter(Boolean).slice(0, 16) : [];
    const bodyLines = sceneLines.slice(1).filter((line) => line !== peopleLine);
    const actionLines = bodyLines.filter((line) => !/^[^：:]{1,18}[：:]/.test(line));
    const sceneSummary = actionLines.slice(0, 3).join(' ').slice(0, 360) || `${location}的本场剧情与调度。`;
    const items = buildArtItems(location, people, bodyLines);
    return { episode, sceneNo, sceneTitle: location, location, scriptText: sceneLines.join('\n'), sceneSummary, items };
  });
}

function findEpisode(lines: string[], fileName: string) {
  const source = `${lines.slice(0, 8).join(' ')} ${fileName}`;
  const match = source.match(/第([一二三四五六七八九十百\d]+)集/);
  if (!match) return '第1集';
  return `第${chineseNumber(match[1])}集`;
}

function chineseNumber(value: string) {
  if (/^\d+$/.test(value)) return Number(value);
  const digits: Record<string, number> = { 一: 1, 二: 2, 三: 3, 四: 4, 五: 5, 六: 6, 七: 7, 八: 8, 九: 9 };
  if (value === '十') return 10;
  if (value.includes('十')) {
    const [left, right] = value.split('十');
    return (left ? digits[left] : 1) * 10 + (right ? digits[right] : 0);
  }
  return digits[value] || 1;
}

export function buildArtItems(location: string, people: string[], _bodyLines: string[]) {
  const result = [{ category: '场景', name: `${location}｜场景总参考`, detail: '本场一个场景上传位，可多传全景、局部及不同角度。', visualBrief: '先上传一张完整场景氛围图，再按实际需求追加细节图；不按文字自动拆分。' }];
  for (const person of ['顾丽乔', '陆文川']) {
    if (!people.some((name) => name.includes(person))) continue;
    result.push(
      { category: '人物', name: `${person}｜人脸、妆造、梳发`, detail: '本场角色形象统一参考，可上传多个备选。', visualBrief: '在同一项上传人脸、妆造和梳发参考，不拆成多个任务。' },
      { category: '服装', name: `${person}｜服装`, detail: '本场该角色的完整穿搭。', visualBrief: '上传完整服装参考，可追加多张备选与细节。' },
    );
  }
  const others = people.filter((name) => !/顾丽乔|陆文川/.test(name));
  if (others.length) result.push({ category: '服装', name: '配角与群演｜整体参考', detail: `本场配角与群演：${others.join('、')}。`, visualBrief: '整体形象和服装参考放在这一项，不需要每个人分别出图。' });
  return result;
}
