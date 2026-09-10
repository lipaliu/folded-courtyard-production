'use client';

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
    const form = new FormData(); form.append('itemId', itemId); form.append('file', file);
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
    const missing = completenessForEpisode(episode);
    if (missing.length) { setError(`正式PDF仍缺${missing.length}项：${missing.slice(0, 3).join('；')}${missing.length > 3 ? '……' : ''}`); return; }
    setPdfEpisode(episode); setError('');
    try {
      await document.fonts.ready;
      const container = document.getElementById(`submission-pdf-${episode.replace(/\W/g, '')}`);
      if (!container) throw new Error('PDF版式没有准备好');
      const images = [...container.querySelectorAll('img')];
      await Promise.all(images.map((image) => image.complete ? Promise.resolve() : new Promise<void>((resolve) => { image.addEventListener('load', () => resolve(), { once: true }); image.addEventListener('error', () => resolve(), { once: true }); })));
      const [{ default: html2canvas }, { jsPDF }] = await Promise.all([import('html2canvas'), import('jspdf')]);
      const pdf = new jsPDF({ orientation: 'portrait', unit: 'mm', format: 'a4', compress: true });
      const pages = [...container.querySelectorAll<HTMLElement>('.submission-pdf-page')];
      for (let index = 0; index < pages.length; index += 1) {
        const canvas = await html2canvas(pages[index], { scale: 1.45, backgroundColor: '#ffffff', useCORS: true, logging: false });
        if (index) pdf.addPage('a4', 'portrait');
        pdf.addImage(canvas.toDataURL('image/jpeg', 0.9), 'JPEG', 0, 0, 210, 297, undefined, 'FAST');
      }
      const version = versionForEpisode(episode);
      pdf.save(`折叠庭院的她_${episode}_剧本v${version?.versionNo || 1}_${workDate.replaceAll('-', '')}_人服道景提报.pdf`);
      setNotice(`${episode}提报PDF已下载，共${pages.length}页；申报日期为${workDate}。`);
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
        <label className={`mt-3 flex min-h-28 items-center justify-center rounded-xl border-2 border-dashed px-4 py-5 text-center ${me.isAdmin ? 'cursor-pointer border-white/15 bg-black/10 hover:border-[#ff6240]/50' : 'border-white/8 bg-black/5 opacity-60'}`}><input type="file" accept=".txt,.docx,text/plain,application/vnd.openxmlformats-officedocument.wordprocessingml.document" disabled={!me.isAdmin || saving} className="sr-only" onChange={(event) => { const next = event.target.files?.[0] || null; setScriptFile(next); setScriptFileName(next?.name || ''); event.target.value = ''; }} /><div><span className="mx-auto grid h-10 w-10 place-items-center rounded-full bg-[#ff6240]/15 text-[#ff8066]"><Upload className="h-4 w-4" /></span><p className="mt-2 text-sm font-medium">{scriptFileName || '选择整集 TXT / DOCX 剧本'}</p><p className="mt-1 text-xs text-muted-foreground">由Lipa操作 · 系统按场头拆场并自动排入当天</p></div></label>
        <Button className="mt-3 h-11 w-full" disabled={!me.isAdmin || !scriptFile || !changeSummary.trim() || saving} onClick={() => void readScriptFile()}>{saving ? <Loader2 className="animate-spin" /> : <Check />}{saving ? '正在存档并拆场…' : '保存新版本并生成当天工作'}</Button>
      </section>

      <section className="control-card p-4 md:p-6"><div className="flex items-start justify-between gap-4"><div><p className="text-sm font-medium">剧本更新档案</p><p className="mt-1 text-xs text-muted-foreground">可展开查看原文、版本更新和提交时间。</p></div><Archive className="h-5 w-5 text-cyan-300" /></div><div className="mt-4 max-h-[330px] space-y-2 overflow-auto pr-1">{versions.length ? versions.map((version) => <details key={version.id} className="rounded-xl border border-white/8 bg-white/[.025] px-3 py-2.5"><summary className="cursor-pointer list-none"><div className="flex items-center justify-between gap-3"><div><p className="text-sm font-medium">{version.episode} · 剧本 v{version.versionNo}</p><p className="mt-1 text-xs text-muted-foreground">{formatDateTime(version.createdAt)} · {version.submittedBy} · {version.sceneCount}场</p></div><span className="rounded-full bg-white/5 px-2 py-1 text-[10px] text-muted-foreground">{version.fileName || '手工录入'}</span></div></summary><div className="mt-3 border-t border-white/8 pt-3"><p className="text-xs leading-5 text-[#ff9a86]">{version.changeSummary || '未填写更新说明'}</p><p className="mt-3 max-h-56 overflow-auto whitespace-pre-wrap rounded-lg bg-black/15 p-3 text-xs leading-5 text-muted-foreground">{version.sourceText}</p></div></details>) : <Empty text="还没有单集剧本版本；由Lipa上传第一版后开始存档。" />}</div></section>
    </div>

    <section className="control-card mt-4 p-4 md:p-6"><div className="flex flex-col gap-3 lg:flex-row lg:items-end lg:justify-between"><div><p className="text-sm font-medium">2 · 安排当天具体场次</p><p className="mt-1 text-xs text-muted-foreground">每个场次会写入当天排产，不再用整集任务代替具体场次。</p></div><div className="flex flex-wrap items-center gap-2">{analyses.map((analysis) => { const selected = selectedIds.includes(analysis.id); const assigned = assignedIds.has(analysis.id); return <button key={analysis.id} disabled={!me.isAdmin || saving} onClick={() => setSelectedIds((current) => selected ? current.filter((id) => id !== analysis.id) : [...current, analysis.id])} className={`rounded-lg border px-3 py-2 text-xs ${selected ? 'border-[#ff6240] bg-[#ff6240]/15 text-white' : assigned ? 'border-emerald-400/25 bg-emerald-400/10 text-emerald-300' : 'border-white/10 bg-white/5 text-muted-foreground'}`}>{assigned ? '已排 ' : selected ? '✓ ' : '□ '}{analysis.episode}·{analysis.sceneNo}场</button>; })}<Button size="sm" disabled={!me.isAdmin || !selectedIds.length || saving} onClick={() => void assignExisting()}><Clock3 />排入{formatDate(workDate)}</Button></div></div></section>

    {notice && <p className="mt-4 rounded-xl border border-emerald-400/20 bg-emerald-400/[.06] px-4 py-3 text-sm text-emerald-300">{notice}</p>}
    {error && <p className="mt-4 rounded-xl border border-red-400/20 bg-red-400/[.06] px-4 py-3 text-sm text-red-300">{error}</p>}

    <div className="mt-7 flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between"><div><p className="eyebrow">DAILY ART PACKAGE</p><h2 className="mt-1 text-xl font-semibold">{formatDate(workDate)} · 人服道景生产与提报</h2><p className="mt-1 text-xs text-muted-foreground">{dailyAnalyses.length}场 · {readyCount}/{dailyItems.length}项齐套 · 默认主美小金18:00交Lipa，可逐项改派</p></div><div className="flex flex-wrap gap-2">{dailyEpisodes.map((episode) => { const missing = completenessForEpisode(episode); return <Button key={episode} variant={missing.length ? 'outline' : 'default'} disabled={Boolean(missing.length) || pdfEpisode === episode} onClick={() => void downloadPdf(episode)}>{pdfEpisode === episode ? <Loader2 className="animate-spin" /> : <Download />}{missing.length ? `${episode}缺${missing.length}项` : `下载${episode}提报PDF`}</Button>; })}</div></div>

    <div className="mt-4 space-y-4">{dailyAnalyses.length ? dailyAnalyses.map((analysis) => { const sceneItems = items.filter((item) => item.analysisId === analysis.id).sort((a, b) => a.sortOrder - b.sortOrder); return <article key={analysis.id} className="control-card p-4 md:p-5"><div className="border-b border-white/8 pb-4"><p className="text-xs text-[#ff8066]">{analysis.episode} · 第{analysis.sceneNo}场</p><h3 className="mt-1 text-lg font-medium">{analysis.sceneTitle}</h3><p className="mt-1 text-sm leading-6 text-muted-foreground">{analysis.location} · {analysis.sceneSummary}</p></div><div className="mt-4 grid gap-3 xl:grid-cols-2">{sceneItems.map((item) => <SubmissionItemCard key={item.id} item={item} detail={detailMap.get(item.id)} files={filesByItem.get(item.id) || []} defaultDueAt={`${workDate}T18:00`} canEdit={canEditArt} isAdmin={me.isAdmin} currentName={me.name} onUpload={uploadImage} onSave={saveDetail} onDeleteFile={deleteFile} />)}</div></article>; }) : <Empty text={`${formatDate(workDate)}还没有具体场次。Lipa上传单集剧本，或在上方选择场次排入当天。`} />}</div>

    <div className="submission-pdf-source" aria-hidden="true">{dailyEpisodes.map((episode) => <SubmissionPdfSource key={episode} id={`submission-pdf-${episode.replace(/\W/g, '')}`} episode={episode} workDate={workDate} version={versionForEpisode(episode)} analyses={dailyAnalyses.filter((analysis) => analysis.episode === episode)} items={items} detailMap={detailMap} filesByItem={filesByItem} />)}</div>
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
    <div className="mt-3 grid grid-cols-2 gap-2 sm:grid-cols-3">{files.map((file) => <div key={file.id} className="group relative overflow-hidden rounded-lg border border-white/10 bg-black/20"><img src={file.url} alt={`${item.name}参考图`} className="aspect-[4/3] w-full object-cover" /><div className="truncate px-2 py-1 text-[10px] text-muted-foreground">{file.fileName}</div>{canEdit && <button onClick={() => void onDeleteFile(file).catch((nextError) => setError(nextError instanceof Error ? nextError.message : '删除失败'))} aria-label={`删除${file.fileName}`} className="absolute right-1 top-1 grid h-7 w-7 place-items-center rounded-full bg-black/75 text-zinc-300 opacity-100 sm:opacity-0 sm:group-hover:opacity-100"><Trash2 className="h-3.5 w-3.5" /></button>}</div>)}{canEdit && <label className="flex aspect-[4/3] cursor-pointer flex-col items-center justify-center rounded-lg border border-dashed border-white/15 bg-black/10 text-xs text-muted-foreground hover:border-[#ff6240]/50"><input type="file" accept="image/jpeg,image/png,image/webp" disabled={uploading} className="sr-only" onChange={(event) => { const file = event.target.files?.[0]; if (file) void upload(file); event.target.value = ''; }} />{uploading ? <Loader2 className="h-4 w-4 animate-spin" /> : <ImagePlus className="h-4 w-4" />}<span className="mt-1">{uploading ? '上传中' : '加参考图'}</span></label>}</div>
    <div className="mt-3 grid gap-2 sm:grid-cols-2"><Field label="具体责任人"><input disabled={!canEdit} value={draft.assignedTo} onChange={(event) => setDraft((current) => ({ ...current, assignedTo: event.target.value }))} className="edit-input" /></Field><Field label="精确截止时间"><input type="datetime-local" disabled={!canEdit} value={draft.dueAt} onChange={(event) => setDraft((current) => ({ ...current, dueAt: event.target.value }))} className="edit-input" /></Field><Field label="下一交接人"><input disabled={!canEdit} value={draft.handoffTo} onChange={(event) => setDraft((current) => ({ ...current, handoffTo: event.target.value }))} className="edit-input" /></Field><Field label="提交状态"><select disabled={!canEdit} value={draft.status} onChange={(event) => setDraft((current) => ({ ...current, status: event.target.value }))} className="edit-input">{(isAdmin ? ['待上传', '已上传', '待审核', '打回', '已锁定', '需复核'] : ['待上传', '已上传', '待审核', '需复核']).map((status) => <option key={status}>{status}</option>)}</select></Field></div>
    <div className="mt-2"><Field label="完成定义"><Textarea disabled={!canEdit} rows={2} value={draft.doneDefinition} onChange={(event) => setDraft((current) => ({ ...current, doneDefinition: event.target.value }))} /></Field></div><div className="mt-2"><Field label="采用说明"><Textarea disabled={!canEdit} rows={2} value={draft.submissionNote} onChange={(event) => setDraft((current) => ({ ...current, submissionNote: event.target.value }))} placeholder="写清具体采用哪种造型、颜色、材质或空间方案" /></Field></div>{isAdmin && <div className="mt-2"><Field label="Lipa审核／打回意见"><Textarea rows={2} value={draft.reviewNote} onChange={(event) => setDraft((current) => ({ ...current, reviewNote: event.target.value }))} placeholder="打回时写清具体改什么和新的时间节点" /></Field></div>}
    {error && <p className="mt-2 text-xs text-red-300">{error}</p>}{canEdit && <div className="mt-3 flex flex-wrap justify-end gap-2">{isAdmin && <><Button size="sm" variant="destructive" disabled={saving || !draft.reviewNote.trim()} onClick={() => void save('打回')}><X />打回</Button><Button size="sm" variant="outline" disabled={saving || !files.length} onClick={() => void save('已锁定')}><Check />锁定</Button></>}<Button size="sm" disabled={saving} onClick={() => void save()}>{saving ? <Loader2 className="animate-spin" /> : <Check />}{saving ? '保存中' : '保存责任与节点'}</Button></div>}</section>;
}

