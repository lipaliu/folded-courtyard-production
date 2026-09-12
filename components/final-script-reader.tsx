'use client';

import { useEffect, useState } from 'react';
import { BookOpen, Loader2 } from 'lucide-react';
import { Dialog, DialogContent, DialogDescription, DialogTitle, DialogTrigger } from '@/components/ui/dialog';

type FinalScript = { id: string; episode: string; versionNo: number; sourceText: string; finalizedAt: string; finalizedBy: string };

export function FinalScriptReader() {
  const [open, setOpen] = useState(false);
  const [scripts, setScripts] = useState<FinalScript[]>([]);
  const [selectedId, setSelectedId] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [retry, setRetry] = useState(0);

  useEffect(() => {
    if (!open) return;
    const controller = new AbortController();
    setLoading(true);
    setError('');
    void (async () => {
      try {
        const response = await fetch('/api/final-scripts', { cache: 'no-store', signal: controller.signal });
        const data = await response.json() as { scripts?: FinalScript[]; error?: string };
        if (!response.ok) throw new Error(data.error || '读取失败');
        if (controller.signal.aborted) return;
        const next = (data.scripts || []).sort((a, b) => a.episode.localeCompare(b.episode, 'zh-CN', { numeric: true }));
        setScripts(next);
        setSelectedId((current) => next.some((script) => script.id === current) ? current : next[0]?.id || '');
      } catch (nextError) {
        if (!controller.signal.aborted) setError(nextError instanceof Error ? nextError.message : '读取失败');
      } finally {
        if (!controller.signal.aborted) setLoading(false);
      }
    })();
    return () => controller.abort();
  }, [open, retry]);

  const selected = scripts.find((script) => script.id === selectedId);
  return <Dialog open={open} onOpenChange={setOpen}>
    <DialogTrigger className="mx-auto mt-2 flex min-h-10 w-full max-w-4xl items-center justify-center gap-2 rounded-xl border border-cyan-300/20 bg-cyan-300/[.06] px-3 py-2 text-xs text-cyan-200 hover:bg-cyan-300/10">
      <BookOpen className="h-4 w-4" />单集定稿剧本<span className="text-cyan-200/60">· 全组只读 · 点击查看</span>
    </DialogTrigger>
    <DialogContent className="z-[100] flex max-h-[85dvh] flex-col gap-3 border border-white/10 bg-[#191b20] p-5 text-zinc-100 sm:max-w-3xl">
      <DialogTitle className="pr-8 text-lg">单集完整定稿剧本</DialogTitle>
      <DialogDescription>仅展示Lipa已确认的定稿。所有工作人员可阅读，不能在这里修改或提报。</DialogDescription>
      {loading ? <p role="status" className="flex items-center gap-2 py-10 text-sm text-zinc-400"><Loader2 className="h-4 w-4 animate-spin" />正在读取最新定稿…</p>
        : error ? <div role="alert" className="py-8 text-sm text-red-300">{error}<button onClick={() => setRetry((value) => value + 1)} className="ml-3 underline">重新加载</button></div>
          : !scripts.length ? <p className="py-10 text-sm text-zinc-400">暂时没有已定稿的单集剧本，等待Lipa确认后会自动显示。</p>
            : <>
              <label className="flex shrink-0 items-center gap-3 text-sm text-zinc-300">选择集数
                <select aria-label="选择定稿剧本集数" value={selectedId} onChange={(event) => setSelectedId(event.target.value)} className="min-w-0 flex-1 rounded-lg border border-white/15 bg-[#252830] px-3 py-2">
                  {scripts.map((script) => <option key={script.id} value={script.id}>{script.episode} · 定稿 v{script.versionNo}</option>)}
                </select>
              </label>
              {selected && <>
                <p className="shrink-0 text-xs text-emerald-300">{selected.finalizedBy || 'Lipa'}确认定稿{selected.finalizedAt ? ` · ${new Date(selected.finalizedAt).toLocaleString('zh-CN', { timeZone: 'Asia/Shanghai' })}` : ''}</p>
                <article key={selected.id} aria-label={`${selected.episode}完整定稿正文`} tabIndex={0} className="min-h-0 overflow-y-auto overscroll-contain whitespace-pre-wrap break-words rounded-xl border border-white/8 bg-black/15 p-4 text-sm leading-8 text-zinc-200 md:p-6">{selected.sourceText}</article>
              </>}
            </>}
    </DialogContent>
  </Dialog>;
}
