(() => {
'use strict';
const catalog=window.MATERIAL_CATALOG, byId=id=>catalog.items.find(n=>n.id===id);
const familyScenes=[2,8,1,7,4,10,3,5,6,9,11];
const el=(tag,cls,text)=>{const e=document.createElement(tag);e.className=cls||'';if(text)e.textContent=text;return e};
const reader=el('section','material-reader');reader.hidden=true;reader.setAttribute('aria-label','物料详情');reader.setAttribute('role','dialog');
const backdrop=el('button','reader-backdrop');backdrop.type='button';backdrop.hidden=true;backdrop.tabIndex=-1;backdrop.setAttribute('aria-label','关闭物料详情');document.body.append(backdrop);
const toolbar=el('header','reader-toolbar'),crumb=el('p','reader-crumb'),close=el('button','reader-close','关闭详情 ×');close.type='button';
const nav=el('nav','reader-siblings');nav.setAttribute('aria-label','同类物料');
const surface=el('div','reader-scroll'),scene=el('div','reader-scene'),host=el('div','reader-content');scene.setAttribute('aria-hidden','true');surface.append(scene,host);toolbar.append(crumb,close);reader.append(toolbar,nav,surface);document.body.append(reader);
let active=null,placeholder=null,origin=null,returnY=0,wasOpen=false;const noteHomes=new Map();
function restore(){if(!active)return;const node=document.getElementById(active);node.open=wasOpen;while(host.firstChild){const child=host.firstChild,home=noteHomes.get(child);if(home){home.before(child);home.remove();noteHomes.delete(child)}else placeholder.before(child)}noteHomes.forEach(home=>home.remove());noteHomes.clear();placeholder.remove();placeholder=null;active=null;window.ACTIVE_MATERIAL_ID=null}
function dismiss(){restore();reader.hidden=true;backdrop.hidden=true;document.body.classList.remove('reader-open');document.querySelector('main').inert=false;window.scrollTo({top:returnY,behavior:'instant'});origin?.focus({preventScroll:true});requestAnimationFrame(()=>window.scrollTo({top:returnY,behavior:'instant'}))}
function show(id,trigger){const n=byId(id);if(!n)return;if(active===id){dismiss();return}if(!active){returnY=scrollY;reader.dataset.returnScroll=String(returnY);origin=trigger||document.activeElement}else restore();
 const node=document.getElementById(id),f=catalog.families.find(f=>f.id===n.parent);placeholder=document.createComment('material-home');node.before(placeholder);wasOpen=node.open;node.open=true;host.append(node);active=id;window.ACTIVE_MATERIAL_ID=id;
 // Keep this material's saved notes with it while reading.
 document.querySelectorAll('.user-idea').forEach(note=>{if(note.querySelector('a[href="#'+id+'"]')){const home=document.createComment('note-home');note.before(home);noteHomes.set(note,home);host.append(note)}});
 crumb.textContent=f.code+' / '+f.title;nav.replaceChildren();catalog.items.filter(x=>x.parent===f.id).forEach((item,i)=>{const b=el('button','',f.code+(i+1)+' '+item.title);b.type='button';b.setAttribute('aria-current',String(item.id===id));b.addEventListener('click',()=>show(item.id,b));nav.append(b)});
 scene.className='reader-scene scene-tone-'+familyScenes[catalog.families.indexOf(f)];reader.hidden=false;backdrop.hidden=false;document.body.classList.add('reader-open');document.querySelector('main').inert=true;surface.scrollTop=0;close.focus({preventScroll:true});
}
close.addEventListener('click',dismiss);backdrop.addEventListener('click',dismiss);document.addEventListener('keydown',e=>{if(e.key==='Escape'&&active){e.preventDefault();dismiss()}});
document.addEventListener('click',e=>{const a=e.target.closest('a[href^="#"]');if(a){const id=a.getAttribute('href').slice(1);if(byId(id)){e.preventDefault();e.stopImmediatePropagation();show(id,a);return}if(active&&document.getElementById(id)&&!reader.contains(document.getElementById(id))){dismiss();return}}
 const summary=e.target.closest('.material-leaf > summary');if(summary&&!e.target.closest('button')){e.preventDefault();e.stopImmediatePropagation();show(summary.parentElement.id,summary)}
},true);
window.addEventListener('open-material',e=>show(e.detail.id,e.detail.trigger));
const visible=new Set();const observer=new IntersectionObserver(entries=>entries.forEach(e=>{e.target.classList.toggle('scene-visible',e.isIntersecting);e.isIntersecting?visible.add(e.target):visible.delete(e.target)}),{rootMargin:'100px'});
document.querySelectorAll('.overview-family').forEach((family,i)=>{const view=el('div','family-scene scene-tone-'+familyScenes[i]);view.setAttribute('aria-hidden','true');view.style.setProperty('--scene-focus',(30+i%4*15)+'%');family.prepend(view);observer.observe(view)});
document.querySelectorAll('.chapter-heading').forEach((heading,i)=>{const view=el('div','chapter-scene scene-tone-'+familyScenes[i]);view.setAttribute('aria-hidden','true');view.append(el('span','',String(i+1).padStart(2,'0')+' / 庭院之间'));heading.prepend(view);observer.observe(view)});
document.querySelectorAll('.derived-section').forEach((section,i)=>{const view=el('div','section-scene scene-tone-'+[10,9,6][i]);view.setAttribute('aria-hidden','true');section.prepend(view);observer.observe(view)});
let frame=0;function draw(){frame=0;if(document.body.classList.contains('motion-off'))return;visible.forEach(v=>{const r=v.getBoundingClientRect();v.style.setProperty('--scene-lift',Math.max(-24,Math.min(24,(innerHeight/2-r.top-r.height/2)*.06))+'px')})}
addEventListener('scroll',()=>{if(!frame)frame=requestAnimationFrame(draw)},{passive:true});draw();
})();