function SubmissionPdfSource({ id, episode, workDate, version, analyses, items, detailMap, filesByItem }: { id: string; episode: string; workDate: string; version?: ScriptVersion; analyses: ScriptAnalysis[]; items: ScriptAssetItem[]; detailMap: Map<string, SubmissionDetail>; filesByItem: Map<string, SubmissionFile[]> }) {
  const episodeIds = new Set(analyses.map((analysis) => analysis.id));
  const episodeItems = items.filter((item) => episodeIds.has(item.analysisId));
  const detailPages: Array<{ analysis: ScriptAnalysis; category: string; rows: ScriptAssetItem[]; pageIndex: number; pageCount: number }> = [];
  for (const analysis of analyses) for (const category of categories) {
    const rows = episodeItems.filter((item) => item.analysisId === analysis.id && item.category === category);
    const chunks = chunk(rows, 2);
    chunks.forEach((chunkRows, index) => detailPages.push({ analysis, category, rows: chunkRows, pageIndex: index + 1, pageCount: chunks.length }));
  }
  return <div id={id}><PdfPage><div className="pt-32 text-center"><p className="text-[18px] tracking-[.32em] text-[#ef5c40]">PRODUCTION SUBMISSION</p><h1 className="mt-8 text-[48px] font-semibold">折叠庭院的她</h1><h2 className="mt-5 text-[30px] font-medium">{episode} · 人服道景提报</h2><div className="mx-auto mt-16 grid w-[620px] grid-cols-2 gap-px overflow-hidden rounded-xl bg-[#d9dce1] text-left"><PdfMeta label="剧本版本" value={`v${version?.versionNo || 1}`} /><PdfMeta label="申报日期" value={workDate} /><PdfMeta label="提报人" value={version?.submittedBy || 'Lipa'} /><PdfMeta label="审核对象" value="叶总、Yoyo" /><PdfMeta label="场次数" value={`${analyses.length}场`} /><PdfMeta label="工作项" value={`${episodeItems.length}项`} /></div><div className="mx-auto mt-12 w-[620px] border-t border-[#d9dce1] pt-6 text-left"><p className="text-[15px] font-medium text-[#ef5c40]">本次更新</p><p className="mt-3 text-[16px] leading-7 text-[#454b55]">{version?.changeSummary || '首次单集提报'}</p></div></div><PdfFooter episode={episode} page={1} /></PdfPage>
    <PdfPage><PdfHeader eyebrow={`${episode} · DAILY OVERVIEW`} title="场次与责任总览" subtitle={`${workDate}申报 · 基于剧本v${version?.versionNo || 1}`} /><div className="mt-8 space-y-4">{analyses.map((analysis) => { const rows = episodeItems.filter((item) => item.analysisId === analysis.id); const owners = [...new Set(rows.map((item) => detailMap.get(item.id)?.assignedTo).filter(Boolean))]; const dues = [...new Set(rows.map((item) => detailMap.get(item.id)?.dueAt).filter(Boolean))]; return <div key={analysis.id} className="rounded-xl border border-[#dfe2e7] p-5"><div className="flex justify-between gap-5"><div><p className="text-[14px] font-medium text-[#ef5c40]">第{analysis.sceneNo}场</p><h3 className="mt-1 text-[21px] font-semibold">{analysis.sceneTitle}</h3><p className="mt-1 text-[13px] text-[#747b86]">{analysis.location}</p></div><div className="text-right text-[13px] leading-6 text-[#555c67]"><p>{categories.map((category) => `${category}${rows.filter((item) => item.category === category).length}`).join(' · ')}</p><p>{owners.join('、') || '待分配'} · {dues.join('、') || '待定时'}</p></div></div><p className="mt-4 border-t border-[#eceef1] pt-4 text-[14px] leading-6 text-[#3f4650]">{analysis.sceneSummary}</p></div>; })}</div><PdfFooter episode={episode} page={2} /></PdfPage>
    {detailPages.map((page, index) => <PdfPage key={`${page.analysis.id}-${page.category}-${page.pageIndex}`}><PdfHeader eyebrow={`${episode} · 第${page.analysis.sceneNo}场`} title={page.analysis.sceneTitle} subtitle={`${page.analysis.location} · ${page.category}${page.pageCount > 1 ? ` ${page.pageIndex}/${page.pageCount}` : ''}`} /><p className="mt-5 rounded-lg bg-[#f4f5f7] p-4 text-[13px] leading-6 text-[#555c67]">{page.analysis.sceneSummary}</p><div className="mt-5 space-y-4">{page.rows.map((item) => { const detail = detailMap.get(item.id); const itemFiles = filesByItem.get(item.id) || []; return <div key={item.id} className="rounded-xl border border-[#dfe2e7] p-5"><div className="flex items-start justify-between gap-4"><div><span className="rounded bg-[#fff0ec] px-2 py-1 text-[11px] text-[#d84f34]">{item.category}</span><h3 className="mt-2 text-[20px] font-semibold">{item.name}</h3></div><span className="rounded-full border border-[#dfe2e7] px-3 py-1 text-[12px] text-[#555c67]">{detail?.status || '待上传'}</span></div><p className="mt-3 text-[14px] leading-6 text-[#353b44]">{item.detail}</p>{detail?.submissionNote && <p className="mt-2 text-[13px] leading-6 text-[#ef5c40]">采用：{detail.submissionNote}</p>}<div className="mt-4 grid grid-cols-3 gap-3">{itemFiles.slice(0, 3).map((file) => <img key={file.id} src={file.url} alt="" className="h-[150px] w-full rounded-lg bg-[#f2f3f5] object-contain" />)}</div><div className="mt-4 grid grid-cols-2 gap-x-5 gap-y-1 border-t border-[#eceef1] pt-3 text-[12px] leading-5 text-[#68707c]"><p>责任人：{detail?.assignedTo}</p><p>截止：{formatDateTime(detail?.dueAt || '')}</p><p>交接给：{detail?.handoffTo}</p><p>上传：{formatDateTime(detail?.submittedAt || '')}</p><p className="col-span-2">完成定义：{detail?.doneDefinition}</p>{detail?.reviewNote && <p className="col-span-2 text-[#d84f34]">审核意见：{detail.reviewNote}</p>}</div></div>; })}</div><PdfFooter episode={episode} page={index + 3} /></PdfPage>)}
    <PdfPage><PdfHeader eyebrow={`${episode} · ARCHIVE`} title="版本与审核记录" subtitle={`剧本v${version?.versionNo || 1} · ${workDate}`} /><div className="mt-10 rounded-xl border border-[#dfe2e7] p-6"><h3 className="text-[18px] font-semibold">剧本更新说明</h3><p className="mt-4 text-[15px] leading-7 text-[#3f4650]">{version?.changeSummary || '首次单集提报'}</p></div><div className="mt-6 rounded-xl bg-[#f4f5f7] p-6"><h3 className="text-[18px] font-semibold">提报完整性</h3><p className="mt-4 text-[15px] leading-7 text-[#3f4650]">共{analyses.length}场、{episodeItems.length}项。人物、服装、道具、场景、参考图、具体责任人、截止时间、下一交接人与申报日期均已写入本提报。</p></div><div className="mt-8 grid grid-cols-2 gap-4"><div className="h-32 rounded-xl border border-[#dfe2e7] p-5"><p className="text-[13px] text-[#747b86]">Lipa提报／检查</p><p className="mt-6 text-[15px]">时间：________________</p></div><div className="h-32 rounded-xl border border-[#dfe2e7] p-5"><p className="text-[13px] text-[#747b86]">叶总／Yoyo整集确认</p><p className="mt-6 text-[15px]">结果：________________</p></div></div><PdfFooter episode={episode} page={detailPages.length + 3} /></PdfPage>
  </div>;
}

