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

export const lockedScheduleItems: ProductionItem[] = [
  item('rollup-2026-09-14-ep1-script', '2026-09-14', '第1集', '剧本', '提交第1集完整剧本给Lipa', '编剧', '未开始', 1, 0, '12:00', '上传完整稿，由Lipa选择定稿后生成本集生产与美术清单。', 1, '', '执行制片人：Lipa', '提交后立即定稿'),
  item('rollup-2026-09-14-ep2-script', '2026-09-14', '第2集', '剧本', '提交第2集完整剧本给Lipa', '编剧', '未开始', 1, 0, '13:00', '上传完整稿，由Lipa选择定稿后生成本集生产与美术清单。', 2, '', '执行制片人：Lipa', '提交后立即定稿'),
  item('rollup-2026-09-14-ep1-art', '2026-09-14', '第1集', '美术清单', '生成并上传第1集全部美术资产', '主美', '未开始', 1, 0, '20:00', '人物造型、服装、道具、场景全部生成并上传；按最终剧本清单逐项完成。', 3, 'rollup-2026-09-14-ep1-script', '执行制片人：Lipa', '20:15'),
  item('rollup-2026-09-14-ep2-art', '2026-09-14', '第2集', '美术清单', '生成并上传第2集全部美术资产', '主美', '未开始', 1, 0, '20:00', '人物造型、服装、道具、场景全部生成并上传；按最终剧本清单逐项完成。', 4, 'rollup-2026-09-14-ep2-script', '执行制片人：Lipa', '20:15'),
  item('rollup-2026-09-14-ep1-wardrobe', '2026-09-14', '第1集', '场景服装清单', '上传第1集全部场景与每个角色服装图', '服化道副导演', '未开始', 1, 0, '20:00', '与主美并行；负责场景和每个角色的服装，图片自动记录实际上传人。', 5, 'rollup-2026-09-14-ep1-script', '执行制片人：Lipa', '20:15'),
  item('rollup-2026-09-14-ep2-wardrobe', '2026-09-14', '第2集', '场景服装清单', '上传第2集全部场景与每个角色服装图', '服化道副导演', '未开始', 1, 0, '20:00', '与主美并行；负责场景和每个角色的服装，图片自动记录实际上传人。', 6, 'rollup-2026-09-14-ep2-script', '执行制片人：Lipa', '20:15'),
  item('rollup-2026-09-14-ep1-send', '2026-09-14', '第1集', '资产提报', '整理第1集全部图片并上传给Yoyo', '执行制片人：Lipa', '未开始', 1, 0, '21:00', '确认主美与服化道副导演已传齐，再生成美术提报H5／PDF并上传Yoyo。', 7, 'rollup-2026-09-14-ep1-wardrobe', '叶总／Yoyo', '发出后等待回复'),
  item('rollup-2026-09-14-ep2-send', '2026-09-14', '第2集', '资产提报', '整理第2集全部图片并上传给Yoyo', '执行制片人：Lipa', '未开始', 1, 0, '21:00', '确认主美与服化道副导演已传齐，再生成美术提报H5／PDF并上传Yoyo。', 8, 'rollup-2026-09-14-ep2-wardrobe', '叶总／Yoyo', '发出后等待回复'),
  item('rollup-2026-09-14-ep1-review', '2026-09-14', '第1集', '整集资产确认', '记录叶总／Yoyo对第1集全部资产的审核结果', '叶总／Yoyo', '未开始', 1, 0, '微信待回复', '审核统一记录为“叶总／Yoyo”，不再拆成两项。', 9, 'rollup-2026-09-14-ep1-send', '执行制片人：Lipa', '收到微信后录入'),
  item('rollup-2026-09-14-ep2-review', '2026-09-14', '第2集', '整集资产确认', '记录叶总／Yoyo对第2集全部资产的审核结果', '叶总／Yoyo', '未开始', 1, 0, '微信待回复', '审核统一记录为“叶总／Yoyo”，不再拆成两项。', 10, 'rollup-2026-09-14-ep2-send', '执行制片人：Lipa', '收到微信后录入'),
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

const rollingWorkDateBySource = new Map<string, string>();
let rollingCursor = '2026-09-14';
for (const sourceDate of batches.flatMap((batch) => datesBetween(batch.start, batch.end))) {
  rollingCursor = nextProductionDay(rollingCursor);
  rollingWorkDateBySource.set(sourceDate, rollingCursor);
}

const rolling = batches.flatMap((batch, batchIndex) =>
  datesBetween(batch.start, batch.end).flatMap((date, dayIndex) => {
    const shiftedWorkDate = rollingWorkDateBySource.get(date)!;
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
        item(`${date}-prep`, shiftedWorkDate, batch.prep, '场景图', `提报${batch.prep}场景、服装、配角与白模`, '主美', '未开始', 2, 0, '17:00', '每天提报2场；发给Yoyo后继续下一场，不等待回复', base + 3, '', '叶总／Yoyo', '完成后即提报'),
      );
    } else {
      rows.push(item(`${date}-finish`, shiftedWorkDate, '全片', '精剪', '全片精剪、声音与视觉统一', '剪辑', '未开始', 1, 0, '22:00', '成片前总检查', base + 2, '', '执行制片人：Lipa', '22:15'));
    }
    rows.push(
      item(`${date}-review`, shiftedWorkDate, `${batch.production} / ${batch.prep}`, '联合审核', '叶总／Yoyo审核当日视觉与成片意见', '叶总／Yoyo', '未开始', 1, 0, '微信待回复', '审核统一为叶总／Yoyo一项；未回复不阻断剧本、场景图和白模，只影响最终锁定', base + 5, batch.prep === '全片' ? '' : `${date}-prep`, '执行制片人：Lipa', '收到回复后更新'),
      item(`${date}-lipa`, shiftedWorkDate, `${batch.production} / ${batch.prep}`, '推进统筹', '更新已收到的微信意见并调整次日Rundown', '执行制片人：Lipa', '未开始', 1, 0, '21:00', '不等待Yoyo回复；Lipa按已收到的信息更新进度与次日安排', base + 6, '', '全组', '21:15'),
    );
    return rows;
  }),
);

