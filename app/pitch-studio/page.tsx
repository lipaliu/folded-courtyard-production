import type { Metadata } from 'next';

import { ScriptPitchStudio } from '@/components/script-pitch-studio';

export const dynamic = 'force-dynamic';

export const metadata: Metadata = {
  title: '《折叠庭院的她》剧本提报系统',
  description: '单集剧本上传、版本管理与公开提报同步后台',
};

export default function PitchStudioPage() {
  return <ScriptPitchStudio />;
}
