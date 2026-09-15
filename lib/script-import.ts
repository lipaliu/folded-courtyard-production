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
  // Word/WeChat drafts may contain invisible directional marks and list bullets.
  // Normalize only the parsing copy; keep the uploaded source text in the archive.
  const text = sourceText.replace(/\r/g, '').replace(/[\u200e\u200f\u202a-\u202e\u2066-\u2069\ufeff]/g, '').replace(/\u00a0/g, ' ').trim();
  const lines = text.split('\n').map((line) => line.trim().replace(/^[•●▪]\s*/, '').trim()).filter(Boolean);
  const episode = findEpisode(lines, fileName);
  const headings: Array<{ index: number; location: string; headerLineCount: number }> = [];

  lines.forEach((line, index) => {
    const inline = matchInlineSceneHeading(line);
    if (inline) {
      const nearby = lines.slice(index + 1, index + 3);
      if (looksLikeSceneHeading(inline) || nearby.some(isPeopleLine)) headings.push({ index, location: inline, headerLineCount: 1 });
      return;
    }
    if (isSceneNumberOnly(line) && lines[index + 1]) {
      const location = lines[index + 1];
      if (looksLikeSceneHeading(location) || isPeopleLine(lines[index + 2] || '')) headings.push({ index, location, headerLineCount: 2 });
      return;
    }
    // Many production drafts omit scene numbers and use only
    // “地点  时间  内/外”, followed by “主要角色：…”. Number those
    // scenes by their order in the document instead of rejecting the file.
    if (!isSceneNumberOnly(lines[index - 1] || '') && isPeopleLine(lines[index + 1] || '')) {
      headings.push({ index, location: line, headerLineCount: 1 });
    }
  });

  // Intake must not be blocked by a writer's formatting. When a draft has no
  // recognizable scene markers at all, preserve the whole document as one
  // automatically numbered scene. Lipa can still finalize or replace it later.
  if (!headings.length && lines.length) {
    headings.push({ index: 0, location: '未标场次（系统自动补为第1场）', headerLineCount: 0 });
  }

  return headings.map(({ index: start, location, headerLineCount }, sceneIndex) => {
    const end = headings[sceneIndex + 1]?.index ?? lines.length;
    const sceneLines = lines.slice(start, end).filter((line) => !/^第.+集完$/.test(line));
    // Some screenplay drafts repeat a scene number after inserting a new scene.
    // Production IDs and assignments must still be unique, so the finalized
    // breakdown follows the actual document order (1..N).
    const sceneNo = sceneIndex + 1;
    const peopleLine = sceneLines.find(isPeopleLine);
    const people = peopleLine ? peopleLine.replace(/^(?:人物|主要角色)\s*[：:]/, '').split(/[、，,]/).map((name) => name.trim()).filter(Boolean).slice(0, 16) : [];
    const bodyLines = sceneLines.slice(headerLineCount).filter((line) => line !== peopleLine);
    const actionLines = bodyLines.filter((line) => !/^[^：:]{1,18}[：:]/.test(line));
    const sceneSummary = actionLines.slice(0, 3).join(' ').slice(0, 360) || `${location}的本场剧情与调度。`;
    const items = buildArtItems(location, people, bodyLines);
    return { episode, sceneNo, sceneTitle: location, location, scriptText: sceneLines.join('\n'), sceneSummary, items };
  });
}

function matchInlineSceneHeading(line: string) {
  const match = line.match(/^(?:(?:场次|场景)\s*)?(?:第\s*)?(?:\d{1,3}(?:[-—]\d{1,3})?|[一二三四五六七八九十百]+)(?:\s*场)?(?:\s*[.．、:：\-—]\s*|\s+)(.+)$/);
  return match?.[1]?.trim() || '';
}

function isSceneNumberOnly(line: string) {
  return /^(?:(?:场次|场景)\s*)?(?:第\s*)?(?:\d{1,3}(?:[-—]\d{1,3})?|[一二三四五六七八九十百]+)(?:\s*场)?\s*[.．、:：\-—]?\s*$/.test(line);
}

function looksLikeSceneHeading(line: string) {
  return /(?:深夜|清晨|凌晨|黄昏|傍晚|早晨|上午|中午|下午|日|夜|晨|晚|内|外)/.test(line);
}

function isPeopleLine(line: string) {
  return /^(?:人物|主要角色)\s*[：:]/.test(line);
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

export function buildArtItems(location: string, people: string[], bodyLines: string[]) {
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
  // Main-scene assets must stay together. Flashback/montage blocks come only
  // after the main scene and keep their own scene → people → wardrobe order.
  result.push(...buildEmbeddedSceneItems(bodyLines));
  return result;
}

function buildEmbeddedSceneItems(lines: string[]) {
  const starts = lines.flatMap((line, index) => {
    const match = line.match(/(闪回|回忆|蒙太奇|一组镜头|一组画面)/);
    return match ? [{ index, rawLabel: match[1] }] : [];
  });
  return starts.flatMap((start, sequenceIndex) => {
    const end = starts[sequenceIndex + 1]?.index ?? Math.min(lines.length, start.index + 8);
    const text = lines.slice(start.index, end).join(' ').replace(/[【】\[\]]/g, '').trim().slice(0, 360);
    const label = /蒙太奇|一组/.test(start.rawLabel) ? '蒙太奇' : '闪回';
    const domesticViolence = /家暴|前夫/.test(text) && /顾丽乔|丽乔/.test(text);
    const subject = domesticViolence
      ? '20岁顾丽乔被前夫家暴的小家'
      : text.replace(/^(?:闪回|回忆|蒙太奇|一组镜头|一组画面)\s*[：:]?\s*/, '').split(/[。；;]/)[0].slice(0, 28) || '独立场景参考';
    const sceneItem = {
      category: '场景',
      name: `${label}｜${subject}`,
      detail: text || `${label}段落需单独确认空间、年代和氛围。`,
      visualBrief: `${label}作为独立美术场景上传，不与当前主场景混用；先放完整空间图，再追加局部与角度。`,
    };
    if (!domesticViolence) return [sceneItem];
    return [
      sceneItem,
      {
        category: '服装',
        name: '闪回｜20岁顾丽乔穿搭',
        detail: '20岁顾丽乔在小家遭遇家暴时的完整穿搭，与片场服装分开审核。',
        visualBrief: '上传完整穿搭参考，可追加正侧背、材质与受损状态；不要混入当前时空服装。',
      },
      {
        category: '服装',
        name: '闪回｜家暴男（前夫）穿搭',
        detail: '家暴男（前夫）在小家闪回中的完整穿搭。',
        visualBrief: '上传完整穿搭参考，可追加正侧背和细节；与顾丽乔穿搭分开审核。',
      },
    ];
  });
}
