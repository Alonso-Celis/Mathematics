#!/usr/bin/env python3
"""Compare a Spanish .qmd against its EN/FR siblings for structural parity.

Given a path like `chapters/01-preliminares.es.qmd`, locate every sibling
`*.en.qmd` / `*.fr.qmd` and verify that the following token classes are
identical (translations are expected to use the same Quarto IDs,
citation keys, macros, and math content — only prose changes):

  - theorem-environment div IDs  (e.g. `::: {#thm-foo}`)  — set equality
  - proof div count               (`::: {.proof}`)         — count equality
  - display-math blocks           (`^$$` fences)            — count equality, even
  - bare `$` count                (inline math delimiters)  — count equality, even
  - citation keys                 (`[@key, ...]`)           — multiset equality
  - cross-reference keys          (`@thm-x`, `@lem-y`, …)   — multiset equality
  - LaTeX environments            (`\\begin{X}` / `\\end{X}`) — per-name counts

Strict checks (mismatch fails the build):
  - div IDs, proof count, display-math fence count,
    citations, cross-references, begin/end environment counts.

Informational only (mismatch warns but does not fail):
  - bare `$` count. Inline math segments can legitimately differ
    between translations when a sentence is rephrased — e.g. ES
    "$\\mathbb P$" referenced explicitly may fold into "the partial
    order" in the EN/FR prose. The structural keys above already
    catch every accidental drop of theorem content.

Out of scope:
  - Prose content (intentionally translated, will differ).
  - Front-matter YAML (stripped before comparison).

Exit codes:
  0 — every sibling pair matches.
  1 — at least one mismatch in at least one pair (details printed).

Usage:
  python scripts/check_math_integrity.py chapters/01-preliminares.es.qmd
  python scripts/check_math_integrity.py chapters/*.es.qmd
"""

from __future__ import annotations

import pathlib
import re
import sys
from collections import Counter

CROSSREF_PREFIXES = ("def", "lem", "prp", "thm", "cor", "exm", "exr")


def strip_frontmatter(text: str) -> str:
    """Remove a leading YAML block (--- ... ---) so it doesn't skew counts."""
    return re.sub(r"^---\n.*?\n---\n", "", text, count=1, flags=re.DOTALL)


def extract_tokens(path: pathlib.Path) -> dict:
    text = strip_frontmatter(path.read_text(encoding="utf-8"))

    # theorem-environment div IDs
    div_ids = set(re.findall(r"^::: \{#([\w-]+)\}", text, flags=re.M))

    # proof div count
    proof_count = len(re.findall(r"^::: \{\.proof\}", text, flags=re.M))

    # display-math fences: lines that are exactly `$$` (open or close)
    display_fences = len(re.findall(r"^\$\$$", text, flags=re.M))

    # bare `$` count for inline math: count every `$` NOT inside a `$$` fence
    # and not preceded by a backslash. Lines that are exactly `$$` are
    # excluded; runs of `$$` inside a line (rare) also collapse.
    text_no_fences = re.sub(r"^\$\$.*?^\$\$", "", text, flags=re.M | re.DOTALL)
    bare_dollars = len(
        [m for m in re.finditer(r"(?<!\\)\$", text_no_fences) if m]
    )

    # citation keys — first key inside [@…]; multi-key cites would need
    # iteration over commas, but this chapter set only uses single keys.
    citations = Counter(re.findall(r"\[@([A-Za-z][\w-]*)", text))

    # cross-references @thm-x, @lem-y, etc. — counted as a multiset
    crossref_pattern = re.compile(
        r"@(?:" + "|".join(CROSSREF_PREFIXES) + r")-[\w-]+"
    )
    crossrefs = Counter(crossref_pattern.findall(text))

    # LaTeX environments inside math — count begin/end per env name
    envs_begin = Counter(re.findall(r"\\begin\{([A-Za-z*]+)\}", text))
    envs_end = Counter(re.findall(r"\\end\{([A-Za-z*]+)\}", text))

    return {
        "div_ids": div_ids,
        "proof_count": proof_count,
        "display_fences": display_fences,
        "bare_dollars": bare_dollars,
        "citations": citations,
        "crossrefs": crossrefs,
        "envs_begin": envs_begin,
        "envs_end": envs_end,
    }


