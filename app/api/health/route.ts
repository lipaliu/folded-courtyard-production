import { env } from "cloudflare:workers";

export async function GET() {
  const adminSecretConfigured = Boolean(env.ADMIN_INITIAL_PASSWORD);

  try {
    const result = await env.DB.prepare("SELECT 1 AS healthy").first<{ healthy: number }>();
    return Response.json({
      ok: result?.healthy === 1,
      database: result?.healthy === 1 ? "connected" : "unexpected-response",
      adminSecretConfigured,
    });
  } catch (error) {
    console.error("Health check failed", error);
    return Response.json(
      {
        ok: false,
        database: "unavailable",
        adminSecretConfigured,
        error: error instanceof Error ? error.message : "unknown error",
      },
      { status: 500 },
    );
  }
}
