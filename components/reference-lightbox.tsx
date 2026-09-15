'use client';
/* oxlint-disable next/no-img-element */
import { useEffect, useState } from 'react';
import { createPortal } from 'react-dom';
import { X, ChevronLeft, ChevronRight } from 'lucide-react';
import { uploadAuthorLabel } from '@/lib/upload-attribution';
import { ArtFavoriteButton } from '@/components/art-favorites';

type Reference = { id: string; url: string; fileName: string; uploadedBy: string };
export function ReferenceLightbox({ files, initialId, onClose, renderActions }: { files: Reference[]; initialId: string; onClose: () => void; renderActions?: (file: Reference) => React.ReactNode }) {
  const [selectedId, setSelectedId] = useState(initialId);
  const index = Math.max(0, files.findIndex((file) => file.id === selectedId));
  const file = files[index];
  function step(direction: number) { setSelectedId(files[(index + direction + files.length) % files.length].id); }
  useEffect(() => {
    const focused = document.activeElement as HTMLElement | null;
    const previousOverflow = document.body.style.overflow;
    const onKeyDown = (event: KeyboardEvent) => {
      if (event.key === 'Escape') onClose();
      if (event.key === 'ArrowLeft') step(-1);
      if (event.key === 'ArrowRight') step(1);
    };
    document.body.style.overflow = 'hidden';
    window.addEventListener('keydown', onKeyDown);
    return () => { document.body.style.overflow = previousOverflow; window.removeEventListener('keydown', onKeyDown); focused?.focus(); };
  });
  if (!file) return null;
  return createPortal(<div role="dialog" aria-modal="true" aria-label="参考图大图预览" onMouseDown={(event) => { if (event.target === event.currentTarget) onClose(); }} className="fixed inset-0 z-[200] flex min-h-0 flex-col bg-[#080d13]/98 p-3 text-white sm:p-5">
    <div className="flex shrink-0 items-center gap-3"><p className="min-w-0 flex-1 truncate text-sm">{file.fileName} · {index + 1}/{files.length}</p><button autoFocus onClick={onClose} aria-label="关闭大图" className="rounded-full bg-white/10 p-2"><X /></button></div>
    <div className="relative mt-3 flex min-h-0 flex-1 items-center justify-center overflow-hidden"><img key={file.id} decoding="async" fetchPriority="high" src={file.url} alt={file.fileName} className="block h-auto max-h-full w-auto max-w-full rounded-xl object-contain" />{files.length > 1 && <><button aria-label="上一张" onClick={() => step(-1)} className="absolute left-0 rounded-full bg-black/75 p-2"><ChevronLeft /></button><button aria-label="下一张" onClick={() => step(1)} className="absolute right-0 rounded-full bg-black/75 p-2"><ChevronRight /></button></>}</div>
    <div className="my-2 flex flex-wrap items-center justify-center gap-3"><p className="text-xs text-cyan-300">{uploadAuthorLabel(file.uploadedBy)}</p><ArtFavoriteButton fileId={file.id} />{renderActions?.(file)}</div>
    <div className="flex h-16 shrink-0 gap-2 overflow-x-auto pb-2">{files.map((image) => <button key={image.id} onClick={() => setSelectedId(image.id)} aria-label={`查看${image.fileName}`} aria-pressed={image.id === file.id} className={`h-14 w-20 shrink-0 overflow-hidden rounded-lg border bg-black/30 ${image.id === file.id ? 'border-cyan-300' : 'border-white/15'}`}><img loading="lazy" decoding="async" src={image.url} alt={image.fileName} className="h-full w-full object-contain" /></button>)}</div>
  </div>, document.body);
}
