declare namespace Cloudflare {
  interface Env {
    DB: D1Database;
    ADMIN_BOOTSTRAP_SECRET?: string;
  }
}
