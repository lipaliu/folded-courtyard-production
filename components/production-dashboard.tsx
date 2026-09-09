'use client';

import { useEffect, useMemo, useState } from 'react';
import {
  CalendarDays, Check, CheckCircle2, ChevronLeft, ChevronRight, CircleDashed,
  ClipboardCopy, Clock3, Film, LayoutDashboard, ListChecks, Loader2, Pencil, RefreshCw, Rows3, Sparkles, X,
} from 'lucide-react';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Button } from '@/components/ui/button';
import { Checkbox } from '@/components/ui/checkbox';
import { Progress } from '@/components/ui/progress';
import { Textarea } from '@/components/ui/textarea';
import { initialBatches, initialItems, initialScenes, PlanBatch, ProductionItem, Scene, STATUSES, Status } from '@/lib/plan-data';

const stageLabels: Array<{ key: keyof Scene; label: string }> = [
  { key: 'scriptStatus', label: '剧本' },
  { key: 'characterStatus', label: '人物' },
  { key: 'locationStatus', label: '场景' },
  { key: 'wardrobeStatus', label: '服化道' },
  { key: 'whiteModelStatus', label: '白模' },
  { key: 'shotStatus', label: '正式镜头' },
  { key: 'roughCutStatus', label: '初剪' },
  { key: 'finalStatus', label: '成片' },
];

const statusStyle: Record<Status, string> = {
  未开始: 'border-white/8 bg-white/4 text-zinc-500',
  进行中: 'border-cyan-400/20 bg-cyan-400/10 text-cyan-300',
  待审核: 'border-violet-400/25 bg-violet-400/12 text-violet-300',
  已通过: 'border-emerald-400/20 bg-emerald-400/10 text-emerald-300',
  打回: 'border-red-400/20 bg-red-400/10 text-red-300',
};

const roles = ['编剧', '主美', 'AIGC抽卡师', '剪辑', '制片人（叶总）', '红人（Yoyo）', '联合制片人／导演：Lipa'];
const timeOptions = Array.from({ length: 96 }, (_, index) => {
  const hour = Math.floor(index / 4).toString().padStart(2, '0');
  const minute = ((index % 4) * 15).toString().padStart(2, '0');
  return `${hour}:${minute}`;
});

type ScriptAnalysis = { id: string; episode: string; sceneNo: number; sceneTitle: string; scriptText: string; sceneSummary: string; location: string; createdAt: string; updatedAt: string };
type ScriptAssetItem = { id: string; analysisId: string; category: string; name: string; detail: string; visualBrief: string; yoyoApproved: boolean; sortOrder: number; updatedAt: string };

export function ProductionDashboard() {
  const [items, setItems] = useState<ProductionItem[]>(initialItems);
  const [scenes, setScenes] = useState<Scene[]>(initialScenes);
  const [selectedDate, setSelectedDate] = useState('2026-09-10');
  const [selectedItem, setSelectedItem] = useState<ProductionItem | null>(null);
  const [batches, setBatches] = useState<PlanBatch[]>(initialBatches);
  const [selectedBatch, setSelectedBatch] = useState<PlanBatch | null>(null);
  const [creatingRole, setCreatingRole] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);
  const [syncing, setSyncing] = useState(true);
  const [me, setMe] = useState<{ name: string; role: string; isAdmin: boolean } | null>(null);

  async function loadData() {
    setSyncing(true);
    try {
      const [itemResponse, sceneResponse, planResponse, meResponse] = await Promise.all([fetch('/api/items'), fetch('/api/scenes'), fetch('/api/plan'), fetch('/api/me')]);
      const itemData = await itemResponse.json() as { items?: ProductionItem[] };
      const sceneData = await sceneResponse.json() as { scenes?: Scene[] };
      const planData = await planResponse.json() as { batches?: PlanBatch[] };
      const meData = await meResponse.json() as { user?: { name: string; role: string; isAdmin: boolean } };
      if (itemData.items?.length) setItems(itemData.items);
      if (sceneData.scenes?.length) setScenes(sceneData.scenes);
      if (planData.batches?.length) setBatches(planData.batches);
      if (meData.user) setMe(meData.user);
    } finally {
      setSyncing(false);
    }
  }

  useEffect(() => { void loadData(); }, []);

  useEffect(() => {
    const context = (document as Document & { modelContext?: { registerTool?: Function } }).modelContext;
    if (!context?.registerTool) return;
    const lifecycle = new AbortController();
    void Promise.resolve(context.registerTool({
      name: 'update_production_task',
      title: '更新制作任务',
      description: '更新《折叠庭院的她》制作任务的状态、完成量或备注。',
      inputSchema: {
        type: 'object',
        properties: {
          id: { type: 'string' }, status: { type: 'string', enum: STATUSES },
          completedQty: { type: 'number', minimum: 0 }, note: { type: 'string' },
        },
        required: ['id'], additionalProperties: false,
      },
      annotations: { readOnlyHint: false, untrustedContentHint: false },
      async execute(input: Record<string, unknown>) {
        const response = await fetch('/api/items', { method: 'PATCH', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ ...input, operator: 'AI助理' }) });
        if (!response.ok) throw new Error('任务更新失败');
        await loadData();
        return { ok: true, id: input.id };
      },
    }, { signal: lifecycle.signal })).catch(() => undefined);
    return () => lifecycle.abort();
  }, []);

  const todayItems = useMemo(() => items.filter((item) => item.workDate === selectedDate), [items, selectedDate]);
  const pendingReview = useMemo(() => items.filter((item) => item.status === '待审核'), [items]);
  const countedItems = todayItems.filter((item) => item.owner !== '红人（Yoyo）');
  const completed = countedItems.reduce((sum, item) => sum + item.completedQty, 0);
  const planned = countedItems.reduce((sum, item) => sum + item.plannedQty, 0);
  const dayProgress = planned ? Math.min(100, Math.round((completed / planned) * 100)) : 0;

  async function updateItem(id: string, changes: Partial<ProductionItem>) {
    setItems((current) => current.map((item) => item.id === id ? { ...item, ...changes } : item));
    try {
      await fetch('/api/items', { method: 'PATCH', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ id, ...changes, operator: 'Lipa' }) });
    } catch { /* optimistic update remains visible in local preview */ }
  }

  async function createItem(draft: Partial<ProductionItem>) {
    const response = await fetch('/api/items', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(draft) });
    if (response.ok) {
      const data = await response.json() as { item: ProductionItem };
      setItems((current) => [...current, data.item].sort((a, b) => a.workDate.localeCompare(b.workDate) || a.sortOrder - b.sortOrder));
    } else {
      const local: ProductionItem = { id: crypto.randomUUID(), workDate: draft.workDate || selectedDate, episode: draft.episode || '全片', category: draft.category || '统筹', title: draft.title || '新任务', owner: draft.owner || '联合制片人／导演：Lipa', reviewer: draft.reviewer || 'Yoyo', status: '未开始', plannedQty: draft.plannedQty || 1, completedQty: 0, dueTime: draft.dueTime || '18:00', dependsOnId: draft.dependsOnId || '', handoffTo: draft.handoffTo || '', handoffDeadline: draft.handoffDeadline || '', note: draft.note || '', sortOrder: Date.now(), updatedAt: new Date().toISOString() };
      setItems((current) => [...current, local]);
    }
  }

  async function updateBatch(batch: PlanBatch) {
    setBatches((current) => current.map((row) => row.id === batch.id ? batch : row));
    try { await fetch('/api/plan', { method: 'PATCH', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(batch) }); } catch { /* local preview */ }
  }

  async function deleteItem(id: string) {
    setItems((current) => current.filter((item) => item.id !== id));
    try { await fetch('/api/items', { method: 'DELETE', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ id }) }); } catch { /* local preview */ }
  }

  async function updateScene(id: string, field: keyof Scene, status: Status) {
    setScenes((current) => current.map((scene) => scene.id === id ? { ...scene, [field]: status } : scene));
    try {
      await fetch('/api/scenes', { method: 'PATCH', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ id, field, status, operator: 'Lipa' }) });
    } catch { /* optimistic update remains visible in local preview */ }
  }

  return (
    <main className="min-h-screen bg-transparent text-foreground">
      <Tabs defaultValue="today" className="mx-auto min-h-screen w-full max-w-6xl pb-24 md:pb-9">
        <header className="sticky top-0 z-30 border-b border-white/8 bg-background/88 px-4 py-3 backdrop-blur-xl md:px-8">
          <div className="mx-auto flex max-w-6xl items-center justify-between gap-3">
            <div>
              <p className="text-[12px] font-medium tracking-[0.16em] text-muted-foreground">总制片推进台</p>
              <h1 className="mt-0.5 text-lg font-semibold tracking-tight">折叠庭院的她</h1>
              <p className="mt-0.5 text-[10px] text-muted-foreground">{me ? `${me.role}：${me.name}` : '正在确认登录身份…'}</p>
            </div>
            <div className="flex items-center gap-2">
              <button onClick={() => void loadData()} aria-label="刷新全组进度" className="grid h-9 w-9 place-items-center rounded-full border border-white/8 bg-white/4 text-muted-foreground">
                <RefreshCw className={`h-4 w-4 ${syncing ? 'animate-spin' : ''}`} />
              </button>
              <div className="flex items-center gap-2 rounded-full border border-emerald-400/20 bg-emerald-400/8 px-3 py-1.5 text-sm text-emerald-300">
                <span className="h-2 w-2 rounded-full bg-emerald-400 shadow-[0_0_14px_rgba(52,211,153,.85)]" />全组同步
              </div>
            </div>
          </div>
        </header>

        <div className="px-4 py-5 md:px-8 md:py-8">
          <div className="mx-auto max-w-6xl">
            <TabsContent value="today" className="mt-0"><TodayView selectedDate={selectedDate} setSelectedDate={setSelectedDate} items={todayItems} progress={dayProgress} completed={completed} planned={planned} isAdmin={Boolean(me?.isAdmin)} onEdit={setSelectedItem} onAdd={setCreatingRole} onToggle={(item, checked) => void updateItem(item.id, { status: checked ? '已通过' : '未开始', completedQty: checked ? item.plannedQty : 0 })} /></TabsContent>
            <TabsContent value="plan" className="mt-0"><PlanView items={items} batches={batches} isAdmin={Boolean(me?.isAdmin)} onEdit={setSelectedBatch} /></TabsContent>
            <TabsContent value="scenes" className="mt-0"><ScenesView scenes={scenes} isAdmin={Boolean(me?.isAdmin)} onChange={updateScene} /></TabsContent>
            <TabsContent value="breakdown" className="mt-0"><ScriptAnalysisView isAdmin={Boolean(me?.isAdmin)} /></TabsContent>
            <TabsContent value="review" className="mt-0"><ReviewView items={pendingReview} scenes={scenes} isAdmin={Boolean(me?.isAdmin)} updateItem={updateItem} updateScene={updateScene} /></TabsContent>
          </div>
        </div>

        <TabsList className="fixed inset-x-3 bottom-3 z-40 mx-auto grid h-[68px] max-w-xl grid-cols-5 rounded-[22px] border border-white/10 bg-[#17191d]/96 p-1.5 shadow-2xl backdrop-blur-xl md:static md:mt-2 md:h-12 md:max-w-2xl md:rounded-xl">
          <NavTab value="today" label="今日" icon={<LayoutDashboard />} />
          <NavTab value="plan" label="大计划" icon={<Rows3 />} />
          <NavTab value="scenes" label="场次" icon={<Film />} />
          <NavTab value="breakdown" label="拆剧本" icon={<Sparkles />} />
          <NavTab value="review" label={`微信确认${pendingReview.length ? ` ${pendingReview.length}` : ''}`} icon={<ListChecks />} />
        </TabsList>
      </Tabs>

      <TaskEditor item={selectedItem} allItems={items} open={Boolean(selectedItem) && Boolean(me?.isAdmin)} saving={saving} onClose={() => setSelectedItem(null)} onDelete={async () => { if (!selectedItem || !window.confirm(`确定删除“${selectedItem.title}”吗？`)) return; await deleteItem(selectedItem.id); setSelectedItem(null); }} onSave={async (changes) => {
        if (!selectedItem) return;
        setSaving(true);
        await updateItem(selectedItem.id, changes);
        setSaving(false);
        setSelectedItem(null);
      }} />
      <NewTaskEditor role={creatingRole} workDate={selectedDate} allItems={items} open={Boolean(creatingRole)} onClose={() => setCreatingRole(null)} onSave={async (draft) => { await createItem(draft); setCreatingRole(null); }} />
      <BatchEditor batch={selectedBatch} open={Boolean(selectedBatch)} onClose={() => setSelectedBatch(null)} onSave={async (batch) => { await updateBatch(batch); setSelectedBatch(null); }} />
    </main>
  );
}

