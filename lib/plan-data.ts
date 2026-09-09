export const STATUSES = ['未开始', '进行中', '待审核', '已通过', '打回'] as const;
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
  item('0909-art', '2026-09-09', '第1集', '场景图', '完成第一集场景图、服装与配角形象首批', '主美', '待审核', 5, 3, '12:00', '通过一场就立即转白模', 1),
  item('0909-review', '2026-09-09', '第1集', '审核', '审完第一集首批视觉设定', '红人（Yoyo）', '待审核', 6, 0, '18:00', 'Yoyo在微信回复，Lipa负责勾选同步', 2),
  item('0909-outline', '2026-09-09', '第2—10集', '剧本', '提交第2—10集分集方向', '编剧', '进行中', 1, 0, '20:00', '大方向先锁定', 3),
  item('0910-script', '2026-09-10', '第1集', '剧本', '修改人物状态、动作与台词', '编剧', '未开始', 6, 0, '18:00', '第一集已有初稿，按修改量推进', 4),
  item('0910-review', '2026-09-10', '第1集', '审核', '锁定全部场景、服装、配角形象', '红人（Yoyo）', '未开始', 12, 0, '20:00', 'Yoyo微信反馈，Lipa录入结果', 5),
  item('0910-white', '2026-09-10', '第1集', '白模', '完成已通过场景的首批白模', '主美', '未开始', 3, 0, '21:00', '视觉一过立刻制作', 6),
  item('0911-lock', '2026-09-11', '第1集', '剧本', '锁定第一集正式剧本与全部台词', '编剧', '未开始', 1, 0, '15:00', '次日直接进入正式镜头', 7),
  item('0911-white', '2026-09-11', '第1集', '白模', '完成并锁定第一集全部白模视频', '主美', '未开始', 5, 0, '18:00', '全部调度确认', 8),
  item('0911-review', '2026-09-11', '第1集', '审核', '剧本、台词、白模总锁定', '联合制片人／导演：Lipa', '未开始', 3, 0, '20:00', '收齐叶总与Yoyo意见后锁定开机', 9),
];

