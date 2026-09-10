import { ProductionDashboard } from '@/components/production-dashboard';
import { chatGPTSignInPath, getChatGPTUser } from '@/app/chatgpt-auth';

export const dynamic = 'force-dynamic';

export default async function Home() {
  const user = await getChatGPTUser();
  if (!user) {
    return <main className="grid min-h-screen place-items-center px-5 py-10"><section className="control-card w-full max-w-md p-7 md:p-9"><p className="eyebrow">PRODUCTION ACCESS</p><h1 className="mt-2 text-3xl font-semibold tracking-tight">折叠庭院的她</h1><p className="mt-3 text-base leading-7 text-muted-foreground">全组每日生产手册、任务进度和交接时间。项目成员登录后注册自己的岗位即可查看。</p><a href={chatGPTSignInPath('/')} target="_top" className="mt-7 flex h-12 w-full items-center justify-center rounded-xl bg-[#ff6240] px-4 font-medium text-[#17110f] transition hover:bg-[#ff765a]">使用 ChatGPT 登录／注册</a><p className="mt-4 text-center text-xs leading-5 text-muted-foreground">登录由 ChatGPT 完成，本项目不保存登录密码。</p></section></main>;
  }
  return <ProductionDashboard />;
}
