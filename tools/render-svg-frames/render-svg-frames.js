// render-svg-frames.js
// npm i puppeteer
const puppeteer = require('puppeteer');
const path = require('path');

(async () => {
  const SVG_FILE = path.resolve(process.argv[2]); // e.g. node render-svg-frames.js animation.svg
  const OUT_PREFIX = 'throbber';      // output prefix
  const FPS = 30;                  // frames per second
  const DURATION = 6.0;            // total duration in seconds (set to actual animation length)
  const WIDTH = 697;
  const HEIGHT = 256;

  const frames = Math.round(FPS * DURATION);
  const browser = await puppeteer.launch({args: ['--enable-experimental-web-platform-features']});
  const page = await browser.newPage();
  await page.setViewport({width: WIDTH, height: HEIGHT});

  // load the SVG as a page
  await page.goto('file://' + SVG_FILE, {waitUntil: 'networkidle0'});

  // pause any running animations (SMIL or Web Animations)
  await page.evaluate(() => {
    // For SMIL
    const svg = document.querySelector('svg');
    if (svg && typeof svg.pauseAnimations === 'function') {
      svg.pauseAnimations();
    }
    // For Web Animations / CSS Animations
    if (document.getAnimations) {
      document.getAnimations().forEach(a => a.pause());
    }
  });

  for (let i = 0; i < frames; ++i) {
    const t = (i / FPS); // seconds from start

    // Set timeline for SMIL or web animations
    await page.evaluate((timeSec) => {
      const svg = document.querySelector('svg');
      if (svg && typeof svg.setCurrentTime === 'function') {
        // SMIL-friendly
        svg.setCurrentTime(timeSec);
      }
      // Web Animations API uses milliseconds
      if (document.getAnimations) {
        document.getAnimations().forEach(a => {
          try { a.currentTime = timeSec * 1000; } catch(e){}
        });
      }
      // If your animation is driven by JS timers, and you expose a setter, call it here.
    }, t);

    const filename = `${OUT_PREFIX}-${String(i+1).padStart(4,'0')}.png`;
    await page.screenshot({path: filename, omitBackground: true});
    console.log('wrote', filename);
  }

  await browser.close();
  console.log('done —', frames, 'frames rendered');
})();
