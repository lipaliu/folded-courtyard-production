(() => {
  'use strict';
  const button = document.getElementById('fullscreen-toggle');
  const status = document.getElementById('fullscreen-status');
  const root = document.documentElement;
  const current = () => document.fullscreenElement || document.webkitFullscreenElement;
  let timer;
  function sync() {
    const active = Boolean(current());
    button.textContent = active ? '退出全屏 ⛶' : '全屏 ⛶';
    button.setAttribute('aria-pressed', String(active));
    button.title = active ? '退出全屏（也可按 Esc）' : '全屏展示网站';
  }
  function notice(message) {
    status.textContent = message;
    status.hidden = false;
    clearTimeout(timer);
    timer = setTimeout(() => { status.hidden = true; }, 6000);
  }
  button.addEventListener('click', async () => {
    status.hidden = true;
    try {
      if (current()) {
        const exit = document.exitFullscreen || document.webkitExitFullscreen;
        if (exit) await exit.call(document);
      } else {
        const enter = root.requestFullscreen || root.webkitRequestFullscreen;
        if (!enter) {
          notice('当前浏览器不支持网页全屏，可在 Chrome 或 Safari 中打开此网址。');
          return;
        }
        await enter.call(root);
      }
      sync();
    } catch {
      notice('当前窗口未允许全屏，请在独立浏览器中打开后重试。');
      sync();
    }
  });
  document.addEventListener('fullscreenchange', sync);
  document.addEventListener('webkitfullscreenchange', sync);
  sync();
})();
