export const LOCKED_SCHEDULE_START = '2026-09-12';
export const LOCKED_SCHEDULE_END = '2026-09-14';

export const LOCKED_SCHEDULE_TASK_IDS = [
  'rollup-2026-09-12-ep1-art',
  'priority-0912-ep2-script',
  'priority-0913-art-rest',
  'priority-0913-ep1-confirm',
  'priority-0913-ep2-script',
  'priority-0914-ep1-revise',
  'priority-0914-ep1-board',
  'priority-0914-ep2-final',
] as const;

const lockedTaskIds = new Set<string>(LOCKED_SCHEDULE_TASK_IDS);

export function isLockedScheduleDate(date: string) {
  return date >= LOCKED_SCHEDULE_START && date <= LOCKED_SCHEDULE_END;
}

export function isLockedScheduleTask(id: string) {
  return lockedTaskIds.has(id);
}
