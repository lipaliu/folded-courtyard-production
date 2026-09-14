'use client';
/* oxlint-disable next/no-img-element */
import { useEffect, useRef, useState } from 'react';
import { createPortal } from 'react-dom';
import { X, ChevronLeft, ChevronRight } from 'lucide-react';
import { uploadAuthorLabel } from '@/lib/upload-attribution';

type Reference = { id: string; url: string; fileName: string; uploadedBy: string };
export function ReferenceLightbox({ files, initialId, onClose }: { files: Reference[]; initialId: string; onClose: () => void }) {
  const [selectedId, setSelectedId] = useState(initialId);
  const dialog = useRef<HTMLDialogElement>(null);
  const index = Math.max(0, files.findIndex((file) => file.id === selectedId));
  const file = files[index];
  function step(direction: number) { setSelectedId(files[(index + direction + files.length) % files.length].id); }
  useEffect(() => {
    const element = dialog.current;
    const focused = document.activeElement as HTMLElement | null;
    element?.showModal();
    return () => { element?.close(); focused?.focus(); };
  }, []);
  if (!file) return null;
  return createPortal(<dialog ref={dialog} aria-label="参考图大图预览" onCancel={onClose} onClick={(event) => { if (event.target === event.currentTarget) onClose(); }} onKeyDown={(event) => { if (event.key === 'ArrowLeft') step(-1); if (event.key === 'ArrowRight') step(1); }} className="fixed inset-0 m-auto h-[94dvh] w-[96vw] max-w-6xl rounded-2xl border border-white/20 bg-[#080d13] p-4 text-white backdrop:bg-black/85">
    <div className="flex items-center gap-3"><p className="min-w-0 flex-1 truncate text-sm">{file.fileName} · {index + 1}/{files.length}</p><button autoFocus onClick={onClose} aria-label="关闭大图" className="rounded-full bg-white/10 p-2"><X /></button></div>
    <div className="relative mt-3 flex h-[calc(94dvh-190px)] items-center justify-center"><img src={file.url} alt={file.fileName} className="h-full w-full object-contain" />{files.length > 1 && <><button aria-label="上一张" onClick={() => step(-1)} className="absolute left-0 rounded-full bg-black/75 p-2"><ChevronLeft /></button><button aria-label="下一张" onClick={() => step(1)} className="absolute right-0 rounded-full bg-black/75 p-2"><ChevronRight /></button></>}</div>
    <p className="my-2 text-center text-xs text-cyan-300">{uploadAuthorLabel(file.uploadedBy)}</p>
    <div className="flex gap-2 overflow-x-auto pb-2">{files.map((image) => <button key={image.id} onClick={() => setSelectedId(image.id)} aria-label={`查看${image.fileName}`} aria-pressed={image.id === file.id} className={`h-16 w-20 shrink-0 overflow-hidden rounded-lg border ${image.id === file.id ? 'border-cyan-300' : 'border-white/15'}`}><img src={image.url} alt={image.fileName} className="h-full w-full object-contain" /></button>)}</div>
  </dialog>, document.body);
}
