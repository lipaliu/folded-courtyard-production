export const TEAM_ROLES = ['编剧', '导演', '制片人', '执行制片人', '主美', '美术', '服化道副导演', 'AIGC抽卡师', '剪辑'] as const;

export function roleCanSeeArt(role: string) {
  return ['主美', '美术', '服化道副导演'].includes(role);
}

export function canEditArtCategory(user: { role: string; isAdmin: boolean }, category: string) {
  return user.isAdmin || ['主美', '美术'].includes(user.role)
    || (user.role === '服化道副导演' && ['场景', '服装'].includes(category));
}
