'use client';
/* oxlint-disable next/no-img-element */

import { useEffect, useMemo, useState } from 'react';
import { ArrowLeft, ClipboardCopy, Download, Loader2 } from 'lucide-react';
import { ArtFavoriteButton, ArtFavoritesProvider } from '@/components/art-favorites';
import { ReferenceLightbox } from '@/components/reference-lightbox';
import { buildReuseMap, compareArtItems, type ReuseExclusion } from '@/lib/art-structure';
import { uploadAuthorLabel } from '@/lib/upload-attribution';

type Analysis = { id: string; episode: string; sceneNo: number; sceneTitle: string; sceneSummary: string; location: string };
type Item = { id: string; analysisId: string; category: string; name: string; detail: string; visualBrief: string; sortOrder: number };
type Detail = { itemId: string; status: string; submissionNote: string; reviewNote: string; selectedFileId: string };
type FileRow = { id: string; itemId: string; fileName: string; uploadedBy: string; createdAt: string; sortOrder: number; url: string };
type Payload = { episode: string; version?: { versionNo: number; finalizedAt: string }; analyses: Analysis[]; items: Item[]; details: Detail[]; files: FileRow[]; exclusions?: ReuseExclusion[]; error?: string };
type ReuseInfo = { sourceItemId: string; sourceSceneNo: number; files: FileRow[] };
type ReviewPage = { analysis: Analysis; item: Item; files: FileRow[]; reuseInfo?: ReuseInfo; pageIndex: number; pageCount: number };