export const initialItems: ProductionItem[] = [
  ...lockedScheduleItems,
  ...rolling,
  item('1021-delivery', '2026-10-24', '全片', '成片', '全片总审、修正与最终交付', '执行制片人：Lipa', '未开始', 10, 0, '20:00', '9月14日正式开工，其余大计划从9月15日起顺延接续。', 999, '', '叶总／Yoyo', '20:00'),
];

function item(id: string, workDate: string, episode: string, category: string, title: string, owner: string, status: Status, plannedQty: number, completedQty: number, dueTime: string, note: string, sortOrder: number, dependsOnId = '', handoffTo = '', handoffDeadline = ''): ProductionItem {
  return { id, workDate, episode, category, title, owner, reviewer: '叶总／Yoyo', status, plannedQty, completedQty, dueTime, dependsOnId, handoffTo, handoffDeadline, note, sortOrder, updatedAt: now };
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
  { id: 'kickoff-0914', startDate: '2026-09-14', endDate: '2026-09-14', production: '正式开工 Day 1：第1、2集剧本与全部图片当天交齐', prep: 'Lipa上传Yoyo · 叶总／Yoyo统一审核', note: '固定开工日，不可修改、不可被自动顺延。', sortOrder: 1, updatedAt: now },
  { id: 'batch-1', startDate: '2026-09-15', endDate: '2026-09-18', production: '第1集 生成＋初剪＋成片', prep: '第2—3集 筹备', note: '9月14日开工后接续原大计划。', sortOrder: 2, updatedAt: now },
  { id: 'batch-2', startDate: '2026-09-19', endDate: '2026-09-25', production: '第2—3集 生成＋初剪＋成片', prep: '第4—5集 筹备', note: '9月20日六休一，其余任务顺延接续。', sortOrder: 3, updatedAt: now },
  { id: 'rest-0920', startDate: '2026-09-20', endDate: '2026-09-20', production: '全组休息', prep: '不排硬交付', note: '从9月14日开工起按六休一计算。', sortOrder: 4, updatedAt: now },
  { id: 'batch-3', startDate: '2026-09-26', endDate: '2026-10-09', production: '第4—5集 生成＋初剪＋成片', prep: '第6—7集 筹备', note: '9月27日休息，10月1—7日国庆放假，其他任务顺延。', sortOrder: 5, updatedAt: now },
  { id: 'rest-0927', startDate: '2026-09-27', endDate: '2026-09-27', production: '全组休息', prep: '不排硬交付', note: '六休一', sortOrder: 6, updatedAt: now },
  { id: 'holiday-national-day', startDate: '2026-10-01', endDate: '2026-10-07', production: '国庆放假', prep: '全组不排工作', note: '按2026年国庆节法定安排休息7天', sortOrder: 9, updatedAt: now },
  { id: 'batch-4', startDate: '2026-10-10', endDate: '2026-10-16', production: '第6—7集 生成＋初剪＋成片', prep: '第8—9集 筹备', note: '10月11日六休一，其余任务顺延接续。', sortOrder: 10, updatedAt: now },
  { id: 'rest-1011', startDate: '2026-10-11', endDate: '2026-10-11', production: '全组休息', prep: '不排硬交付', note: '六休一', sortOrder: 11, updatedAt: now },
  { id: 'batch-5', startDate: '2026-10-17', endDate: '2026-10-21', production: '第8—9集 生成＋初剪＋成片', prep: '第10集 筹备', note: '10月18日六休一，其余任务顺延接续。', sortOrder: 12, updatedAt: now },
  { id: 'rest-1018', startDate: '2026-10-18', endDate: '2026-10-18', production: '全组休息', prep: '不排硬交付', note: '六休一', sortOrder: 13, updatedAt: now },
  { id: 'batch-6', startDate: '2026-10-22', endDate: '2026-10-24', production: '第10集生成＋初剪＋成片', prep: '全片精剪与统一', note: '第10集保留生成、初剪、修改成片三天。', sortOrder: 14, updatedAt: now },
  { id: 'delivery', startDate: '2026-10-24', endDate: '2026-10-24', production: '全片最终交付', prep: '机动修正', note: '9月14日正式开工，后续计划顺延接续，预计10月24日交付。', sortOrder: 99, updatedAt: now },
];
