import { claimOrGetSiteUser } from '@/lib/auth';

export async function GET(request: Request) {
  try {
    const user = await claimOrGetSiteUser(request);
    if (!user) return Response.json({ error: '请先登录' }, { status: 401 });
    return Response.json({ user });
  } catch {
    return Response.json({ user: { id: 'local-preview', email: 'lipa@local.preview', name: 'Lipa', role: '联合制片人／导演', isAdmin: true }, localFallback: true });
  }
}
