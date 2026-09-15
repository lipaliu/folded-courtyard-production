'use client';
import { createContext, useContext, useEffect, useRef, useState } from 'react';
import { Star } from 'lucide-react';

const FavoritesContext = createContext<{ ids: Set<string>; enabled: boolean; pending: Set<string>; toggle: (id: string) => Promise<void> }>({ ids: new Set(), enabled: false, pending: new Set(), toggle: async () => {} });
export const useArtFavorites = () => useContext(FavoritesContext);

export function ArtFavoritesProvider({ children }: { children: React.ReactNode }) {
  const [ids, setIds] = useState<Set<string>>(new Set());
  const [enabled, setEnabled] = useState(false);
  const [pending, setPending] = useState<Set<string>>(new Set());
  const busy = useRef(new Set<string>());
  useEffect(() => {
    let cancelled = false;
    void fetch('/api/art-favorites', { cache: 'no-store' }).then(async response => {
      if (!response.ok) return;
      const data = await response.json() as { fileIds: string[] };
      if (!cancelled) { setIds(new Set(data.fileIds)); setEnabled(true); }
    }).catch(() => {});
    return () => { cancelled = true; };
  }, []);
  async function toggle(id: string) {
    if (busy.current.has(id)) return;
    const favorite = !ids.has(id);
    const apply = (value: boolean) => setIds(current => { const next = new Set(current); if (value) next.add(id); else next.delete(id); return next; });
    busy.current.add(id); setPending(new Set(busy.current)); apply(favorite);
    try {
      const response = await fetch('/api/art-favorites', { method: 'PATCH', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ fileId: id, favorite }) });
      if (!response.ok) { const data = await response.json() as { error?: string }; throw new Error(data.error || '收藏保存失败'); }
    } catch (error) { apply(!favorite); throw error; }
    finally { busy.current.delete(id); setPending(new Set(busy.current)); }
  }
  return <FavoritesContext.Provider value={{ ids, enabled, pending, toggle }}>{children}</FavoritesContext.Provider>;
}

export function ArtFavoriteButton({ fileId }: { fileId: string }) {
  const { ids, enabled, pending, toggle } = useArtFavorites();
  const [error, setError] = useState('');
  if (!enabled) return null;
  const selected = ids.has(fileId);
  return <span className="inline-flex flex-col items-center gap-1"><button type="button" aria-label={selected ? '取消星标收藏' : '星标收藏'} aria-pressed={selected} disabled={pending.has(fileId)} onClick={() => { setError(''); void toggle(fileId).catch(e => setError(e instanceof Error ? e.message : '收藏失败，请重试')); }} className={`inline-flex min-h-8 items-center gap-1 rounded-md border px-2 py-1 text-xs ${selected ? 'border-amber-300/40 bg-amber-300/10 text-amber-200' : 'border-white/15 text-white/70 hover:text-amber-200'}`}><Star className="h-3.5 w-3.5" fill={selected ? 'currentColor' : 'none'} />{selected ? '已收藏' : '收藏'}</button>{error && <span role="alert" className="text-xs text-red-300">{error}</span>}</span>;
}
