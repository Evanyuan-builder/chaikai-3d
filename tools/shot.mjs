// node shot.mjs [url] [outdir] [w] [h] —— 逐屏截图
const { chromium } = await import(process.env.HOME + '/code/products/geo/node_modules/playwright/index.mjs');
const [url='http://localhost:8765/', out='/tmp/shots', w='1440', h='900'] = process.argv.slice(2);
import fs from 'fs'; fs.mkdirSync(out,{recursive:true});
const b = await chromium.launch({ args:['--use-gl=angle','--use-angle=metal','--enable-gpu'] });
const p = await b.newPage({ viewport:{width:+w,height:+h}, deviceScaleFactor:1 });
const logs=[]; p.on('console',m=>logs.push(m.type()+': '+m.text())); p.on('pageerror',e=>logs.push('ERR '+e.message));
await p.goto(url); await p.waitForSelector('#loading.done',{timeout:60000}).catch(()=>logs.push('loading not done'));
const steps = await p.$$eval('section',ss=>ss.map(s=>s.dataset.step));
for (let i=0;i<steps.length;i++){
  await p.evaluate(i=>document.querySelectorAll('section')[i].scrollIntoView({block:'center'}),i);
  await p.waitForTimeout(2600);
  await p.screenshot({path:`${out}/${String(i).padStart(2,'0')}_${steps[i]}.png`});
}
console.log(logs.slice(0,20).join('\n')); await b.close();
