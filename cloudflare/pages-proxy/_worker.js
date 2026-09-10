const WORKER_ORIGIN = "https://folded-courtyard-production.lipaliu514.workers.dev";

const pagesProxy = {
  async fetch(request) {
    const targetUrl = new URL(request.url);
    const workerUrl = new URL(WORKER_ORIGIN);
    targetUrl.protocol = workerUrl.protocol;
    targetUrl.hostname = workerUrl.hostname;
    targetUrl.port = workerUrl.port;

    return fetch(new Request(targetUrl, request));
  },
};

export default pagesProxy;