function TodayView({ selectedDate, setSelectedDate, items, progress, completed, planned, isAdmin, onEdit, onAdd, onToggle }: { selectedDate: string; setSelectedDate: (value: string) => void; items: ProductionItem[]; progress: number; completed: number; planned: number; isAdmin: boolean; onEdit: (item: ProductionItem) => void; onAdd: (role: string) => void; onToggle: (item: ProductionItem, checked: boolean) => void }) {
  const [showSummary, setShowSummary] = useState(false);
  const [copied, setCopied] = useState(false);
  const dateText = new Intl.DateTimeFormat('zh-CN', { month: 'long', day: 'numeric', weekday: 'short', timeZone: 'UTC' }).format(new Date(`${selectedDate}T00:00:00Z`));
  const incomplete = items.filter((item) => item.status !== '已通过').length;
  const workflowLanes = buildWorkflowLanes(items);
  const finishedItems = items.filter((item) => item.status === '已通过');
  const unfinishedItems = items.filter((item) => item.status !== '已通过');
  const rolloverItems = unfinishedItems.filter((item) => item.owner !== '红人（Yoyo）');
  const yoyoPendingItems = unfinishedItems.filter((item) => item.owner === '红人（Yoyo）');
  const dayNumber = Math.max(1, Math.round((new Date(`${selectedDate}T00:00:00Z`).getTime() - new Date('2026-09-10T00:00:00Z').getTime()) / 86400000) + 1);
  const selectedMonthDay = `${Number(selectedDate.slice(5, 7))}月${Number(selectedDate.slice(8, 10))}日`;
  useEffect(() => { setShowSummary(false); setCopied(false); }, [selectedDate]);

  function moveDay(offset: number) {
    const next = new Date(`${selectedDate}T00:00:00Z`);
    next.setUTCDate(next.getUTCDate() + offset);
    const value = next.toISOString().slice(0, 10);
    if (value >= '2026-09-10' && value <= '2026-10-09') setSelectedDate(value);
  }

  async function copySummary() {
    const lines = [
      `《${dateText}每日生产汇总》`,
      `完成：${finishedItems.length}/${items.length}项`, '',
      '【已完成】', ...(finishedItems.length ? finishedItems.map((item) => `✓ ${item.owner}｜${item.title}`) : ['无']), '',
      '【未完成】', ...(unfinishedItems.length ? unfinishedItems.map((item) => `□ ${item.owner}｜${item.title}`) : ['无']), '',
      '【需要顺延】', ...(rolloverItems.length ? rolloverItems.map((item) => `→ ${item.owner}｜${item.title}`) : ['无']), '',
      '【Yoyo异步待回】', ...(yoyoPendingItems.length ? yoyoPendingItems.map((item) => `□ ${item.title}`) : ['无']),
    ];
    await navigator.clipboard.writeText(lines.join('\n'));
    setCopied(true);
    window.setTimeout(() => setCopied(false), 1600);
  }
  return <>
    <section className="grid gap-4 md:grid-cols-[1.45fr_.75fr]">
      <div className="control-card overflow-hidden p-5 md:p-7">
        <div className="flex items-start justify-between gap-4">
          <div className="min-w-0">
            <div className="flex items-center gap-2"><p className="eyebrow">每日 RUNDOWN</p><span className="rounded-full bg-white/5 px-2 py-0.5 text-[10px] text-muted-foreground">{dateText}</span></div>
            <h2 className="mt-2 text-2xl font-semibold tracking-tight md:text-3xl">{selectedDate <= '2026-09-11' ? '第一集开机筹备' : '滚动生产日'}</h2>
            <p className="mt-2 max-w-xl text-[15px] leading-6 text-muted-foreground">剧本、场景图与白模同步推进；Yoyo在微信异步审核，未回复不阻断可继续的制作。</p>
          </div>
            <div className="relative grid h-20 w-20 shrink-0 place-items-center rounded-full" title="今日进度 = 实际完成量 ÷ 计划量" style={{ background: `conic-gradient(#ff6240 0 ${progress}%, rgba(255,255,255,.08) ${progress}% 100%)` }}>
            <div className="grid h-[66px] w-[66px] place-items-center rounded-full bg-card"><div className="text-center"><b className="text-xl">{progress}%</b><span className="block text-[10px] text-muted-foreground">完成量/计划量</span></div></div>
          </div>
        </div>
        <div className="mt-6 grid grid-cols-3 gap-2 border-t border-white/8 pt-4">
          <Metric label="完成" value={String(completed)} suffix={`/ ${planned}`} />
          <Metric label="Yoyo待回" value={String(items.filter((item) => item.owner === '红人（Yoyo）' && item.status !== '已通过').length)} suffix="项" accent />
          <Metric label="未完成" value={String(incomplete)} suffix="项" />
        </div>
      </div>
      <div className="control-card p-5 md:p-6">
        <div className="flex items-center justify-between"><p className="eyebrow">选择工作日</p><CalendarDays className="h-4 w-4 text-[#ff6240]" /></div>
        <input type="date" min="2026-09-10" max="2026-10-09" value={selectedDate} onChange={(event) => setSelectedDate(event.target.value)} className="mt-4 h-11 w-full rounded-lg border border-white/10 bg-white/5 px-3 text-base outline-none focus:border-[#ff6240]" />
        <div className="mt-3 grid grid-cols-2 gap-2"><Button variant="outline" disabled={selectedDate === '2026-09-10'} onClick={() => moveDay(-1)}><ChevronLeft />前一天</Button><Button variant="outline" disabled={selectedDate === '2026-10-09'} onClick={() => moveDay(1)}>后一天<ChevronRight /></Button></div>
        <p className="mt-5 text-3xl font-semibold tracking-[-.04em]">{selectedMonthDay}</p><p className="mt-1 text-sm text-muted-foreground">正式筹备 Day {dayNumber} · 10月9日硬交付</p>
      </div>
    </section>
    {items.length > 0 && <section className="mt-7">
      <div className="mb-3 flex items-end justify-between gap-3"><div><p className="eyebrow">TODAY&apos;S WORKFLOWS</p><h2 className="mt-1 text-xl font-semibold">今日主要工作流</h2></div><span className="rounded-full border border-cyan-400/20 bg-cyan-400/8 px-3 py-1 text-xs text-cyan-300">{workflowLanes.length}条同步推进</span></div>
      <div className="space-y-3">{workflowLanes.map((lane, laneIndex) => {
        const laneDone = lane.filter((item) => item.status === '已通过').length;
        const isAsyncReview = lane.some((item) => item.owner === '红人（Yoyo）');
        return <article key={lane.map((item) => item.id).join('-')} className="rounded-2xl border border-white/8 bg-card p-3.5 md:p-4"><div className="flex items-center justify-between gap-3"><div className="flex items-center gap-2"><span className="grid h-7 w-7 place-items-center rounded-full bg-white/6 text-xs font-semibold">{laneIndex + 1}</span><div><h3 className="text-sm font-medium">{workflowLaneName(lane)}</h3><p className={`text-[11px] ${isAsyncReview ? 'text-violet-300' : 'text-muted-foreground'}`}>{isAsyncReview ? '异步审核 · 未回复不阻断其他制作线' : lane.length > 1 ? `串行 · 按顺序完成${lane.length}步` : '可与其他工作流并行'}</p></div></div><span className={`rounded-full border px-2.5 py-1 text-xs ${laneDone === lane.length ? 'border-emerald-400/20 bg-emerald-400/10 text-emerald-300' : 'border-white/8 bg-white/4 text-muted-foreground'}`}>{laneDone}/{lane.length}</span></div><div className="mt-3 flex gap-2 overflow-x-auto pb-1">{lane.map((item, index) => {
          const checked = item.status === '已通过';
          return <div key={item.id} className="flex shrink-0 items-center gap-2"><div className={`w-[250px] rounded-xl border p-3 ${checked ? 'border-emerald-400/25 bg-emerald-400/[.055]' : 'border-red-400/25 bg-red-400/[.045]'}`}><div className="flex items-start gap-3"><Checkbox checked={checked} disabled={!isAdmin} onCheckedChange={(nextChecked) => onToggle(item, Boolean(nextChecked))} aria-label={`${item.title}${checked ? '已完成' : '未完成'}`} className="mt-0.5 size-5 border-red-400/70 text-black data-checked:border-emerald-400 data-checked:bg-emerald-400" /><div className="min-w-0 flex-1"><p className="text-[11px] text-muted-foreground">{item.owner} · {item.dueTime}</p><p className={`mt-1 text-sm font-medium leading-5 ${checked ? 'text-zinc-500 line-through' : ''}`}>{item.title}</p></div>{isAdmin && <button onClick={() => onEdit(item)} aria-label={`编辑${item.title}`} className="grid h-7 w-7 shrink-0 place-items-center rounded-lg text-muted-foreground hover:bg-white/5 hover:text-white"><Pencil className="h-3.5 w-3.5" /></button>}</div>{item.handoffTo && <p className={`mt-2 border-t border-white/6 pt-2 text-[11px] ${checked ? 'text-emerald-300' : 'text-muted-foreground'}`}>交给：{item.handoffTo} · {item.handoffDeadline}</p>}</div>{index < lane.length - 1 && <div className="flex shrink-0 flex-col items-center text-zinc-600"><ChevronRight className="h-5 w-5" /><span className="mt-0.5 text-[9px]">然后</span></div>}</div>;
        })}</div></article>;
      })}</div>
    </section>}
    <section className="mt-7">
      <div className="mb-3 flex items-end justify-between"><div><p className="eyebrow">TODAY&apos;S HANDOFF</p><h2 className="mt-1 text-xl font-semibold">当天必须交付</h2></div><span className="text-sm text-muted-foreground">{items.length} 项</span></div>
      <div className="grid gap-3 lg:grid-cols-2">
        {roles.map((role) => {
          const roleItems = items.filter((item) => item.owner === role || (role === 'AIGC抽卡师' && item.owner === '抽卡师'));
          return <section key={role} className="rounded-2xl border border-white/8 bg-card p-3 md:p-4">
            <div className="mb-3 flex items-center justify-between"><div className="flex items-center gap-2"><span className="grid h-8 w-8 place-items-center rounded-full bg-white/6 text-sm font-semibold">{role.includes('Lipa') ? 'L' : role.includes('Yoyo') ? 'Y' : role.includes('叶总') ? '叶' : role.slice(0, 1)}</span><div><h3 className="text-sm font-medium">{role === 'AIGC抽卡师' ? '抽卡师' : role}</h3><p className="text-[10px] text-muted-foreground">{roleItems.length ? `${roleItems.length} 项工作` : '今天尚未排活'}</p></div></div>{isAdmin && <button onClick={() => onAdd(role)} className="rounded-lg border border-white/10 px-2.5 py-1.5 text-xs text-muted-foreground hover:text-white">＋ 添加</button>}</div>
            <div className="space-y-2">{roleItems.length ? roleItems.map((item) => <RoleTask key={item.id} item={item} editable={isAdmin} onEdit={() => onEdit(item)} onToggle={(checked) => onToggle(item, checked)} />) : isAdmin ? <button onClick={() => onAdd(role)} className="w-full rounded-xl border border-dashed border-white/10 py-4 text-xs text-muted-foreground">为{role === 'AIGC抽卡师' ? '抽卡师' : role}安排今日工作</button> : <p className="rounded-xl border border-dashed border-white/8 py-4 text-center text-xs text-muted-foreground">今日无任务</p>}</div>
          </section>;
        })}
      </div>
    </section>
    <section className="mt-7 rounded-2xl border border-white/8 bg-card p-4 md:p-5">
      <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between"><div><p className="eyebrow">DAILY REPORT</p><h2 className="mt-1 text-xl font-semibold">每日生产汇总</h2><p className="mt-1 text-sm text-muted-foreground">根据当天打钩结果，自动整理完成、未完成和需要顺延的工作。</p></div><Button onClick={() => setShowSummary(true)} className="h-11 shrink-0"><ListChecks />一键生成今日汇总</Button></div>
      {showSummary && <div className="mt-4 border-t border-white/8 pt-4"><div className="flex items-center justify-between gap-3"><p className="font-medium">{dateText} · 完成 {finishedItems.length}/{items.length} 项</p><Button variant="outline" size="sm" onClick={() => void copySummary()}><ClipboardCopy />{copied ? '已复制' : '复制发群'}</Button></div><div className="mt-4 grid gap-3 md:grid-cols-3"><SummaryGroup title="已完成" tone="green" items={finishedItems} empty="今天还没有勾选完成项" /><SummaryGroup title="未完成" tone="red" items={unfinishedItems} empty="今天任务已全部完成" /><SummaryGroup title="需要顺延" tone="amber" items={rolloverItems} empty="没有需要顺延的团队任务" /></div>{yoyoPendingItems.length > 0 && <div className="mt-3 rounded-xl border border-violet-400/20 bg-violet-400/[.05] p-3"><p className="text-sm font-medium text-violet-300">Yoyo异步待回 · {yoyoPendingItems.length}项</p><p className="mt-1 text-xs leading-5 text-muted-foreground">保持红色未勾即可，不计入团队顺延，也不影响剧本、美术和白模继续工作。</p></div>}</div>}
    </section>
    <section className="mt-4 rounded-2xl border border-[#ff6240]/20 bg-[#ff6240]/8 p-4 md:p-5"><div className="flex gap-3"><div className="mt-0.5 grid h-8 w-8 shrink-0 place-items-center rounded-full bg-[#ff6240] text-black"><ChevronRight className="h-4 w-4" /></div><div><p className="font-medium">怎么推进</p><p className="mt-1 text-sm leading-6 text-muted-foreground">Yoyo没回复时，编剧、美术和白模继续做。第一集的最终意见确认后，再开始生成正式视频。视频素材全部生成后，先粗搭一版交给剪辑师，剪辑师用2—3天完成剪辑。</p></div></div></section>
  </>;
}

