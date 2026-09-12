'use client';
/* oxlint-disable react/react-compiler, next/no-img-element */

import { useEffect, useMemo, useState } from 'react';
import { Archive, Check, Clock3, Download, ExternalLink, FileText, ImagePlus, Loader2, RefreshCw, Trash2, Upload, X } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Textarea } from '@/components/ui/textarea';
import { canEditArtCategory, roleCanSeeArt } from '@/lib/team-roles';
import type { ProductionItem } from '@/lib/plan-data';

type CurrentUser = { id: string; username: string; name: string; role: string; isAdmin: boolean };
type ScriptAnalysis = { id: string; episode: string; sceneNo: number; sceneTitle: string; scriptText: string; sceneSummary: string; location: string; createdAt: string; updatedAt: string };
type ScriptAssetItem = { id: string; analysisId: string; category: string; name: string; detail: string; visualBrief: string; sortOrder: number };
type ScriptVersion = { id: string; episode: string; versionNo: number; fileName: string; sourceText: string; changeSummary: string; workDate: string; submittedBy: string; sceneCount: number; itemCount: number; isFinal: number | boolean; finalizedAt: string; finalizedBy: string; createdAt: string };
type DailySceneAssignment = { id: string; workDate: string; analysisId: string; scriptVersionId: string; assignedBy: string; createdAt: string };
type SubmissionDetail = { itemId: string; assignedTo: string; dueAt: string; handoffTo: string; doneDefinition: string; status: string; submissionNote: string; reviewNote: string; submittedAt: string; reviewedAt: string; updatedAt: string };
type SubmissionFile = { id: string; itemId: string; fileName: string; contentType: string; byteSize: number; uploadedBy: string; sortOrder: number; createdAt: string; url: string };
type ReuseInfo = { sourceItemId: string; sourceSceneNo: number; files: SubmissionFile[] };

const categories = ['人物', '服装', '道具', '场景'];
const activeStatuses = new Set(['已上传', '待审核', '已锁定']);

