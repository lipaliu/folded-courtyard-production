'use client';
/* oxlint-disable react/react-compiler, next/no-img-element */

import { useEffect, useMemo, useState } from 'react';
import { Archive, Check, Clock3, Download, FileText, ImagePlus, Loader2, RefreshCw, Trash2, Upload, X } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Textarea } from '@/components/ui/textarea';
import type { ProductionItem } from '@/lib/plan-data';
import { PROJECT_END, PROJECT_START } from '@/lib/work-calendar';

type CurrentUser = { id: string; username: string; name: string; role: string; isAdmin: boolean };
type ScriptAnalysis = { id: string; episode: string; sceneNo: number; sceneTitle: string; scriptText: string; sceneSummary: string; location: string; createdAt: string; updatedAt: string };
type ScriptAssetItem = { id: string; analysisId: string; category: string; name: string; detail: string; visualBrief: string; sortOrder: number };
type ScriptVersion = { id: string; episode: string; versionNo: number; fileName: string; sourceText: string; changeSummary: string; workDate: string; submittedBy: string; sceneCount: number; itemCount: number; createdAt: string };
type DailySceneAssignment = { id: string; workDate: string; analysisId: string; scriptVersionId: string; assignedBy: string; createdAt: string };
type SubmissionDetail = { itemId: string; assignedTo: string; dueAt: string; handoffTo: string; doneDefinition: string; status: string; submissionNote: string; reviewNote: string; submittedAt: string; reviewedAt: string; updatedAt: string };
type SubmissionFile = { id: string; itemId: string; fileName: string; contentType: string; byteSize: number; uploadedBy: string; sortOrder: number; createdAt: string; url: string };

const categories = ['人物', '服装', '道具', '场景'];
const activeStatuses = new Set(['已上传', '待审核', '已锁定']);