function ScriptAnalysisView({ isAdmin }: { isAdmin: boolean }) {
  const [analyses, setAnalyses] = useState<ScriptAnalysis[]>([]);
  const [assetItems, setAssetItems] = useState<ScriptAssetItem[]>([]);
  const [modelReady, setModelReady] = useState<boolean | null>(null);
  const [episode, setEpisode] = useState('第1集');
  const [sceneNo, setSceneNo] = useState(1);
  const [sceneTitle, setSceneTitle] = useState('');
  const [scriptText, setScriptText] = useState('');
  const [analyzing, setAnalyzing] = useState(false);
  const [error, setError] = useState('');

  async function loadAnalyses() {
    try {
      const response = await fetch('/api/script-analysis', { cache: 'no-store' });
      const data = await response.json() as { analyses?: ScriptAnalysis[]; items?: Array<Omit<ScriptAssetItem, 'yoyoApproved'> & { yoyoApproved: boolean | number }>; modelReady?: boolean };
      setAnalyses(data.analyses || []);
      setAssetItems((data.items || []).map((item) => ({ ...item, yoyoApproved: Boolean(item.yoyoApproved) })));
      setModelReady(Boolean(data.modelReady));
    } catch {
      setError('暂时无法读取拆解记录，请刷新后重试');
    }
  }

  useEffect(() => { void loadAnalyses(); }, []);

  async function analyzeScript() {
    if (!scriptText.trim()) return;
    setAnalyzing(true);
    setError('');
    try {
      const response = await fetch('/api/script-analysis', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ episode, sceneNo, sceneTitle, scriptText }) });
      const data = await response.json() as { error?: string };
      if (!response.ok) throw new Error(data.error || '分析失败');
      await loadAnalyses();
      setScriptText('');
      setSceneTitle('');
    } catch (nextError) {
      setError(nextError instanceof Error ? nextError.message : '分析失败');
    } finally {
      setAnalyzing(false);
    }
  }

  async function toggleApproval(item: ScriptAssetItem, checked: boolean) {
    setAssetItems((current) => current.map((candidate) => candidate.id === item.id ? { ...candidate, yoyoApproved: checked } : candidate));
    const response = await fetch('/api/script-analysis', { method: 'PATCH', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ id: item.id, yoyoApproved: checked }) });
    if (!response.ok) {
      setAssetItems((current) => current.map((candidate) => candidate.id === item.id ? { ...candidate, yoyoApproved: !checked } : candidate));
      setError('审核结果保存失败，请重试');
    }
  }

  return <section>
    <div className="mb-5 flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between"><div><p className="eyebrow">AI SCRIPT BREAKDOWN</p><h2 className="mt-1 text-2xl font-semibold">单场剧本拆解</h2><p className="mt-2 text-sm leading-6 text-muted-foreground">粘贴一场戏，自动拆出场景、人物、服装、妆发、道具和需要生成的美术图。</p></div><span className={`w-fit rounded-full border px-3 py-1.5 text-xs ${modelReady ? 'border-emerald-400/20 bg-emerald-400/10 text-emerald-300' : 'border-amber-400/20 bg-amber-400/10 text-amber-300'}`}>{modelReady ? '模型已接通' : '等待接入模型'}</span></div>
    <div className="control-card p-4 md:p-6">
      <div className="grid gap-3 sm:grid-cols-[120px_100px_1fr]"><Field label="集数"><input value={episode} onChange={(event) => setEpisode(event.target.value)} className="edit-input" /></Field><Field label="场次"><input type="number" min="1" value={sceneNo} onChange={(event) => setSceneNo(Number(event.target.value))} className="edit-input" /></Field><Field label="场名（可不填）"><input value={sceneTitle} onChange={(event) => setSceneTitle(event.target.value)} className="edit-input" placeholder="例如：陆文川初入庭院" /></Field></div>
      <Field label="单场剧本文字"><Textarea value={scriptText} onChange={(event) => setScriptText(event.target.value)} rows={10} className="mt-3" placeholder="把这一场的场景描述、动作和台词粘贴到这里……" /></Field>
      <div className="mt-4 flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between"><p className="text-xs leading-5 text-muted-foreground">模型只做初步拆解；Lipa检查后发微信给Yoyo逐项确认。</p><Button disabled={!isAdmin || !modelReady || !scriptText.trim() || analyzing} onClick={() => void analyzeScript()} className="h-11 shrink-0"><Sparkles className={analyzing ? 'animate-pulse' : ''} />{analyzing ? '正在拆解…' : '开始AI拆解'}</Button></div>
      {error && <p className="mt-3 rounded-xl border border-red-400/20 bg-red-400/[.06] px-3 py-2 text-sm text-red-300">{error}</p>}
    </div>

    <div className="mt-7 flex items-end justify-between"><div><p className="eyebrow">YOYO CHECKLIST</p><h2 className="mt-1 text-xl font-semibold">逐项确认清单</h2></div><span className="text-sm text-muted-foreground">红色未过 · 绿色已过</span></div>
    <div className="mt-3 space-y-4">{analyses.length ? analyses.map((analysis) => {
      const rows = assetItems.filter((item) => item.analysisId === analysis.id).sort((a, b) => a.sortOrder - b.sortOrder);
      const approved = rows.filter((item) => item.yoyoApproved).length;
      return <article key={analysis.id} className="control-card p-4 md:p-5"><div className="flex flex-col gap-2 border-b border-white/8 pb-4 sm:flex-row sm:items-start sm:justify-between"><div><p className="text-xs text-[#ff8066]">{analysis.episode} · 第{analysis.sceneNo}场</p><h3 className="mt-1 text-lg font-medium">{analysis.sceneTitle}</h3><p className="mt-1 text-sm text-muted-foreground">{analysis.location}{analysis.sceneSummary ? ` · ${analysis.sceneSummary}` : ''}</p></div><span className={`w-fit rounded-full border px-3 py-1 text-xs ${approved === rows.length && rows.length ? 'border-emerald-400/20 bg-emerald-400/10 text-emerald-300' : 'border-white/10 bg-white/5 text-muted-foreground'}`}>{approved}/{rows.length} 已通过</span></div><div className="mt-4 grid gap-3 md:grid-cols-2">{rows.map((item) => <div key={item.id} className={`rounded-xl border p-3 ${item.yoyoApproved ? 'border-emerald-400/25 bg-emerald-400/[.05]' : 'border-red-400/25 bg-red-400/[.045]'}`}><div className="flex items-start gap-3"><Checkbox checked={item.yoyoApproved} disabled={!isAdmin} onCheckedChange={(checked) => void toggleApproval(item, Boolean(checked))} aria-label={`${item.name}${item.yoyoApproved ? '已通过' : '未通过'}`} className="mt-0.5 size-5 border-red-400/70 text-black data-checked:border-emerald-400 data-checked:bg-emerald-400" /><div className="min-w-0"><div className="flex flex-wrap items-center gap-2"><span className="rounded-md bg-white/6 px-2 py-0.5 text-[10px] text-muted-foreground">{item.category}</span><p className={`text-sm font-medium ${item.yoyoApproved ? 'text-zinc-500 line-through' : ''}`}>{item.name}</p></div><p className="mt-2 text-xs leading-5 text-zinc-300">{item.detail}</p>{item.visualBrief && <p className="mt-2 border-t border-white/6 pt-2 text-[11px] leading-5 text-muted-foreground"><span className="text-zinc-400">美术出图：</span>{item.visualBrief}</p>}</div></div></div>)}</div></article>;
    }) : <Empty text={modelReady === false ? '模型接通后，在上方粘贴单场剧本开始拆解' : '还没有剧本拆解记录'} />}</div>
  </section>;
}