export function SubmissionCenter({ me, selectedDate, productionItems, onAssigned, mode = 'art' }: { me: CurrentUser; selectedDate: string; productionItems: ProductionItem[]; onAssigned: (date: string) => Promise<void>; mode?: 'script' | 'art' }) {
  const [analyses, setAnalyses] = useState<ScriptAnalysis[]>([]);
  const [items, setItems] = useState<ScriptAssetItem[]>([]);
  const [versions, setVersions] = useState<ScriptVersion[]>([]);
  const [assignments, setAssignments] = useState<DailySceneAssignment[]>([]);
  const [details, setDetails] = useState<SubmissionDetail[]>([]);
  const [files, setFiles] = useState<SubmissionFile[]>([]);
  const [workDate, setWorkDate] = useState(selectedDate);
  const [selectedIds, setSelectedIds] = useState<string[]>([]);
  const [selectedPropIds, setSelectedPropIds] = useState<string[]>([]);
  const [changeSummary, setChangeSummary] = useState('首次单集提报');
  const [scriptFileName, setScriptFileName] = useState('');
  const [scriptFile, setScriptFile] = useState<File | null>(null);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [finalizingVersion, setFinalizingVersion] = useState('');
  const [pdfEpisode, setPdfEpisode] = useState('');
  const [notice, setNotice] = useState('');
  const [error, setError] = useState('');
  const canEditArt = me.isAdmin || roleCanSeeArt(me.role);
  const wardrobeAssistant = !me.isAdmin && me.role === '服化道副导演';
  const canUploadScript = me.isAdmin || me.role === '编剧';
  const canDeleteProps = me.isAdmin || me.role === '执行制片人';
  const canFinalizeScript = me.isAdmin;

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
  useEffect(() => { setWorkDate(selectedDate); setNotice(''); setSelectedIds([]); setSelectedPropIds([]); }, [selectedDate]);

  const dateAssignments = assignments.filter((assignment) => assignment.workDate === workDate);
  const assignedIds = new Set(dateAssignments.map((assignment) => assignment.analysisId));
  const legacyEpisodes = new Set(productionItems
    .filter((item) => item.workDate === workDate && ['美术清单', '资产修改', '整集资产确认'].includes(item.category))
    .map((item) => item.episode));
  const showCurrentAssets = wardrobeAssistant && !assignedIds.size && !legacyEpisodes.size;
  const dailyAnalyses = analyses.filter((analysis) => assignedIds.size ? assignedIds.has(analysis.id) : legacyEpisodes.has(analysis.episode) || showCurrentAssets);
  const dailyAnalysisIds = new Set(dailyAnalyses.map((analysis) => analysis.id));
  const dailyItems = items.filter((item) => dailyAnalysisIds.has(item.analysisId) && (!wardrobeAssistant || canEditArtCategory(me, item.category)));
  const dailyEpisodes = [...new Set(dailyAnalyses.map((analysis) => analysis.episode))];
  const detailMap = useMemo(() => new Map(details.map((detail) => [detail.itemId, detail])), [details]);
  const filesByItem = useMemo(() => {
    const map = new Map<string, SubmissionFile[]>();
    for (const file of files) map.set(file.itemId, [...(map.get(file.itemId) || []), file]);
    return map;
  }, [files]);
  const reuseByItem = useMemo(() => buildReuseMap(analyses, items, filesByItem), [analyses, items, filesByItem]);
  const resolvedFilesByItem = useMemo(() => {
    const map = new Map<string, SubmissionFile[]>();
    for (const item of items) map.set(item.id, filesByItem.get(item.id)?.length ? filesByItem.get(item.id)! : (reuseByItem.get(item.id)?.files || []));
    return map;
  }, [items, filesByItem, reuseByItem]);

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
      const imported = await importResponse.json() as { versions?: Array<{ episode: string; versionNo: number }>; sceneCount?: number; itemCount?: number; error?: string };
      if (!importResponse.ok || !imported.versions?.length) throw new Error(imported.error || '剧本候选稿存档失败');
      await loadAll();
      const versionText = (imported.versions || []).map((row) => `${row.episode} v${row.versionNo}`).join('、');
      setNotice(`已存档${versionText || '新剧本版本'}候选稿，识别${imported.sceneCount || 0}场、${imported.itemCount || 0}项人服道景。此次上传不会对外提报或覆盖生产数据；请由Lipa选择定稿。`);
      setScriptFile(null); setScriptFileName(''); setChangeSummary('');
    } catch (nextError) {
      setError(nextError instanceof Error ? nextError.message : '剧本提报失败');
    } finally {
      setSaving(false);
    }
  }

  async function finalizeScriptVersion(version: ScriptVersion) {
    if (!window.confirm(`确定将${version.episode}剧本 v${version.versionNo}设为定稿吗？\n\n后续拆场、主美资产、排产和PDF都将以此版为准，旧稿和旧图仍保留在档案。`)) return;
    setFinalizingVersion(version.id); setError(''); setNotice('');
    try {
      const response = await fetch('/api/script-analysis', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ action: 'finalizeVersion', versionId: version.id }) });
      const data = await response.json() as { sceneCount?: number; error?: string };
      if (!response.ok) throw new Error(data.error || '设为定稿失败');
      await loadAll(); await onAssigned(workDate);
      setNotice(`已将${version.episode}剧本 v${version.versionNo}设为定稿。现在拆场、主美上传和PDF均按该版本生成，共${data.sceneCount || version.sceneCount}场。`);
    } catch (nextError) {
      setError(nextError instanceof Error ? nextError.message : '设为定稿失败');
    } finally { setFinalizingVersion(''); }
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
    await onAssigned(workDate);
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

  async function deleteProp(item: ScriptAssetItem) {
    if (item.category !== '道具' || !window.confirm(`确定删除系统拆出的道具“${item.name}”吗？相关参考图也会一起删除。`)) return;
    setError('');
    const response = await fetch('/api/script-analysis', { method: 'DELETE', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ id: item.id }) });
    const data = await response.json() as { error?: string };
    if (!response.ok) { setError(data.error || '删除道具失败，请重试'); return; }
    setItems((current) => current.filter((row) => row.id !== item.id));
    setDetails((current) => current.filter((row) => row.itemId !== item.id));
    setFiles((current) => current.filter((row) => row.itemId !== item.id));
    setNotice(`已删除道具“${item.name}”。`);
    await onAssigned(workDate);
  }

  async function deleteSelectedProps() {
    const ids = selectedPropIds.filter((id) => dailyItems.some((item) => item.id === id && item.category === '道具'));
    if (!ids.length || !window.confirm(`确定批量删除选中的${ids.length}个过度拆解道具吗？相关参考图也会一起删除。`)) return;
    setSaving(true); setError('');
    try {
      const response = await fetch('/api/script-analysis', { method: 'DELETE', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ ids }) });
      const data = await response.json() as { ids?: string[]; error?: string };
      if (!response.ok) throw new Error(data.error || '批量删除失败');
      const deleted = new Set(data.ids || ids);
      setItems((current) => current.filter((row) => !deleted.has(row.id)));
      setDetails((current) => current.filter((row) => !deleted.has(row.itemId)));
      setFiles((current) => current.filter((row) => !deleted.has(row.itemId)));
      setSelectedPropIds([]);
      setNotice(`已批量删除${deleted.size}个过度拆解道具。`);
      await onAssigned(workDate);
    } catch (nextError) { setError(nextError instanceof Error ? nextError.message : '批量删除失败'); }
    finally { setSaving(false); }
  }

  function versionForEpisode(episode: string) {
    return versions.find((version) => version.episode === episode && Boolean(version.isFinal));
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
        const referenceFiles = resolvedFilesByItem.get(item.id) || [];
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
      const version = versionForEpisode(episode);
      if (!version) throw new Error(`${episode}还没有选择定稿，请先由Lipa在剧本更新档案中点击“设为定稿”。`);
      await document.fonts.ready;
      const container = document.getElementById(`submission-pdf-${episode.replace(/\W/g, '')}`);
      if (!container) throw new Error('PDF版式没有准备好');
      const images = [...container.querySelectorAll('img')];
      await Promise.all(images.map((image) => image.complete ? Promise.resolve() : new Promise<void>((resolve) => { image.addEventListener('load', () => resolve(), { once: true }); image.addEventListener('error', () => resolve(), { once: true }); })));
      const [{ default: html2canvas }, { jsPDF }] = await Promise.all([import('html2canvas-pro'), import('jspdf')]);
      const pdf = new jsPDF({ orientation: 'landscape', unit: 'mm', format: 'a4', compress: true });
      const pages = [...container.querySelectorAll<HTMLElement>('.submission-pdf-page')];
      for (let index = 0; index < pages.length; index += 1) {
        const canvas = await html2canvas(pages[index], { scale: 1.45, backgroundColor: '#111820', useCORS: true, logging: false });
        if (index) pdf.addPage('a4', 'landscape');
        pdf.addImage(canvas.toDataURL('image/jpeg', 0.9), 'JPEG', 0, 0, 297, 210, undefined, 'FAST');
      }
      pdf.save(`折叠庭院的她_${episode}_剧本v${version.versionNo}_${workDate.replaceAll('-', '')}_Yoyo视觉参考简报.pdf`);
      setNotice(`${episode}Yoyo看图PDF已下载，共${pages.length}页。`);
    } catch (nextError) {
      setError(nextError instanceof Error ? nextError.message : 'PDF生成失败');
    } finally { setPdfEpisode(''); }
  }

  if (loading) return <section className="control-card flex min-h-64 items-center justify-center gap-3 p-6 text-sm text-muted-foreground"><Loader2 className="h-5 w-5 animate-spin text-[#ff6240]" />正在读取单集版本与提报档案…</section>;

  const readyCount = dailyItems.filter((item) => {
    const detail = detailMap.get(item.id); const itemFiles = resolvedFilesByItem.get(item.id) || [];
    return Boolean(detail?.assignedTo && detail?.dueAt && detail?.handoffTo && detail?.doneDefinition && activeStatuses.has(detail.status) && itemFiles.length);
  }).length;
  const dailyProps = dailyItems.filter((item) => item.category === '道具');
  const allDailyPropsSelected = Boolean(dailyProps.length && dailyProps.every((item) => selectedPropIds.includes(item.id)));

  if (mode === 'script') return <section>
    <div className="mb-5 flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between"><div><p className="eyebrow">SCREENPLAY WORKFLOW</p><h2 className="mt-1 text-2xl font-semibold">编剧上传与Lipa定稿</h2><p className="mt-2 max-w-3xl text-sm leading-6 text-muted-foreground">编剧只负责上传候选稿；导演与制片人可以查看。Lipa确认定稿后，系统才拆场、生成主美清单，并开放本集剧本提报H5与PDF。</p></div><button onClick={() => void loadAll()} className="grid h-10 w-10 place-items-center rounded-full border border-white/10 bg-white/5 text-muted-foreground" aria-label="刷新剧本档案"><RefreshCw className="h-4 w-4" /></button></div>
    <div className="grid gap-4 xl:grid-cols-[1.05fr_.95fr]">
      <section className="control-card p-4 md:p-6"><div className="flex items-start justify-between gap-4"><div><p className="text-sm font-medium">1 · 编剧上传候选稿</p><p className="mt-1 text-xs leading-5 text-muted-foreground">上传只新增版本，不会直接对外提报，也不会覆盖旧稿或现有图片。</p></div><FileText className="h-5 w-5 text-[#ff8066]" /></div>
        <div className="mt-4 grid gap-3 sm:grid-cols-[160px_1fr]"><Field label="上传日期"><input type="date" value={workDate} disabled={!canUploadScript} onChange={(event) => setWorkDate(event.target.value)} className="edit-input" /></Field><Field label="本次修改说明"><input value={changeSummary} disabled={!canUploadScript} onChange={(event) => setChangeSummary(event.target.value)} className="edit-input" placeholder="改了哪些场、影响哪些人物或剧情" /></Field></div>
        <label aria-label="选择整集TXT或DOCX剧本" className={`mt-3 flex min-h-28 items-center justify-center rounded-xl border-2 border-dashed px-4 py-5 text-center ${canUploadScript ? 'cursor-pointer border-white/15 bg-black/10 hover:border-[#ff6240]/50' : 'border-white/8 bg-black/5 opacity-60'}`}><input aria-label="上传整集剧本文件" type="file" accept=".txt,.docx,text/plain,application/vnd.openxmlformats-officedocument.wordprocessingml.document" disabled={!canUploadScript || saving} className="sr-only" onChange={(event) => { const next = event.target.files?.[0] || null; setScriptFile(next); setScriptFileName(next?.name || ''); event.target.value = ''; }} /><div><span className="mx-auto grid h-10 w-10 place-items-center rounded-full bg-[#ff6240]/15 text-[#ff8066]"><Upload className="h-4 w-4" /></span><p className="mt-2 text-sm font-medium">{scriptFileName || '选择整集 TXT / DOCX 剧本'}</p><p className="mt-1 text-xs text-muted-foreground">{canUploadScript ? '编剧上传后进入候选版本档案，等待Lipa定稿' : '当前身份可查看版本，但不能上传'}</p></div></label>
        <Button className="mt-3 h-11 w-full" disabled={!canUploadScript || !scriptFile || !changeSummary.trim() || saving} onClick={() => void readScriptFile()}>{saving ? <Loader2 className="animate-spin" /> : <Upload />}{saving ? '正在存档候选稿…' : '上传候选稿'}</Button>
      </section>
      <section className="control-card p-4 md:p-6"><div className="flex items-start justify-between gap-4"><div><p className="text-sm font-medium">2 · 版本档案与定稿</p><p className="mt-1 text-xs leading-5 text-muted-foreground">每集只有一个已定稿版本驱动后续；只有Lipa可以定稿和对外提报。</p></div><Archive className="h-5 w-5 text-cyan-300" /></div>
        <div className="mt-4 max-h-[620px] space-y-2 overflow-auto pr-1">{versions.length ? versions.map((version) => { const isFinal = Boolean(version.isFinal); const episodeNo = episodeNumber(version.episode); const h5Url = `/pitch?episode=${episodeNo}`; return <details key={version.id} className={`rounded-xl border px-3 py-2.5 ${isFinal ? 'border-emerald-400/35 bg-emerald-400/[.07]' : 'border-white/8 bg-white/[.025]'}`}><summary aria-label={`展开${version.episode}剧本v${version.versionNo}`} className="cursor-pointer list-none"><div className="flex items-start justify-between gap-3"><div><div className="flex flex-wrap items-center gap-2"><p className="text-sm font-medium">{version.episode} · 剧本 v{version.versionNo}</p><span className={`rounded-full px-2 py-1 text-[10px] font-medium ${isFinal ? 'bg-emerald-400/15 text-emerald-300' : 'bg-white/5 text-muted-foreground'}`}>{isFinal ? 'Lipa已定稿' : '候选稿'}</span></div><p className="mt-1 text-xs text-muted-foreground">{formatDateTime(version.createdAt)} · {version.submittedBy} · {version.sceneCount}场</p></div><span className="max-w-40 truncate rounded-full bg-white/5 px-2 py-1 text-[10px] text-muted-foreground">{version.fileName || '手工录入'}</span></div></summary><div className="mt-3 border-t border-white/8 pt-3"><p className="text-xs leading-5 text-[#ff9a86]">{version.changeSummary || '未填写更新说明'}</p>{isFinal && <p className="mt-2 text-[11px] text-emerald-300">由{version.finalizedBy || 'Lipa'}于{formatDateTime(version.finalizedAt)}确认；拆场和主美资产均以此稿生成。</p>}<p className="mt-3 max-h-48 overflow-auto whitespace-pre-wrap rounded-lg bg-black/15 p-3 text-xs leading-5 text-muted-foreground">{version.sourceText}</p>{canFinalizeScript && !isFinal && <Button className="mt-3 w-full" size="sm" disabled={Boolean(finalizingVersion)} onClick={() => void finalizeScriptVersion(version)}>{finalizingVersion === version.id ? <Loader2 className="animate-spin" /> : <Check />}{finalizingVersion === version.id ? '正在生成后续生产数据…' : 'Lipa定稿并生成后续'}</Button>}{me.isAdmin && isFinal && <div className="mt-3 grid grid-cols-2 gap-2"><a href={h5Url} target="_blank" rel="noreferrer" className="inline-flex h-9 items-center justify-center gap-1.5 rounded-lg border border-cyan-300/25 bg-cyan-300/8 px-3 text-xs text-cyan-200"><ExternalLink className="h-3.5 w-3.5" />打开提报H5</a><a href={`${h5Url}&print=1`} target="_blank" rel="noreferrer" className="inline-flex h-9 items-center justify-center gap-1.5 rounded-lg border border-[#ff6240]/25 bg-[#ff6240]/8 px-3 text-xs text-[#ff9a86]"><Download className="h-3.5 w-3.5" />下载PDF</a></div>}</div></details>; }) : <Empty text="还没有单集剧本版本；编剧上传后由Lipa选择定稿。" />}</div>
      </section>
    </div>
    {showCurrentAssets && <p className="mt-4 text-sm text-muted-foreground">当天未单独分配场次，下面显示当前生产资产中的场景与角色服装，可直接上传；不会自动新增或调整排期。</p>}
    {notice && <p className="mt-4 rounded-xl border border-emerald-400/20 bg-emerald-400/[.06] px-4 py-3 text-sm text-emerald-300">{notice}</p>}
    {error && <p className="mt-4 rounded-xl border border-red-400/20 bg-red-400/[.06] px-4 py-3 text-sm text-red-300">{error}</p>}
  </section>;

  return <section>
    <div className="mb-5 flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between"><div><p className="eyebrow">ART UPLOAD & REVIEW</p><h2 className="mt-1 text-2xl font-semibold">美术上传与审图</h2><p className="mt-2 max-w-3xl text-sm leading-6 text-muted-foreground">服化道副导演上传场景和角色服装；主美保留人物、服装、道具和场景上传权限。场景共用同一清单，双方图片一起保留；Lipa确认齐套后，独立生成本集美术提报H5或PDF。</p></div><button onClick={() => void loadAll()} className="grid h-10 w-10 place-items-center rounded-full border border-white/10 bg-white/5 text-muted-foreground" aria-label="刷新美术档案"><RefreshCw className="h-4 w-4" /></button></div>

    {canEditArt && <section className="mb-4 flex flex-col gap-3 rounded-2xl border border-[#ff6240]/30 bg-[#ff6240]/[.07] p-4 sm:flex-row sm:items-center sm:justify-between"><div><p className="text-sm font-semibold text-[#ff9a86]">{wardrobeAssistant ? '服化道副导演 · 场景与角色服装上传' : '美术上传入口'}</p><p className="mt-1 text-xs leading-5 text-muted-foreground">先选当天日期，再到下方对应场次的“上传参考图”卡片；上传成功后会立刻出现缩略图。</p></div><Button size="sm" onClick={() => document.getElementById('art-upload-list')?.scrollIntoView({ behavior: 'smooth', block: 'start' })}><ImagePlus />去上传图片</Button></section>}

    <div className="hidden grid-cols-[1.15fr_.85fr] gap-4">
      <section className="control-card p-4 md:p-6"><div className="flex items-start justify-between gap-4"><div><p className="text-sm font-medium">1 · 编剧上传单集剧本</p><p className="mt-1 text-xs leading-5 text-muted-foreground">每次上传只新增候选稿，不覆盖旧稿或已上传图片；Lipa选择定稿后，才会用该版生成拆场、主美资产和PDF。</p></div><FileText className="h-5 w-5 text-[#ff8066]" /></div>
        <div className="mt-4 grid gap-3 sm:grid-cols-[160px_1fr]"><Field label="提报日期"><input type="date" value={workDate} disabled={!canUploadScript} onChange={(event) => setWorkDate(event.target.value)} className="edit-input" /></Field><Field label="本次更新说明"><input value={changeSummary} disabled={!canUploadScript} onChange={(event) => setChangeSummary(event.target.value)} className="edit-input" placeholder="改了哪些场、影响哪些人物或剧情" /></Field></div>
        <label aria-label="选择整集TXT或DOCX剧本" className={`mt-3 flex min-h-28 items-center justify-center rounded-xl border-2 border-dashed px-4 py-5 text-center ${canUploadScript ? 'cursor-pointer border-white/15 bg-black/10 hover:border-[#ff6240]/50' : 'border-white/8 bg-black/5 opacity-60'}`}><input aria-label="上传整集剧本文件" type="file" accept=".txt,.docx,text/plain,application/vnd.openxmlformats-officedocument.wordprocessingml.document" disabled={!canUploadScript || saving} className="sr-only" onChange={(event) => { const next = event.target.files?.[0] || null; setScriptFile(next); setScriptFileName(next?.name || ''); event.target.value = ''; }} /><div><span className="mx-auto grid h-10 w-10 place-items-center rounded-full bg-[#ff6240]/15 text-[#ff8066]"><Upload className="h-4 w-4" /></span><p className="mt-2 text-sm font-medium">{scriptFileName || '选择整集 TXT / DOCX 剧本'}</p><p className="mt-1 text-xs text-muted-foreground">编剧可上传 · 导演与制片人可登录查看 · 系统按场头自动拆场</p></div></label>
        <Button className="mt-3 h-11 w-full" disabled={!canUploadScript || !scriptFile || !changeSummary.trim() || saving} onClick={() => void readScriptFile()}>{saving ? <Loader2 className="animate-spin" /> : <Check />}{saving ? '正在存档候选稿…' : '上传并保存候选稿'}</Button>
      </section>

      <section className="control-card p-4 md:p-6">
        <div className="flex items-start justify-between gap-4"><div><p className="text-sm font-medium">剧本更新档案 · 选择定稿</p><p className="mt-1 text-xs leading-5 text-muted-foreground">保留所有稿件；每集只有一个“已定稿”版本驱动后续生产。</p></div><Archive className="h-5 w-5 text-cyan-300" /></div>
        <div className="mt-4 max-h-[360px] space-y-2 overflow-auto pr-1">{versions.length ? versions.map((version) => {
          const isFinal = Boolean(version.isFinal);
          return <details key={version.id} className={`rounded-xl border px-3 py-2.5 ${isFinal ? 'border-emerald-400/35 bg-emerald-400/[.07]' : 'border-white/8 bg-white/[.025]'}`}>
            <summary aria-label={`展开${version.episode}剧本v${version.versionNo}`} className="cursor-pointer list-none"><div className="flex items-start justify-between gap-3"><div><div className="flex flex-wrap items-center gap-2"><p className="text-sm font-medium">{version.episode} · 剧本 v{version.versionNo}</p><span className={`rounded-full px-2 py-1 text-[10px] font-medium ${isFinal ? 'bg-emerald-400/15 text-emerald-300' : 'bg-white/5 text-muted-foreground'}`}>{isFinal ? '已定稿' : '候选稿'}</span></div><p className="mt-1 text-xs text-muted-foreground">{formatDateTime(version.createdAt)} · {version.submittedBy} · {version.sceneCount}场</p></div><span className="max-w-40 truncate rounded-full bg-white/5 px-2 py-1 text-[10px] text-muted-foreground">{version.fileName || '手工录入'}</span></div></summary>
            <div className="mt-3 border-t border-white/8 pt-3"><p className="text-xs leading-5 text-[#ff9a86]">{version.changeSummary || '未填写更新说明'}</p>{isFinal && <p className="mt-2 text-[11px] text-emerald-300">由{version.finalizedBy || 'Lipa'}于{formatDateTime(version.finalizedAt)}确认；拆场、主美资产与PDF均以此稿为准。</p>}<p className="mt-3 max-h-48 overflow-auto whitespace-pre-wrap rounded-lg bg-black/15 p-3 text-xs leading-5 text-muted-foreground">{version.sourceText}</p>{canFinalizeScript && !isFinal && <Button className="mt-3 w-full" size="sm" disabled={Boolean(finalizingVersion)} onClick={() => void finalizeScriptVersion(version)}>{finalizingVersion === version.id ? <Loader2 className="animate-spin" /> : <Check />}{finalizingVersion === version.id ? '正在生成定稿生产数据…' : '设为定稿并生成后续'}</Button>}</div>
          </details>;
        }) : <Empty text="还没有单集剧本版本；编剧上传后由Lipa选择定稿。" />}</div>
      </section>
    </div>

    {me.isAdmin && <section className="control-card mt-4 p-4 md:p-6"><div className="flex flex-col gap-3 lg:flex-row lg:items-end lg:justify-between"><div><p className="text-sm font-medium">1 · Lipa安排当天场次</p><p className="mt-1 text-xs text-muted-foreground">定稿场次排入当天后，主美与服化道副导演按各自权限在下面的资产卡上传。</p></div><div className="flex flex-wrap items-center gap-2">{analyses.map((analysis) => { const selected = selectedIds.includes(analysis.id); const assigned = assignedIds.has(analysis.id); return <button key={analysis.id} disabled={saving} onClick={() => setSelectedIds((current) => selected ? current.filter((id) => id !== analysis.id) : [...current, analysis.id])} className={`rounded-lg border px-3 py-2 text-xs ${selected ? 'border-[#ff6240] bg-[#ff6240]/15 text-white' : assigned ? 'border-emerald-400/25 bg-emerald-400/10 text-emerald-300' : 'border-white/10 bg-white/5 text-muted-foreground'}`}>{assigned ? '已排 ' : selected ? '✓ ' : '□ '}{analysis.episode}·{analysis.sceneNo}场</button>; })}<Button size="sm" disabled={!selectedIds.length || saving} onClick={() => void assignExisting()}><Clock3 />排入{formatDate(workDate)}</Button></div></div></section>}

    {notice && <p className="mt-4 rounded-xl border border-emerald-400/20 bg-emerald-400/[.06] px-4 py-3 text-sm text-emerald-300">{notice}</p>}
    {error && <p className="mt-4 rounded-xl border border-red-400/20 bg-red-400/[.06] px-4 py-3 text-sm text-red-300">{error}</p>}

    <div className="mt-7 flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between"><div><p className="eyebrow">DAILY ART PACKAGE</p><h2 className="mt-1 text-xl font-semibold">{formatDate(workDate)} · {wardrobeAssistant ? '场景与角色服装上传清单' : '人服道景上传清单'}</h2><p className="mt-1 text-xs text-muted-foreground">{dailyAnalyses.length}场 · {readyCount}/{dailyItems.length}项齐套 · 美术团队上传，Lipa最终审图和提报</p></div>{me.isAdmin && <div className="flex flex-wrap gap-2">{dailyEpisodes.map((episode) => <div key={episode} className="flex gap-2"><a href={`/art-review?episode=${encodeURIComponent(episode)}`} target="_blank" rel="noreferrer" className={`inline-flex h-10 items-center gap-2 rounded-lg border px-3 text-sm ${readyCount === dailyItems.length && dailyItems.length ? 'border-cyan-300/25 bg-cyan-300/8 text-cyan-200' : 'pointer-events-none border-white/8 text-zinc-600'}`}><ExternalLink className="h-4 w-4" />生成美术H5</a><Button variant="outline" disabled={pdfEpisode === episode || readyCount !== dailyItems.length || !dailyItems.length} onClick={() => void downloadPdf(episode)}>{pdfEpisode === episode ? <Loader2 className="animate-spin" /> : <Download />}{`下载${episode}美术PDF`}</Button></div>)}</div>}</div>

    {canDeleteProps && dailyProps.length > 0 && <div className="mt-4 flex flex-wrap items-center justify-between gap-3 rounded-xl border border-red-400/20 bg-red-400/[.045] px-3 py-2.5"><button type="button" onClick={() => setSelectedPropIds(allDailyPropsSelected ? [] : dailyProps.map((item) => item.id))} className="text-xs text-red-200">{allDailyPropsSelected ? '取消全选道具' : `选择全部道具（${dailyProps.length}）`}</button><Button size="sm" variant="destructive" disabled={!selectedPropIds.length || saving} onClick={() => void deleteSelectedProps()}><Trash2 />批量删除选中道具{selectedPropIds.length ? `（${selectedPropIds.length}）` : ''}</Button></div>}

    <div id="art-upload-list" className="mt-4 scroll-mt-6 space-y-4">{dailyAnalyses.length ? dailyAnalyses.map((analysis) => { const sceneItems = dailyItems.filter((item) => item.analysisId === analysis.id).sort((a, b) => a.sortOrder - b.sortOrder); return <article key={analysis.id} className="control-card p-4 md:p-5"><div className="border-b border-white/8 pb-4"><p className="text-xs text-[#ff8066]">{analysis.episode} · 第{analysis.sceneNo}场</p><h3 className="mt-1 text-lg font-medium">{analysis.sceneTitle}</h3><p className="mt-1 text-sm leading-6 text-muted-foreground">{analysis.location} · {analysis.sceneSummary}</p></div><div className="mt-4 grid gap-3 xl:grid-cols-2">{sceneItems.map((item) => <SubmissionItemCard key={item.id} item={item} detail={detailMap.get(item.id)} files={resolvedFilesByItem.get(item.id) || []} reuseInfo={reuseByItem.get(item.id)} defaultDueAt={`${workDate}T18:00`} canEdit={canEditArtCategory(me, item.category)} canDelete={canDeleteProps && item.category === '道具'} selectedForDelete={selectedPropIds.includes(item.id)} onToggleDelete={() => setSelectedPropIds((current) => current.includes(item.id) ? current.filter((id) => id !== item.id) : [...current, item.id])} isAdmin={me.isAdmin} currentName={me.name} onUpload={uploadImage} onSave={saveDetail} onDeleteFile={deleteFile} onDeleteItem={deleteProp} />)}</div></article>; }) : <Empty text={`${formatDate(workDate)}还没有具体场次。Lipa上传单集剧本，或在上方选择场次排入当天。`} />}</div>

    <div className="submission-pdf-source" aria-hidden="true">{dailyEpisodes.map((episode) => <SubmissionPdfSource key={episode} id={`submission-pdf-${episode.replace(/\W/g, '')}`} episode={episode} workDate={workDate} version={versionForEpisode(episode)} analyses={dailyAnalyses.filter((analysis) => analysis.episode === episode)} items={items} filesByItem={resolvedFilesByItem} />)}</div>
  </section>;
}

