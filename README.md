# Mathematics — Memorias de licenciatura y maestría

[![Publish site](https://github.com/Alonso-Celis/Mathematics/actions/workflows/publish.yml/badge.svg)](https://github.com/Alonso-Celis/Mathematics/actions/workflows/publish.yml)

This repository hosts mathematics memoirs by **Alonso Celis**, served as a
multilingual static site on GitHub Pages.

- **Live site** (once Pages is enabled): <https://alonso-celis.github.io/Mathematics/>
- **Languages**: Español (original) · English · Français

## Current memoir

**Encajes entre nociones de forcing** — Bachelor's thesis, Faculty of
Sciences, UNAM. PDF: [`pdf/ENCAJES_ENTRE_NOCIONES_DE_FORCING.pdf`](pdf/ENCAJES_ENTRE_NOCIONES_DE_FORCING.pdf).

A second document, `pdf/StageAlonsoCELIS.pdf` (Master internship report),
is archived but not yet integrated into the site.

## Repo structure

```
.
├── _quarto.yml                 # Quarto book project (Spanish, root site)
├── _quarto-en.yml              # English profile (/en/)
├── _quarto-fr.yml              # French profile (/fr/)
├── _brand.yml                  # Palette + typography
├── index.{es,en,fr}.qmd        # Landing pages per language
├── chapters/                   # One trio (.es / .en / .fr) per chapter
├── references.bib              # Shared bibliography
├── assets/
│   ├── css/custom.scss         # Academic typography
│   ├── logos/                  # Decoded UNAM logos
│   └── figures/                # Extracted figures
├── tex-source/                 # Frozen original LaTeX (reference only)
├── pdf/                        # Source PDFs
└── .github/workflows/publish.yml
```

## Local preview

Requires [Quarto](https://quarto.org) ≥ 1.5:

```bash
quarto preview                  # Spanish (root)
quarto render --profile en      # build English under _site/en/
quarto render --profile fr      # build French under _site/fr/
```

## Publishing

Push to `main` → GitHub Actions builds all three languages and deploys to
GitHub Pages.

One-time setup: in repository **Settings → Pages**, select
**Build and deployment: GitHub Actions**.

## License

The text and figures of each memoir are © Alonso Celis. The site
infrastructure (configs, workflow, theme) is released under the MIT License.
