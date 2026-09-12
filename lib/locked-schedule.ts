export const LOCKED_SCHEDULE_START = '2026-09-14';
export const LOCKED_SCHEDULE_END = '2026-09-14';

export const LOCKED_SCHEDULE_TASK_IDS = [
  'rollup-2026-09-14-ep1-script',
  'rollup-2026-09-14-ep1-art',
  'rollup-2026-09-14-ep1-wardrobe',
  'rollup-2026-09-14-ep1-send',
  'rollup-2026-09-14-ep1-review',
  'rollup-2026-09-14-ep2-script',
  'rollup-2026-09-14-ep2-art',
  'rollup-2026-09-14-ep2-wardrobe',
  'rollup-2026-09-14-ep2-send',
  'rollup-2026-09-14-ep2-review',
] as const;

const lockedTaskIds = new Set<string>(LOCKED_SCHEDULE_TASK_IDS);

export function isLockedScheduleDate(date: string) {
  return date >= LOCKED_SCHEDULE_START && date <= LOCKED_SCHEDULE_END;
}

export function isLockedScheduleTask(id: string) {
  return lockedTaskIds.has(id);
}
