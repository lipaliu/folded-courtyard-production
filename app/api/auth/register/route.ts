export async function POST() {
  return Response.json({ error: '项目账号仅由制片人开通，不开放公开注册' }, { status: 403 });
}
