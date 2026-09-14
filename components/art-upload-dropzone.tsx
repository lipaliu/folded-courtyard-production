'use client';

import { useEffect, useRef, useState } from 'react';
import { ImagePlus, Loader2 } from 'lucide-react';
import { ImageUploadQueue, type UploadEntry } from '@/lib/image-upload-queue';

export function ArtUploadDropzone({ name, currentName, reuse, onUpload, onIdle }: {
  name: string; currentName: string; reuse: boolean;
  onUpload: (file: File) => Promise<unknown>; onIdle: () => Promise<unknown>;
}) {
  const [entries, setEntries] = useState<UploadEntry[]>([]);
  const [dragging, setDragging] = useState(false);
  const [error, setError] = useState('');
  const dragDepth = useRef(0);
  const mounted = useRef(true);
  const callbacks = useRef({ onUpload, onIdle });
  callbacks.current = { onUpload, onIdle };
  const queue = useRef<ImageUploadQueue | null>(null);
  if (!queue.current) queue.current = new ImageUploadQueue(
    (file) => callbacks.current.onUpload(file),
    (next) => { if (mounted.current) setEntries(next); },
    () => { void callbacks.current.onIdle().catch(() => {
      if (mounted.current) setError('图片已保存，外层进度暂未刷新，可稍后刷新页面。');
    }); },
  );
  useEffect(() => { mounted.current = true; return () => { mounted.current = false; }; }, []);
  function add(files: File[]) {
    const accepted = files.filter((file) => ['image/jpeg', 'image/png', 'image/webp'].includes(file.type));
    setError(accepted.length < files.length ? '部分文件不是 JPG、PNG 或 WebP，已跳过；其余图片继续上传。' : '');
    queue.current!.add(accepted);
  }
  const done = entries.filter((entry) => entry.status === 'done').length;
  const failed = entries.filter((entry) => entry.status === 'failed');
  const pending = entries.filter((entry) => entry.status === 'queued' || entry.status === 'uploading');

  return <div className="min-w-0">
    <label aria-label={`为${name}增加参考图`} className={`flex min-h-[180px] cursor-pointer flex-col items-center justify-center rounded-lg border-2 border-dashed px-2 text-center text-xs text-[#ff9a86] transition-colors ${dragging ? 'border-cyan-300 bg-cyan-300/15' : 'border-[#ff6240]/35 bg-[#ff6240]/[.04] hover:border-[#ff6240]/70'}`}
      onDragEnter={(event) => { event.preventDefault(); event.stopPropagation(); dragDepth.current += 1; setDragging(true); }}
      onDragOver={(event) => { event.preventDefault(); event.stopPropagation(); event.dataTransfer.dropEffect = 'copy'; }}
      onDragLeave={(event) => { event.preventDefault(); event.stopPropagation(); dragDepth.current = Math.max(0, dragDepth.current - 1); if (!dragDepth.current) setDragging(false); }}
      onDrop={(event) => { event.preventDefault(); event.stopPropagation(); dragDepth.current = 0; setDragging(false); add(Array.from(event.dataTransfer.files)); }}>
      <input aria-label={`上传${name}参考图`} type="file" accept="image/jpeg,image/png,image/webp" multiple className="sr-only" onChange={(event) => { add(Array.from(event.target.files || [])); event.target.value = ''; }} />
      {pending.length ? <Loader2 className="h-5 w-5 animate-spin" /> : <ImagePlus className="h-5 w-5" />}
      <span className="mt-2 font-medium">{dragging ? '松开，添加全部图片' : '拖入多张图片 / 点击多选'}</span>
      <span className="mt-1 text-[10px]">可一次多选 · 数量不限</span>
      <span className="mt-1 text-[10px] text-cyan-300">上传中也可继续拖入追加</span>
      {reuse && <span className="mt-1 text-[10px]">本场变化时另传</span>}
      <span className="mt-1 text-[10px] text-[#ff9a86]/70">每张自动署名：{currentName}</span>
    </label>
    {!!entries.length && <div className="mt-2 text-[11px] leading-5" aria-live="polite">
      <p className="text-cyan-300">{pending.length ? '上传中' : '上传结束'} · 成功 {done}/{entries.length}{failed.length ? ` · 失败 ${failed.length}` : ''}</p>
      {!!pending.length && <p className="text-zinc-400">正在上传 {pending.filter((entry) => entry.status === 'uploading').length} 张 · 排队 {pending.filter((entry) => entry.status === 'queued').length} 张</p>}
      {failed.map((entry) => <div key={entry.id} className="mt-1 rounded-md bg-red-400/10 p-2 text-red-300"><p className="break-all">{entry.file.name}：{entry.error}</p><button type="button" className="mt-1 underline" onClick={() => queue.current!.retry(entry.id)}>重试这张</button></div>)}
    </div>}
    {error && <p role="alert" className="mt-2 text-[11px] text-red-300">{error}</p>}
  </div>;
}