function SubmissionItemCard({ item, detail, files, reuseInfo, defaultDueAt, canEdit, canDelete, selectedForDelete, onToggleDelete, isAdmin, currentName, onUpload, onSave, onDeleteFile, onDeleteItem }: { item: ScriptAssetItem; detail?: SubmissionDetail; files: SubmissionFile[]; reuseInfo?: ReuseInfo; defaultDueAt: string; canEdit: boolean; canDelete: boolean; selectedForDelete: boolean; onToggleDelete: () => void; isAdmin: boolean; currentName: string; onUpload: (itemId: string, file: File) => Promise<void>; onSave: (itemId: string, changes: Partial<SubmissionDetail>) => Promise<void>; onDeleteFile: (file: SubmissionFile) => Promise<void>; onDeleteItem: (item: ScriptAssetItem) => Promise<void> }) {
  const [draft, setDraft] = useState({ assignedTo: detail?.assignedTo || (canEdit ? currentName : '主美小金'), dueAt: detail?.dueAt || defaultDueAt, handoffTo: detail?.handoffTo || 'Lipa', doneDefinition: detail?.doneDefinition || item.visualBrief, status: detail?.status || '待上传', submissionNote: detail?.submissionNote || '', reviewNote: detail?.reviewNote || '' });
  const [saving, setSaving] = useState(false);
  const [uploading, setUploading] = useState(false);
  const [error, setError] = useState('');
  useEffect(() => { setDraft({ assignedTo: detail?.assignedTo || (canEdit ? currentName : '主美小金'), dueAt: detail?.dueAt || defaultDueAt, handoffTo: detail?.handoffTo || 'Lipa', doneDefinition: detail?.doneDefinition || item.visualBrief, status: detail?.status || '待上传', submissionNote: detail?.submissionNote || '', reviewNote: detail?.reviewNote || '' }); }, [detail, defaultDueAt, item.visualBrief, canEdit, currentName]);
  async function upload(file: File) { setUploading(true); setError(''); try { await onUpload(item.id, file); setDraft((current) => ({ ...current, status: '已上传' })); } catch (nextError) { setError(nextError instanceof Error ? nextError.message : '上传失败'); } finally { setUploading(false); } }
  async function save(nextStatus?: string) { setSaving(true); setError(''); try { const next = { ...draft, status: nextStatus || draft.status }; await onSave(item.id, next); setDraft(next); } catch (nextError) { setError(nextError instanceof Error ? nextError.message : '保存失败'); } finally { setSaving(false); } }
  return <section className={`rounded-xl border p-3 ${selectedForDelete ? 'border-red-400/55 bg-red-400/[.07]' : detail?.status === '打回' || detail?.status === '需复核' ? 'border-red-400/35 bg-red-400/[.04]' : detail?.status === '已锁定' ? 'border-emerald-400/30 bg-emerald-400/[.04]' : 'border-white/10 bg-white/[.025]'}`}><div className="flex items-start justify-between gap-3"><div className="flex items-start gap-2">{canDelete && <input type="checkbox" checked={selectedForDelete} onChange={onToggleDelete} aria-label={`选择删除道具${item.name}`} className="mt-1 h-4 w-4 accent-red-400" />}<div><div className="flex flex-wrap items-center gap-1.5"><span className="rounded-md bg-white/6 px-2 py-0.5 text-[10px] text-muted-foreground">{item.category}</span>{reuseInfo && <span className="rounded-full border border-cyan-400/25 bg-cyan-400/[.08] px-2 py-0.5 text-[10px] text-cyan-300">复用第{reuseInfo.sourceSceneNo}场 · 已自动贴图</span>}</div><h4 className="mt-2 text-sm font-medium">{item.name}</h4></div></div><div className="flex items-center gap-1.5"><span className="rounded-full border border-white/10 px-2 py-1 text-[10px] text-muted-foreground">{detail?.status || (reuseInfo ? '复用' : '待上传')}</span>{canDelete && <button type="button" onClick={() => void onDeleteItem(item)} aria-label={`删除道具${item.name}`} title="删除这个道具" className="grid h-7 w-7 place-items-center rounded-full border border-red-400/20 bg-red-400/[.06] text-red-300 hover:bg-red-400/15"><Trash2 className="h-3.5 w-3.5" /></button>}</div></div><p className="mt-2 text-xs leading-5 text-zinc-300">{item.detail}</p><p className="mt-2 border-t border-white/6 pt-2 text-xs leading-5 text-muted-foreground">需要出：{item.visualBrief}</p>
    <div className="mt-3 grid grid-cols-2 gap-2 sm:grid-cols-3">{files.map((file) => <div key={`${item.id}-${file.id}`} className="group relative overflow-hidden rounded-lg border border-white/10 bg-black/20"><img src={file.url} alt={`${item.name}·${file.fileName}`} className="aspect-[4/3] w-full object-cover" /><div title={file.fileName} className="min-h-10 px-2 py-1.5 text-[11px] leading-4 text-zinc-300">{reuseInfo ? `与第${reuseInfo.sourceSceneNo}场一样` : file.fileName}</div>{canEdit && !reuseInfo && <button onClick={() => void onDeleteFile(file).catch((nextError) => setError(nextError instanceof Error ? nextError.message : '删除失败'))} aria-label={`删除${file.fileName}`} className="absolute right-1 top-1 grid h-7 w-7 place-items-center rounded-full bg-black/75 text-zinc-300 opacity-100 sm:opacity-0 sm:group-hover:opacity-100"><Trash2 className="h-3.5 w-3.5" /></button>}</div>)}{canEdit && <label aria-label={`为${item.name}增加参考图`} className="flex aspect-[4/3] cursor-pointer flex-col items-center justify-center rounded-lg border border-dashed border-[#ff6240]/35 bg-[#ff6240]/[.04] text-xs text-[#ff9a86] hover:border-[#ff6240]/70"><input aria-label={`上传${item.name}参考图`} type="file" accept="image/jpeg,image/png,image/webp" disabled={uploading} className="sr-only" onChange={(event) => { const file = event.target.files?.[0]; if (file) void upload(file); event.target.value = ''; }} />{uploading ? <Loader2 className="h-4 w-4 animate-spin" /> : <ImagePlus className="h-4 w-4" />}<span className="mt-1 font-medium">{uploading ? '上传中' : reuseInfo ? '本场变化时另传' : '上传参考图'}</span></label>}</div>
    <div className="mt-3 grid gap-2 sm:grid-cols-2"><Field label="具体责任人"><input disabled={!canEdit} value={draft.assignedTo} onChange={(event) => setDraft((current) => ({ ...current, assignedTo: event.target.value }))} className="edit-input" /></Field><Field label="精确截止时间"><input type="datetime-local" disabled={!canEdit} value={draft.dueAt} onChange={(event) => setDraft((current) => ({ ...current, dueAt: event.target.value }))} className="edit-input" /></Field><Field label="下一交接人"><input disabled={!canEdit} value={draft.handoffTo} onChange={(event) => setDraft((current) => ({ ...current, handoffTo: event.target.value }))} className="edit-input" /></Field><Field label="提交状态"><select disabled={!canEdit} value={draft.status} onChange={(event) => setDraft((current) => ({ ...current, status: event.target.value }))} className="edit-input">{(isAdmin ? ['待上传', '已上传', '待审核', '打回', '已锁定', '需复核'] : ['待上传', '已上传', '待审核', '需复核']).map((status) => <option key={status}>{status}</option>)}</select></Field></div>
    <div className="mt-2"><Field label="完成定义"><Textarea disabled={!canEdit} rows={2} value={draft.doneDefinition} onChange={(event) => setDraft((current) => ({ ...current, doneDefinition: event.target.value }))} /></Field></div><div className="mt-2"><Field label="采用说明"><Textarea disabled={!canEdit} rows={2} value={draft.submissionNote} onChange={(event) => setDraft((current) => ({ ...current, submissionNote: event.target.value }))} placeholder="写清具体采用哪种造型、颜色、材质或空间方案" /></Field></div>{isAdmin && <div className="mt-2"><Field label="Lipa审核／打回意见"><Textarea rows={2} value={draft.reviewNote} onChange={(event) => setDraft((current) => ({ ...current, reviewNote: event.target.value }))} placeholder="打回时写清具体改什么和新的时间节点" /></Field></div>}
    {error && <p className="mt-2 text-xs text-red-300">{error}</p>}{canEdit && <div className="mt-3 flex flex-wrap justify-end gap-2">{isAdmin && <><Button size="sm" variant="destructive" disabled={saving || !draft.reviewNote.trim()} onClick={() => void save('打回')}><X />打回</Button><Button size="sm" variant="outline" disabled={saving || !files.length} onClick={() => void save('已锁定')}><Check />锁定</Button></>}<Button size="sm" disabled={saving} onClick={() => void save()}>{saving ? <Loader2 className="animate-spin" /> : <Check />}{saving ? '保存中' : '保存责任与节点'}</Button></div>}</section>;
}