function PlanView({ items, batches, isAdmin, onEdit }: { items: ProductionItem[]; batches: PlanBatch[]; isAdmin: boolean; onEdit: (batch: PlanBatch) => void }) {
  return <section>
    <div className="mb-5 flex items-end justify-between"><div><p className="eyebrow">MASTER PLAN · 9.10—10.09</p><h2 className="mt-1 text-2xl font-semibold">一个月滚动大计划</h2></div><span className="hidden text-sm text-muted-foreground sm:block">筹备、生成、剪辑错峰衔接</span></div>
    <div className="control-card overflow-hidden">
      <div className="grid grid-cols-[76px_1fr_1fr] border-b border-white/8 px-4 py-3 text-xs text-muted-foreground md:grid-cols-[150px_1fr_1fr]"><span>日期</span><span>正式生产</span><span>同步筹备</span></div>
      <div className="divide-y divide-white/8">{batches.map((batch, index) => <TimelineRow key={batch.id} dates={batch.startDate === batch.endDate ? shortDate(batch.startDate) : `${shortDate(batch.startDate)}—${shortDate(batch.endDate)}`} production={batch.production} prep={batch.prep} note={batch.note} highlight={index === 0 || index === batches.length - 1} editable={isAdmin} onEdit={() => onEdit(batch)} />)}</div>
    </div>
    <div className="mt-5 grid gap-3 md:grid-cols-4">
      {roles.map((role) => {
        const roleItems = items.filter((item) => item.owner === role);
        const passed = roleItems.filter((item) => item.status === '已通过').length;
        const percent = roleItems.length ? Math.round((passed / roleItems.length) * 100) : 0;
        return <div key={role} className="rounded-2xl border border-white/8 bg-card p-4"><div className="flex items-center justify-between"><span className="text-sm font-medium">{role}</span><span className="text-xs text-muted-foreground">{passed}/{roleItems.length}</span></div><Progress value={percent} className="mt-4" /></div>;
      })}
    </div>
  </section>;
}