export function ArtReviewPage() { return <ArtFavoritesProvider><ArtReviewContent /></ArtFavoritesProvider>; }
function ArtReviewContent() {
  const [previewId, setPreviewId] = useState('');
  const [data, setData] = useState<Payload | null>(null);
  const [error, setError] = useState('');
  const [downloading, setDownloading] = useState(false);
  const [pdfProgress, setPdfProgress] = useState('');
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
    for (const items of map.values()) items.sort(compareArtItems);
    return map;
  }, [data]);
  const rawFilesByItem = useMemo(() => {
    const map = new Map<string, FileRow[]>();
    for (const file of data?.files || []) map.set(file.itemId, [...(map.get(file.itemId) || []), file]);
    return map;
  }, [data]);
  const reuseByItem = useMemo(() => buildReuseMap(data?.analyses || [], data?.items || [], rawFilesByItem, data?.exclusions || []), [data, rawFilesByItem]);
  const filesByItem = useMemo(() => {
    const map = new Map(rawFilesByItem);
    for (const [id, reference] of reuseByItem) if (!map.get(id)?.length) map.set(id, reference.files);
    return map;
  }, [rawFilesByItem, reuseByItem]);
  const detailByItem = useMemo(() => new Map((data?.details || []).map((detail) => [detail.itemId, detail])), [data]);

  async function copyLink() {
    await navigator.clipboard.writeText(window.location.href);
    setCopied(true); window.setTimeout(() => setCopied(false), 1600);
  }

  async function downloadPdf() {
    if (!data) return;
    setDownloading(true); setError(''); setPdfProgress('准备中');
    try {
      const pages: FastPdfPage[] = data.analyses.flatMap((analysis) => (itemByAnalysis.get(analysis.id) || []).flatMap((item) => {
        const files = filesByItem.get(item.id) || [];
        const reuseInfo = reuseByItem.get(item.id);
        const selectedFileId = detailByItem.get(item.id)?.selectedFileId || '';
        if (reuseInfo || !files.length) return [{ analysis, item, files: [] as FileRow[], reuseInfo, selectedFileId, optionOffset: 0, part: 1, partCount: 1 }];
        const ordered = [...files].sort((a, b) => Number(b.id === selectedFileId) - Number(a.id === selectedFileId));
        return chunk(ordered, 4).map((pageFiles, part) => ({ analysis, item, files: pageFiles, selectedFileId, optionOffset: part * 4, part: part + 1, partCount: Math.ceil(ordered.length / 4) }));
      }));
      await buildFastPdf(data, pages, (done, total) => setPdfProgress(`${done}/${total}`));
    } catch (nextError) {
      setError(nextError instanceof Error ? nextError.message : 'PDF生成失败');
    } finally { setDownloading(false); setPdfProgress(''); }
  }

  if (error && !data) return <main className="grid min-h-screen place-items-center bg-[#080d13] p-6 text-red-300">{error}</main>;
  if (!data) return <main className="grid min-h-screen place-items-center bg-[#080d13] text-zinc-400"><Loader2 className="h-6 w-6 animate-spin" /></main>;

  const uploaded = data.items.filter((item) => (filesByItem.get(item.id) || []).length).length;
  return <main className="min-h-screen bg-[#080d13] text-white">
    <header className="no-print sticky top-0 z-50 border-b border-white/10 bg-[#080d13]/90 px-4 py-3 backdrop-blur-xl">
      <div className="mx-auto flex max-w-6xl flex-wrap items-center gap-3"><div className="mr-auto"><p className="text-[10px] tracking-[.2em] text-[#ff8066]">ART REVIEW H5</p><h1 className="text-lg font-semibold">《折叠庭院的她》{data.episode} · 美术预览</h1></div><span className="rounded-full border border-cyan-300/20 bg-cyan-300/10 px-3 py-2 text-xs text-cyan-200">{uploaded}/{data.items.length}项已上传</span><a href="/studio" className="inline-flex items-center gap-2 rounded-full border border-white/15 px-4 py-2 text-sm text-white/80 transition hover:bg-white/10 hover:text-white"><ArrowLeft className="h-4 w-4" />返回主 SOP</a><button onClick={() => void copyLink()} className="inline-flex items-center gap-2 rounded-full border border-white/15 px-4 py-2 text-sm"><ClipboardCopy className="h-4 w-4" />{copied ? '已复制' : '复制H5链接'}</button><button onClick={() => void downloadPdf()} disabled={downloading} className="inline-flex items-center gap-2 rounded-full bg-[#ff6240] px-4 py-2 text-sm font-medium text-black disabled:opacity-60">{downloading ? <Loader2 className="h-4 w-4 animate-spin" /> : <Download className="h-4 w-4" />}{downloading ? `生成中 ${pdfProgress}` : '下载PDF'}</button></div>
    </header>
    {previewId && <ReferenceLightbox files={data.files} initialId={previewId} onClose={() => setPreviewId('')} />}
    <p className="mx-auto mt-4 max-w-6xl px-4 text-sm text-amber-200">当前上传进度预览 · 不代表定稿或审核通过。{uploaded < data.items.length ? `尚有${data.items.length - uploaded}项待上传。` : '图片已齐，定稿以Lipa选择为准。'}</p>
    {error && <p className="mx-auto mt-4 max-w-6xl rounded-xl border border-red-400/20 bg-red-400/5 px-4 py-3 text-sm text-red-300">{error}</p>}
    <div className="mx-auto max-w-6xl space-y-7 px-4 py-7">
      <section className="art-review-sheet relative h-[794px] overflow-hidden rounded-3xl border border-white/10 bg-[#101821] p-12 shadow-2xl" style={{ backgroundImage: "linear-gradient(rgba(6,12,18,.82),rgba(6,12,18,.91)),url('/folded-courtyard-bg.jpg')", backgroundPosition: 'center', backgroundSize: 'cover' }}><div className="pt-28 text-center"><p className="text-sm tracking-[.28em] text-[#ff8066]">VISUAL REVIEW</p><h2 className="mt-5 text-6xl font-semibold">折叠庭院的她</h2><p className="mt-5 text-3xl text-white/85">{data.episode} · 美术提报 H5</p><p className="mx-auto mt-8 max-w-2xl text-base leading-8 text-white/65">按场景、情节、人物与服装逐项审图。页面保留美术团队上传的全部备选，并明确标记Lipa选定的定稿图。</p><div className="mx-auto mt-10 grid max-w-xl grid-cols-3 overflow-hidden rounded-2xl border border-white/15 bg-black/35"><Meta label="剧本定稿" value={`v${data.version?.versionNo || '—'}`} /><Meta label="场次" value={`${data.analyses.length}场`} /><Meta label="图片" value={`${data.files.length}张`} /></div></div><Footer episode={data.episode} page={1} /></section>
      {data.analyses.flatMap((analysis) => {
        const sceneItems = itemByAnalysis.get(analysis.id) || [];
        return sceneItems.flatMap<ReviewPage>((item) => {
          const files = filesByItem.get(item.id) || [];
          const reuseInfo: ReuseInfo | undefined = reuseByItem.get(item.id);
          if (reuseInfo) return [{ analysis, item, files: [] as FileRow[], reuseInfo, pageIndex: 0, pageCount: 1 }];
          if (!files.length) return [{ analysis, item, files: [] as FileRow[], reuseInfo, pageIndex: 0, pageCount: 1 }];
          return chunk(files, 4).map((pageFiles, pageIndex) => ({ analysis, item, files: pageFiles, reuseInfo, pageIndex, pageCount: Math.ceil(files.length / 4) }));
        });
      }).map((page, index) => <section key={`${page.item.id}-${page.pageIndex}`} className="art-review-sheet relative min-h-[794px] overflow-visible rounded-3xl border border-white/10 bg-[#101821] p-5 shadow-2xl sm:p-8 lg:h-[794px] lg:overflow-hidden lg:p-10" style={{ backgroundImage: "linear-gradient(rgba(6,12,18,.86),rgba(6,12,18,.92)),url('/folded-courtyard-bg.jpg')", backgroundPosition: 'center', backgroundSize: 'cover' }}><div className="border-b border-white/15 pb-4"><p className="text-xs tracking-[.2em] text-[#ff8066]">{data.episode} · 第{page.analysis.sceneNo}场 · {page.item.category}</p><h2 className="mt-2 text-2xl font-semibold sm:text-3xl">{page.item.category === '场景' ? page.analysis.location || page.analysis.sceneTitle : page.item.name}</h2><p className="mt-2 text-sm text-white/60">{page.reuseInfo ? `沿用第${page.reuseInfo.sourceSceneNo}场` : page.pageCount > 1 ? `Option 第${page.pageIndex + 1}/${page.pageCount}页` : '单项审阅'}</p></div><div className="art-review-layout mt-5 grid grid-cols-1 gap-6 lg:grid-cols-[270px_1fr]"><aside className="rounded-2xl border border-white/12 bg-black/45 p-5"><p className="text-xs tracking-[.16em] text-[#ff8066]">本场情节</p><p className="mt-3 line-clamp-5 text-base font-semibold leading-7">{page.analysis.sceneSummary || page.analysis.sceneTitle}</p><div className="mt-5 border-t border-white/10 pt-4 text-sm leading-6 text-white/60"><p className="line-clamp-5">{page.item.detail}</p>{detailByItem.get(page.item.id)?.submissionNote && <p className="mt-3 text-white/80">采用：{detailByItem.get(page.item.id)?.submissionNote}</p>}</div></aside>{page.reuseInfo ? <div className="grid min-h-[360px] place-items-center rounded-2xl border border-cyan-400/20 bg-cyan-400/[.06] p-10 text-center"><div><p className="text-sm tracking-[.18em] text-cyan-300">CONTINUITY REUSE</p><p className="mt-5 text-4xl font-semibold">与第{page.reuseInfo.sourceSceneNo}场一样</p><p className="mt-4 text-sm text-white/55">沿用来源场次已上传并审核的整组参考，本场不重复展示图片。</p>{page.reuseInfo.files[0] && <button type="button" onClick={() => setPreviewId(page.reuseInfo!.files[0].id)} className="mt-6 rounded-full border border-cyan-300/30 px-5 py-2 text-sm text-cyan-200">查看第{page.reuseInfo.sourceSceneNo}场原图</button>}</div></div> : <div className={`art-review-files grid content-start place-items-center gap-4 ${page.files.length === 1 ? 'grid-cols-1' : 'grid-cols-1 md:grid-cols-2'}`}>{!page.files.length && <p className="rounded-xl border border-dashed border-white/20 p-10 text-sm text-white/50">本项待上传，可随时回来查看更新。</p>}{page.files.map((file, fileIndex) => { const selected = detailByItem.get(page.item.id)?.selectedFileId === file.id; return <figure key={file.id} className={`flex w-full max-w-[390px] flex-col items-center rounded-2xl border bg-black/45 p-3 ${selected ? 'border-emerald-400/70' : 'border-white/12'}`}><div className="art-review-file-frame flex h-[min(58vw,360px)] w-full items-center justify-center md:h-[190px]"><button type="button" onClick={() => setPreviewId(file.id)} aria-label={`放大查看${file.fileName}`} className="flex h-full w-full items-center justify-center"><img src={file.url} alt={file.fileName} className="block h-auto max-h-full w-auto max-w-full rounded-xl object-contain" /></button></div><figcaption className="mt-2 text-center text-xs text-white/70">{selected && <span className="mr-2 rounded-full bg-emerald-400 px-2 py-0.5 font-semibold text-black">定稿图</span>}<span>Option {page.pageIndex * 4 + fileIndex + 1}</span><span className="mt-0.5 block font-medium text-cyan-300">{uploadAuthorLabel(file.uploadedBy)}</span><span className="mt-2 inline-block"><ArtFavoriteButton fileId={file.id} /></span></figcaption></figure>})}</div>}</div><Footer episode={data.episode} page={index + 2} /></section>)}
    </div>
  </main>;
}