function SubmissionPdfSource({ id, episode, workDate, version, analyses, items, filesByItem }: { id: string; episode: string; workDate: string; version?: ScriptVersion; analyses: ScriptAnalysis[]; items: ScriptAssetItem[]; filesByItem: Map<string, SubmissionFile[]> }) {
  const episodeIds = new Set(analyses.map((analysis) => analysis.id));
  const episodeItems = items.filter((item) => episodeIds.has(item.analysisId) && ['人物', '服装', '场景'].includes(item.category));
  const referenceCount = episodeItems.reduce((total, item) => total + (filesByItem.get(item.id)?.length || 0), 0);
  type PdfContentPage =
    | { kind: 'scene'; analysis: ScriptAnalysis; entries: Array<{ item: ScriptAssetItem; file: SubmissionFile }>; pageIndex: number; pageCount: number }
    | { kind: 'item'; analysis: ScriptAnalysis; item: ScriptAssetItem; files: SubmissionFile[]; pageIndex: number; pageCount: number; itemReferenceCount: number };
  const contentPages: PdfContentPage[] = [];
  for (const analysis of analyses) {
    const sceneEntries = episodeItems
      .filter((item) => item.analysisId === analysis.id && item.category === '场景')
      .flatMap((item) => (filesByItem.get(item.id) || []).map((file) => ({ item, file })));
    const sceneGroups = chunk(sceneEntries, 4);
    sceneGroups.forEach((entries, index) => contentPages.push({ kind: 'scene', analysis, entries, pageIndex: index + 1, pageCount: sceneGroups.length }));

    const reviewItems = episodeItems
      .filter((item) => item.analysisId === analysis.id && ['人物', '服装'].includes(item.category))
      .sort((a, b) => a.sortOrder - b.sortOrder);
    for (const item of reviewItems) {
      const itemFiles = filesByItem.get(item.id) || [];
      if (!itemFiles.length) continue;
      const fileGroups = chunk(itemFiles, 4);
      fileGroups.forEach((pageFiles, index) => contentPages.push({ kind: 'item', analysis, item, files: pageFiles, pageIndex: index + 1, pageCount: fileGroups.length, itemReferenceCount: itemFiles.length }));
    }
  }
  return <div id={id}><PdfPage><div className="pt-24 text-center"><p className="text-[15px] tracking-[.24em] text-[#ff8066]">VISUAL REVIEW</p><h1 className="mt-6 text-[50px] font-semibold text-white">折叠庭院的她</h1><h2 className="mt-3 text-[28px] font-medium text-white/90">{episode} · Yoyo视觉审核简报</h2><div className="mx-auto mt-6 w-fit rounded-full border border-white/20 bg-black/35 px-5 py-2 text-[13px] font-medium text-white/85">先看场景与情节 · 再逐人审核造型服装</div><div className="mx-auto mt-10 grid w-[690px] grid-cols-4 gap-px overflow-hidden rounded-xl bg-white/15 text-left"><PdfMeta label="剧本版本" value={`v${version?.versionNo || 1}`} /><PdfMeta label="整理日期" value={workDate} /><PdfMeta label="场次" value={`${analyses.length}场`} /><PdfMeta label="参考图片" value={`${referenceCount}张`} /></div><p className="mx-auto mt-7 w-[700px] text-[14px] leading-6 text-white/75">每个审核对象单独成组，不再把女主、丧尸、其他人物和服装参考混在同一页。</p></div><PdfFooter episode={episode} page={1} /></PdfPage>
    {contentPages.map((page, index) => page.kind === 'scene'
      ? <PdfScenePage key={`${page.analysis.id}-scene-${page.pageIndex}`} episode={episode} page={page} pdfPage={index + 2} />
      : <PdfItemReviewPage key={`${page.item.id}-${page.pageIndex}`} episode={episode} page={page} pdfPage={index + 2} />)}
  </div>;
}