const batches = [
  { start: '2026-09-12', end: '2026-09-16', production: '第1集', prep: '第2—3集' },
  { start: '2026-09-17', end: '2026-09-21', production: '第2—3集', prep: '第4—5集' },
  { start: '2026-09-22', end: '2026-09-26', production: '第4—5集', prep: '第6—7集' },
  { start: '2026-09-27', end: '2026-10-01', production: '第6—7集', prep: '第8—9集' },
  { start: '2026-10-02', end: '2026-10-05', production: '第8—9集', prep: '第10集' },
  { start: '2026-10-06', end: '2026-10-08', production: '第10集', prep: '全片' },
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

const rolling = batches.flatMap((batch, batchIndex) =>
  datesBetween(batch.start, batch.end).flatMap((date, dayIndex) => {
    const day = dayIndex + 1;
    const base = 100 + batchIndex * 30 + dayIndex * 4;
    const rows: ProductionItem[] = [
      item(`${date}-gen`, date, batch.production, '正式镜头', `生成${batch.production}正式镜头 · 第${day}天`, 'AIGC抽卡师', '未开始', batch.production === '第1集' ? 1 : 2, 0, '19:00', '只统计审核可用镜头', base),
      item(`${date}-edit`, date, batch.production, '初剪', `按场接收并初剪${batch.production}`, 'AIGC抽卡师', '未开始', 10, 0, '21:00', '不等整集镜头全部生成', base + 1),
    ];
    if (batch.prep !== '全片') {
      rows.push(
        item(`${date}-script`, date, batch.prep, '剧本', day === datesBetween(batch.start, batch.end).length ? `锁定${batch.prep}全部剧本` : `编写${batch.prep} · 第${day}天`, '编剧', '未开始', 6, 0, '18:00', '单集最多3天，双集5天锁定', base + 2),
        item(`${date}-prep`, date, batch.prep, '场景图', `完成${batch.prep}场景、服装、配角与白模`, '主美', '未开始', 2, 0, '20:00', '每天完成并送审2场', base + 3),
      );
    } else {
      rows.push(item(`${date}-finish`, date, '全片', '精剪', '全片精剪、声音与视觉统一', 'AIGC抽卡师', '未开始', 1, 0, '22:00', '成片前总检查', base + 2));
    }
    rows.push(
      item(`${date}-producer`, date, `${batch.production} / ${batch.prep}`, '制片审核', '确认方向与关键制作决策', '制片人（叶总）', '未开始', 1, 0, '17:00', '叶总确认关键决策', base + 4),
      item(`${date}-review`, date, `${batch.production} / ${batch.prep}`, '红人审核', '在微信反馈当日视觉与成片意见', '红人（Yoyo）', '未开始', 1, 0, '20:30', 'Yoyo微信反馈，不要求登录系统', base + 5),
      item(`${date}-lipa`, date, `${batch.production} / ${batch.prep}`, '推进统筹', '汇总微信意见、更新进度并调整次日Rundown', '联合制片人／导演：Lipa', '未开始', 1, 0, '21:00', 'Lipa负责系统推进与勾选确认', base + 6),
    );
    return rows;
  }),
);

export const initialItems: ProductionItem[] = [
  ...special,
  ...rolling,
  item('1009-delivery', '2026-10-09', '全片', '成片', '全片总审、修正与最终交付', '联合制片人／导演：Lipa', '未开始', 10, 0, '20:00', '最终硬截止', 999),
];

function item(id: string, workDate: string, episode: string, category: string, title: string, owner: string, status: Status, plannedQty: number, completedQty: number, dueTime: string, note: string, sortOrder: number): ProductionItem {
  return { id, workDate, episode, category, title, owner, reviewer: 'Yoyo', status, plannedQty, completedQty, dueTime, note, sortOrder, updatedAt: now };
}

export const initialScenes: Scene[] = [
  scene('ep1-s1', 1, '怪物戏与六十秒预见', '南庭影视城·复古教堂片场', '主美', '进行中'),
  scene('ep1-s2', 2, '白鸽治愈与火警', '东方庭院外围候场区', '主美', '进行中'),
  scene('ep1-s3', 3, '火场救回陆文川', '东方庭院·临水巷道', '主美', '进行中'),
  scene('ep1-s4', 4, '监控录像流出', '影视城监控室', '主美', '未开始'),
  scene('ep1-s5', 5, '事件发酵与身份曝光', '网络舆情蒙太奇', '主美', '未开始'),
];

function scene(id: string, sceneNo: number, title: string, location: string, owner: string, visual: Status): Scene {
  return {
    id, episode: '第1集', sceneNo, title, location, owner,
    scriptStatus: '进行中', characterStatus: visual, locationStatus: visual, wardrobeStatus: visual,
    whiteModelStatus: '未开始', shotStatus: '未开始', roughCutStatus: '未开始', finalStatus: '未开始', updatedAt: now,
  };
}

export const initialBatches: PlanBatch[] = [
  { id: 'prep-ep1', startDate: '2026-09-09', endDate: '2026-09-11', production: '第1集开机筹备', prep: '场景 / 服装 / 配角 / 白模', note: '视觉通过一场，白模启动一场', sortOrder: 1, updatedAt: now },
  ...batches.map((batch, index) => ({ id: `batch-${index + 1}`, startDate: batch.start, endDate: batch.end, production: `${batch.production} 正式生产`, prep: batch.prep === '全片' ? '全片精剪与统一' : `${batch.prep} 筹备`, note: '审核与生成错开并行', sortOrder: index + 2, updatedAt: now })),
  { id: 'delivery', startDate: '2026-10-09', endDate: '2026-10-09', production: '全片总审与交付', prep: '机动修正', note: '最终硬截止，前序计划预留机动量', sortOrder: 99, updatedAt: now },
];
