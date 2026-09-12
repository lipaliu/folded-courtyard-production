import { nextProductionDay } from '@/lib/work-calendar';

export const STATUSES = ['未开始', '进行中', '待审核', '已通过', '延期', '未完成', '打回'] as const;
export type Status = (typeof STATUSES)[number];

export type ProductionItem = {
  id: string;
  workDate: string;
  episode: string;
  category: string;
  title: string;
  owner: string;
  reviewer: string;
  status: Status;
  plannedQty: number;
  completedQty: number;
  dueTime: string;
  dependsOnId: string;
  handoffTo: string;
  handoffDeadline: string;
  note: string;
  sortOrder: number;
  updatedAt: string;
};

export type Scene = {
  id: string;
  episode: string;
  sceneNo: number;
  title: string;
  location: string;
  owner: string;
  scriptStatus: Status;
  characterStatus: Status;
  locationStatus: Status;
  wardrobeStatus: Status;
  whiteModelStatus: Status;
  shotStatus: Status;
  roughCutStatus: Status;
  finalStatus: Status;
  updatedAt: string;
};

export type PlanBatch = {
  id: string;
  startDate: string;
  endDate: string;
  production: string;
  prep: string;
  note: string;
  sortOrder: number;
  updatedAt: string;
};

const now = '2026-09-09T09:00:00.000Z';

const special: ProductionItem[] = [
  item('0910-script', '2026-09-10', '第1—10集', '剧本', '提交全剧大纲＋分集初版', '编剧', '未开始', 1, 0, '15:00', '先锁定强逻辑内容和每集方向', 1, '', '执行制片人：Lipa', '15:30'),
  item('0910-script-meeting', '2026-09-10', '第1—10集', '剧本过会', '与编剧过会讨论大纲与分集', '执行制片人：Lipa', '未开始', 1, 0, '18:00', '收到大纲和分集后开会，锁定修改方向', 2, '0910-script', '编剧', '18:15'),
  item('0910-art', '2026-09-10', '第1集', '场景图', '提报第一集场景、服装与配角形象首批', '主美', '未开始', 5, 0, '12:00', '提报后Lipa才可发微信给Yoyo', 3, '', '执行制片人：Lipa', '12:15'),
  item('0910-send-yoyo', '2026-09-10', '第1集', '审核交接', '检查首批视觉并发微信给Yoyo', '执行制片人：Lipa', '未开始', 1, 0, '12:15', '收到主美提报后立即发送；发出后等待微信回复', 3, '0910-art', '红人（Yoyo）', '发出即等待回复'),
  item('0910-yoyo', '2026-09-10', '第1集', '红人审核', '在微信反馈第一集首批视觉设定', '红人（Yoyo）', '未开始', 5, 0, '微信待回复', 'Yoyo不登录系统、不设硬deadline；未回复不阻断剧本、场景图和白模', 4, '0910-send-yoyo', '执行制片人：Lipa', '收到回复后更新'),
  item('0910-lipa-record', '2026-09-10', '第1集', '推进统筹', '收到后录入Yoyo反馈并更新已通过场景', '执行制片人：Lipa', '未开始', 5, 0, '收到后', '收到一项录入一项；不影响剧本、场景图和白模继续推进', 5, '', '主美', '录入后即时同步'),
  item('0910-white', '2026-09-10', '第1集', '白模', '依据第一集剧本生成首批场景白模视频', '主美', '未开始', 3, 0, '21:00', '第一集剧本已具备，可直接按剧本制作；无需等待Yoyo回复，生成后同步提报Yoyo和叶总', 6, '', '红人（Yoyo）＋制片人（叶总）', '生成后即提报'),
  item('0911-lock', '2026-09-11', '第1集', '剧本', '完成第一集台词细化版并交Lipa', '编剧', '未开始', 1, 0, '20:00', '按9月10日过会意见细化人物状态、动作与全部台词', 7, '0910-script-meeting', '执行制片人：Lipa', '20:15'),
  item('0911-white', '2026-09-11', '第1集', '白模', '完成并提报第一集全部场景白模视频', '主美', '未开始', 5, 0, '15:00', '依据剧本完成全部场景与调度白模；无需等待Yoyo回复，完成后同步审核材料', 8, '0910-white', '红人（Yoyo）＋制片人（叶总）', '完成后即提报'),
  item('0911-yoyo-white', '2026-09-11', '第1集', '美术图审核', '在微信反馈第一集主美视觉图', '红人（Yoyo）', '未开始', 5, 0, '微信待回复', 'Yoyo只看主美做的图，不审核剧本和白模；Lipa收到意见后逐项更新', 9, '0910-send-yoyo', '执行制片人：Lipa', '收到回复后更新'),
  item('0911-producer-white', '2026-09-11', '第1集', '美术图审核', '审核第一集主美视觉图', '制片人（叶总）', '未开始', 5, 0, '18:00', '叶总只看主美做的图，不审核剧本和白模', 10, '0910-send-yoyo', '执行制片人：Lipa', '18:15'),
  item('0911-review', '2026-09-11', '第1集', '审核汇总', '汇总Yoyo与叶总对主美图的意见', '执行制片人：Lipa', '未开始', 1, 0, '20:00', '按已收到的意见逐项更新；最终视觉锁定后释放正式镜头', 11, '0910-send-yoyo', 'AIGC抽卡师', '2026-09-12 09:00'),
];

