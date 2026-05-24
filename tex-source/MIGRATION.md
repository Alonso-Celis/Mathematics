# Migration recipe — `.tex` → `.qmd`

This folder will hold the **frozen original LaTeX source** of the thesis,
unpacked from the `unam-tesis` archive when it arrives. It is a read-only
reference; ongoing authoring happens in the `.qmd` files at the repo root
and under `chapters/`.

## When the archive arrives

1. Unpack into this folder, preserving directory structure:

   ```bash
   unzip /path/to/unam-tesis.zip -d tex-source/
   # or, if it's a folder copy:
   cp -r /path/to/unam-tesis/* tex-source/
   ```

2. Verify the top-level `.tex` file (usually `main.tex` or `tesis.tex`) and
   the chapter includes (`\include{chapters/01-preliminares}` etc.).

3. Pull `references.bib` from `tex-source/` and merge into the root
   `references.bib`, deduplicating citation keys.

## Per-chapter conversion

For each chapter file (`chapters/NN-name.tex`):

```bash
pandoc \
  -f latex \
  -t markdown+tex_math_dollars+raw_tex+pipe_tables+citations \
  --wrap=preserve \
  --bibliography=references.bib \
  -o chapters/NN-name.es.qmd \
  tex-source/chapters/NN-name.tex
```

Then **manually**:

- Add a YAML front matter block (`title`, `lang: es`).
- Replace `\begin{theorem}` / `\begin{proof}` blocks with Quarto's crossref
  syntax: `::: {#thm-name}` / `:::` and `::: {.proof}` / `:::`.
- Replace `\ref{eq:foo}` with `@eq-foo` (Quarto crossref).
- Replace `\cite{key}` with `[@key]`.
- Inspect every displayed equation for `\begin{align*}` → `$$ \begin{aligned} … \end{aligned} $$`.

## Translation pipeline

For each migrated `.es.qmd`:

1. Copy to `.en.qmd` and `.fr.qmd`.
2. Translate prose with a math-aware pass — **never edit content between
   `$...$`, `$$...$$`, or `\begin{…}…\end{…}`**.
3. Lock terminology against `glossary.es-en.csv` and `glossary.es-fr.csv`
   (placeholders below — seed from Jech for EN and Krivine for FR).
4. Update `_quarto-en.yml` / `_quarto-fr.yml` `book.chapters:` list.
5. Run the math integrity check (see below) before committing.

## Math integrity check

For each translated file, the counts of these tokens must match the source:

- `\begin{` and `\end{` (per environment name)
- `$$` (must be even)
- `\ref{`, `\eqref{`, `\cite{` keys

A minimal script lives at `scripts/check-math-integrity.sh` (TODO — add in
the first translation PR).

## Glossary seeds

`glossary.es-en.csv` and `glossary.es-fr.csv` will live next to this file
once translation work begins. Initial entries:

| ES                          | EN                            | FR                                |
|-----------------------------|-------------------------------|-----------------------------------|
| encaje                      | embedding                     | plongement                        |
| forcing                     | forcing                       | forcing                           |
| condición                   | condition                     | condition                         |
| filtro genérico             | generic filter                | filtre générique                  |
| nombre forcing              | name (or P-name)              | nom (ou P-nom)                    |
| iteración con soportes …    | iteration with … support      | itération à support …             |
| extensión genérica          | generic extension             | extension générique               |
| cardinal regular            | regular cardinal              | cardinal régulier                 |
| denso                       | dense                         | dense                             |
| compatibilidad              | compatibility                 | compatibilité                     |
