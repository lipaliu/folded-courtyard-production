export type ImportedScriptScene = {
  episode: string;
  sceneNo: number;
  sceneTitle: string;
  location: string;
  scriptText: string;
  sceneSummary: string;
  items: Array<{ category: string; name: string; detail: string; visualBrief: string }>;
};

const propKeywords = [
  '祭坛', '手机', '酒瓶', '镜子', '灯架', '工作证', '细线', '卸妆棉', '纱布', '道具筐',
  '纸币', '结算单', '灭火器', '乌篷船', '电子钟', '船桨', '监控', '电话', '监护仪', '补光灯',
  '面膜', '置换单', '头套', '警铃', '门锁', '木栓', '景片', '屏幕', '病床',
];

const costumePattern = /(穿着|身穿|换上|脱下|湿透|白色长裙|裙|戏服|制服|西装|衬衫|外套|裤|鞋|袜|配饰|头套)/;
const visualStatePattern = /(穿着|身穿|湿透|血|伤|白发|刘海|妆|酒气|气息|发抖|虚脱|面膜|头套|长发|脸色)/;

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

function buildArtItems(location: string, people: string[], bodyLines: string[]) {
  const result: Array<{ category: string; name: string; detail: string; visualBrief: string }> = [];

  if (people.length) {
    for (const person of people) {
      const baseName = person.replace(/（.*?）|\(.*?\)/g, '').trim() || person;
      const clues = bodyLines.filter((line) => line.includes(baseName) && visualStatePattern.test(line)).slice(0, 3);
      result.push({
        category: '人物',
        name: `${person}｜人物造型`,
        detail: clues.join(' ') || `根据本场身份、情绪和前后场连续性确定${person}的妆发与人物状态。`,
        visualBrief: `${person}本场定妆图；包括发型、妆面、表情状态及必要的正侧面参考。`,
      });
    }
  } else {
    result.push({ category: '人物', name: '本场人物造型', detail: '从剧本中核对全部出场人物及状态。', visualBrief: '主美补充人物定妆、妆发和表情状态图。' });
  }

  const costumeLines = unique(bodyLines.filter((line) => costumePattern.test(line))).slice(0, 6);
  if (costumeLines.length) {
    costumeLines.forEach((line, index) => result.push({ category: '服装', name: `本场服装${costumeLines.length > 1 ? index + 1 : ''}`, detail: line, visualBrief: '按这条剧本信息生成完整穿搭图，标清内外层、鞋袜、配饰、颜色、材质和连续性。' }));
  } else {
    result.push({ category: '服装', name: '本场服装连续性', detail: '剧本没有写明具体服装，需根据人物身份、时间地点和前后场确定。', visualBrief: '主美补充本场完整穿搭图并标注与前后场是否连戏。' });
  }

  const foundProps = propKeywords.filter((keyword) => bodyLines.some((line) => line.includes(keyword))).slice(0, 14);
  if (foundProps.length) {
    foundProps.forEach((keyword) => {
      const clue = bodyLines.find((line) => line.includes(keyword)) || '';
      result.push({ category: '道具', name: keyword, detail: clue, visualBrief: `生成“${keyword}”设定图；标明外形、材质、尺寸及剧中使用状态。` });
    });
  } else {
    result.push({ category: '道具', name: '本场道具核对', detail: '剧本未识别出明确道具，主美需复核人物动作与剧情信息。', visualBrief: '如有手持、互动或剧情关键物，补充道具设定图。' });
  }

  const environmentClues = unique(bodyLines.filter((line) => !/^[^：:]{1,18}[：:]/.test(line) && /(房间|教堂|片场|庭院|巷|水|河|船|火|烟|门|窗|灯|医院|监控室|布景|景片|祭坛|回廊)/.test(line))).slice(0, 6);
  result.push({
    category: '场景',
    name: `${location}｜场景图`,
    detail: environmentClues.join(' ') || `根据场头“${location}”建立本场空间。`,
    visualBrief: '生成场景全景、关键机位方向、人物出入口、主要陈设和光线气氛图，足够支持白模调度。',
  });
  return result;
}

function unique(values: string[]) {
  return [...new Set(values)];
}
