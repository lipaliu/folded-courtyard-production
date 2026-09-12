import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import vm from 'node:vm';
import { test } from 'node:test';
import ts from 'typescript';

function loadTs(path, dependencies = {}, globals = {}) {
  const code = ts.transpileModule(readFileSync(new URL(path, import.meta.url), 'utf8'), {
    compilerOptions: { module: ts.ModuleKind.CommonJS, target: ts.ScriptTarget.ES2022 },
  }).outputText;
  const exports = {};
  vm.runInNewContext(code, { exports, require: (name) => {
    if (!(name in dependencies)) throw new Error(`Unexpected import: ${name}`);
    return dependencies[name];
  }, Response, Request, File, FormData, crypto: globalThis.crypto, ...globals });
  return exports;
}

const roles = loadTs('../lib/team-roles.ts');
const accountRules = loadTs('../lib/account-rules.ts');
const workCalendar = loadTs('../lib/work-calendar.ts');
const lockedSchedule = loadTs('../lib/locked-schedule.ts');
const planData = loadTs('../lib/plan-data.ts', { '@/lib/work-calendar': workCalendar });
const uploadAttribution = loadTs('../lib/upload-attribution.ts');
const { accountFormError } = loadTs('../lib/account-form.ts', { './team-roles': roles, './account-rules': accountRules });
test('September 14 is production Day 1 and the following plan starts September 15', () => {
  assert.equal(workCalendar.PROJECT_START, '2026-09-14');
  assert.equal(workCalendar.productionDayNumber('2026-09-14'), 1);
  assert.equal(workCalendar.productionDayNumber('2026-09-15'), 2);
  assert.equal(workCalendar.isSixOnOneOffRestDay('2026-09-20'), true);
  assert.equal(workCalendar.nextProductionDay('2026-09-19'), '2026-09-21');
  assert.equal(lockedSchedule.LOCKED_SCHEDULE_START, '2026-09-14');
  assert.equal(lockedSchedule.LOCKED_SCHEDULE_END, '2026-09-14');
  assert.ok(planData.initialItems.every((item) => item.workDate >= '2026-09-14'));
  assert.equal(planData.initialBatches[0].id, 'kickoff-0914');
  assert.equal(planData.initialBatches[1].startDate, '2026-09-15');
});
test('kickoff tasks merge approval and assign both art upload roles', () => {
  const kickoff = planData.initialItems.filter((item) => item.workDate === '2026-09-14');
  assert.equal(kickoff.filter((item) => item.owner === '编剧').length, 2);
  assert.equal(kickoff.filter((item) => item.owner === '主美').length, 2);
  assert.equal(kickoff.filter((item) => item.owner === '服化道副导演').length, 2);
  assert.equal(kickoff.filter((item) => item.owner === '叶总／Yoyo').length, 2);
  assert.equal(kickoff.some((item) => ['制片人（叶总）', '红人（Yoyo）'].includes(item.owner)), false);
});
test('upload attribution uses account name and labels legacy images clearly', () => {
  assert.equal(uploadAttribution.uploadAuthorLabel('服化道小王'), '上传人：服化道小王');
  assert.equal(uploadAttribution.uploadAuthorLabel(''), '上传人：历史图·未记录');
});
test('registration API accepts one-character name, login and password', async () => {
  let writes = 0;
  const api = loadTs('../app/api/auth/register/route.ts', {
    'cloudflare:workers': { env: { DB: {
      prepare() { return { bind() { return this; }, async first() { return null; } }; },
      async batch() { writes++; },
    } } },
    '@/lib/auth': {
      ...accountRules, TEAM_ROLES: roles.TEAM_ROLES,
      normalizeUsername: (value) => value.normalize('NFKC').trim().toLowerCase(),
      hashPassword: async (password) => { assert.equal(password, '1'); return { hash: 'hash', salt: 'salt', iterations: 100000 }; },
      createSession: async () => 'session=test',
    },
  });
  const response = await api.POST(new Request('https://test/api/auth/register', {
    method: 'POST', headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ name: '张', username: 'x', password: '1', role: '服化道副导演' }),
  }));
  assert.equal(response.status, 201);
  assert.equal(writes, 1);
  assert.equal((await response.json()).user.isAdmin, false);
});
test('registration explains missing fields and accepts the new role', () => {
  const fields = { name: '测试', role: '服化道副导演', username: 'new_artist', password: '12345678' };
  assert.equal(accountFormError('register', fields), '');
  for (const [key, value, message] of [
    ['name', '', /姓名/], ['role', '', /岗位/], ['username', '', /登录名/], ['password', '', /密码/],
  ]) assert.match(accountFormError('register', { ...fields, [key]: value }), message);
  assert.equal(accountFormError('login', { ...fields, name: '', role: '' }), '');
  assert.match(accountFormError('login', { ...fields, username: '' }), /登录名/);
  assert.equal(accountFormError('register', { ...fields, name: '张', username: '张', password: '1' }), '');
  assert.equal(accountFormError('register', { ...fields, username: 'my name', password: '1234' }), '');
  assert.ok(accountRules.validatePassword('1'));
  assert.ok(accountRules.validateUsername('张'));
});
test('every member role can read final scripts; anonymous requests cannot', async () => {
  for (const role of [...roles.TEAM_ROLES, null]) {
    let queried = false;
    const api = loadTs('../app/api/final-scripts/route.ts', {
      'cloudflare:workers': { env: { DB: { prepare(sql) {
        queried = true;
        assert.match(sql, /WHERE is_final = 1/);
        return { async all() { return { results: [{ id: 'final', episode: '第1集', sourceText: '完整正文' }] }; } };
      } } } },
      '@/lib/auth': { requireMember: async () => role ? { role, isAdmin: false } : null },
    });
    const response = await api.GET(new Request('https://test/api/final-scripts'));
    assert.equal(response.status, role ? 200 : 401);
    assert.equal(queried, Boolean(role));
    if (role) {
      assert.equal(response.headers.get('cache-control'), 'private, no-store');
      assert.equal((await response.json()).scripts[0].sourceText, '完整正文');
    }
  }
});
test('registration includes new role; art access preserves main artist rights', () => {
  assert.ok(roles.TEAM_ROLES.includes('服化道副导演'));
  assert.ok(roles.roleCanSeeArt('服化道副导演'));
  assert.equal(roles.roleCanSeeArt('编剧'), false);
  for (const category of ['人物', '服装', '道具', '场景']) {
    assert.equal(roles.canEditArtCategory({ role: '服化道副导演', isAdmin: false }, category), ['场景', '服装'].includes(category));
    for (const role of ['主美', '美术']) assert.ok(roles.canEditArtCategory({ role, isAdmin: false }, category));
    assert.ok(roles.canEditArtCategory({ role: '执行制片人', isAdmin: true }, category));
    assert.equal(roles.canEditArtCategory({ role: '编剧', isAdmin: false }, category), false);
  }
});