export function SubmissionCenter({ me, selectedDate, productionItems, onAssigned }: { me: CurrentUser; selectedDate: string; productionItems: ProductionItem[]; onAssigned: (date: string) => Promise<void> }) {
  const [analyses, setAnalyses] = useState<ScriptAnalysis[]>([]);
  const [items, setItems] = useState<ScriptAssetItem[]>([]);
  const [versions, setVersions] = useState<ScriptVersion[]>([]);
  const [assignments, setAssignments] = useState<DailySceneAssignment[]>([]);
  const [details, setDetails] = useState<SubmissionDetail[]>([]);
  const [files, setFiles] = useState<SubmissionFile[]>([]);
  const [workDate, setWorkDate] = useState(selectedDate);
  const [selectedIds, setSelectedIds] = useState<string[]>([]);
  const [changeSummary, setChangeSummary] = useState('首次单集提报');
  const [scriptFileName, setScriptFileName] = useState('');
  const [scriptFile, setScriptFile] = useState<File | null>(null);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [pdfEpisode, setPdfEpisode] = useState('');
  const [notice, setNotice] = useState('');
  const [error, setError] = useState('');
  const canEditArt = me.isAdmin || ['主美', '美术'].includes(me.role);

  async function loadAll() {
    setLoading(true);
    setError('');
    try {
      const [scriptResponse, submissionResponse] = await Promise.all([
        fetch('/api/script-analysis', { cache: 'no-store' }),
        fetch('/api/art-submissions', { cache: 'no-store' }),
      ]);
      const scriptData = await scriptResponse.json() as { analyses?: ScriptAnalysis[]; items?: ScriptAssetItem[]; versions?: ScriptVersion[]; assignments?: DailySceneAssignment[]; error?: string };
      const submissionData = await submissionResponse.json() as { details?: SubmissionDetail[]; files?: SubmissionFile[]; error?: string };
      if (!scriptResponse.ok) throw new Error(scriptData.error || '读取剧本提报失败');
      if (!submissionResponse.ok) throw new Error(submissionData.error || '读取美术提报失败');
      setAnalyses(scriptData.analyses || []);
      setItems(scriptData.items || []);
      setVersions(scriptData.versions || []);
      setAssignments(scriptData.assignments || []);
      setDetails(submissionData.details || []);
      setFiles(submissionData.files || []);
    } catch (nextError) {
      setError(nextError instanceof Error ? nextError.message : '暂时无法读取提报中心');
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => { void loadAll(); }, []);
  useEffect(() => { setWorkDate(selectedDate); setNotice(''); setSelectedIds([]); }, [selectedDate]);

  const dateAssignments = assignments.filter((assignment) => assignment.workDate === workDate);
  const assignedIds = new Set(dateAssignments.map((assignment) => assignment.analysisId));
  const legacyEpisodes = new Set(productionItems.filter((item) => item.workDate === workDate && item.category === '美术清单').map((item) => item.episode));
  const dailyAnalyses = analyses.filter((analysis) => assignedIds.size ? assignedIds.has(analysis.id) : legacyEpisodes.has(analysis.episode));
  const dailyAnalysisIds = new Set(dailyAnalyses.map((analysis) => analysis.id));
  const dailyItems = items.filter((item) => dailyAnalysisIds.has(item.analysisId));
  const dailyEpisodes = [...new Set(dailyAnalyses.map((analysis) => analysis.episode))];
  const detailMap = useMemo(() => new Map(details.map((detail) => [detail.itemId, detail])), [details]);
  const filesByItem = useMemo(() => {
    const map = new Map<string, SubmissionFile[]>();
    for (const file of files) map.set(file.itemId, [...(map.get(file.itemId) || []), file]);
    return map;
  }, [files]);

  async function readScriptFile() {
    if (!scriptFile || !changeSummary.trim()) return;
    setSaving(true); setError(''); setNotice('');
    try {
      const extension = scriptFile.name.toLowerCase().split('.').pop();
      if (!['txt', 'docx'].includes(extension || '')) throw new Error('请上传 TXT 或 DOCX；旧版 DOC 请先另存为 DOCX。');
      let sourceText = '';
      if (extension === 'txt') sourceText = await scriptFile.text();
      else {
        const mammoth = await import('mammoth');
        const result = await mammoth.extractRawText({ arrayBuffer: await scriptFile.arrayBuffer() });
        sourceText = result.value;
      }
      if (!sourceText.trim()) throw new Error('剧本文件里没有读取到文字');
      const importResponse = await fetch('/api/script-analysis', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ action: 'importScript', workDate, fileName: scriptFile.name, text: sourceText, changeSummary }) });
      const imported = await importResponse.json() as { analysisIds?: string[]; versions?: Array<{ episode: string; versionNo: number }>; sceneCount?: number; itemCount?: number; error?: string };
      if (!importResponse.ok || !imported.analysisIds?.length) throw new Error(imported.error || '单集剧本拆解失败');
      const assignResponse = await fetch('/api/script-analysis', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ action: 'assign', workDate, analysisIds: imported.analysisIds }) });
      const assigned = await assignResponse.json() as { error?: string };
      if (!assignResponse.ok) throw new Error(assigned.error || '剧本已存档，但当天工作分配失败');
      await loadAll();
      await onAssigned(workDate);
      const versionText = (imported.versions || []).map((row) => `${row.episode} v${row.versionNo}`).join('、');
      setNotice(`已存档${versionText || '新剧本版本'}，识别${imported.sceneCount || 0}场、${imported.itemCount || 0}项人服道景工作，并排入${formatDate(workDate)}。`);
      setScriptFile(null); setScriptFileName(''); setChangeSummary('');
    } catch (nextError) {
      setError(nextError instanceof Error ? nextError.message : '剧本提报失败');
    } finally {
      setSaving(false);
    }
  }

  async function assignExisting() {
    if (!selectedIds.length) return;
    setSaving(true); setError('');
    try {
      const response = await fetch('/api/script-analysis', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ action: 'assign', workDate, analysisIds: selectedIds }) });
      const data = await response.json() as { error?: string };
      if (!response.ok) throw new Error(data.error || '排产失败');
      await loadAll(); await onAssigned(workDate);
      setNotice(`已把${selectedIds.length}场排入${formatDate(workDate)}；责任人与18:00节点已建立，可逐项改派。`);
      setSelectedIds([]);
    } catch (nextError) {
      setError(nextError instanceof Error ? nextError.message : '排产失败');
    } finally { setSaving(false); }
  }

  async function uploadImage(itemId: string, file: File) {
    const uploadFile = await prepareImageForUpload(file);
    const form = new FormData(); form.append('itemId', itemId); form.append('file', uploadFile);
    const response = await fetch('/api/art-submissions', { method: 'POST', body: form });
    const data = await response.json() as { file?: SubmissionFile; detail?: Partial<SubmissionDetail>; error?: string };
    if (!response.ok || !data.file) throw new Error(data.error || '图片上传失败');
    setFiles((current) => [...current, data.file!]);
    setDetails((current) => current.map((detail) => detail.itemId === itemId ? { ...detail, ...data.detail } : detail));
  }

  async function saveDetail(itemId: string, changes: Partial<SubmissionDetail>) {
    const response = await fetch('/api/art-submissions', { method: 'PATCH', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ itemId, ...changes }) });
    const data = await response.json() as { detail?: SubmissionDetail; error?: string };
    if (!response.ok || !data.detail) throw new Error(data.error || '保存责任与节点失败');
    setDetails((current) => current.some((row) => row.itemId === itemId) ? current.map((row) => row.itemId === itemId ? data.detail! : row) : [...current, data.detail!]);
  }

  async function deleteFile(file: SubmissionFile) {
    if (!window.confirm(`确定删除错误上传的“${file.fileName}”吗？`)) return;
    const response = await fetch('/api/art-submissions', { method: 'DELETE', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ fileId: file.id }) });
    const data = await response.json() as { error?: string };
    if (!response.ok) throw new Error(data.error || '删除图片失败');
    setFiles((current) => current.filter((row) => row.id !== file.id));
  }

  function versionForEpisode(episode: string) {
    const versionId = dateAssignments.find((assignment) => analyses.find((analysis) => analysis.id === assignment.analysisId)?.episode === episode)?.scriptVersionId;
    return versions.find((version) => version.id === versionId) || versions.find((version) => version.episode === episode);
  }

  function completenessForEpisode(episode: string) {
    const episodeAnalyses = dailyAnalyses.filter((analysis) => analysis.episode === episode);
    const episodeIds = new Set(episodeAnalyses.map((analysis) => analysis.id));
    const episodeItems = items.filter((item) => episodeIds.has(item.analysisId));
    const missing: string[] = [];
    for (const analysis of episodeAnalyses) {
      const sceneItems = episodeItems.filter((item) => item.analysisId === analysis.id);
      if (!analysis.sceneSummary.trim()) missing.push(`第${analysis.sceneNo}场缺剧情`);
      for (const category of categories) if (!sceneItems.some((item) => item.category === category)) missing.push(`第${analysis.sceneNo}场缺${category}`);
      for (const item of sceneItems) {
        const detail = detailMap.get(item.id);
        const referenceFiles = filesByItem.get(item.id) || [];
        const reused = item.name.includes('本场无新增') || item.detail.includes('沿用');
        if (!detail?.assignedTo || !detail?.dueAt || !detail?.handoffTo || !detail?.doneDefinition) missing.push(`第${analysis.sceneNo}场·${item.name}责任/时间未齐`);
        if (!referenceFiles.length && !reused) missing.push(`第${analysis.sceneNo}场·${item.name}缺图`);
        if (!detail || !activeStatuses.has(detail.status)) missing.push(`第${analysis.sceneNo}场·${item.name}未提交`);
      }
    }
    if (!versionForEpisode(episode)) missing.push(`${episode}缺剧本版本`);
    return [...new Set(missing)];
  }

  async function downloadPdf(episode: string) {
    setPdfEpisode(episode); setError('');
    try {
      await document.fonts.ready;
      const container = document.getElementById(`submission-pdf-${episode.replace(/\W/g, '')}`);
      if (!container) throw new Error('PDF版式没有准备好');
      const images = [...container.querySelectorAll('img')];
      await Promise.all(images.map((image) => image.complete ? Promise.resolve() : new Promise<void>((resolve) => { image.addEventListener('load', () => resolve(), { once: true }); image.addEventListener('error', () => resolve(), { once: true }); })));
      const [{ default: html2canvas }, { jsPDF }] = await Promise.all([import('html2canvas'), import('jspdf')]);
      const pdf = new jsPDF({ orientation: 'landscape', unit: 'mm', format: 'a4', compress: true });
      const pages = [...container.querySelectorAll<HTMLElement>('.submission-pdf-page')];
      for (let index = 0; index < pages.length; index += 1) {
        const canvas = await html2canvas(pages[index], { scale: 1.45, backgroundColor: '#111820', useCORS: true, logging: false });
        if (index) pdf.addPage('a4', 'landscape');
        pdf.addImage(canvas.toDataURL('image/jpeg', 0.9), 'JPEG', 0, 0, 297, 210, undefined, 'FAST');
      }
      const version = versionForEpisode(episode);
      pdf.save(`折叠庭院的她_${episode}_剧本v${version?.versionNo || 1}_${workDate.replaceAll('-', '')}_Yoyo视觉参考简报.pdf`);
      setNotice(`${episode}Yoyo看图PDF已下载，共${pages.length}页。`);
    } catch (nextError) {
      setError(nextError instanceof Error ? nextError.message : 'PDF生成失败');
    } finally { setPdfEpisode(''); }
  }

  if (loading) return <section className="control-card flex min-h-64 items-center justify-center gap-3 p-6 text-sm text-muted-foreground"><Loader2 className="h-5 w-5 animate-spin text-[#ff6240]" />正在读取单集版本与提报档案…</section>;

  const readyCount = dailyItems.filter((item) => {
    const detail = detailMap.get(item.id); const itemFiles = filesByItem.get(item.id) || [];
    return Boolean(detail?.assignedTo && detail?.dueAt && detail?.handoffTo && detail?.doneDefinition && activeStatuses.has(detail.status) && itemFiles.length);
  }).length;

  return <section>
    <div className="mb-5 flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between"><div><p className="eyebrow">SINGLE EPISODE SUBMISSION</p><h2 className="mt-1 text-2xl font-semibold">单集提报中心</h2><p className="mt-2 max-w-3xl text-sm leading-6 text-muted-foreground">Lipa提报单集剧本并保存版本；系统拆成当天具体场次，美术逐项上传人物、服装、道具、场景参考，齐套后自动下载提报PDF。</p></div><button onClick={() => void loadAll()} className="grid h-10 w-10 place-items-center rounded-full border border-white/10 bg-white/5 text-muted-foreground" aria-label="刷新提报档案"><RefreshCw className="h-4 w-4" /></button></div>

    <div className="grid gap-4 xl:grid-cols-[1.15fr_.85fr]">
      <section className="control-card p-4 md:p-6"><div className="flex items-start justify-between gap-4"><div><p className="text-sm font-medium">1 · Lipa提报单集剧本</p><p className="mt-1 text-xs leading-5 text-muted-foreground">每次上传都新增版本，不覆盖旧稿；更新说明会随PDF归档。</p></div><FileText className="h-5 w-5 text-[#ff8066]" /></div>
        <div className="mt-4 grid gap-3 sm:grid-cols-[160px_1fr]"><Field label="生产日期"><input type="date" min={PROJECT_START} max={PROJECT_END} value={workDate} onChange={(event) => setWorkDate(event.target.value)} className="edit-input" /></Field><Field label="本次更新说明"><input value={changeSummary} disabled={!me.isAdmin} onChange={(event) => setChangeSummary(event.target.value)} className="edit-input" placeholder="改了哪些场、影响哪些人服道景" /></Field></div>
        <label aria-label="选择整集TXT或DOCX剧本" className={`mt-3 flex min-h-28 items-center justify-center rounded-xl border-2 border-dashed px-4 py-5 text-center ${me.isAdmin ? 'cursor-pointer border-white/15 bg-black/10 hover:border-[#ff6240]/50' : 'border-white/8 bg-black/5 opacity-60'}`}><input aria-label="上传整集剧本文件" type="file" accept=".txt,.docx,text/plain,application/vnd.openxmlformats-officedocument.wordprocessingml.document" disabled={!me.isAdmin || saving} className="sr-only" onChange={(event) => { const next = event.target.files?.[0] || null; setScriptFile(next); setScriptFileName(next?.name || ''); event.target.value = ''; }} /><div><span className="mx-auto grid h-10 w-10 place-items-center rounded-full bg-[#ff6240]/15 text-[#ff8066]"><Upload className="h-4 w-4" /></span><p className="mt-2 text-sm font-medium">{scriptFileName || '选择整集 TXT / DOCX 剧本'}</p><p className="mt-1 text-xs text-muted-foreground">由Lipa操作 · 系统按场头拆场并自动排入当天</p></div></label>
        <Button className="mt-3 h-11 w-full" disabled={!me.isAdmin || !scriptFile || !changeSummary.trim() || saving} onClick={() => void readScriptFile()}>{saving ? <Loader2 className="animate-spin" /> : <Check />}{saving ? '正在存档并拆场…' : '保存新版本并生成当天工作'}</Button>
      </section>

      <section className="control-card p-4 md:p-6"><div className="flex items-start justify-between gap-4"><div><p className="text-sm font-medium">剧本更新档案</p><p className="mt-1 text-xs text-muted-foreground">可展开查看原文、版本更新和提交时间。</p></div><Archive className="h-5 w-5 text-cyan-300" /></div><div className="mt-4 max-h-[330px] space-y-2 overflow-auto pr-1">{versions.length ? versions.map((version) => <details key={version.id} className="rounded-xl border border-white/8 bg-white/[.025] px-3 py-2.5"><summary className="cursor-pointer list-none"><div className="flex items-center justify-between gap-3"><div><p className="text-sm font-medium">{version.episode} · 剧本 v{version.versionNo}</p><p className="mt-1 text-xs text-muted-foreground">{formatDateTime(version.createdAt)} · {version.submittedBy} · {version.sceneCount}场</p></div><span className="rounded-full bg-white/5 px-2 py-1 text-[10px] text-muted-foreground">{version.fileName || '手工录入'}</span></div></summary><div className="mt-3 border-t border-white/8 pt-3"><p className="text-xs leading-5 text-[#ff9a86]">{version.changeSummary || '未填写更新说明'}</p><p className="mt-3 max-h-56 overflow-auto whitespace-pre-wrap rounded-lg bg-black/15 p-3 text-xs leading-5 text-muted-foreground">{version.sourceText}</p></div></details>) : <Empty text="还没有单集剧本版本；由Lipa上传第一版后开始存档。" />}</div></section>
    </div>

    <section className="control-card mt-4 p-4 md:p-6"><div className="flex flex-col gap-3 lg:flex-row lg:items-end lg:justify-between"><div><p className="text-sm font-medium">2 · 安排当天具体场次</p><p className="mt-1 text-xs text-muted-foreground">每个场次会写入当天排产，不再用整集任务代替具体场次。</p></div><div className="flex flex-wrap items-center gap-2">{analyses.map((analysis) => { const selected = selectedIds.includes(analysis.id); const assigned = assignedIds.has(analysis.id); return <button key={analysis.id} disabled={!me.isAdmin || saving} onClick={() => setSelectedIds((current) => selected ? current.filter((id) => id !== analysis.id) : [...current, analysis.id])} className={`rounded-lg border px-3 py-2 text-xs ${selected ? 'border-[#ff6240] bg-[#ff6240]/15 text-white' : assigned ? 'border-emerald-400/25 bg-emerald-400/10 text-emerald-300' : 'border-white/10 bg-white/5 text-muted-foreground'}`}>{assigned ? '已排 ' : selected ? '✓ ' : '□ '}{analysis.episode}·{analysis.sceneNo}场</button>; })}<Button size="sm" disabled={!me.isAdmin || !selectedIds.length || saving} onClick={() => void assignExisting()}><Clock3 />排入{formatDate(workDate)}</Button></div></div></section>

    {notice && <p className="mt-4 rounded-xl border border-emerald-400/20 bg-emerald-400/[.06] px-4 py-3 text-sm text-emerald-300">{notice}</p>}
    {error && <p className="mt-4 rounded-xl border border-red-400/20 bg-red-400/[.06] px-4 py-3 text-sm text-red-300">{error}</p>}

    <div className="mt-7 flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between"><div><p className="eyebrow">DAILY ART PACKAGE</p><h2 className="mt-1 text-xl font-semibold">{formatDate(workDate)} · 人服道景生产与提报</h2><p className="mt-1 text-xs text-muted-foreground">{dailyAnalyses.length}场 · {readyCount}/{dailyItems.length}项齐套 · 默认主美小金18:00交Lipa，可逐项改派</p></div><div className="flex flex-wrap gap-2">{dailyEpisodes.map((episode) => <Button key={episode} variant="outline" disabled={pdfEpisode === episode} onClick={() => void downloadPdf(episode)}>{pdfEpisode === episode ? <Loader2 className="animate-spin" /> : <Download />}{`下载${episode}Yoyo看图PDF`}</Button>)}</div></div>

    <div className="mt-4 space-y-4">{dailyAnalyses.length ? dailyAnalyses.map((analysis) => { const sceneItems = items.filter((item) => item.analysisId === analysis.id).sort((a, b) => a.sortOrder - b.sortOrder); return <article key={analysis.id} className="control-card p-4 md:p-5"><div className="border-b border-white/8 pb-4"><p className="text-xs text-[#ff8066]">{analysis.episode} · 第{analysis.sceneNo}场</p><h3 className="mt-1 text-lg font-medium">{analysis.sceneTitle}</h3><p className="mt-1 text-sm leading-6 text-muted-foreground">{analysis.location} · {analysis.sceneSummary}</p></div><div className="mt-4 grid gap-3 xl:grid-cols-2">{sceneItems.map((item) => <SubmissionItemCard key={item.id} item={item} detail={detailMap.get(item.id)} files={filesByItem.get(item.id) || []} defaultDueAt={`${workDate}T18:00`} canEdit={canEditArt} isAdmin={me.isAdmin} currentName={me.name} onUpload={uploadImage} onSave={saveDetail} onDeleteFile={deleteFile} />)}</div></article>; }) : <Empty text={`${formatDate(workDate)}还没有具体场次。Lipa上传单集剧本，或在上方选择场次排入当天。`} />}</div>

    <div className="submission-pdf-source" aria-hidden="true">{dailyEpisodes.map((episode) => <SubmissionPdfSource key={episode} id={`submission-pdf-${episode.replace(/\W/g, '')}`} episode={episode} workDate={workDate} version={versionForEpisode(episode)} analyses={dailyAnalyses.filter((analysis) => analysis.episode === episode)} items={items} filesByItem={filesByItem} />)}</div>
  </section>;
}