function PdfScenePage({ episode, page, pdfPage }: { episode: string; page: { analysis: ScriptAnalysis; entries: Array<{ item: ScriptAssetItem; file: SubmissionFile }>; pageIndex: number; pageCount: number }; pdfPage: number }) {
  const { analysis, entries, pageIndex, pageCount } = page;
  return <PdfPage><PdfHeader eyebrow={`${episode} · 第${analysis.sceneNo}场 · 场景与情节`} title={analysis.location || analysis.sceneTitle} subtitle={`先确认场景氛围，再进入人物与服装审核${pageCount > 1 ? ` · 场景参考第${pageIndex}/${pageCount}页` : ''}`} /><div className="mt-5 grid grid-cols-[310px_1fr] gap-5"><section className="rounded-2xl border border-white/15 bg-black/50 p-5"><p className="text-[11px] font-medium tracking-[.16em] text-[#ff8066]">本场情节</p><p className="mt-3 text-[21px] font-semibold leading-8 text-white">{simpleSceneSummary(analysis)}</p><div className="mt-5 border-t border-white/15 pt-4"><p className="text-[10px] text-white/50">场次</p><p className="mt-1 text-[13px] text-white/80">第{analysis.sceneNo}场 · {analysis.sceneTitle}</p></div></section><div className={`grid place-items-center gap-5 px-5 ${entries.length === 1 ? 'grid-cols-1' : 'grid-cols-2'}`}>{entries.map(({ item, file }) => <figure key={file.id} className="flex w-full max-w-[350px] flex-col items-center rounded-xl border border-white/15 bg-black/45 p-3"><div className="flex h-[205px] w-full items-center justify-center"><img src={file.url} alt={file.fileName} className="block h-auto max-h-[195px] w-auto max-w-full rounded-lg object-contain" /></div><figcaption className="mt-2 text-center text-[11px] leading-5 text-white/75">{friendlyReferenceLabel(item, file)}</figcaption></figure>)}</div></div><PdfFooter episode={episode} page={pdfPage} /></PdfPage>;
}