function Meta({ label, value }: { label: string; value: string }) { return <div className="border-r border-white/10 p-4 last:border-r-0"><p className="text-[10px] text-white/45">{label}</p><p className="mt-1 font-medium">{value}</p></div>; }
function Footer({ episode, page }: { episode: string; page: number }) { return <footer className="absolute inset-x-10 bottom-7 flex justify-between border-t border-white/15 pt-2 text-[10px] text-white/45"><span>《折叠庭院的她》 · {episode} · 美术提报</span><span>第 {page} 页</span></footer>; }
function chunk<T>(values: T[], size: number) { const result: T[][] = []; for (let index = 0; index < values.length; index += size) result.push(values.slice(index, index + size)); return result; }

type FastPdfPage = { analysis: Analysis; item: Item; files: FileRow[]; reuseInfo?: ReuseInfo; selectedFileId: string; optionOffset: number; part: number; partCount: number };

async function buildFastPdf(data: Payload, pages: FastPdfPage[], onProgress: (done: number, total: number) => void) {
  const { jsPDF } = await import('jspdf');
  const pdf = new jsPDF({ orientation: 'landscape', unit: 'mm', format: 'a4', compress: true });
  const background = await loadCanvasImage('/folded-courtyard-bg.jpg').catch(() => null);
  const total = pages.length + 1;
  const cover = document.createElement('canvas'); cover.width = 1120; cover.height = 794;
  drawFastBackground(cover, background);
  const coverDraw = cover.getContext('2d')!;
  coverDraw.textAlign = 'center'; coverDraw.fillStyle = '#ff8066'; coverDraw.font = '20px sans-serif'; coverDraw.fillText('VISUAL REVIEW', 560, 235);
  coverDraw.fillStyle = '#fff'; coverDraw.font = '600 60px "PingFang SC", sans-serif'; coverDraw.fillText('折叠庭院的她', 560, 330);
  coverDraw.font = '34px "PingFang SC", sans-serif'; coverDraw.fillText(`${data.episode} · 美术提报`, 560, 395);
  coverDraw.fillStyle = '#56d7ed'; coverDraw.font = '24px "PingFang SC", sans-serif'; coverDraw.fillText(`${data.analyses.length}场 · ${data.items.length}项 · H5保留全部${data.files.length}张原图`, 560, 500);
  pdf.addImage(cover.toDataURL('image/jpeg', 0.68), 'JPEG', 0, 0, 297, 210, undefined, 'FAST');
  onProgress(1, total);
  for (let index = 0; index < pages.length; index += 1) {
    const page = pages[index];
    const canvas = document.createElement('canvas'); canvas.width = 1120; canvas.height = 794;
    drawFastBackground(canvas, background);
    const draw = canvas.getContext('2d')!;
    draw.fillStyle = '#ff8066'; draw.font = '18px "PingFang SC", sans-serif'; draw.fillText(`${data.episode} · 第${page.analysis.sceneNo}场 · ${page.item.category}`, 50, 55);
    draw.fillStyle = '#fff'; draw.font = '600 32px "PingFang SC", sans-serif'; draw.fillText(page.item.category === '场景' ? page.analysis.location || page.analysis.sceneTitle : page.item.name, 50, 100);
    if (page.partCount > 1) { draw.textAlign = 'right'; draw.fillStyle = 'rgba(255,255,255,.55)'; draw.font = '16px "PingFang SC", sans-serif'; draw.fillText(`${page.part}/${page.partCount}`, 1070, 100); draw.textAlign = 'left'; }
    draw.strokeStyle = 'rgba(255,255,255,.18)'; draw.beginPath(); draw.moveTo(50, 128); draw.lineTo(1070, 128); draw.stroke();
    draw.fillStyle = 'rgba(255,255,255,.68)'; draw.font = '17px "PingFang SC", sans-serif'; drawWrapped(draw, page.analysis.sceneSummary || page.analysis.sceneTitle, 50, 160, 1020, 25, 3);
    if (page.reuseInfo) {
      draw.fillStyle = 'rgba(32,186,215,.13)'; roundedRect(draw, 170, 285, 780, 300, 28); draw.fill();
      draw.textAlign = 'center'; draw.fillStyle = '#56d7ed'; draw.font = '18px sans-serif'; draw.fillText('CONTINUITY REUSE', 560, 375);
      draw.fillStyle = '#fff'; draw.font = '600 54px "PingFang SC", sans-serif'; draw.fillText(`与第${page.reuseInfo.sourceSceneNo}场一样`, 560, 475);
      draw.fillStyle = 'rgba(255,255,255,.58)'; draw.font = '18px "PingFang SC", sans-serif'; draw.fillText('本场不重复铺图，原图请在H5点击查看。', 560, 530);
    } else {
      const ordered = page.files;
      const loaded = await Promise.all(ordered.map((file) => loadCanvasImage(file.url).catch(() => null)));
      const columns = ordered.length === 1 ? 1 : 2;
      const rows = Math.ceil(Math.max(1, ordered.length) / columns);
      const cellWidth = columns === 1 ? 1020 : 500;
      const cellHeight = rows === 1 ? 470 : 225;
      for (let fileIndex = 0; fileIndex < ordered.length; fileIndex += 1) {
        const x = 50 + (fileIndex % columns) * (cellWidth + 20); const y = 245 + Math.floor(fileIndex / columns) * (cellHeight + 15);
        draw.fillStyle = 'rgba(0,0,0,.42)'; roundedRect(draw, x, y, cellWidth, cellHeight, 15); draw.fill();
        if (loaded[fileIndex]) drawContained(draw, loaded[fileIndex]!, x + 10, y + 10, cellWidth - 20, cellHeight - 55);
        draw.fillStyle = '#fff'; draw.font = '15px "PingFang SC", sans-serif'; draw.fillText(`Option ${page.optionOffset + fileIndex + 1}${ordered[fileIndex].id === page.selectedFileId ? ' · 定稿图' : ''}`, x + 14, y + cellHeight - 20);
        draw.fillStyle = '#56d7ed'; draw.fillText(uploadAuthorLabel(ordered[fileIndex].uploadedBy), x + 160, y + cellHeight - 20);
      }
      if (!ordered.length) { draw.fillStyle = 'rgba(255,255,255,.45)'; draw.font = '22px "PingFang SC", sans-serif'; draw.fillText('本项待上传', 500, 430); }
    }
    draw.textAlign = 'left'; draw.fillStyle = 'rgba(255,255,255,.42)'; draw.font = '14px "PingFang SC", sans-serif'; draw.fillText(`《折叠庭院的她》 · ${data.episode}`, 50, 775); draw.textAlign = 'right'; draw.fillText(`${index + 2}/${total}`, 1070, 775);
    pdf.addPage('a4', 'landscape'); pdf.addImage(canvas.toDataURL('image/jpeg', 0.68), 'JPEG', 0, 0, 297, 210, undefined, 'FAST');
    canvas.width = 1; canvas.height = 1; onProgress(index + 2, total);
    if (index % 3 === 2) await new Promise<void>((resolve) => requestAnimationFrame(() => resolve()));
  }
  pdf.save(`折叠庭院的她_${data.episode}_快速美术提报.pdf`);
}