function SubmissionItemCard({ item, detail, files, defaultDueAt, canEdit, isAdmin, currentName, onUpload, onSave, onDeleteFile }: { item: ScriptAssetItem; detail?: SubmissionDetail; files: SubmissionFile[]; defaultDueAt: string; canEdit: boolean; isAdmin: boolean; currentName: string; onUpload: (itemId: string, file: File) => Promise<void>; onSave: (itemId: string, changes: Partial<SubmissionDetail>) => Promise<void>; onDeleteFile: (file: SubmissionFile) => Promise<void> }) {
  const [draft, setDraft] = useState({ assignedTo: detail?.assignedTo || (canEdit ? currentName : '主美小金'), dueAt: detail?.dueAt || defaultDueAt, handoffTo: detail?.handoffTo || 'Lipa', doneDefinition: detail?.doneDefinition || item.visualBrief, status: detail?.status || '待上传', submissionNote: detail?.submissionNote || '', reviewNote: detail?.reviewNote || '' });
  const [saving, setSaving] = useState(false);
  const [uploading, setUploading] = useState(false);
  const [error, setError] = useState('');
  useEffect(() => { setDraft({ assignedTo: detail?.assignedTo || (canEdit ? currentName : '主美小金'), dueAt: detail?.dueAt || defaultDueAt, handoffTo: detail?.handoffTo || 'Lipa', doneDefinition: detail?.doneDefinition || item.visualBrief, status: detail?.status || '待上传', submissionNote: detail?.submissionNote || '', reviewNote: detail?.reviewNote || '' }); }, [detail, defaultDueAt, item.visualBrief, canEdit, currentName]);
  async function upload(file: File) { setUploading(true); setError(''); try { await onUpload(item.id, file); setDraft((current) => ({ ...current, status: '已上传' })); } catch (nextError) { setError(nextError instanceof Error ? nextError.message : '上传失败'); } finally { setUploading(false); } }
  async function save(nextStatus?: string) { setSaving(true); setError(''); try { const next = { ...draft, status: nextStatus || draft.status }; await onSave(item.id, next); setDraft(next); } catch (nextError) { setError(nextError instanceof Error ? nextError.message : '保存失败'); } finally { setSaving(false); } }
  return <section className={`rounded-xl border p-3 ${detail?.status === '打回' || detail?.status === '需复核' ? 'border-red-400/35 bg-red-400/[.04]' : detail?.status === '已锁定' ? 'border-emerald-400/30 bg-emerald-400/[.04]' : 'border-white/10 bg-white/[.025]'}`}><div className="flex items-start justify-between gap-3"><div><span className="rounded-md bg-white/6 px-2 py-0.5 text-[10px] text-muted-foreground">{item.category}</span><h4 className="mt-2 text-sm font-medium">{item.name}</h4></div><span className="rounded-full border border-white/10 px-2 py-1 text-[10px] text-muted-foreground">{detail?.status || '待上传'}</span></div><p className="mt-2 text-xs leading-5 text-zinc-300">{item.detail}</p><p className="mt-2 border-t border-white/6 pt-2 text-xs leading-5 text-muted-foreground">需要出：{item.visualBrief}</p>
    <div className="mt-3 grid grid-cols-2 gap-2 sm:grid-cols-3">{files.map((file) => <div key={file.id} className="group relative overflow-hidden rounded-lg border border-white/10 bg-black/20"><img src={file.url} alt={`${item.name}·${file.fileName}`} className="aspect-[4/3] w-full object-cover" /><div title={file.fileName} className="min-h-10 px-2 py-1.5 text-[11px] leading-4 text-zinc-300">{file.fileName}</div>{canEdit && <button onClick={() => void onDeleteFile(file).catch((nextError) => setError(nextError instanceof Error ? nextError.message : '删除失败'))} aria-label={`删除${file.fileName}`} className="absolute right-1 top-1 grid h-7 w-7 place-items-center rounded-full bg-black/75 text-zinc-300 opacity-100 sm:opacity-0 sm:group-hover:opacity-100"><Trash2 className="h-3.5 w-3.5" /></button>}</div>)}{canEdit && <label aria-label={`为${item.name}增加参考图`} className="flex aspect-[4/3] cursor-pointer flex-col items-center justify-center rounded-lg border border-dashed border-white/15 bg-black/10 text-xs text-muted-foreground hover:border-[#ff6240]/50"><input aria-label={`上传${item.name}参考图`} type="file" accept="image/jpeg,image/png,image/webp" disabled={uploading} className="sr-only" onChange={(event) => { const file = event.target.files?.[0]; if (file) void upload(file); event.target.value = ''; }} />{uploading ? <Loader2 className="h-4 w-4 animate-spin" /> : <ImagePlus className="h-4 w-4" />}<span className="mt-1">{uploading ? '上传中' : '加参考图'}</span></label>}</div>
    <div className="mt-3 grid gap-2 sm:grid-cols-2"><Field label="具体责任人"><input disabled={!canEdit} value={draft.assignedTo} onChange={(event) => setDraft((current) => ({ ...current, assignedTo: event.target.value }))} className="edit-input" /></Field><Field label="精确截止时间"><input type="datetime-local" disabled={!canEdit} value={draft.dueAt} onChange={(event) => setDraft((current) => ({ ...current, dueAt: event.target.value }))} className="edit-input" /></Field><Field label="下一交接人"><input disabled={!canEdit} value={draft.handoffTo} onChange={(event) => setDraft((current) => ({ ...current, handoffTo: event.target.value }))} className="edit-input" /></Field><Field label="提交状态"><select disabled={!canEdit} value={draft.status} onChange={(event) => setDraft((current) => ({ ...current, status: event.target.value }))} className="edit-input">{(isAdmin ? ['待上传', '已上传', '待审核', '打回', '已锁定', '需复核'] : ['待上传', '已上传', '待审核', '需复核']).map((status) => <option key={status}>{status}</option>)}</select></Field></div>
    <div className="mt-2"><Field label="完成定义"><Textarea disabled={!canEdit} rows={2} value={draft.doneDefinition} onChange={(event) => setDraft((current) => ({ ...current, doneDefinition: event.target.value }))} /></Field></div><div className="mt-2"><Field label="采用说明"><Textarea disabled={!canEdit} rows={2} value={draft.submissionNote} onChange={(event) => setDraft((current) => ({ ...current, submissionNote: event.target.value }))} placeholder="写清具体采用哪种造型、颜色、材质或空间方案" /></Field></div>{isAdmin && <div className="mt-2"><Field label="Lipa审核／打回意见"><Textarea rows={2} value={draft.reviewNote} onChange={(event) => setDraft((current) => ({ ...current, reviewNote: event.target.value }))} placeholder="打回时写清具体改什么和新的时间节点" /></Field></div>}
    {error && <p className="mt-2 text-xs text-red-300">{error}</p>}{canEdit && <div className="mt-3 flex flex-wrap justify-end gap-2">{isAdmin && <><Button size="sm" variant="destructive" disabled={saving || !draft.reviewNote.trim()} onClick={() => void save('打回')}><X />打回</Button><Button size="sm" variant="outline" disabled={saving || !files.length} onClick={() => void save('已锁定')}><Check />锁定</Button></>}<Button size="sm" disabled={saving} onClick={() => void save()}>{saving ? <Loader2 className="animate-spin" /> : <Check />}{saving ? '保存中' : '保存责任与节点'}</Button></div>}</section>;
}