function PdfItemReviewPage({ episode, page, pdfPage }: { episode: string; page: { analysis: ScriptAnalysis; item: ScriptAssetItem; files: SubmissionFile[]; pageIndex: number; pageCount: number; itemReferenceCount: number }; pdfPage: number }) {
  const { analysis, item, files, pageIndex, pageCount, itemReferenceCount } = page;
  return <PdfPage><PdfHeader eyebrow={`${episode} · 第${analysis.sceneNo}场 · ${item.category}`} title={reviewItemTitle(item)} subtitle={`单项审核 · 本页只看“${reviewItemTitle(item)}” · Option ${itemReferenceCount}张${pageCount > 1 ? ` · 第${pageIndex}/${pageCount}页` : ''}`} /><div className="mt-3 rounded-xl border border-white/12 bg-black/40 px-4 py-2.5"><p className="line-clamp-2 text-[11px] leading-5 text-white/65">{item.detail}</p></div>{files.length === 1 ? <div className="mt-5 flex h-[475px] items-start justify-center px-16"><figure className="flex w-fit max-w-[760px] flex-col items-center rounded-xl border border-white/15 bg-black/45 p-3"><img src={files[0].url} alt={files[0].fileName} className="block h-auto max-h-[405px] w-auto max-w-[720px] rounded-lg object-contain" /><figcaption className="mt-2 text-center text-[11px] leading-5 text-white/80">Option {((pageIndex - 1) * 4) + 1} · {friendlyReferenceLabel(item, files[0])}</figcaption></figure></div> : <div className="mt-4 grid grid-cols-2 place-items-center gap-5 px-12">{files.map((file, fileIndex) => <figure key={file.id} className="flex w-full max-w-[420px] flex-col items-center rounded-xl border border-white/15 bg-black/45 p-3"><div className="flex h-[215px] w-full items-center justify-center"><img src={file.url} alt={file.fileName} className="block h-auto max-h-[205px] w-auto max-w-full rounded-lg object-contain" /></div><figcaption className="mt-2 text-center text-[11px] leading-5 text-white/80">Option {((pageIndex - 1) * 4) + fileIndex + 1} · {friendlyReferenceLabel(item, file)}</figcaption></figure>)}</div>}<PdfFooter episode={episode} page={pdfPage} /></PdfPage>;
}