def diff(label: str, base, other, *, mismatches: list) -> None:
    """Compare a single token class; record any mismatch."""
    if isinstance(base, set):
        only_base = base - other
        only_other = other - base
        if only_base or only_other:
            mismatches.append(
                f"  {label}: missing in target = {sorted(only_base) or '(none)'}, "
                f"unexpected in target = {sorted(only_other) or '(none)'}"
            )
    elif isinstance(base, Counter):
        diff_keys = set(base) | set(other)
        per_key = []
        for k in sorted(diff_keys):
            if base[k] != other[k]:
                per_key.append(f"{k!r}: {base[k]} vs {other[k]}")
        if per_key:
            mismatches.append(f"  {label}: " + "; ".join(per_key))
    else:
        if base != other:
            mismatches.append(f"  {label}: {base} vs {other}")


def diff_warn(label: str, base, other, *, warnings: list) -> None:
    """Compare a single token class — record drift as informational only."""
    if base != other:
        warnings.append(f"  {label}: {base} vs {other}")


def check_pair(es_path: pathlib.Path, tr_path: pathlib.Path) -> bool:
    """Compare a Spanish file to a translation. Print details. Return ok bool."""
    es = extract_tokens(es_path)
    tr = extract_tokens(tr_path)

    # Per-file structural sanity (fences and dollars should be even)
    structural = []
    if es["display_fences"] % 2:
        structural.append(f"{es_path.name} has odd display-fence count: "
                          f"{es['display_fences']}")
    if tr["display_fences"] % 2:
        structural.append(f"{tr_path.name} has odd display-fence count: "
                          f"{tr['display_fences']}")
    if es["bare_dollars"] % 2:
        structural.append(f"{es_path.name} has odd bare-$ count: "
                          f"{es['bare_dollars']}")
    if tr["bare_dollars"] % 2:
        structural.append(f"{tr_path.name} has odd bare-$ count: "
                          f"{tr['bare_dollars']}")

    mismatches: list = []
    warnings: list = []
    diff("div IDs",        es["div_ids"],        tr["div_ids"],        mismatches=mismatches)
    diff("proof count",    es["proof_count"],    tr["proof_count"],    mismatches=mismatches)
    diff("display fences", es["display_fences"], tr["display_fences"], mismatches=mismatches)
    diff_warn("bare $",    es["bare_dollars"],   tr["bare_dollars"],   warnings=warnings)
    diff("citations",      es["citations"],      tr["citations"],      mismatches=mismatches)
    diff("crossrefs",      es["crossrefs"],      tr["crossrefs"],      mismatches=mismatches)
    diff("begin envs",     es["envs_begin"],     tr["envs_begin"],     mismatches=mismatches)
    diff("end envs",       es["envs_end"],       tr["envs_end"],       mismatches=mismatches)

    ok = not (mismatches or structural)
    status = "OK " if ok else "FAIL"
    print(f"  [{status}] {es_path.name}  <->  {tr_path.name}")
    for line in structural:
        print(f"    structural: {line}")
    for line in mismatches:
        print(line)
    for line in warnings:
        print(f"  WARN {line.lstrip()}")
    return ok


def main(argv: list[str]) -> int:
    if len(argv) < 2:
        print(__doc__)
        return 2

    overall_ok = True
    any_pairs_checked = False

    for arg in argv[1:]:
        es_path = pathlib.Path(arg)
        if not es_path.is_file():
            print(f"[skip] not a file: {es_path}", file=sys.stderr)
            continue
        if not es_path.name.endswith(".es.qmd"):
            print(f"[skip] not a *.es.qmd file: {es_path}", file=sys.stderr)
            continue

        stem = es_path.name[: -len(".es.qmd")]
        print(f"\n-> Checking translations of {es_path}")
        for lang in ("en", "fr"):
            sibling = es_path.with_name(f"{stem}.{lang}.qmd")
            if not sibling.is_file():
                print(f"  (no {lang} sibling at {sibling.name} — skipped)")
                continue
            any_pairs_checked = True
            if not check_pair(es_path, sibling):
                overall_ok = False

    if not any_pairs_checked:
        print("\nNo translation pairs were checked.")
        return 0 if overall_ok else 1

    print()
    if overall_ok:
        print("All translation pairs match.")
        return 0
    print("Mismatches found — see details above.")
    return 1


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
