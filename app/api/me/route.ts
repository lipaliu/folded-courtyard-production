import { getSiteUser } from '@/lib/auth';

export async function GET(request: Request) {
  try {
    const user = await getSiteUser(request);
    if (!user) return Response.json({ error: '请先登录' }, { status: 401 });
    return Response.json({ user });
  } catch {
    return Response.json({ error: '暂时无法确认登录状态' }, { status: 500 });
  }
}
