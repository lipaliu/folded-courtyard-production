(() => {
  'use strict';
  const plan = window.RELEASE_MEETING_PLAN;
  const accountById = new Map(plan.accounts.map(a => [a.id, a]));
  const candidateCodes = new Set(['B4','B5','C2','C3','D3','D4','E2','E7','F1','F2','F3','F6','H4','H5','I1','I2','I3','J3','J4','J5','K1','K2','K4']);
  plan.rows.forEach(row => {
    row.disposition = row.code.startsWith('G') ? '暂缓' : candidateCodes.has(row.code) ? '候选' : '会议讨论';
    row.accountText = row.accounts.map(id => {
      const account = accountById.get(id);
      return account.title + '（' + account.status + '）';
    }).join('；');
    const item = window.MATERIAL_CATALOG.items.find(n => n.id === row.id);
    if (!item) return;
    item.meeting = row;
    item.rule = {...item.rule, stages:row.stages, account:row.accountText, note:row.when + '。' + row.gate, shoot:row.capture};
  });
  const roles = window.RELEASE_NODES.find(n => n.id === 'roles');
  if (roles) {
    roles.title = '会议中的账号分工与待核对入口';
    roles.body = '<h3>按具体内容，选择对应账号。</h3><p>真人大号择优争取，小号承接本人工作和反应；Yoyo 虚拟号持续做 IP 日常；方舟智创与方舟 AI 以作品和制作内容为主。正片承接号身份仍需核对。</p><p>真人直播切片池与 AI 剧二创池分开供料。电商矩阵有分歧，暂不默认全量铺发。</p><p><a href="#meeting-mapping">查看本次会议的账号逐项匹配 ↗</a></p>';
  }
})();
