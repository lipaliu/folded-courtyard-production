import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { test } from 'node:test';
import ts from 'typescript';

const source = ts.transpileModule(readFileSync(new URL('../lib/image-upload-queue.ts', import.meta.url), 'utf8'), {
  compilerOptions: { module: ts.ModuleKind.ESNext, target: ts.ScriptTarget.ES2022 },
}).outputText;
const { ImageUploadQueue } = await import(`data:text/javascript;base64,${Buffer.from(source).toString('base64')}`);
const tick = () => new Promise((resolve) => setImmediate(resolve));
const files = (...names) => names.map((name) => new File(['image'], `${name}.png`, { type: 'image/png' }));

test('multi-file queue runs three requests concurrently and accepts additional drops while busy', async () => {
  const started = [];
  const finish = new Map();
  let snapshot = [], idle = 0;
  const queue = new ImageUploadQueue((file) => new Promise((resolve) => {
    started.push(file.name); finish.set(file.name, resolve);
  }), (entries) => { snapshot = entries; }, () => { idle++; });
  queue.add(files('a', 'b', 'c', 'd'));
  await tick();
  assert.deepEqual(started, ['a.png', 'b.png', 'c.png']);
  queue.add(files('e', 'f'));
  assert.equal(snapshot.length, 6);
  finish.get('b.png')();
  await tick();
  assert.deepEqual(started, ['a.png', 'b.png', 'c.png', 'd.png']);
  for (const name of ['a.png', 'c.png', 'd.png', 'e.png', 'f.png']) {
    finish.get(name)(); await tick();
  }
  assert.equal(snapshot.filter((entry) => entry.status === 'done').length, 6);
  assert.equal(idle, 1);
});

test('failure does not stop remaining files and retry only resends that failed image', async () => {
  const calls = [];
  let fail = true, snapshot = [];
  const queue = new ImageUploadQueue(async (file) => {
    calls.push(file.name);
    if (file.name === 'bad.png' && fail) throw new Error('网络中断');
  }, (entries) => { snapshot = entries; }, () => {});
  queue.add(files('a', 'bad', 'c', 'd', 'e'));
  await tick();
  assert.equal(snapshot.filter((entry) => entry.status === 'done').length, 4);
  const failed = snapshot.find((entry) => entry.status === 'failed');
  assert.equal(failed.error, '网络中断');
  fail = false;
  queue.retry(failed.id); queue.retry(failed.id);
  await tick();
  assert.equal(snapshot.filter((entry) => entry.status === 'done').length, 5);
  assert.equal(calls.length, 6);
  assert.equal(calls.filter((name) => name === 'a.png').length, 1);
});
