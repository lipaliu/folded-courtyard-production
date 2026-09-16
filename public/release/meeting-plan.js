(() => {
  'use strict';
  const plan = window.RELEASE_MEETING_PLAN;
  const rows = [...plan.rows].sort((a,b) => a.code.localeCompare(b.code, 'en', {numeric:true}));
  const byCode = new Map(rows.map(row => [row.code,row]));
  const el = (tag, className, text) => {
    const node = document.createElement(tag);
    if (className) node.className = className;
    if (text !== undefined) node.textContent = text;
    return node;
  };
  const link = row => {
    const a = el('a','mapping-material-link',row.code + ' · ' + row.title);
    a.href = '#' + row.id;
    return a;
  };
  const field = (label,value) => {
    const d = el('div','meeting-field');
    d.append(el('dt','',label),el('dd','',value));
    return d;
  };
  // Keep meeting evidence inside the existing floating material reader.
  rows.forEach(row => {
    const detail = document.getElementById(row.id);
    if (!detail) return;
    const body = detail.querySelector('.leaf-body');
    const notice = el('section','meeting-decision');
    notice.append(el('p','meeting-kicker','本次宣发会议 · ' + row.code),el('h3','',row.status));
    const fields = el('dl','meeting-fields');
    fields.append(field('发什么',row.content),field('先准备',row.capture),field('还缺什么',row.gate));
    notice.append(fields,el('p','meeting-source','转写定位：' + row.source));
    body.prepend(notice);
    const chain = body.querySelectorAll('.execution-chain > .chain-step');
    chain[0].querySelector('p').textContent = row.capture;
    chain[1].querySelector('.assignment').textContent = '数量 / 规格：' + row.quantity + ' · 负责人：' + row.owner;
    chain[2].querySelector('.match-reason').textContent = row.when;
    chain[3].querySelector('.assignment').textContent = '以上为内容适配方向，非全部必发；账号链接、最终选号和发布顺序待核对。';
    detail.querySelector('.material-tier').textContent = row.disposition === '暂缓' ? '会议暂缓' : row.disposition === '候选' ? '候选 · 未逐项确定' : '已匹配会议';
    const overviewLink = document.querySelector('.overview-types a[href="#' + row.id + '"]');
    if (overviewLink) overviewLink.title = row.status + '｜' + row.when;
  });

  const section = el('section','meeting-mapping');
  section.id = 'meeting-mapping';
  section.setAttribute('aria-labelledby','meeting-mapping-title');
  const heading = el('header','mapping-heading');
  const h = el('h2','','这次会议，落实到每一条。');
  h.id = 'meeting-mapping-title';
  heading.append(el('p','eyebrow','宣发策略会议 · 逐项匹配'),h,
    el('p','mapping-intro','46 分 41 秒 · 337 段原话已核对。现有 55 个物料方向逐项对应；未点选、暂缓和有分歧的内容保留原状态。点击物料编号，在当前页上方查看完整安排。'));
  const anchors = el('div','mapping-facts');
  anchors.append(el('p','','9.18 · 虚拟号启动'),el('p','','首播 T 日 · 待定'),el('p','','10.10 · 仅为会议举例'));
  section.append(heading,anchors);
  const tabs = el('div','mapping-tabs');
  tabs.setAttribute('role','tablist');
  tabs.setAttribute('aria-label','会议匹配查看方式');
  const panel = el('div','mapping-panel');
  panel.id = 'mapping-panel';
  panel.setAttribute('role','tabpanel');
  const modes = [['material','按物料'],['period','按发行周期'],['account','按账号'],['pending','待确认事项']];
  let mode = 'material';
  const selected = {material:'A',period:'ongoing',account:'virtual_yoyo'};
  const buttons = modes.map(([id,label]) => {
    const b = el('button','',label);
    b.type = 'button'; b.id = 'mapping-tab-' + id;
    b.setAttribute('role','tab'); b.setAttribute('aria-controls',panel.id);
    b.addEventListener('click',() => { mode=id; render(); });
    tabs.append(b); return b;
  });
  tabs.addEventListener('keydown',e => {
    const i = buttons.indexOf(document.activeElement);
    if (i < 0 || !['ArrowLeft','ArrowRight','Home','End'].includes(e.key)) return;
    e.preventDefault();
    const next = e.key==='Home'?0:e.key==='End'?buttons.length-1:(i+(e.key==='ArrowRight'?1:-1)+buttons.length)%buttons.length;
    buttons[next].click(); buttons[next].focus();
  });
  function materialList(list, accountView=false) {
    const listNode = el('div','mapping-materials');
    list.forEach(row => {
      const article = el('article','mapping-material');
      article.append(link(row),el('span','mapping-state',row.status),el('p','',row.content));
      const dl = el('dl','mapping-row-fields');
      dl.append(field('时间',row.when));
      if (!accountView) dl.append(field('账号',row.accountText));
      dl.append(field('条件',row.gate));
      article.append(dl,el('p','meeting-source','转写：'+row.source));
      listNode.append(article);
    });
    return listNode;
  }
  function render() {
    buttons.forEach((b,i) => {const active=modes[i][0]===mode;b.setAttribute('aria-selected',String(active));b.tabIndex=active?0:-1;});
    panel.setAttribute('aria-labelledby','mapping-tab-'+mode);
    panel.replaceChildren();
    if (mode==='pending') {
      panel.append(el('h3','','这些信息补齐后，才能锁定排期。'));
      const list = el('ol','mapping-pending');
      plan.openItems.forEach(text => list.append(el('li','',text)));
      panel.append(list); return;
    }
    const options = mode==='material' ? window.MATERIAL_CATALOG.families.map(f=>({id:f.code,title:f.code+' · '+f.title})) : mode==='period'?plan.periods:plan.accounts;
    const label = el('label','mapping-select-label',mode==='material'?'选择内容线':mode==='period'?'选择发行阶段':'选择账号或合作池');
    const select = el('select','mapping-select');
    options.forEach(option => {const o=el('option','',option.title);o.value=option.id;select.append(o);});
    select.value=selected[mode]; label.append(select); panel.append(label);
    const content = el('div','mapping-selection');
    panel.append(content);
    function choose() {
      selected[mode]=select.value; content.replaceChildren();
      const option=options.find(o=>o.id===select.value);
      if(mode==='material') {
        content.append(materialList(rows.filter(row=>row.code.startsWith(option.id))));
      } else if(mode==='period') {
        content.append(el('h3','',option.title),el('p','mapping-state',option.status),el('p','mapping-description',option.note));
        content.append(materialList(option.codes.map(code=>byCode.get(code))));
        if (!option.codes.length) content.append(el('p','mapping-note','这些是制作与账号准备工作，不另算一类对外物料。'));
      } else {
        content.append(el('h3','',option.title),el('p','mapping-state',option.status),el('p','mapping-description',option.content));
        content.append(el('p','mapping-note','入口 / 条件：'+option.gate),el('p','meeting-source','账号口径定位：'+option.source));
        content.append(el('p','mapping-note','下列为适配内容，含候选及暂缓项；不表示此账号已确定全发。'));
        content.append(materialList(rows.filter(row=>row.accounts.includes(option.id)),true));
      }
    }
    select.addEventListener('change',choose); choose();
  }
  section.append(tabs,panel);
  document.getElementById('overview').after(section);
  const quickLink = el('a','mapping-jump','查看会议匹配：物料 · 周期 · 账号 ↗');
  quickLink.href = '#meeting-mapping';
  document.querySelector('.overview-heading').append(quickLink);
  const sidebarLink = el('a','','本次会议匹配 ↗');
  sidebarLink.href='#meeting-mapping';document.querySelector('.index-note').append(sidebarLink);
  render();
})();
