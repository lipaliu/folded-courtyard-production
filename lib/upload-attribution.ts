export function uploadAuthorLabel(uploadedBy?: string) {
  const author = uploadedBy?.trim();
  return author ? `上传人：${author}` : '上传人：历史图·未记录';
}

export function uploadTimeLabel(createdAt?: string) {
  if (!createdAt) return '';
  const date = new Date(createdAt);
  if (Number.isNaN(date.getTime())) return '';
  return new Intl.DateTimeFormat('zh-CN', {
    timeZone: 'Asia/Shanghai', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', hour12: false,
  }).format(date);
}