function SubmissionPdfSource({ id, episode, workDate, version, analyses, items, filesByItem }: { id: string; episode: string; workDate: string; version?: ScriptVersion; analyses: ScriptAnalysis[]; items: ScriptAssetItem[]; filesByItem: Map<string, SubmissionFile[]> }) {
  const episodeIds = new Set(analyses.map((analysis) => analysis.id));
  const episodeItems = items.filter((item) => episodeIds.has(item.analysisId) && ['人物', '服装', '场景'].includes(item.category));
  const referenceCount = episodeItems.reduce((total, item) => total + (filesByItem.get(item.id)?.length || 0), 0);
  const referencePages: Array<{ analysis: ScriptAnalysis; entries: Array<{ item: ScriptAssetItem; file: SubmissionFile }>; pageIndex: number; pageCount: number; sceneReferenceCount: number }> = [];
  for (const analysis of analyses) {
    const entries = episodeItems
      .filter((item) => item.analysisId === analysis.id)
      .flatMap((item) => (filesByItem.get(item.id) || []).map((file) => ({ item, file })));
    const groups = chunk(entries, 6);
    groups.forEach((pageEntries, index) => referencePages.push({ analysis, entries: pageEntries, pageIndex: index + 1, pageCount: groups.length, sceneReferenceCount: entries.length }));
  }
  return <div id={id}><PdfPage><div className="pt-24 text-center"><p className="text-[15px] tracking-[.24em] text-[#ff8066]">VISUAL REFERENCE</p><h1 className="mt-6 text-[50px] font-semibold text-white">折叠庭院的她</h1><h2 className="mt-3 text-[28px] font-medium text-white/90">{episode} · Yoyo视觉参考简报</h2><div className="mx-auto mt-6 w-fit rounded-full border border-white/20 bg-black/35 px-5 py-2 text-[13px] font-medium text-white/85">看情节 · 看人物 · 看场景</div><div className="mx-auto mt-10 grid w-[690px] grid-cols-4 gap-px overflow-hidden rounded-xl bg-white/15 text-left"><PdfMeta label="剧本版本" value={`v${version?.versionNo || 1}`} /><PdfMeta label="整理日期" value={workDate} /><PdfMeta label="场次" value={`${analyses.length}场`} /><PdfMeta label="参考图片" value={`${referenceCount}张`} /></div><p className="mx-auto mt-7 w-[700px] text-[14px] leading-6 text-white/75">每场只保留一句情节和已上传的视觉参考。所有 Option 供 Yoyo 快速审核选择，不代表最终锁定。</p></div><PdfFooter episode={episode} page={1} /></PdfPage>
    {referencePages.map((page, index) => <PdfPage key={`${page.analysis.id}-refs-${page.pageIndex}`}><PdfHeader eyebrow={`${episode} · 第${page.analysis.sceneNo}场`} title={simpleSceneSummary(page.analysis)} subtitle={`人物／服装／场景参考 · 第${page.pageIndex}/${page.pageCount}页 · 本场${page.sceneReferenceCount}张`} /><div className="mt-4 grid grid-cols-3 gap-4">{page.entries.map(({ item, file }) => <figure key={file.id} className="rounded-xl border border-white/15 bg-black/45 p-2.5 shadow-2xl"><img src={file.url} alt={file.fileName} className="h-[205px] w-full rounded-lg bg-black/30 object-contain" /><figcaption className="mt-1.5 text-center text-[11px] leading-5 text-white/80">{friendlyReferenceLabel(item, file)}</figcaption></figure>)}</div><PdfFooter episode={episode} page={index + 2} /></PdfPage>)}
  </div>;
}