function ScenesView({ scenes, isAdmin, onChange }: { scenes: Scene[]; isAdmin: boolean; onChange: (id: string, field: keyof Scene, status: Status) => void }) {
  return <section>
    <div className="mb-5"><p className="eyebrow">SCENE PIPELINE</p><h2 className="mt-1 text-2xl font-semibold">第1集 · 逐场生产</h2><p className="mt-2 text-sm text-muted-foreground">每个环节完成后直接勾选；再次点击可以取消完成。</p></div>
    <div className="space-y-3">{scenes.map((scene) => {
      const passed = stageLabels.filter((stage) => scene[stage.key] === '已通过').length;
      return <article key={scene.id} className="control-card p-4 md:p-5">
        <div className="flex items-start justify-between gap-4"><div><p className="text-xs text-[#ff8168]">第1集 · 第{scene.sceneNo}场</p><h3 className="mt-1 text-base font-medium md:text-lg">{scene.title}</h3><p className="mt-1 text-xs text-muted-foreground">{scene.location}</p></div><span className="rounded-full bg-white/5 px-2.5 py-1 text-xs text-muted-foreground">{passed}/8</span></div>
        <div className="mt-4 grid grid-cols-4 gap-2 md:grid-cols-8">{stageLabels.map((stage) => {
          const value = scene[stage.key] as Status;
          const checked = value === '已通过';
          return <label key={String(stage.key)} className={`flex min-h-[76px] cursor-pointer flex-col items-center justify-center rounded-xl border px-1 py-2 text-center transition has-[:disabled]:cursor-default ${statusStyle[value]}`}><Checkbox checked={checked} disabled={!isAdmin} onCheckedChange={(nextChecked) => onChange(scene.id, stage.key, nextChecked ? '已通过' : '未开始')} aria-label={`${stage.label}${checked ? '已完成' : '未完成'}`} className="mb-2 size-5 border-white/30 data-checked:border-emerald-400 data-checked:bg-emerald-400 data-checked:text-black" /><span className="block text-[12px]">{stage.label}</span><span className="mt-0.5 block text-[10px] opacity-75">{checked ? '已完成' : value}</span></label>;
        })}</div>
      </article>;
    })}</div>
  </section>;
}

function ReviewView({ items, scenes, isAdmin, updateItem, updateScene }: { items: ProductionItem[]; scenes: Scene[]; isAdmin: boolean; updateItem: (id: string, changes: Partial<ProductionItem>) => Promise<void>; updateScene: (id: string, field: keyof Scene, status: Status) => Promise<void> }) {
  const sceneReviews = scenes.flatMap((scene) => stageLabels.filter((stage) => scene[stage.key] === '待审核').map((stage) => ({ scene, stage })));
  const total = items.length + sceneReviews.length;
  return <section>
    <div className="mb-5 flex items-start justify-between gap-4"><div><p className="eyebrow">WECHAT CHECKLIST</p><h2 className="mt-1 text-2xl font-semibold">微信确认清单</h2><p className="mt-2 text-sm text-muted-foreground">Yoyo在微信回复后，由Lipa勾选“已确认”；打回意见记录在任务备注里。</p></div><div className="rounded-2xl border border-violet-400/20 bg-violet-400/10 px-4 py-3 text-center"><b className="text-2xl text-violet-300">{total}</b><span className="block text-[10px] text-muted-foreground">等微信回复</span></div></div>
    {!total ? <Empty text="当前审核队列已清空" success /> : <div className="space-y-3">
      {items.map((item) => <article key={item.id} className="control-card flex items-center gap-3 p-4 md:p-5"><button disabled={!isAdmin} role="checkbox" aria-checked="false" aria-label={`微信已确认：${item.title}`} onClick={() => void updateItem(item.id, { status: '已通过', completedQty: item.plannedQty })} className="grid h-8 w-8 shrink-0 place-items-center rounded-lg border-2 border-white/20 bg-white/4 text-transparent transition enabled:hover:border-emerald-400 enabled:hover:bg-emerald-400/10 enabled:hover:text-emerald-300 disabled:cursor-default"><Check className="h-5 w-5" /></button><div className="min-w-0 flex-1"><p className="text-xs text-violet-300">{item.episode} · {item.category}</p><h3 className="mt-1 font-medium">{item.title}</h3><p className="mt-1.5 text-xs text-muted-foreground">微信确认人：{item.reviewer} · 提交：{item.owner} · {item.dueTime}</p></div>{isAdmin && <Button variant="destructive" size="sm" onClick={() => void updateItem(item.id, { status: '打回' })}><X />记录打回</Button>}</article>)}
      {sceneReviews.map(({ scene, stage }) => <article key={`${scene.id}-${String(stage.key)}`} className="control-card flex items-center gap-3 p-4"><button disabled={!isAdmin} role="checkbox" aria-checked="false" aria-label={`微信已确认：第${scene.sceneNo}场${stage.label}`} onClick={() => void updateScene(scene.id, stage.key, '已通过')} className="grid h-8 w-8 shrink-0 place-items-center rounded-lg border-2 border-white/20 bg-white/4 text-transparent transition enabled:hover:border-emerald-400 enabled:hover:bg-emerald-400/10 enabled:hover:text-emerald-300 disabled:cursor-default"><Check className="h-5 w-5" /></button><div className="min-w-0 flex-1"><p className="text-xs text-violet-300">第1集 · 第{scene.sceneNo}场 · {stage.label}</p><h3 className="mt-1 font-medium">{scene.title}</h3></div>{isAdmin && <Button variant="destructive" size="sm" onClick={() => void updateScene(scene.id, stage.key, '打回')}><X />记录打回</Button>}</article>)}
    </div>}
  </section>;
}