export const lockedScheduleItems: ProductionItem[] = [
  item('rollup-2026-09-12-ep1-art', '2026-09-12', '第1集', '美术清单', '生成并上传第1集全部主美资产', '主美', '未开始', 1, 0, '20:00', '完成人物造型、服装、道具和场景全部资产并上传；共40项。', 1, '', '执行制片人：Lipa', '2026-09-13 10:00'),
  item('priority-0912-ep2-script', '2026-09-12', '第2集', '剧本', '开始撰写第2集完整剧本', '编剧', '未开始', 1, 0, '20:00', '完成结构、核心冲突与前半集，上传为候选稿。', 2, '', '执行制片人：Lipa', '当天收工前'),
  item('priority-0913-art-rest', '2026-09-13', '全组', '休息', '主美休息，不排主美硬交付', '主美', '已通过', 1, 1, '全天', '主美当日休息；修改统一放到9月14日。', 1),
  item('priority-0913-ep1-confirm', '2026-09-13', '第1集', '资产复核', 'Lipa确认第1集全部资产', '执行制片人：Lipa', '未开始', 1, 0, '18:00', '逐项检查场景、人物、服装和道具，写清通过项与打回修改项。', 2, 'rollup-2026-09-12-ep1-art', '主美', '2026-09-14 10:00'),
  item('priority-0913-ep2-script', '2026-09-13', '第2集', '剧本', '继续撰写第2集完整剧本', '编剧', '未开始', 1, 0, '20:00', '完成后半集、结尾钩子与前后场连续性。', 3, 'priority-0912-ep2-script', '执行制片人：Lipa', '当天收工前'),
  item('priority-0914-ep1-revise', '2026-09-14', '第1集', '资产修改', '按Lipa意见修改第1集资产', '主美', '未开始', 1, 0, '18:00', '只修改9月13日打回项；已通过资产不重复返工。', 1, 'priority-0913-ep1-confirm', '执行制片人：Lipa', '修改后立即复核'),
  item('priority-0914-ep1-board', '2026-09-14', '第1集', '分镜', '第1集资产全部通过后开始分镜', '主美', '未开始', 1, 0, '全部通过后', '条件任务：资产全部通过才启动；未通过则继续修改资产。', 2, 'priority-0914-ep1-revise', '执行制片人：Lipa', '当天同步'),
  item('priority-0914-ep2-final', '2026-09-14', '第2集', '剧本', '提交第2集完整剧本', '编剧', '未开始', 1, 0, '20:00', '上传完整稿为候选版本；由Lipa选择定稿后再生成拆场和主美资产。', 3, 'priority-0913-ep2-script', '执行制片人：Lipa', '提交后定稿'),
];

