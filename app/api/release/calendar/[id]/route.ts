import { releaseRequest } from '@/lib/release-store';
type Context={params:Promise<{id:string}>};
export async function PUT(request:Request,context:Context){return releaseRequest(request,(await context.params).id)}
export async function DELETE(request:Request,context:Context){return releaseRequest(request,(await context.params).id)}