function TaskEditor({ item, allItems, open, saving, onClose, onDelete, onSave }: { item: ProductionItem | null; allItems: ProductionItem[]; open: boolean; saving: boolean; onClose: () => void; onDelete: () => Promise<void>; onSave: (changes: Partial<ProductionItem>) => Promise<void> }) {
  const [draft, setDraft] = useState<ProductionItem | null>(null);
  useEffect(() => { if (item) setDraft({ ...item }); }, [item]);
  if (!open || !draft) return null;
  const set = <K extends keyof ProductionItem>(key: K, value: ProductionItem[K]) => setDraft((current) => current ? { ...current, [key]: value } : current);
  return <div className="fixed inset-0 z-50 grid place-items-end bg-black/70 backdrop-blur-sm sm:place-items-center sm:p-4" onMouseDown={(event) => { if (event.currentTarget === event.target) onClose(); }}><section role="dialog" aria-modal="true" aria-labelledby="task-editor-title" className="max-h-[92vh] w-full max-w-xl overflow-y-auto rounded-t-[24px] border border-white/10 bg-[#1b1d22] p-5 shadow-2xl sm:rounded-[20px]"><div className="flex items-start justify-between gap-4"><div><h2 id="task-editor-title" className="text-lg font-medium">编辑任务</h2><p className="mt-1 text-sm text-muted-foreground">任务、材料接收关系、交接对象和deadline都可以调整</p></div><button onClick={onClose} aria-label="关闭" className="grid h-8 w-8 place-items-center rounded-full bg-white/5"><X className="h-4 w-4" /></button></div><div className="mt-5 space-y-4"><Field label="任务名称"><input value={draft.title} onChange={(event) => set('title', event.target.value)} className="edit-input" /></Field><div className="grid grid-cols-2 gap-3"><Field label="工作日期"><input type="date" value={draft.workDate} onChange={(event) => set('workDate', event.target.value)} className="edit-input" /></Field><Field label="本人完成 deadline"><TimeSelect value={draft.dueTime} onChange={(value) => set('dueTime', value)} /></Field></div><div className="grid grid-cols-2 gap-3"><Field label="负责人"><select value={draft.owner} onChange={(event) => set('owner', event.target.value)} className="edit-input">{roles.map((role) => <option key={role} value={role}>{role === 'AIGC抽卡师' ? '抽卡师' : role}</option>)}</select></Field><Field label="状态"><select value={draft.status} onChange={(event) => set('status', event.target.value as Status)} className="edit-input">{STATUSES.map((value) => <option key={value} value={value}>{value}</option>)}</select></Field></div><Field label="必须先收到的任务 / 材料"><select value={draft.dependsOnId} onChange={(event) => set('dependsOnId', event.target.value)} className="edit-input"><option value="">不需要等材料，可直接开始</option>{allItems.filter((candidate) => candidate.id !== draft.id).map((candidate) => <option key={candidate.id} value={candidate.id}>{shortDate(candidate.workDate)} · {candidate.owner} · {candidate.title}</option>)}</select></Field><div className="grid grid-cols-2 gap-3"><Field label="完成后交给谁"><input value={draft.handoffTo} onChange={(event) => set('handoffTo', event.target.value)} className="edit-input" placeholder="如：剪辑 / Yoyo" /></Field><Field label="交接 deadline"><input value={draft.handoffDeadline} onChange={(event) => set('handoffDeadline', event.target.value)} className="edit-input" placeholder="如：20:00" /></Field></div><div className="grid grid-cols-2 gap-3"><Field label="集数"><input value={draft.episode} onChange={(event) => set('episode', event.target.value)} className="edit-input" /></Field><Field label="工作类型"><input value={draft.category} onChange={(event) => set('category', event.target.value)} className="edit-input" /></Field></div><div className="grid grid-cols-2 gap-3"><Field label="计划量"><input type="number" min="0" value={draft.plannedQty} onChange={(event) => set('plannedQty', Number(event.target.value))} className="edit-input" /></Field><Field label="实际完成"><input type="number" min="0" value={draft.completedQty} onChange={(event) => set('completedQty', Number(event.target.value))} className="edit-input" /></Field></div><Field label="同步统筹 / 备注 / 打回原因"><Textarea value={draft.note} onChange={(event) => set('note', event.target.value)} rows={3} /></Field></div><div className="mt-5 grid grid-cols-[auto_1fr_1fr] gap-2"><Button variant="destructive" className="h-11" onClick={() => void onDelete()}>删除</Button><Button variant="outline" className="h-11" onClick={onClose}>取消</Button><Button className="h-11" disabled={saving} onClick={() => void onSave(draft)}>{saving ? <Loader2 className="animate-spin" /> : <Check />}保存并同步</Button></div></section></div>;
}

function LegacyTaskEditor({ item, open, saving, onClose, onSave }: { item: ProductionItem | null; open: boolean; saving: boolean; onClose: () => void; onSave: (changes: Partial<Pick<ProductionItem, 'status' | 'completedQty' | 'note'>>) => Promise<void> }) {
  const [status, setStatus] = useState<Status>('未开始');
  const [completedQty, setCompletedQty] = useState(0);
  const [note, setNote] = useState('');
  useEffect(() => { if (item) { setStatus(item.status); setCompletedQty(item.completedQty); setNote(item.note); } }, [item]);
  if (!open || !item) return null;
  return <div className="fixed inset-0 z-50 grid place-items-end bg-black/70 p-0 backdrop-blur-sm sm:place-items-center sm:p-4" onMouseDown={(event) => { if (event.currentTarget === event.target) onClose(); }}><section role="dialog" aria-modal="true" aria-labelledby="task-editor-title" className="w-full max-w-md rounded-t-[24px] border border-white/10 bg-[#1b1d22] p-5 shadow-2xl sm:rounded-[20px]"><div className="flex items-start justify-between gap-4"><div><h2 id="task-editor-title" className="text-lg font-medium">更新任务</h2><p className="mt-1 text-sm text-muted-foreground">{item.episode} · {item.category} · {item.owner}</p></div><button onClick={onClose} aria-label="关闭" className="grid h-8 w-8 place-items-center rounded-full bg-white/5"><X className="h-4 w-4" /></button></div><div className="mt-5 space-y-4"><div><label className="mb-1.5 block text-sm text-muted-foreground">任务</label><p className="rounded-xl bg-white/5 p-3 text-sm leading-6">{item.title}</p></div><div className="grid grid-cols-2 gap-3"><div><label className="mb-1.5 block text-sm text-muted-foreground">状态</label><select value={status} onChange={(event) => setStatus(event.target.value as Status)} className="h-10 w-full rounded-lg border border-white/10 bg-[#24272d] px-3 text-sm outline-none focus:border-[#ff6240]">{STATUSES.map((value) => <option key={value} value={value}>{value}</option>)}</select></div><div><label className="mb-1.5 block text-sm text-muted-foreground">完成量 / {item.plannedQty}</label><input type="number" min="0" value={completedQty} onChange={(event) => setCompletedQty(Number(event.target.value))} className="h-10 w-full rounded-lg border border-white/10 bg-white/5 px-3 outline-none focus:border-[#ff6240]" /></div></div><div><label className="mb-1.5 block text-sm text-muted-foreground">备注 / 打回原因</label><Textarea value={note} onChange={(event) => setNote(event.target.value)} rows={3} /></div></div><div className="mt-5 grid grid-cols-2 gap-2"><Button variant="outline" className="h-11" onClick={onClose}>取消</Button><Button className="h-11" disabled={saving} onClick={() => void onSave({ status, completedQty, note })}>{saving ? <Loader2 className="animate-spin" /> : <Check />}保存更新</Button></div></section></div>;
}

