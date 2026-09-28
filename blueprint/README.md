# Blueprint: the Schur–Cohn step for complex polynomials

This is the blueprint for plan work package C4.B: the complex, algebraic Schur–Cohn step theorem, its recursion and an executable checker, with Lemmas A–C and Corollaries 1–4. It has 56 nodes and 81 dependency edges (`dependency-graph.svg`; source `src/content.tex`).

**Status.** Statements only. Lemma A (the Blaschke identity) is proved in `SchurCohn/LemmaA.lean`; every other node is unproved. Statement signatures for every node type-check against this repository's pinned Lean and mathlib, with proof bodies pending; they are kept outside this repository because its CI rejects `sorry`. Gate G6 is not passed.

**Conventions** (research repository `DECISIONS.md`, D-025): the conjugate reciprocal is taken at an explicit formal degree, `(p.map (starRingEnd ℂ)).reflect n`, never `Polynomial.reverse`; the reciprocal of the Schur transform `q` is taken at degree `n − 1`; the executable checker works on Gaussian integers by structural recursion, so that `decide` can check the pilot example; only the root-predicate bridge to AR stationarity is in scope.

**Prior work.** S. Kamaguchi's `ar456-stationarity-lean` proves the real step-down `isStationary_iff_stepDown_gen` by a path and openness argument. It is cited, not duplicated; Corollary 3 derives its statement from the complex theorem. The prior-art search is recorded in the research repository's `DECISIONS.md` (D-026).

`BUILD.md` describes how the web version is built with `leanblueprint`; the rendered output is not committed. `lean_decls` lists the Lean names referenced by the blueprint: mathlib names exist, and `SchurCohn.*` names other than `lemmaA` and `lemmaA_normSq` are planned.