function PdfPage({ children }: { children: React.ReactNode }) { return <section className="submission-pdf-page relative overflow-hidden px-[44px] py-[38px] text-white" style={{ backgroundImage: "url('/folded-courtyard-bg.jpg')", backgroundPosition: 'center', backgroundSize: 'cover' }}><div className="absolute inset-0 bg-[#071019]/80" /><div className="relative z-10 h-full">{children}</div></section>; }
function PdfHeader({ eyebrow, title, subtitle }: { eyebrow: string; title: string; subtitle: string }) { return <header className="border-b border-white/25 pb-3"><p className="text-[12px] font-medium tracking-[.18em] text-[#ff8066]">{eyebrow}</p><h2 className="mt-1 text-[26px] font-semibold text-white">{title}</h2><p className="mt-1 text-[12px] text-white/65">{subtitle}</p></header>; }
function PdfFooter({ episode, page }: { episode: string; page: number }) { return <footer className="absolute inset-x-0 bottom-0 flex justify-between border-t border-white/20 pt-2 text-[9px] text-white/55"><span>《折叠庭院的她》 · {episode} · Yoyo视觉参考简报</span><span>第 {page} 页</span></footer>; }
function PdfMeta({ label, value }: { label: string; value: string }) { return <div className="bg-black/45 p-4"><p className="text-[10px] text-white/55">{label}</p><p className="mt-1 text-[15px] font-medium text-white">{value}</p></div>; }
function Field({ label, children }: { label: string; children: React.ReactNode }) { return <label className="block"><span className="mb-1.5 block text-xs text-muted-foreground">{label}</span>{children}</label>; }
function Empty({ text }: { text: string }) { return <div className="rounded-xl border border-dashed border-white/10 px-5 py-10 text-center text-sm leading-6 text-muted-foreground">{text}</div>; }
function episodeNumber(value: string) { return Number(value.match(/\d+/)?.[0] || 1); }
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
function reviewItemTitle(item: ScriptAssetItem) {
  return item.name.replace(/\s*｜\s*(?:人物造型|场景图)\s*$/, '').trim() || item.name;
}