function PdfPage({ children }: { children: React.ReactNode }) { return <section className="submission-pdf-page relative overflow-hidden px-[44px] py-[38px] text-white" style={{ backgroundImage: "url('/folded-courtyard-bg.jpg')", backgroundPosition: 'center', backgroundSize: 'cover' }}><div className="absolute inset-0 bg-[#071019]/80" /><div className="relative z-10 h-full">{children}</div></section>; }
function PdfHeader({ eyebrow, title, subtitle }: { eyebrow: string; title: string; subtitle: string }) { return <header className="border-b border-white/25 pb-3"><p className="text-[12px] font-medium tracking-[.18em] text-[#ff8066]">{eyebrow}</p><h2 className="mt-1 text-[26px] font-semibold text-white">{title}</h2><p className="mt-1 text-[12px] text-white/65">{subtitle}</p></header>; }
function PdfFooter({ episode, page }: { episode: string; page: number }) { return <footer className="absolute inset-x-0 bottom-0 flex justify-between border-t border-white/20 pt-2 text-[9px] text-white/55"><span>《折叠庭院的她》 · {episode} · Yoyo视觉参考简报</span><span>第 {page} 页</span></footer>; }
function PdfMeta({ label, value }: { label: string; value: string }) { return <div className="bg-black/45 p-4"><p className="text-[10px] text-white/55">{label}</p><p className="mt-1 text-[15px] font-medium text-white">{value}</p></div>; }
function Field({ label, children }: { label: string; children: React.ReactNode }) { return <label className="block"><span className="mb-1.5 block text-xs text-muted-foreground">{label}</span>{children}</label>; }
function Empty({ text }: { text: string }) { return <div className="rounded-xl border border-dashed border-white/10 px-5 py-10 text-center text-sm leading-6 text-muted-foreground">{text}</div>; }
function chunk<T>(values: T[], size: number) { const chunks: T[][] = []; for (let index = 0; index < values.length; index += size) chunks.push(values.slice(index, index + size)); return chunks; }
function simpleSceneSummary(analysis: ScriptAnalysis) {
  const summaries: Record<number, string> = {
    1: '女主穿着替身服装，被群演扮演的丧尸追打。',
    2: '女主在片场救下一只受伤的白鸽，第一次付出白发的代价。',
    3: '女主救下陆文川，并预见他今晚会死亡。',
    4: '火警发生，女主放弃离开，冲进火场救陆文川。',
    5: '陆文川落水，女主在六十秒内将他救活。',
    6: '有人删除事故监控，只留下女主救人的视频。',
    7: '陆文川醒来，开始寻找女主并追查缺失的一分钟。',
    8: '女主回到姑妈面摊后突然爆红，前夫和神秘人同时盯上她。',
  };
  return summaries[analysis.sceneNo] || analysis.sceneSummary;
}
function friendlyReferenceLabel(item: ScriptAssetItem, file: SubmissionFile) {
  return /^[a-f\d]{24,}\.(?:jpe?g|png|webp)$/i.test(file.fileName) ? item.name : file.fileName;
}
function formatDate(value: string) { if (!value) return '未定日期'; const [, month, day] = value.split('-'); return `${Number(month)}月${Number(day)}日`; }
function formatDateTime(value: string) { if (!value) return '未记录'; return value.replace('T', ' ').slice(0, 16); }