function TaskCard({ item, onEdit }: { item: ProductionItem; onEdit: () => void }) {
  const categoryColor: Record<string, string> = { 剧本: 'bg-cyan-400', 审核: 'bg-violet-400', 场景图: 'bg-amber-400', 白模: 'bg-pink-400', 正式镜头: 'bg-[#ff6240]', 初剪: 'bg-blue-400', 精剪: 'bg-indigo-400', 成片: 'bg-emerald-400' };
  const ratio = item.plannedQty ? Math.min(100, Math.round(item.completedQty / item.plannedQty * 100)) : 0;
  return <button onClick={onEdit} className="group flex w-full items-center gap-3 rounded-2xl border border-white/8 bg-card px-3.5 py-4 text-left transition hover:border-white/16 hover:bg-[#202329] md:px-5"><div className="w-12 shrink-0 text-center"><p className="font-mono text-sm text-muted-foreground">{item.dueTime}</p><span className={`mx-auto mt-2 block h-1.5 w-1.5 rounded-full ${categoryColor[item.category] || 'bg-zinc-400'}`} /></div><div className="min-w-0 flex-1 border-l border-white/8 pl-3.5 md:pl-5"><div className="flex items-center gap-2 text-xs text-muted-foreground"><span>{item.owner}</span><span>·</span><span>{item.episode}</span></div><h3 className="mt-1 truncate text-[15px] font-medium md:text-base">{item.title}</h3><div className="mt-2 flex items-center gap-2"><div className="h-1 w-24 overflow-hidden rounded-full bg-white/8"><div className="h-full rounded-full bg-[#ff6240]" style={{ width: `${ratio}%` }} /></div><span className="text-[11px] text-muted-foreground">{item.completedQty}/{item.plannedQty}</span></div></div><div className="flex items-center gap-2"><span className={`hidden rounded-full border px-2.5 py-1 text-xs sm:block ${statusStyle[item.status]}`}>{item.status}</span><Pencil className="h-4 w-4 text-muted-foreground transition group-hover:text-white" /></div></button>;
}

function RoleTask({ item, editable, onEdit, onToggle }: { item: ProductionItem; editable: boolean; onEdit: () => void; onToggle: (checked: boolean) => void }) {
  const checked = item.status === '已通过';
  return <div className={`flex w-full items-start gap-3 rounded-xl border p-3 text-left ${checked ? 'border-emerald-400/25 bg-emerald-400/[.05]' : 'border-red-400/25 bg-red-400/[.04]'}`}><Checkbox checked={checked} disabled={!editable} onCheckedChange={(nextChecked) => onToggle(Boolean(nextChecked))} aria-label={`${item.title}${checked ? '已完成' : '未完成'}`} className="mt-0.5 size-5 border-red-400/70 text-black data-checked:border-emerald-400 data-checked:bg-emerald-400" /><div className="min-w-0 flex-1"><p className={`text-sm ${checked ? 'text-zinc-500 line-through' : ''}`}>{item.title}</p><p className="mt-1 text-[11px] text-muted-foreground">{item.episode} · {item.dueTime}</p></div>{editable && <button onClick={onEdit} aria-label={`编辑${item.title}`} className="grid h-7 w-7 shrink-0 place-items-center rounded-lg text-muted-foreground hover:bg-white/5 hover:text-white"><Pencil className="h-3.5 w-3.5" /></button>}</div>;
}

function TimelineRow({ dates, production, prep, note, highlight = false, editable, onEdit }: { dates: string; production: string; prep: string; note: string; highlight?: boolean; editable: boolean; onEdit: () => void }) {
  return <button disabled={!editable} onClick={onEdit} className={`grid w-full grid-cols-[76px_1fr_1fr_auto] items-center px-4 py-4 text-left text-sm enabled:hover:bg-white/[.025] disabled:cursor-default md:grid-cols-[150px_1fr_1fr_auto] md:px-5 ${highlight ? 'bg-[#ff6240]/7' : ''}`}><span className="font-mono text-xs text-muted-foreground">{dates}</span><div className="pr-3"><span className="inline-block h-2 w-2 rounded-full bg-[#ff6240]" /><span className="ml-2">{production}</span><span className="mt-1 hidden text-[10px] text-muted-foreground md:block">{note}</span></div><div className="border-l border-white/8 pl-3 text-muted-foreground md:pl-5">{prep}</div>{editable ? <Pencil className="h-3.5 w-3.5 text-muted-foreground" /> : <span />}</button>;
}

function NewTaskEditor({ role, workDate, allItems, open, onClose, onSave }: { role: string | null; workDate: string; allItems: ProductionItem[]; open: boolean; onClose: () => void; onSave: (draft: Partial<ProductionItem>) => Promise<void> }) {
  const [title, setTitle] = useState('');
  const [date, setDate] = useState(workDate);
  const [time, setTime] = useState('18:00');
  const [episode, setEpisode] = useState('第1集');
  const [category, setCategory] = useState('统筹');
  const [qty, setQty] = useState(1);
  const [note, setNote] = useState('');
  const [dependsOnId, setDependsOnId] = useState('');
  const [handoffTo, setHandoffTo] = useState('');
  const [handoffDeadline, setHandoffDeadline] = useState('');
  useEffect(() => { if (open) { setTitle(''); setDate(workDate); setTime('18:00'); setNote(''); setDependsOnId(''); setHandoffTo(''); setHandoffDeadline(''); setCategory(role === '编剧' ? '剧本' : role === '主美' ? '场景图' : role === 'AIGC抽卡师' ? '正式镜头' : role === '剪辑' ? '初剪' : role?.includes('Yoyo') ? '审核' : '统筹'); } }, [open, role, workDate]);
  if (!open || !role) return null;
  return <div className="fixed inset-0 z-50 grid place-items-end bg-black/70 backdrop-blur-sm sm:place-items-center sm:p-4"><section role="dialog" aria-modal="true" className="max-h-[92vh] w-full max-w-lg overflow-y-auto rounded-t-[24px] border border-white/10 bg-[#1b1d22] p-5 sm:rounded-[20px]"><div className="flex items-center justify-between"><div><h2 className="text-lg font-medium">给{role === 'AIGC抽卡师' ? '抽卡师' : role}安排工作</h2><p className="mt-1 text-sm text-muted-foreground">新增后全组同步可见</p></div><button onClick={onClose} className="grid h-8 w-8 place-items-center rounded-full bg-white/5"><X className="h-4 w-4" /></button></div><div className="mt-5 space-y-4"><Field label="任务名称"><input autoFocus value={title} onChange={(event) => setTitle(event.target.value)} className="edit-input" placeholder="今天必须完成什么" /></Field><div className="grid grid-cols-2 gap-3"><Field label="日期"><input type="date" value={date} onChange={(event) => setDate(event.target.value)} className="edit-input" /></Field><Field label="本人 deadline"><TimeSelect value={time} onChange={setTime} /></Field></div><Field label="必须先收到的任务 / 材料"><select value={dependsOnId} onChange={(event) => setDependsOnId(event.target.value)} className="edit-input"><option value="">不需要等材料，可直接开始</option>{allItems.map((candidate) => <option key={candidate.id} value={candidate.id}>{shortDate(candidate.workDate)} · {candidate.owner} · {candidate.title}</option>)}</select></Field><div className="grid grid-cols-2 gap-3"><Field label="完成后交给谁"><input value={handoffTo} onChange={(event) => setHandoffTo(event.target.value)} className="edit-input" /></Field><Field label="交接 deadline"><input value={handoffDeadline} onChange={(event) => setHandoffDeadline(event.target.value)} className="edit-input" /></Field></div><div className="grid grid-cols-3 gap-3"><Field label="集数"><input value={episode} onChange={(event) => setEpisode(event.target.value)} className="edit-input" /></Field><Field label="类型"><input value={category} onChange={(event) => setCategory(event.target.value)} className="edit-input" /></Field><Field label="计划量"><input type="number" min="0" value={qty} onChange={(event) => setQty(Number(event.target.value))} className="edit-input" /></Field></div><Field label="同步统筹备注"><Textarea value={note} onChange={(event) => setNote(event.target.value)} rows={3} placeholder="交接条件、风险、需要等待的材料……" /></Field></div><div className="mt-5 grid grid-cols-2 gap-2"><Button variant="outline" className="h-11" onClick={onClose}>取消</Button><Button className="h-11" disabled={!title.trim()} onClick={() => void onSave({ title, workDate: date, dueTime: time, episode, category, plannedQty: qty, owner: role, reviewer: 'Yoyo', dependsOnId, handoffTo, handoffDeadline, note })}><Check />添加并同步</Button></div></section></div>;
}