const batches = [
  { start: '2026-09-12', end: '2026-09-15', production: '第1集', prep: '第2—3集' },
  { start: '2026-09-17', end: '2026-09-22', production: '第2—3集', prep: '第4—5集' },
  { start: '2026-09-24', end: '2026-09-29', production: '第4—5集', prep: '第6—7集' },
  { start: '2026-10-08', end: '2026-10-13', production: '第6—7集', prep: '第8—9集' },
  { start: '2026-10-15', end: '2026-10-18', production: '第8—9集', prep: '第10集' },
  { start: '2026-10-19', end: '2026-10-21', production: '第10集', prep: '全片' },
];

function datesBetween(start: string, end: string) {
  const dates: string[] = [];
  const cursor = new Date(`${start}T00:00:00Z`);
  const last = new Date(`${end}T00:00:00Z`);
  while (cursor <= last) {
    dates.push(cursor.toISOString().slice(0, 10));
    cursor.setUTCDate(cursor.getUTCDate() + 1);
  }
  return dates;
}

function advanceProductionDays(value: string, amount: number) {
  let result = value;
  for (let index = 0; index < amount; index += 1) result = nextProductionDay(result);
  return result;
}

const rolling = batches.flatMap((batch, batchIndex) =>
  datesBetween(batch.start, batch.end).flatMap((date, dayIndex) => {
    const shiftedWorkDate = advanceProductionDays(date, 3);
    const day = dayIndex + 1;
    const base = 100 + batchIndex * 30 + dayIndex * 4;
    const days = datesBetween(batch.start, batch.end);
    const isRoughCutDay = dayIndex === days.length - 2;
    const isFinalCutDay = dayIndex === days.length - 1;
    const previousDate = days[Math.max(0, dayIndex - 1)];
    const rows: ProductionItem[] = [];
    if (!isRoughCutDay && !isFinalCutDay) {
      rows.push(item(`${date}-gen`, shiftedWorkDate, batch.production, '正式镜头', `生成${batch.production}正式镜头 · 第${day}天`, 'AIGC抽卡师', '未开始', batch.production === '第1集' ? 1 : 2, 0, '19:00', dayIndex === days.length - 3 ? '本集全部素材齐套，当晚同步剪辑' : '只统计审核可用镜头', base, '', dayIndex === days.length - 3 ? '剪辑' : '执行制片人：Lipa', dayIndex === days.length - 3 ? '20:00' : '19:15'));
    }
    if (isRoughCutDay) {
      rows.push(item(`${date}-rough`, shiftedWorkDate, batch.production, '初剪', `接收${batch.production}全部素材并完成初剪`, '剪辑', '未开始', 1, 0, '21:00', '素材齐套后预留1天完成初剪', base, `${previousDate}-gen`, '执行制片人：Lipa', '21:15'));
    }
    if (isFinalCutDay) {
      rows.push(item(`${date}-final`, shiftedWorkDate, batch.production, '成片', `完成${batch.production}修改版与成片`, '剪辑', '未开始', 1, 0, '21:00', '初剪反馈后预留1天修改与交片', base, `${previousDate}-rough`, '执行制片人：Lipa', '21:15'));
    }
    if (batch.prep !== '全片') {
      rows.push(
        item(`${date}-script`, shiftedWorkDate, batch.prep, '剧本', day === days.length ? `锁定${batch.prep}全部剧本` : `编写${batch.prep} · 第${day}天`, '编剧', '未开始', 6, 0, '18:00', '单集最多3天，双集5天锁定', base + 2, '', '执行制片人：Lipa', '18:15'),
        item(`${date}-prep`, shiftedWorkDate, batch.prep, '场景图', `提报${batch.prep}场景、服装、配角与白模`, '主美', '未开始', 2, 0, '17:00', '每天提报2场；发给Yoyo后继续下一场，不等待回复', base + 3, '', '红人（Yoyo）', '完成后即提报'),
      );
    } else {
      rows.push(item(`${date}-finish`, shiftedWorkDate, '全片', '精剪', '全片精剪、声音与视觉统一', '剪辑', '未开始', 1, 0, '22:00', '成片前总检查', base + 2, '', '执行制片人：Lipa', '22:15'));
    }
    rows.push(
      item(`${date}-producer`, shiftedWorkDate, `${batch.production} / ${batch.prep}`, '制片审核', '确认方向与关键制作决策', '制片人（叶总）', '未开始', 1, 0, '17:00', '叶总确认关键决策', base + 4, '', '执行制片人：Lipa', '17:15'),
      item(`${date}-review`, shiftedWorkDate, `${batch.production} / ${batch.prep}`, '红人审核', '在微信反馈当日视觉与成片意见', '红人（Yoyo）', '未开始', 1, 0, '微信待回复', 'Yoyo不登录系统、不设硬deadline；未回复不阻断剧本、场景图和白模，只影响最终锁定', base + 5, batch.prep === '全片' ? '' : `${date}-prep`, '执行制片人：Lipa', '收到回复后更新'),
      item(`${date}-lipa`, shiftedWorkDate, `${batch.production} / ${batch.prep}`, '推进统筹', '更新已收到的微信意见并调整次日Rundown', '执行制片人：Lipa', '未开始', 1, 0, '21:00', '不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排', base + 6, '', '全组', '21:15'),
    );
    return rows;
  }),
);