async function prepareImageForUpload(file: File) {
  if (file.size <= 1_400_000) return file;
  const objectUrl = URL.createObjectURL(file);
  try {
    const source = await new Promise<HTMLImageElement>((resolve, reject) => {
      const image = new Image();
      image.onload = () => resolve(image);
      image.onerror = () => reject(new Error('无法读取这张图片'));
      image.src = objectUrl;
    });
    const maxSide = 1600;
    const scale = Math.min(1, maxSide / Math.max(source.naturalWidth, source.naturalHeight));
    const canvas = document.createElement('canvas');
    canvas.width = Math.max(1, Math.round(source.naturalWidth * scale));
    canvas.height = Math.max(1, Math.round(source.naturalHeight * scale));
    const context = canvas.getContext('2d');
    if (!context) throw new Error('图片压缩失败');
    context.drawImage(source, 0, 0, canvas.width, canvas.height);
    const blob = await new Promise<Blob | null>((resolve) => canvas.toBlob(resolve, 'image/jpeg', 0.82));
    if (!blob) throw new Error('图片压缩失败');
    const baseName = file.name.replace(/\.[^.]+$/, '');
    return new File([blob], `${baseName}-web.jpg`, { type: 'image/jpeg' });
  } finally {
    URL.revokeObjectURL(objectUrl);
  }
}
