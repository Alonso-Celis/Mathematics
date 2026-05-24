# Logo provenance

Both PDFs were shipped inside the thesis LaTeX source archive
(`ENCAJES_ENTRE_NOCIONES_DE_FORCING.zip`) and are referenced from
`tex-source/main.tex` via `\includegraphics{escudo-unam}` /
`\includegraphics{escudo-ciencias}` rendered through the
`unam_tesis1.cls` document class.

| File                    | Subject                                    |
|-------------------------|--------------------------------------------|
| `escudo-unam.pdf`       | Universidad Nacional Autónoma de México    |
| `escudo-ciencias.pdf`   | Facultad de Ciencias, UNAM                 |

The originals are kept under `tex-source/` so the LaTeX source remains
self-compilable; these copies in `assets/logos/` are what the Quarto site
uses (favicon, navbar mark, landing-page header).

UNAM's identity marks are property of the Universidad Nacional Autónoma de
México. Their use here is limited to identifying the institution where the
thesis was defended, consistent with academic attribution practice.

## Brand palette

Both escudo PDFs are monochrome in the thesis source:

- `escudo-unam.pdf` is a 1-bit bitmap (504×556px, black + white only),
  so no chromatic colours can be lifted from it.
- `escudo-ciencias.pdf` ships an indexed-colour image, but its 256-entry
  palette is entirely grayscale (max(r,g,b) - min(r,g,b) ≤ 15 for every
  entry).

Because the source files don't carry the official Pantones directly,
the palette in `_brand.yml` and `assets/css/custom.scss` uses the
canonical UNAM identity colours from the Manual de Identidad Gráfica
de la UNAM:

| Role        | Pantone | Hex       | Notes                          |
|-------------|---------|-----------|--------------------------------|
| Azul UNAM   | 540 C   | `#003D7C` | primary, links, theorem rules  |
| Oro UNAM    | 7406 C  | `#FFB81C` | secondary, active-language pill, sidebar active |
| Azul deep   | —       | `#002147` | hover state for links          |
| Oro deep    | —       | `#B8870C` | proof-box rule, low-contrast accents |

If a future revision swaps in colour escudos (e.g. SVGs from the UNAM
visual-identity portal), the palette here should be re-derived from
those files to match exactly.