export const initialItems: ProductionItem[] = [
  ...special,
  ...lockedScheduleItems,
  ...rolling,
  item('1021-delivery', '2026-10-24', '全片', '成片', '全片总审、修正与最终交付', '执行制片人：Lipa', '未开始', 10, 0, '20:00', '三天锁定排期插入后，最终交付顺延至10月24日。', 999, '', '制片人（叶总）', '20:00'),
];

function item(id: string, workDate: string, episode: string, category: string, title: string, owner: string, status: Status, plannedQty: number, completedQty: number, dueTime: string, note: string, sortOrder: number, dependsOnId = '', handoffTo = '', handoffDeadline = ''): ProductionItem {
  return { id, workDate, episode, category, title, owner, reviewer: 'Yoyo', status, plannedQty, completedQty, dueTime, dependsOnId, handoffTo, handoffDeadline, note, sortOrder, updatedAt: now };
}

export const initialScenes: Scene[] = [
  scene('ep1-s1', 1, '戏中戏受虐与真实身份翻面', '南庭影视城·玄幻剧片场／婚姻闪回空间', '主美', '未开始'),
  scene('ep1-s2', 2, '白鸽复苏与第一次代价', '玄幻剧片场·廊柱后候场区', '主美', '未开始'),
  scene('ep1-s3', 3, '相触预见陆文川死亡', '影视城棚间小巷', '主美', '未开始'),
  scene('ep1-s4', 4, '火警成真与逆行选择', '东方庭院外围', '主美', '未开始'),
  scene('ep1-s5', 5, '六十秒救回陆文川', '东方庭院·临水巷道', '主美', '未开始'),
  scene('ep1-s6', 6, '监控剪辑与幕后操盘', '影视城监控室', '主美', '未开始'),
  scene('ep1-s7', 7, '陆文川醒来追查缺失一分钟', '医院病房', '主美', '未开始'),
  scene('ep1-s8', 8, '面摊爆红、前夫与黑车双钩子', '上塘城·姑妈面摊／街边黑色轿车', '主美', '未开始'),
];

