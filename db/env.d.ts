declare namespace Cloudflare {
  interface Env {
    DB: D1Database;
    ART_ASSETS: R2Bucket;
    ADMIN_INITIAL_PASSWORD?: string;
  }
}
