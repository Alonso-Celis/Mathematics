// Capture full-page screenshots of the published site.
// Run from the Playwright base image (browsers preinstalled), or any
// environment with `playwright` available on the module path.

const { chromium } = require('playwright');
const fs = require('fs');
const path = require('path');

const BASE = process.env.SITE_BASE || 'https://alonso-celis.github.io/Mathematics';

const targets = [
  { name: 'landing-es', url: `${BASE}/` },
  { name: 'landing-en', url: `${BASE}/en/` },
  { name: 'landing-fr', url: `${BASE}/fr/` },
  { name: 'chapter-es', url: `${BASE}/chapters/01-preliminares.es.html` },
  { name: 'chapter-en', url: `${BASE}/en/chapters/01-preliminares.en.html` },
  { name: 'chapter-fr', url: `${BASE}/fr/chapters/01-preliminares.fr.html` },
];

const outDir = path.join('assets', 'screenshots');
fs.mkdirSync(outDir, { recursive: true });

(async () => {
  const browser = await chromium.launch();
  const context = await browser.newContext({
    viewport: { width: 1280, height: 800 },
    deviceScaleFactor: 2,
  });

  for (const t of targets) {
    const page = await context.newPage();
    console.log(`-> ${t.name}: ${t.url}`);
    const response = await page.goto(t.url, { waitUntil: 'networkidle', timeout: 30_000 });
    if (!response || !response.ok()) {
      throw new Error(`Bad response for ${t.url}: ${response && response.status()}`);
    }
    // Let KaTeX finish rendering math.
    await page.waitForFunction(
      () => !document.querySelector('annotation[encoding="application/x-tex"]') ||
            document.querySelectorAll('.katex').length > 0 ||
            !document.querySelector('.math'),
      { timeout: 10_000 }
    ).catch(() => {});
    await page.waitForTimeout(800);
    const out = path.join(outDir, `${t.name}.png`);
    await page.screenshot({ path: out, fullPage: true });
    console.log(`   wrote ${out}`);
    await page.close();
  }

  await browser.close();
})().catch((err) => {
  console.error(err);
  process.exit(1);
});