function buildReuseMap(analyses: ScriptAnalysis[], items: ScriptAssetItem[], filesByItem: Map<string, SubmissionFile[]>) {
  const result = new Map<string, ReuseInfo>();
  const resolved = new Map<string, SubmissionFile[]>();
  const origin = new Map<string, { sourceItemId: string; sourceSceneNo: number }>();
  const analysisById = new Map(analyses.map((analysis) => [analysis.id, analysis]));
  const ordered = [...items].sort((left, right) => {
    const a = analysisById.get(left.analysisId); const b = analysisById.get(right.analysisId);
    return (a?.episode || '').localeCompare(b?.episode || '', 'zh-CN') || (a?.sceneNo || 0) - (b?.sceneNo || 0) || left.sortOrder - right.sortOrder;
  });
  const previous: ScriptAssetItem[] = [];
  for (const item of ordered) {
    const analysis = analysisById.get(item.analysisId);
    const ownFiles = filesByItem.get(item.id) || [];
    if (ownFiles.length && analysis) {
      resolved.set(item.id, ownFiles);
      origin.set(item.id, { sourceItemId: item.id, sourceSceneNo: analysis.sceneNo });
      previous.push(item);
      continue;
    }
    const key = reusableAssetKey(item);
    const explicitScenes = referencedSceneNumbers(`${item.name} ${item.detail} ${item.visualBrief}`);
    if (analysis && key) {
      const candidate = [...previous].reverse().find((row) => {
        const sourceAnalysis = analysisById.get(row.analysisId);
        return sourceAnalysis?.episode === analysis.episode && sourceAnalysis.sceneNo < analysis.sceneNo && (!explicitScenes.length || explicitScenes.includes(sourceAnalysis.sceneNo)) && reusableAssetKey(row) === key && Boolean(resolved.get(row.id)?.length);
      });
      if (candidate) {
        const source = origin.get(candidate.id) || { sourceItemId: candidate.id, sourceSceneNo: analysisById.get(candidate.analysisId)?.sceneNo || 0 };
        const reusedFiles = resolved.get(candidate.id) || [];
        result.set(item.id, { ...source, files: reusedFiles });
        resolved.set(item.id, reusedFiles);
        origin.set(item.id, source);
      }
    }
    previous.push(item);
  }
  return result;
}

function reusableAssetKey(item: ScriptAssetItem) {
  const generic = /^(?:本场|其他|新增|临时|相关|全部).*(?:人物|服装|道具|场景)/;
  const name = item.name.replace(/\s*｜\s*(?:人物造型|人物状态|服装|道具|场景图)\s*$/, '').replace(/[：:（(].*$/, '').trim();
  if (!name || generic.test(name)) return '';
  if (item.category === '人物') {
    const text = `${item.name} ${item.detail} ${item.visualBrief}`;
    const entity = ['顾丽乔', '陆文川', '沈糯', '怪物演员', '制片主任', '视察人员', '神秘人', '导演', '群演', '群头', '助理', '前夫', '姑妈', '白鸽'].find((value) => text.includes(value));
    if (entity) return `人物:${entity}`;
  }
  return `${item.category}:${name.replace(/[\s·，,。]/g, '').toLowerCase()}`;
}

function referencedSceneNumbers(text: string) {
  const scenes = new Set<number>();
  for (const match of text.matchAll(/第\s*([\d、,，和及/\s]+)\s*场/g)) {
    for (const value of match[1].match(/\d+/g) || []) scenes.add(Number(value));
  }
  return [...scenes];
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