function apiFor(role, category) {
  const writes = [];
  const db = {
    prepare(sql) {
      return { bind() { return this; }, async first() {
        if (sql.includes('FROM script_analysis_items')) return { id: 'asset-1', category, episode: '第1集', sceneNo: 1 };
        if (sql.includes('FROM art_submission_files f')) return { id: 'image-1', itemId: 'asset-1', objectKey: 'd1:image-1', category };
        return null;
      }, async run() { writes.push(sql); return { success: true }; } };
    },
    async batch(statements) { writes.push(...statements); return []; },
  };
  const api = loadTs('../app/api/art-submissions/route.ts', {
    'cloudflare:workers': { env: { DB: db } },
    '@/lib/auth': { requireMember: async () => ({ role, isAdmin: false, name: 'test' }) },
    '@/lib/team-roles': roles,
  });
  return { api, writes };
}

for (const category of ['人物', '服装', '道具', '场景']) {
  test(`upload authorization enforced by stored category: ${category}`, async () => {
    const { api, writes } = apiFor('服化道副导演', category);
    const form = new FormData();
    form.append('itemId', 'asset-1');
    form.append('file', new File(['test'], 'ref.png', { type: 'image/png' }));
    const response = await api.POST(new Request('https://test/api/art-submissions', { method: 'POST', body: form }));
    const allowed = ['服装', '场景'].includes(category);
    assert.equal(response.status, allowed ? 200 : 403);
    assert.equal(writes.length > 0, allowed);
    if (allowed) assert.equal((await response.json()).file.uploadedBy, 'test');
  });
}

for (const method of ['PATCH', 'DELETE']) {
  test(`${method} cannot bypass category restriction`, async () => {
    const { api, writes } = apiFor('服化道副导演', '人物');
    const response = await api[method](new Request('https://test/api/art-submissions', {
      method, headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ itemId: 'asset-1', fileId: 'image-1' }),
    }));
    assert.equal(response.status, 403);
    assert.equal(writes.length, 0);
  });
}
