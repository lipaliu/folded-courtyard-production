export const PROJECT_START = '2026-09-10';
export const PROJECT_END = '2026-10-24';
export const NATIONAL_DAY_START = '2026-10-01';
export const NATIONAL_DAY_END = '2026-10-07';

function addDays(value: string, amount: number) {
  const date = new Date(`${value}T00:00:00Z`);
  date.setUTCDate(date.getUTCDate() + amount);
  return date.toISOString().slice(0, 10);
}

export function isNationalDayHoliday(value: string) {
  return value >= NATIONAL_DAY_START && value <= NATIONAL_DAY_END;
}

export function isSixOnOneOffRestDay(value: string) {
  if (value < PROJECT_START || isNationalDayHoliday(value)) return false;
  let cursor = PROJECT_START;
  let consecutiveWorkDays = 0;
  while (cursor <= value) {
    if (!isNationalDayHoliday(cursor)) {
      if (consecutiveWorkDays === 6) {
        if (cursor === value) return true;
        consecutiveWorkDays = 0;
      } else {
        if (cursor === value) return false;
        consecutiveWorkDays += 1;
      }
    }
    cursor = addDays(cursor, 1);
  }
  return false;
}

export function isProductionDay(value: string) {
  return value >= PROJECT_START && !isNationalDayHoliday(value) && !isSixOnOneOffRestDay(value);
}

export function nextProductionDay(value: string) {
  let candidate = addDays(value, 1);
  while (!isProductionDay(candidate)) candidate = addDays(candidate, 1);
  return candidate;
}

export function productionDayNumber(value: string) {
  if (value < PROJECT_START) return 0;
  let cursor = PROJECT_START;
  let count = 0;
  while (cursor <= value) {
    if (isProductionDay(cursor)) count += 1;
    cursor = addDays(cursor, 1);
  }
  return count;
}

export function dayType(value: string): '工作日' | '六休一' | '国庆放假' {
  if (isNationalDayHoliday(value)) return '国庆放假';
  if (isSixOnOneOffRestDay(value)) return '六休一';
  return '工作日';
}
