import { env } from 'cloudflare:workers';

import { TEAM_ROLES } from './team-roles';
export { TEAM_ROLES } from './team-roles';
export { validateUsername, validatePassword } from './account-rules';
export type TeamRole = (typeof TEAM_ROLES)[number];
export type SiteUser = { id: string; username: string; name: string; role: string; isAdmin: boolean };

const SESSION_COOKIE = 'folded_courtyard_session';
const SESSION_DAYS = 14;
export const PASSWORD_ITERATIONS = 100000;

export type AccountRow = {
  id: string;
  username: string;
  passwordHash: string;
  passwordSalt: string;
  passwordIterations: number;
  name: string;
  role: string;
  isAdmin: number;
  active: number;
  failedAttempts: number;
  lockedUntil: string;
};

function bytesToBase64(bytes: Uint8Array) {
  let binary = '';
  for (const byte of bytes) binary += String.fromCharCode(byte);
  return btoa(binary);
}

function base64ToBytes(value: string) {
  const binary = atob(value);
  return Uint8Array.from(binary, (char) => char.charCodeAt(0));
}

async function sha256(value: string) {
  const digest = await crypto.subtle.digest('SHA-256', new TextEncoder().encode(value));
  return Array.from(new Uint8Array(digest), (byte) => byte.toString(16).padStart(2, '0')).join('');
}

export function normalizeUsername(value: string) {
  return value.normalize('NFKC').trim().toLocaleLowerCase('en-US');
}

export async function hashPassword(password: string, salt?: string, iterations = PASSWORD_ITERATIONS) {
  const saltBytes = salt ? base64ToBytes(salt) : crypto.getRandomValues(new Uint8Array(16));
  const key = await crypto.subtle.importKey('raw', new TextEncoder().encode(password), 'PBKDF2', false, ['deriveBits']);
  const bits = await crypto.subtle.deriveBits({ name: 'PBKDF2', hash: 'SHA-256', salt: saltBytes, iterations }, key, 256);
  return { hash: bytesToBase64(new Uint8Array(bits)), salt: bytesToBase64(saltBytes), iterations };
}

export async function verifyPassword(password: string, account: AccountRow) {
  const candidate = await hashPassword(password, account.passwordSalt, account.passwordIterations);
  const expected = base64ToBytes(account.passwordHash);
  const actual = base64ToBytes(candidate.hash);
  if (expected.length !== actual.length) return false;
  let different = 0;
  for (let index = 0; index < expected.length; index += 1) different |= expected[index] ^ actual[index];
  return different === 0;
}

function parseCookies(request: Request) {
  const result = new Map<string, string>();
  for (const part of (request.headers.get('cookie') || '').split(';')) {
    const separator = part.indexOf('=');
    if (separator < 0) continue;
    result.set(part.slice(0, separator).trim(), decodeURIComponent(part.slice(separator + 1).trim()));
  }
  return result;
}

export function clearSessionCookie() {
  return `${SESSION_COOKIE}=; Path=/; HttpOnly; Secure; SameSite=Lax; Max-Age=0`;
}

export async function createSession(accountId: string) {
  const token = bytesToBase64(crypto.getRandomValues(new Uint8Array(32))).replaceAll('+', '-').replaceAll('/', '_').replaceAll('=', '');
  const tokenHash = await sha256(token);
  const now = new Date();
  const expiresAt = new Date(now.getTime() + SESSION_DAYS * 86400000);
  await env.DB.batch([
    env.DB.prepare('DELETE FROM member_sessions WHERE expires_at <= ?').bind(now.toISOString()),
    env.DB.prepare(`INSERT INTO member_sessions (id, account_id, token_hash, expires_at, created_at, last_seen_at)
      VALUES (?, ?, ?, ?, ?, ?)`).bind(crypto.randomUUID(), accountId, tokenHash, expiresAt.toISOString(), now.toISOString(), now.toISOString()),
  ]);
  return `${SESSION_COOKIE}=${encodeURIComponent(token)}; Path=/; HttpOnly; Secure; SameSite=Lax; Max-Age=${SESSION_DAYS * 86400}`;
}

export async function deleteSession(request: Request) {
  const token = parseCookies(request).get(SESSION_COOKIE);
  if (token) await env.DB.prepare('DELETE FROM member_sessions WHERE token_hash = ?').bind(await sha256(token)).run();
}

export async function getAccountByUsername(username: string) {
  return env.DB.prepare(`SELECT id, username, password_hash AS passwordHash, password_salt AS passwordSalt,
    password_iterations AS passwordIterations, name, role, is_admin AS isAdmin, active,
    failed_attempts AS failedAttempts, locked_until AS lockedUntil
    FROM member_accounts WHERE username = ?`).bind(normalizeUsername(username)).first<AccountRow>();
}

export async function getSiteUser(request: Request): Promise<SiteUser | null> {
  const token = parseCookies(request).get(SESSION_COOKIE);
  if (!token) return null;
  const tokenHash = await sha256(token);
  const now = new Date().toISOString();
  const row = await env.DB.prepare(`SELECT a.id, a.username, a.name, a.role, a.is_admin AS isAdmin
    FROM member_sessions s JOIN member_accounts a ON a.id = s.account_id
    WHERE s.token_hash = ? AND s.expires_at > ? AND a.active = 1`).bind(tokenHash, now).first<{ id: string; username: string; name: string; role: string; isAdmin: number }>();
  if (!row || (!row.isAdmin && !TEAM_ROLES.includes(row.role as TeamRole))) return null;
  void env.DB.prepare('UPDATE member_sessions SET last_seen_at = ? WHERE token_hash = ?').bind(now, tokenHash).run();
  return { ...row, isAdmin: Boolean(row.isAdmin) };
}

export async function requireMember(request: Request) { return getSiteUser(request); }

export async function requireScriptUploader(request: Request) {
  const user = await getSiteUser(request);
  return user && (user.isAdmin || user.role === '编剧') ? user : null;
}

export async function requireAdmin(request: Request) {
  const user = await getSiteUser(request);
  return user?.isAdmin ? user : null;
}
