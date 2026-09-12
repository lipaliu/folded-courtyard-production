'use client';
/* oxlint-disable next/no-img-element */

import { useEffect, useMemo, useState } from 'react';
import { ArrowLeft, ClipboardCopy, Download, Loader2 } from 'lucide-react';

type Analysis = { id: string; episode: string; sceneNo: number; sceneTitle: string; sceneSummary: string; location: string };
type Item = { id: string; analysisId: string; category: string; name: string; detail: string; visualBrief: string; sortOrder: number };
type Detail = { itemId: string; status: string; submissionNote: string; reviewNote: string };
type FileRow = { id: string; itemId: string; fileName: string; sortOrder: number; url: string };
type Payload = { episode: string; version?: { versionNo: number; finalizedAt: string }; analyses: Analysis[]; items: Item[]; details: Detail[]; files: FileRow[]; error?: string };

const order = ['场景', '人物', '服装', '道具'];

export function ArtReviewPage() {
  const [data, setData] = useState<Payload | null>(null);
  const [error, setError] = useState('');
  const [downloading, setDownloading] = useState(false);
  const [copied, setCopied] = useState(false);

  useEffect(() => {
    const episode = new URLSearchParams(window.location.search).get('episode') || '第1集';
    fetch(`/api/public/art-review?episode=${encodeURIComponent(episode)}`, { cache: 'no-store' })
      .then(async (response) => {
        const payload = await response.json() as Payload;
        if (!response.ok) throw new Error(payload.error || '读取美术提报失败');
        setData(payload);
      })
      .catch((nextError) => setError(nextError instanceof Error ? nextError.message : '读取美术提报失败'));
  }, []);

  const itemByAnalysis = useMemo(() => {
    const map = new Map<string, Item[]>();
    for (const item of data?.items || []) map.set(item.analysisId, [...(map.get(item.analysisId) || []), item]);
    for (const items of map.values()) items.sort((a, b) => order.indexOf(a.category) - order.indexOf(b.category) || a.sortOrder - b.sortOrder);
    return map;
  }, [data]);
  const filesByItem = useMemo(() => {
    const map = new Map<string, FileRow[]>();
    for (const file of data?.files || []) map.set(file.itemId, [...(map.get(file.itemId) || []), file]);
    return map;
  }, [data]);
  const detailByItem = useMemo(() => new Map((data?.details || []).map((detail) => [detail.itemId, detail])), [data]);

  async function copyLink() {
    await navigator.clipboard.writeText(window.location.href);
    setCopied(true); window.setTimeout(() => setCopied(false), 1600);
  }

  async function downloadPdf() {
    if (!data) return;
    setDownloading(true); setError('');
    try {
      await Promise.all([...document.images].map((image) => image.complete ? Promise.resolve() : new Promise<void>((resolve) => { image.onload = () => resolve(); image.onerror = () => resolve(); })));
      const sheets = [...document.querySelectorAll<HTMLElement>('.art-review-sheet')];
      const [{ default: html2canvas }, { jsPDF }] = await Promise.all([import('html2canvas-pro'), import('jspdf')]);
      const pdf = new jsPDF({ orientation: 'landscape', unit: 'mm', format: 'a4', compress: true });
      for (let index = 0; index < sheets.length; index += 1) {
        const canvas = await html2canvas(sheets[index], { scale: 1.35, backgroundColor: '#0b1118', useCORS: true, logging: false });
        if (index) pdf.addPage('a4', 'landscape');
        pdf.addImage(canvas.toDataURL('image/jpeg', 0.9), 'JPEG', 0, 0, 297, 210, undefined, 'FAST');
      }
      pdf.save(`折叠庭院的她_${data.episode}_美术提报.pdf`);
    } catch (nextError) {
      setError(nextError instanceof Error ? nextError.message : 'PDF生成失败');
    } finally { setDownloading(false); }
  }

  if (error && !data) return <main className="grid min-h-screen place-items-center bg-[#080d13] p-6 text-red-300">{error}</main>;
  if (!data) return <main className="grid min-h-screen place-items-center bg-[#080d13] text-zinc-400"><Loader2 className="h-6 w-6 animate-spin" /></main>;

  const uploaded = data.items.filter((item) => (filesByItem.get(item.id) || []).length).length;
  return <main className="min-h-screen bg-[#080d13] text-white">
    <header className="no-print sticky top-0 z-50 border-b border-white/10 bg-[#080d13]/90 px-4 py-3 backdrop-blur-xl">
      <div className="mx-auto flex max-w-6xl flex-wrap items-center gap-3"><div className="mr-auto"><p className="text-[10px] tracking-[.2em] text-[#ff8066]">ART REVIEW H5</p><h1 className="text-lg font-semibold">《折叠庭院的她》{data.episode} · 美术提报</h1></div><span className="rounded-full border border-cyan-300/20 bg-cyan-300/10 px-3 py-2 text-xs text-cyan-200">{uploaded}/{data.items.length}项已上传</span><a href="/studio" className="inline-flex items-center gap-2 rounded-full border border-white/15 px-4 py-2 text-sm text-white/80 transition hover:bg-white/10 hover:text-white"><ArrowLeft className="h-4 w-4" />返回主 SOP</a><button onClick={() => void copyLink()} className="inline-flex items-center gap-2 rounded-full border border-white/15 px-4 py-2 text-sm"><ClipboardCopy className="h-4 w-4" />{copied ? '已复制' : '复制H5链接'}</button><button onClick={() => void downloadPdf()} disabled={downloading} className="inline-flex items-center gap-2 rounded-full bg-[#ff6240] px-4 py-2 text-sm font-medium text-black disabled:opacity-60">{downloading ? <Loader2 className="h-4 w-4 animate-spin" /> : <Download className="h-4 w-4" />}下载PDF</button></div>
    </header>
    {error && <p className="mx-auto mt-4 max-w-6xl rounded-xl border border-red-400/20 bg-red-400/5 px-4 py-3 text-sm text-red-300">{error}</p>}
    <div className="mx-auto max-w-6xl space-y-7 px-4 py-7">
      <section className="art-review-sheet relative h-[794px] overflow-hidden rounded-3xl border border-white/10 bg-[#101821] p-12 shadow-2xl" style={{ backgroundImage: "linear-gradient(rgba(6,12,18,.82),rgba(6,12,18,.91)),url('/folded-courtyard-bg.jpg')", backgroundPosition: 'center', backgroundSize: 'cover' }}><div className="pt-28 text-center"><p className="text-sm tracking-[.28em] text-[#ff8066]">VISUAL REVIEW</p><h2 className="mt-5 text-6xl font-semibold">折叠庭院的她</h2><p className="mt-5 text-3xl text-white/85">{data.episode} · 美术提报 H5</p><p className="mx-auto mt-8 max-w-2xl text-base leading-8 text-white/65">按场景、情节、人物与服装逐项审图。页面只展示主美已上传的参考，不混入剧本提报内容。</p><div className="mx-auto mt-10 grid max-w-xl grid-cols-3 overflow-hidden rounded-2xl border border-white/15 bg-black/35"><Meta label="剧本定稿" value={`v${data.version?.versionNo || '—'}`} /><Meta label="场次" value={`${data.analyses.length}场`} /><Meta label="图片" value={`${data.files.length}张`} /></div></div><Footer episode={data.episode} page={1} /></section>
      {data.analyses.flatMap((analysis) => {
        const sceneItems = itemByAnalysis.get(analysis.id) || [];
        return sceneItems.flatMap((item) => {
          const files = filesByItem.get(item.id) || [];
          if (!files.length) return [];
          return chunk(files, 4).map((pageFiles, pageIndex) => ({ analysis, item, files: pageFiles, pageIndex, pageCount: Math.ceil(files.length / 4) }));
        });
      }).map((page, index) => <section key={`${page.item.id}-${page.pageIndex}`} className="art-review-sheet relative h-[794px] overflow-hidden rounded-3xl border border-white/10 bg-[#101821] p-10 shadow-2xl" style={{ backgroundImage: "linear-gradient(rgba(6,12,18,.86),rgba(6,12,18,.92)),url('/folded-courtyard-bg.jpg')", backgroundPosition: 'center', backgroundSize: 'cover' }}><div className="border-b border-white/15 pb-4"><p className="text-xs tracking-[.2em] text-[#ff8066]">{data.episode} · 第{page.analysis.sceneNo}场 · {page.item.category}</p><h2 className="mt-2 text-3xl font-semibold">{page.item.category === '场景' ? page.analysis.location || page.analysis.sceneTitle : page.item.name}</h2><p className="mt-2 text-sm text-white/60">{page.pageCount > 1 ? `Option 第${page.pageIndex + 1}/${page.pageCount}页` : '单项审阅'}</p></div><div className="mt-5 grid grid-cols-[270px_1fr] gap-6"><aside className="rounded-2xl border border-white/12 bg-black/45 p-5"><p className="text-xs tracking-[.16em] text-[#ff8066]">本场情节</p><p className="mt-3 text-xl font-semibold leading-8">{page.analysis.sceneSummary || page.analysis.sceneTitle}</p><div className="mt-5 border-t border-white/10 pt-4 text-sm leading-6 text-white/60"><p>{page.item.detail}</p>{detailByItem.get(page.item.id)?.submissionNote && <p className="mt-3 text-white/80">采用：{detailByItem.get(page.item.id)?.submissionNote}</p>}</div></aside><div className={`grid content-start place-items-center gap-4 ${page.files.length === 1 ? 'grid-cols-1' : 'grid-cols-2'}`}>{page.files.map((file, fileIndex) => <figure key={file.id} className="flex w-full max-w-[390px] flex-col items-center rounded-2xl border border-white/12 bg-black/45 p-3"><div className="flex h-[250px] w-full items-center justify-center"><img src={file.url} alt={file.fileName} className="block h-auto max-h-[238px] w-auto max-w-full rounded-xl object-contain" /></div><figcaption className="mt-2 text-center text-xs text-white/70">Option {page.pageIndex * 4 + fileIndex + 1} · {file.fileName}</figcaption></figure>)}</div></div><Footer episode={data.episode} page={index + 2} /></section>)}
    </div>
  </main>;
}

function Meta({ label, value }: { label: string; value: string }) { return <div className="border-r border-white/10 p-4 last:border-r-0"><p className="text-[10px] text-white/45">{label}</p><p className="mt-1 font-medium">{value}</p></div>; }
function Footer({ episode, page }: { episode: string; page: number }) { return <footer className="absolute inset-x-10 bottom-7 flex justify-between border-t border-white/15 pt-2 text-[10px] text-white/45"><span>《折叠庭院的她》 · {episode} · 美术提报</span><span>第 {page} 页</span></footer>; }
function chunk<T>(values: T[], size: number) { const result: T[][] = []; for (let index = 0; index < values.length; index += size) result.push(values.slice(index, index + size)); return result; }