function PdfPage({ children }: { children: React.ReactNode }) { return <section className="submission-pdf-page relative bg-white px-[58px] py-[54px] text-[#1d2128]">{children}</section>; }
function PdfHeader({ eyebrow, title, subtitle }: { eyebrow: string; title: string; subtitle: string }) { return <header className="border-b-2 border-[#1f232a] pb-5"><p className="text-[13px] font-medium tracking-[.18em] text-[#ef5c40]">{eyebrow}</p><h2 className="mt-2 text-[30px] font-semibold">{title}</h2><p className="mt-2 text-[13px] text-[#747b86]">{subtitle}</p></header>; }
function PdfFooter({ episode, page }: { episode: string; page: number }) { return <footer className="absolute inset-x-[58px] bottom-[35px] flex justify-between border-t border-[#dfe2e7] pt-3 text-[10px] text-[#8b919b]"><span>《折叠庭院的她》 · {episode} · 人服道景提报</span><span>第 {page} 页</span></footer>; }
function PdfMeta({ label, value }: { label: string; value: string }) { return <div className="bg-white p-4"><p className="text-[11px] text-[#8b919b]">{label}</p><p className="mt-1 text-[16px] font-medium">{value}</p></div>; }
function Field({ label, children }: { label: string; children: React.ReactNode }) { return <label className="block"><span className="mb-1.5 block text-xs text-muted-foreground">{label}</span>{children}</label>; }
function Empty({ text }: { text: string }) { return <div className="rounded-xl border border-dashed border-white/10 px-5 py-10 text-center text-sm leading-6 text-muted-foreground">{text}</div>; }
function chunk<T>(values: T[], size: number) { const chunks: T[][] = []; for (let index = 0; index < values.length; index += size) chunks.push(values.slice(index, index + size)); return chunks; }
function formatDate(value: string) { if (!value) return '未定日期'; const [, month, day] = value.split('-'); return `${Number(month)}月${Number(day)}日`; }
function formatDateTime(value: string) { if (!value) return '未记录'; return value.replace('T', ' ').slice(0, 16); }
