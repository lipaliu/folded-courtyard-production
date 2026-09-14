export type UploadEntry = { id: number; file: File; status: 'queued' | 'uploading' | 'done' | 'failed'; error: string };

/** An appendable queue: failed files never block the rest of the batch. */
export class ImageUploadQueue {
  private entries: UploadEntry[] = [];
  private active = 0;
  private nextId = 0;

  constructor(
    private upload: (file: File) => Promise<unknown>,
    private changed: (entries: UploadEntry[]) => void,
    private idle: () => void,
    private concurrency = 3,
  ) {}

  add(files: File[]) {
    if (!files.length) return;
    if (!this.active && !this.entries.some((entry) => entry.status === 'queued')) {
      this.entries = this.entries.filter((entry) => entry.status !== 'done');
    }
    this.entries.push(...files.map((file): UploadEntry => ({ id: ++this.nextId, file, status: 'queued', error: '' })));
    this.publish();
    this.pump();
  }

  retry(id: number) {
    const entry = this.entries.find((candidate) => candidate.id === id);
    if (!entry || entry.status !== 'failed') return;
    entry.status = 'queued';
    entry.error = '';
    this.publish();
    this.pump();
  }

  private publish() { this.changed(this.entries.map((entry) => ({ ...entry }))); }

  private pump() {
    while (this.active < this.concurrency) {
      const entry = this.entries.find((candidate) => candidate.status === 'queued');
      if (!entry) break;
      entry.status = 'uploading';
      this.active += 1;
      this.publish();
      void Promise.resolve().then(() => this.upload(entry.file)).then(() => {
        entry.status = 'done';
      }, (error: unknown) => {
        entry.status = 'failed';
        entry.error = error instanceof Error ? error.message : '图片上传失败';
      }).finally(() => {
        this.active -= 1;
        this.publish();
        this.pump();
        if (!this.active && !this.entries.some((candidate) => candidate.status === 'queued')) this.idle();
      });
    }
  }
}
