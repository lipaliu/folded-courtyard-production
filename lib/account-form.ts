import { TEAM_ROLES } from './team-roles';
import { validateUsername, validatePassword } from './account-rules';

export function accountFormError(mode: 'login' | 'register', fields: { name: string; role: string; username: string; password: string }) {
  if (mode === 'register') {
    if (!fields.name.trim()) return '请填写姓名。';
    if (!(TEAM_ROLES as readonly string[]).includes(fields.role)) return '请选择岗位；新岗位请选择“服化道副导演”。';
    const username = fields.username.normalize('NFKC').trim();
    if (!validateUsername(username)) return '请输入登录名。';
    if (!validatePassword(fields.password)) return '请设置密码。';
  } else {
    if (!fields.username.trim()) return '请输入登录名。';
    if (!fields.password) return '请输入密码。';
  }
  return '';
}
