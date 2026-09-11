'use client';

import { useCallback, useEffect, useState } from 'react';
import Link from 'next/link';
import { Archive, Check, ExternalLink, FileText, Loader2, LogOut, RefreshCw, Upload } from 'lucide-react';
import { Button } from '@/components/ui/button';

type CurrentUser = { id: string; username: string; name: string; role: string; isAdmin: boolean };
type ScriptVersion = {
  id: string;
  episode: string;
  versionNo: number;
  fileName: string;
  sourceText: string;
  changeSummary: string;
  workDate: string;
  submittedBy: string;
  sceneCount: number;
  itemCount: number;
  createdAt: string;
};

export function ScriptPitchStudio() {
  const [me, setMe] = useState<CurrentUser | null>(null);
  const [checking, setChecking] = useState(true);
  const [versions, setVersions] = useState<ScriptVersion[]>([]);
  const [loadingVersions, setLoadingVersions] = useState(false);
  const [file, setFile] = useState<File | null>(null);
  const [changeSummary, setChangeSummary] = useState('');
  const [workDate, setWorkDate] = useState(() => new Date().toISOString().slice(0, 10));
  const [saving, setSaving] = useState(false);
  const [notice, setNotice] = useState('');
  const [error, setError] = useState('');

  const loadVersions = useCallback(async () => {
    setLoadingVersions(true);
    try {
      const response = await fetch('/api/script-analysis', { cache: 'no-store' });
      const data = await response.json() as { versions?: ScriptVersion[]; error?: string };
      if (!response.ok) throw new Error(data.error || '读取剧本版本失败');
      setVersions(data.versions || []);
    } catch (nextError) {
      setError(nextError instanceof Error ? nextError.message : '读取剧本版本失败');
    } finally {
      setLoadingVersions(false);
    }
  }, []);

  const loadIdentity = useCallback(async () => {
    setChecking(true);
    try {
      const response = await fetch('/api/me', { cache: 'no-store' });
      const data = await response.json() as { user?: CurrentUser };
      const user = response.ok ? data.user || null : null;
      setMe(user);
      if (user) await loadVersions();
    } finally {
      setChecking(false);
    }
  }, [loadVersions]);

  useEffect(() => { void loadIdentity(); }, [loadIdentity]);

  async function uploadScript() {
    if (!file || !changeSummary.trim()) return;
    setSaving(true); setError(''); setNotice('');
    try {
      const extension = file.name.toLowerCase().split('.').pop();
      if (!['txt', 'docx'].includes(extension || '')) throw new Error('请上传 DOCX 或 TXT 文件');
      let sourceText = '';
      if (extension === 'txt') sourceText = await file.text();
      else {
        const mammoth = await import('mammoth');
        sourceText = (await mammoth.extractRawText({ arrayBuffer: await file.arrayBuffer() })).value;
      }
      if (!sourceText.trim()) throw new Error('文件中没有读取到剧本文字');
      const response = await fetch('/api/script-analysis', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ action: 'importScript', workDate, fileName: file.name, text: sourceText, changeSummary: changeSummary.trim() }),
      });
      const data = await response.json() as { versions?: Array<{ episode: string; versionNo: number }>; sceneCount?: number; error?: string };
      if (!response.ok) throw new Error(data.error || '剧本上传失败');
      const versionText = (data.versions || []).map((item) => `${item.episode} v${item.versionNo}`).join('、') || '新版本';
      setNotice(`${versionText} 已保存，共识别 ${data.sceneCount || 0} 场；公开提报页已同步。`);
      setFile(null); setChangeSummary('');
      await loadVersions();
    } catch (nextError) {
      setError(nextError instanceof Error ? nextError.message : '剧本上传失败');
    } finally {
      setSaving(false);
    }
  }

  async function logout() {
    await fetch('/api/auth/logout', { method: 'POST' });
    setMe(null); setVersions([]);
  }

  if (checking) return <main className="grid min-h-screen place-items-center"><div className="control-card flex items-center gap-3 px-5 py-4 text-sm text-muted-foreground"><Loader2 className="h-4 w-4 animate-spin text-[#ff6240]" />正在确认剧本提报账号…</div></main>;
  if (!me) return <PitchLogin onAuthenticated={loadIdentity} />;

  const canUpload = me.isAdmin || me.role === '编剧';
  return <main className="min-h-screen px-4 pb-16 md:px-8">
    <header className="sticky top-0 z-30 -mx-4 border-b border-white/8 bg-background/90 px-4 py-3 backdrop-blur-xl md:-mx-8 md:px-8">
      <div className="mx-auto flex max-w-5xl items-center justify-between gap-3">
        <div><p className="eyebrow">SCREENPLAY SUBMISSION</p><h1 className="mt-1 text-lg font-semibold">折叠庭院的她 · 剧本提报</h1></div>
        <div className="flex items-center gap-2"><span className="hidden text-xs text-muted-foreground sm:inline">{me.username} · {me.role}</span><button onClick={() => void logout()} className="grid h-9 w-9 place-items-center rounded-full border border-white/10 bg-white/5" aria-label="退出登录"><LogOut className="h-4 w-4" /></button></div>
      </div>
    </header>

    <div className="mx-auto max-w-5xl pt-6">
      <nav className="mb-6 flex flex-wrap gap-2" aria-label="系统切换">
        <span className="rounded-full bg-[#ff6240] px-4 py-2 text-sm font-medium text-black">剧本提报系统</span>
        <Link href="/studio" className="rounded-full border border-white/10 bg-white/5 px-4 py-2 text-sm text-muted-foreground hover:text-white">项目管理 SOP</Link>
        <Link href="/pitch" className="ml-auto inline-flex items-center gap-1.5 rounded-full border border-white/10 px-4 py-2 text-sm text-muted-foreground hover:text-white">查看公开提报 <ExternalLink className="h-3.5 w-3.5" /></Link>
      </nav>

      <section className="mb-6"><p className="text-sm text-muted-foreground">这里仅处理单集剧本上传与版本归档，不进入总制片推进台。</p></section>

      <div className="grid gap-5 lg:grid-cols-[1.05fr_.95fr]">
        <section className="control-card p-5 md:p-6">
          <div className="flex items-start justify-between gap-4"><div><p className="text-sm font-medium">上传新一集／新版本</p><p className="mt-1 text-sm leading-6 text-muted-foreground">同一集重复上传会自动增加版本号，旧稿不会被覆盖。</p></div><FileText className="h-5 w-5 text-[#ff8066]" /></div>
          <div className="mt-5 grid gap-4 sm:grid-cols-[160px_1fr]">
            <Field label="提报日期"><input type="date" value={workDate} disabled={!canUpload} onChange={(event) => setWorkDate(event.target.value)} className="edit-input" /></Field>
            <Field label="本次更新说明"><input value={changeSummary} disabled={!canUpload} onChange={(event) => setChangeSummary(event.target.value)} className="edit-input" placeholder="例如：调整第3场冲突和集尾钩子" /></Field>
          </div>
          <label className={`mt-4 flex min-h-36 items-center justify-center rounded-2xl border-2 border-dashed px-5 text-center ${canUpload ? 'cursor-pointer border-white/15 bg-black/10 hover:border-[#ff6240]/60' : 'border-white/8 opacity-55'}`}>
            <input type="file" accept=".docx,.txt,text/plain,application/vnd.openxmlformats-officedocument.wordprocessingml.document" disabled={!canUpload || saving} className="sr-only" onChange={(event) => { setFile(event.target.files?.[0] || null); event.target.value = ''; }} />
            <div><span className="mx-auto grid h-11 w-11 place-items-center rounded-full bg-[#ff6240]/15 text-[#ff8066]"><Upload className="h-5 w-5" /></span><p className="mt-3 text-sm font-medium">{file?.name || '选择 DOCX / TXT 单集剧本'}</p><p className="mt-1 text-xs text-muted-foreground">{canUpload ? '上传后自动拆场，并同步到公开提报页' : '当前身份可审阅版本，但不能上传剧本'}</p></div>
          </label>
          <Button className="mt-4 h-11 w-full" disabled={!canUpload || !file || !changeSummary.trim() || saving} onClick={() => void uploadScript()}>{saving ? <Loader2 className="animate-spin" /> : <Check />}{saving ? '正在保存版本…' : '上传并保存新版本'}</Button>
          {notice && <p className="mt-4 rounded-xl border border-emerald-400/20 bg-emerald-400/[.06] px-4 py-3 text-sm text-emerald-300">{notice}</p>}
          {error && <p className="mt-4 rounded-xl border border-red-400/20 bg-red-400/[.06] px-4 py-3 text-sm text-red-300">{error}</p>}
        </section>

        <section className="control-card p-5 md:p-6">
          <div className="flex items-start justify-between gap-4"><div><p className="text-sm font-medium">剧本版本档案</p><p className="mt-1 text-sm text-muted-foreground">{versions.length} 个已保存版本</p></div><button onClick={() => void loadVersions()} className="grid h-9 w-9 place-items-center rounded-full border border-white/10 bg-white/5" aria-label="刷新版本"><RefreshCw className={`h-4 w-4 ${loadingVersions ? 'animate-spin' : ''}`} /></button></div>
          <div className="mt-5 max-h-[620px] space-y-3 overflow-auto pr-1">
            {versions.length ? versions.map((version) => <details key={version.id} className="rounded-xl border border-white/8 bg-white/[.025] px-4 py-3"><summary className="cursor-pointer list-none"><div className="flex items-start justify-between gap-3"><div><p className="font-medium">{version.episode} · v{version.versionNo}</p><p className="mt-1 text-xs leading-5 text-muted-foreground">{formatDateTime(version.createdAt)} · {version.submittedBy} · {version.sceneCount}场</p></div><Archive className="mt-0.5 h-4 w-4 shrink-0 text-cyan-300" /></div></summary><div className="mt-3 border-t border-white/8 pt-3"><p className="text-sm leading-6 text-[#ff9a86]">{version.changeSummary || '未填写更新说明'}</p><p className="mt-2 text-xs text-muted-foreground">源文件：{version.fileName || '手工录入'}</p><p className="mt-3 max-h-56 overflow-auto whitespace-pre-wrap rounded-lg bg-black/15 p-3 text-sm leading-6 text-muted-foreground">{version.sourceText}</p></div></details>) : <div className="rounded-xl border border-dashed border-white/10 px-5 py-12 text-center text-sm text-muted-foreground">还没有剧本版本</div>}
          </div>
        </section>
      </div>
    </div>
  </main>;
}

