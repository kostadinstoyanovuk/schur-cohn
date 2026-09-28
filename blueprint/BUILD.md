# Building the C4.B blueprint

Source: `src/` (leanblueprint layout; `content.tex` holds every node). The rendered web version is produced by the
build below and is not committed (it opens at `web/index.html`, with the dependency graph at `web/dep_graph_document.html`). Static graph:
`dependency-graph.dot` / `dependency-graph.svg`. `lean_decls` is the list of Lean names that
leanblueprint extracted from the `\lean{...}` tags (mathlib names exist; `SchurCohn.*` names other
than `lemmaA`/`lemmaA_normSq` are proposed and do not exist yet).

Build used on 2026-09-28 (Linux, Python 3.11, no TeX installation):

```text
pip install leanblueprint==0.0.20          # pulls plasTeX 3.1, plastexdepgraph 0.0.5, plastexshowmore 0.0.2
apt-get install graphviz libgraphviz-dev   # pygraphviz; graphviz 2.43.0
cd src && plastex --kpsewhich <shim> -c plastex.cfg web.tex
```

`<shim>` is a four-line stand-in for `kpsewhich` that resolves `\input{macros/...}` relative to the
source directory; without it plasTeX cannot find `macros/common.tex` when no TeX installation is
present, the theorem environments stay undefined and plastexdepgraph fails with
`TypeError: unhashable type: 'definition'`. The shim:

```sh
#!/bin/sh
IFS=:
for d in ${TEXINPUTS:-.} .; do
  [ -n "$d" ] || continue
  if [ -f "$d/$1" ]; then printf '%s\n' "$d/$1"; exit 0; fi
done
exit 1
```

Not run: `leanblueprint pdf` (no `latexmk`/XeLaTeX here; the PDF rendering is UNVERIFIED) and
`leanblueprint checkdecls` (needs a Lean project containing the declarations; they do not exist yet).