function BatchEditor({ batch, open, onClose, onSave }: { batch: PlanBatch | null; open: boolean; onClose: () => void; onSave: (batch: PlanBatch) => Promise<void> }) {
  const [draft, setDraft] = useState<PlanBatch | null>(null);
  useEffect(() => { if (batch) setDraft({ ...batch }); }, [batch]);
  if (!open || !draft) return null;
  const set = <K extends keyof PlanBatch>(key: K, value: PlanBatch[K]) => setDraft((current) => current ? { ...current, [key]: value } : current);
  return <div className="fixed inset-0 z-50 grid place-items-end bg-black/70 backdrop-blur-sm sm:place-items-center sm:p-4"><section role="dialog" aria-modal="true" className="w-full max-w-lg rounded-t-[24px] border border-white/10 bg-[#1b1d22] p-5 sm:rounded-[20px]"><div className="flex items-center justify-between"><div><h2 className="text-lg font-medium">调整大计划</h2><p className="mt-1 text-sm text-muted-foreground">修改后作为全组最新基准</p></div><button onClick={onClose} className="grid h-8 w-8 place-items-center rounded-full bg-white/5"><X className="h-4 w-4" /></button></div><div className="mt-5 space-y-4"><div className="grid grid-cols-2 gap-3"><Field label="开始日期"><input type="date" value={draft.startDate} onChange={(event) => set('startDate', event.target.value)} className="edit-input" /></Field><Field label="结束日期"><input type="date" value={draft.endDate} onChange={(event) => set('endDate', event.target.value)} className="edit-input" /></Field></div><Field label="正式生产"><input value={draft.production} onChange={(event) => set('production', event.target.value)} className="edit-input" /></Field><Field label="同步筹备"><input value={draft.prep} onChange={(event) => set('prep', event.target.value)} className="edit-input" /></Field><Field label="时间余量 / 统筹备注"><Textarea value={draft.note} onChange={(event) => set('note', event.target.value)} rows={3} /></Field></div><div className="mt-5 grid grid-cols-2 gap-2"><Button variant="outline" className="h-11" onClick={onClose}>取消</Button><Button className="h-11" onClick={() => void onSave(draft)}><Check />保存并同步</Button></div></section></div>;
}

function Field({ label, children }: { label: string; children: React.ReactNode }) { return <label className="block"><span className="mb-1.5 block text-sm text-muted-foreground">{label}</span>{children}</label>; }

function TimeSelect({ value, onChange }: { value: string; onChange: (value: string) => void }) {
  const standardValues = new Set([...timeOptions, '异步', '收到后']);
  return <select value={value} onChange={(event) => onChange(event.target.value)} className="edit-input">{!standardValues.has(value) && <option value={value}>{value}</option>}<option value="异步">异步（不设时间）</option><option value="收到后">收到后</option>{timeOptions.map((time) => <option key={time} value={time}>{time}</option>)}</select>;
}

function Metric({ label, value, suffix, accent = false }: { label: string; value: string; suffix: string; accent?: boolean }) { return <div><p className="text-xs text-muted-foreground">{label}</p><p className={`mt-1 text-xl font-semibold ${accent ? 'text-violet-300' : ''}`}>{value}<span className="ml-1 text-xs font-normal text-muted-foreground">{suffix}</span></p></div>; }
function SummaryGroup({ title, tone, items, empty }: { title: string; tone: 'green' | 'red' | 'amber'; items: ProductionItem[]; empty: string }) {
  const styles = tone === 'green' ? 'border-emerald-400/20 bg-emerald-400/[.045] text-emerald-300' : tone === 'red' ? 'border-red-400/20 bg-red-400/[.04] text-red-300' : 'border-amber-400/20 bg-amber-400/[.045] text-amber-300';
  return <div className={`rounded-xl border p-3 ${styles}`}><div className="flex items-center justify-between"><p className="text-sm font-medium">{title}</p><span className="text-xs">{items.length}项</span></div><div className="mt-2 space-y-2">{items.length ? items.map((item) => <div key={item.id} className="border-t border-white/6 pt-2"><p className="text-xs leading-5 text-zinc-200">{item.title}</p><p className="mt-0.5 text-[11px] text-muted-foreground">{item.owner}</p></div>) : <p className="text-xs leading-5 text-muted-foreground">{empty}</p>}</div></div>;
}
function NavTab({ value, label, icon }: { value: string; label: string; icon: React.ReactNode }) { return <TabsTrigger value={value} className="group flex h-full flex-col gap-1 rounded-[16px] text-xs text-zinc-500 data-[state=active]:bg-white/8 data-[state=active]:text-white md:flex-row md:gap-2 md:rounded-lg [&_svg]:h-[18px] [&_svg]:w-[18px]"><span>{icon}</span><span>{label}</span></TabsTrigger>; }
function Empty({ text, success = false }: { text: string; success?: boolean }) { return <div className="control-card grid min-h-52 place-items-center p-8 text-center"><div><div className={`mx-auto grid h-11 w-11 place-items-center rounded-full ${success ? 'bg-emerald-400/10 text-emerald-300' : 'bg-white/5 text-muted-foreground'}`}>{success ? <CheckCircle2 className="h-5 w-5" /> : <CircleDashed className="h-5 w-5" />}</div><p className="mt-3 text-sm text-muted-foreground">{text}</p></div></div>; }
function shortDate(date: string) { const [, month, day] = date.split('-'); return `${Number(month)}.${day}`; }
function buildWorkflowLanes(items: ProductionItem[]) {
  const ordered = items.slice().sort((a, b) => a.sortOrder - b.sortOrder);
  const byId = new Map(ordered.map((item) => [item.id, item]));
  const neighbors = new Map(ordered.map((item) => [item.id, new Set<string>()]));
  for (const item of ordered) {
    const isAsyncReviewEdge = item.owner === '红人（Yoyo）' || item.category === '红人审核';
    if (!isAsyncReviewEdge && item.dependsOnId && byId.has(item.dependsOnId)) {
      neighbors.get(item.id)?.add(item.dependsOnId);
      neighbors.get(item.dependsOnId)?.add(item.id);
    }
  }
  const visited = new Set<string>();
  const lanes: ProductionItem[][] = [];
  for (const item of ordered) {
    if (visited.has(item.id)) continue;
    const queue = [item.id];
    const component: ProductionItem[] = [];
    visited.add(item.id);
    while (queue.length) {
      const id = queue.shift();
      if (!id) continue;
      const row = byId.get(id);
      if (row) component.push(row);
      for (const neighbor of neighbors.get(id) || []) {
        if (!visited.has(neighbor)) { visited.add(neighbor); queue.push(neighbor); }
      }
    }
    component.sort((a, b) => workflowDepth(a, byId) - workflowDepth(b, byId) || a.dueTime.localeCompare(b.dueTime) || a.sortOrder - b.sortOrder);
    lanes.push(component);
  }
  return lanes.sort((a, b) => Math.min(...a.map((item) => item.sortOrder)) - Math.min(...b.map((item) => item.sortOrder)));
}

function workflowDepth(item: ProductionItem, byId: Map<string, ProductionItem>, seen = new Set<string>()): number {
  if (!item.dependsOnId || !byId.has(item.dependsOnId) || seen.has(item.id)) return 0;
  const upstream = byId.get(item.dependsOnId);
  if (!upstream) return 0;
  const nextSeen = new Set(seen);
  nextSeen.add(item.id);
  return 1 + workflowDepth(upstream, byId, nextSeen);
}

function workflowLaneName(lane: ProductionItem[]) {
  if (lane.some((item) => item.owner === '红人（Yoyo）')) return 'Yoyo微信异步审核';
  if (lane.some((item) => item.category.includes('剧本'))) return '剧本与过会';
  if (lane.some((item) => item.category === '场景图')) return '美术提报与审核';
  if (lane.some((item) => item.category === '白模')) return '场景白模制作';
  if (lane.some((item) => item.owner === '剪辑')) return '剪辑交付';
  if (lane.some((item) => item.owner === 'AIGC抽卡师')) return '正式镜头生成';
  return `${lane[0]?.category || '当日'}工作流`;
}