function PitchLogin({ onAuthenticated }: { onAuthenticated: () => Promise<void> }) {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState('');
  const ready = username.trim().length >= 3 && password.length >= 8;
  async function submit() {
    setSaving(true); setError('');
    try {
      const response = await fetch('/api/auth/login', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ username, password }) });
      const data = await response.json() as { error?: string };
      if (!response.ok) throw new Error(data.error || '登录失败');
      await onAuthenticated();
    } catch (nextError) {
      setError(nextError instanceof Error ? nextError.message : '登录失败');
    } finally {
      setSaving(false);
    }
  }
  return <main className="grid min-h-screen place-items-center px-5 py-10"><section className="control-card w-full max-w-md p-6 md:p-8"><p className="eyebrow">SCREENPLAY ACCESS</p><h1 className="mt-2 text-3xl font-semibold tracking-tight">剧本提报系统</h1><p className="mt-2 text-sm leading-6 text-muted-foreground">使用与项目管理 SOP 完全相同的登录名和密码。</p><div className="mt-6 space-y-4"><Field label="登录名"><input autoCapitalize="none" autoComplete="username" value={username} onChange={(event) => setUsername(event.target.value)} className="edit-input" placeholder="请输入项目登录名" /></Field><Field label="密码"><input type="password" autoComplete="current-password" value={password} onChange={(event) => setPassword(event.target.value)} onKeyDown={(event) => { if (event.key === 'Enter' && ready) void submit(); }} className="edit-input" placeholder="请输入密码" /></Field></div>{error && <p className="mt-4 rounded-xl border border-red-400/20 bg-red-400/[.06] px-3 py-2 text-sm text-red-300">{error}</p>}<Button className="mt-6 h-12 w-full" disabled={saving || !ready} onClick={() => void submit()}>{saving ? <Loader2 className="animate-spin" /> : <Check />}{saving ? '正在登录…' : '登录剧本提报系统'}</Button><div className="mt-4 flex justify-between text-xs text-muted-foreground"><Link href="/pitch" className="hover:text-white">← 返回公开提报</Link><Link href="/studio" className="hover:text-white">项目管理 SOP →</Link></div></section></main>;
}

function Field({ label, children }: { label: string; children: React.ReactNode }) { return <label className="block"><span className="mb-1.5 block text-xs text-muted-foreground">{label}</span>{children}</label>; }
function formatDateTime(value: string) { return value ? new Intl.DateTimeFormat('zh-CN', { month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit' }).format(new Date(value)) : '—'; }
