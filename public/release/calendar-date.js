/* Calendar day boundaries follow China Standard Time, independent of device zone. */
(function(root){
  function today(now=new Date()) {
    const parts=new Intl.DateTimeFormat('en-CA',{timeZone:'Asia/Shanghai',year:'numeric',month:'2-digit',day:'2-digit'}).formatToParts(now);
    const value=Object.fromEntries(parts.map(p=>[p.type,p.value]));
    return `${value.year}-${value.month}-${value.day}`;
  }
  function clamp(day,start,end){return day<start?start:day>end?end:day;}
  const api={today,clamp,current:(start,end,now)=>clamp(today(now),start,end)};
  if(typeof module!=='undefined'&&module.exports)module.exports=api;
  else root.CalendarDate=api;
})(typeof window!=='undefined'?window:globalThis);