function scene(id: string, sceneNo: number, title: string, location: string, owner: string, visual: Status): Scene {
  return {
    id, episode: '第1集', sceneNo, title, location, owner,
    scriptStatus: '进行中', characterStatus: visual, locationStatus: visual, wardrobeStatus: visual,
    whiteModelStatus: '未开始', shotStatus: '未开始', roughCutStatus: '未开始', finalStatus: '未开始', updatedAt: now,
  };
}

export const initialBatches: PlanBatch[] = [
  { id: 'prep-ep1', startDate: '2026-09-10', endDate: '2026-09-11', production: '第1集正式筹备', prep: '场景 / 服装 / 配角 / 白模', note: '9月10日Day 1；视觉通过一场，白模启动一场', sortOrder: 1, updatedAt: now },
  { id: 'priority-0912-0914', startDate: '2026-09-12', endDate: '2026-09-14', production: '第1集资产完成、确认、修改；通过后启动分镜', prep: '第2集完整剧本写作与提交', note: '固定执行期：9.12—9.14不能修改、不能被自动顺延；原大计划从9.15继续。', sortOrder: 2, updatedAt: now },
  { id: 'batch-1', startDate: '2026-09-15', endDate: '2026-09-19', production: '第1集 生成＋初剪＋成片', prep: '第2—3集 筹备', note: '原9.12起任务整体顺延3个生产日；9.16全组休息。', sortOrder: 3, updatedAt: now },
  { id: 'rest-0916', startDate: '2026-09-16', endDate: '2026-09-16', production: '全组休息', prep: '不排硬交付', note: '六休一', sortOrder: 4, updatedAt: now },
  { id: 'batch-2', startDate: '2026-09-20', endDate: '2026-09-26', production: '第2—3集 生成＋初剪＋成片', prep: '第4—5集 筹备', note: '原计划整体顺延3个生产日；9.23全组休息。', sortOrder: 5, updatedAt: now },
  { id: 'rest-0923', startDate: '2026-09-23', endDate: '2026-09-23', production: '全组休息', prep: '不排硬交付', note: '六休一', sortOrder: 6, updatedAt: now },
  { id: 'batch-3', startDate: '2026-09-27', endDate: '2026-10-10', production: '第4—5集 生成＋初剪＋成片', prep: '第6—7集 筹备', note: '原计划顺延；9.30休息，10.1—10.7国庆放假。', sortOrder: 7, updatedAt: now },
  { id: 'rest-0930', startDate: '2026-09-30', endDate: '2026-09-30', production: '全组休息', prep: '不排硬交付', note: '六休一', sortOrder: 8, updatedAt: now },
  { id: 'holiday-national-day', startDate: '2026-10-01', endDate: '2026-10-07', production: '国庆放假', prep: '全组不排工作', note: '按2026年国庆节法定安排休息7天', sortOrder: 9, updatedAt: now },
  { id: 'batch-4', startDate: '2026-10-11', endDate: '2026-10-17', production: '第6—7集 生成＋初剪＋成片', prep: '第8—9集 筹备', note: '节后继续顺延后计划；10.14全组休息。', sortOrder: 10, updatedAt: now },
  { id: 'rest-1014', startDate: '2026-10-14', endDate: '2026-10-14', production: '全组休息', prep: '不排硬交付', note: '六休一', sortOrder: 11, updatedAt: now },
  { id: 'batch-5', startDate: '2026-10-18', endDate: '2026-10-21', production: '第8—9集 生成＋初剪＋成片', prep: '第10集 筹备', note: '原计划整体顺延3个生产日。', sortOrder: 12, updatedAt: now },
  { id: 'batch-6', startDate: '2026-10-22', endDate: '2026-10-24', production: '第10集生成＋初剪＋成片', prep: '全片精剪与统一', note: '第10集保留生成、初剪、修改成片三天。', sortOrder: 13, updatedAt: now },
  { id: 'delivery', startDate: '2026-10-24', endDate: '2026-10-24', production: '全片最终交付', prep: '机动修正', note: '插入9.12—9.14固定执行期后，交付日顺延至10月24日。', sortOrder: 99, updatedAt: now },
];
