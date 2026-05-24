# Mathematics — Memorias de licenciatura y maestría

[![Publish site](https://github.com/Alonso-Celis/Mathematics/actions/workflows/publish.yml/badge.svg)](https://github.com/Alonso-Celis/Mathematics/actions/workflows/publish.yml)

This repository hosts mathematics memoirs by **Alonso Celis**, served as a
multilingual static site on GitHub Pages.

## Live site

| Language          | URL                                                                        |
|-------------------|----------------------------------------------------------------------------|
| 🇲🇽 Español       | <https://alonso-celis.github.io/Mathematics/>                              |
| 🇬🇧 English       | <https://alonso-celis.github.io/Mathematics/en/>                           |
| 🇫🇷 Français      | <https://alonso-celis.github.io/Mathematics/fr/>                           |

The full thesis — *Encajes entre nociones de forcing* — is published in all
three languages: landing + Preliminares + Encajes + Aplicaciones, with
cross-referenced theorems, proofs, the canonical bibliography
([Kunen](references.bib), Jech, Shelah, Krivine, …), a per-language
"Download PDF" button on every page, and a built-in search restricted to
the visitor's current language.

### Landing pages

<a href="https://alonso-celis.github.io/Mathematics/">
  <img src="assets/screenshots/landing-es.png"
       alt="Spanish landing page"
       width="32%" />
</a>
<a href="https://alonso-celis.github.io/Mathematics/en/">
  <img src="assets/screenshots/landing-en.png"
       alt="English landing page"
       width="32%" />
</a>
<a href="https://alonso-celis.github.io/Mathematics/fr/">
  <img src="assets/screenshots/landing-fr.png"
       alt="French landing page"
       width="32%" />
</a>

<sub>
🇲🇽 <a href="https://alonso-celis.github.io/Mathematics/">Español</a>
&nbsp;·&nbsp;
🇬🇧 <a href="https://alonso-celis.github.io/Mathematics/en/">English</a>
&nbsp;·&nbsp;
🇫🇷 <a href="https://alonso-celis.github.io/Mathematics/fr/">Français</a>
</sub>

Full-page chapter captures (multi-MB each) live alongside the landings:
[`chapter-es.png`](assets/screenshots/chapter-es.png) ·
[`chapter-en.png`](assets/screenshots/chapter-en.png) ·
[`chapter-fr.png`](assets/screenshots/chapter-fr.png).

## Current memoir

**Encajes entre nociones de forcing** — Bachelor's thesis, Faculty of
Sciences, UNAM (2013). Original Spanish PDF:
[`pdf/ENCAJES_ENTRE_NOCIONES_DE_FORCING.pdf`](pdf/ENCAJES_ENTRE_NOCIONES_DE_FORCING.pdf).
LaTeX source under [`tex-source/`](tex-source/) with
[`MIGRATION.md`](tex-source/MIGRATION.md) describing the `.tex → .qmd`
recipe and the EN/FR terminology glossaries.

A second document, `pdf/StageAlonsoCELIS.pdf` (Master internship report),
is archived but not yet integrated into the site.

## Repo structure

```
.
├── _quarto.yml                 # Shared base (no chapter list)
├── _quarto-es.yml              # Spanish profile  (root /)
├── _quarto-en.yml              # English profile  (/en/)
├── _quarto-fr.yml              # French profile   (/fr/)
├── _brand.yml                  # Palette + typography
├── index.{es,en,fr}.qmd        # Landing pages per language
├── chapters/                   # One trio (.es / .en / .fr) per chapter
├── references.bib              # Shared bibliography
├── assets/
│   ├── css/custom.scss         # Academic typography
│   ├── logos/                  # UNAM escudos (escudo-unam, escudo-ciencias)
│   └── screenshots/            # Live-site PNGs (refreshed by workflow)
├── scripts/screenshot.js       # Playwright driver for site captures
├── tex-source/                 # Frozen original LaTeX + glossaries
├── pdf/                        # Source PDFs
└── .github/workflows/
    ├── publish.yml             # Build + deploy on every push to main
    └── screenshots.yml         # Manual: refresh assets/screenshots/
```

## Local preview

Requires [Quarto](https://quarto.org) ≥ 1.5:

```bash
quarto render --profile es      # build Spanish at _site/
quarto render --profile en      # build English at _site/en/
quarto render --profile fr      # build French at _site/fr/
quarto preview --profile es     # local server, Spanish
```

## Publishing

Push to `main` → GitHub Actions renders all three languages and deploys to
GitHub Pages.

One-time setup: in repository **Settings → Pages**, select **Build and
deployment: GitHub Actions**.

## Citing this work

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.20370496.svg)](https://doi.org/10.5281/zenodo.20370496)

Machine-readable metadata lives in [`CITATION.cff`](CITATION.cff) — GitHub
renders a *"Cite this repository"* widget from it in the sidebar. BibTeX:

```bibtex
@phdthesis{celis2013encajes,
  author    = {Celis Mart{\'i}nez, Alonso Lenin},
  title     = {Encajes entre nociones de forcing},
  school    = {Facultad de Ciencias, UNAM},
  type      = {Tesis de licenciatura},
  year      = {2013},
  url       = {https://alonso-celis.github.io/Mathematics/},
  doi       = {10.5281/zenodo.20370496}
}
```

### Re-archiving future releases

Each subsequent `gh release create vX.Y.Z` fires a release webhook to
Zenodo, which archives the source tarball and issues a fresh
version-specific DOI under the umbrella concept-DOI
[`10.5281/zenodo.20370496`](https://doi.org/10.5281/zenodo.20370496).
After a new release lands, update the `doi:` field in
[`CITATION.cff`](CITATION.cff) and the four BibTeX blocks (this one
plus the three landing pages) to the new version DOI.

## Refreshing site screenshots

```bash
gh workflow run "Capture screenshots"
```

Opens a `bot/screenshots` PR adding refreshed PNGs under
`assets/screenshots/`. Driven by `scripts/screenshot.js`
(Chromium / Playwright). Re-running updates the same branch.

## License

The text and figures of each memoir are © Alonso Celis. The site
infrastructure (configs, workflow, theme, scripts) is released under the
MIT License.