function loadCanvasImage(url: string) {
  return new Promise<HTMLImageElement>((resolve, reject) => {
    const image = new Image(); const timer = window.setTimeout(() => reject(new Error('图片读取超时')), 15000);
    image.crossOrigin = 'anonymous'; image.decoding = 'async'; image.onload = () => { window.clearTimeout(timer); resolve(image); }; image.onerror = () => { window.clearTimeout(timer); reject(new Error('图片读取失败')); }; image.src = url;
  });
}
function drawFastBackground(canvas: HTMLCanvasElement, background: HTMLImageElement | null) { const draw = canvas.getContext('2d')!; draw.fillStyle = '#081019'; draw.fillRect(0, 0, canvas.width, canvas.height); if (background) { draw.globalAlpha = .2; draw.drawImage(background, 0, 0, canvas.width, canvas.height); draw.globalAlpha = 1; } draw.fillStyle = 'rgba(5,12,18,.76)'; draw.fillRect(0, 0, canvas.width, canvas.height); }
function drawContained(draw: CanvasRenderingContext2D, image: HTMLImageElement, x: number, y: number, width: number, height: number) { const scale = Math.min(width / image.naturalWidth, height / image.naturalHeight); const targetWidth = image.naturalWidth * scale; const targetHeight = image.naturalHeight * scale; draw.drawImage(image, x + (width - targetWidth) / 2, y + (height - targetHeight) / 2, targetWidth, targetHeight); }
function drawWrapped(draw: CanvasRenderingContext2D, text: string, x: number, y: number, width: number, lineHeight: number, maxLines: number) { let line = ''; let row = 0; for (const character of text) { const next = line + character; if (draw.measureText(next).width > width && line) { draw.fillText(line, x, y + row * lineHeight); line = character; row += 1; if (row >= maxLines) return; } else line = next; } if (line && row < maxLines) draw.fillText(line, x, y + row * lineHeight); }
function roundedRect(draw: CanvasRenderingContext2D, x: number, y: number, width: number, height: number, radius: number) { draw.beginPath(); draw.roundRect(x, y, width, height, radius); }
