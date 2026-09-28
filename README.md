# schur-cohn

Lean formalisation development for the Unit Circle Programme, which studies
autoregressive roots and time-series stability.

The current repository establishes a reproducible Lean environment with
arithmetic and polynomial smoke examples, and proves Lemma A of the programme
plan (the Blaschke identity) in `SchurCohn/LemmaA.lean` as the foundations
exercise F6. Following the blueprint in `blueprint/`, it also contains the
definitions and conjugate-reciprocal API of work package C4.D
(`SchurCohn/Defs.lean`, `ConjRecip.lean`, `Stable.lean`) and Lemmas A–C of
C4.LEM (`LemmaAFactor.lean`, `Factor.lean`, `LemmaB.lean`, `LemmaC.lean`, with
`MultisetProd.lean`). The Schur–Cohn step (the main theorem), the recursion and
the corollaries are not yet formalised; `node-status.md` lists every blueprint
node. Formal work started under D-022 of the research repository's DECISIONS.md
after both coordination messages were posted (D-027, D-030); formal proof gates G6 and G7 remain open.

## Build

The environment is pinned to Lean `v4.32.2` and mathlib commit
`905b95818eb32af7874a58b427f50c1711a5e96c` (release tag `v4.32.2`).
`lake-manifest.json` records the transitive dependencies.

With the pinned toolchain available, set `MATHLIB_NO_CACHE_ON_UPDATE=1` before
dependency resolution, then run:

```text
lake exe cache get Mathlib.Algebra.Polynomial.Eval.Defs Mathlib.Analysis.Complex.Norm \
  Mathlib.Algebra.Polynomial.Reverse Mathlib.Algebra.Polynomial.Inductions \
  Mathlib.Algebra.Polynomial.Roots Mathlib.Algebra.Polynomial.BigOperators \
  Mathlib.Algebra.Order.BigOperators.GroupWithZero.Multiset Mathlib.Data.Real.Basic \
  Mathlib.Analysis.Complex.Polynomial.Basic
lake build
lake env lean checks/Axioms.lean > axioms.log
python3 checks/check_axioms.py checks/decls.txt axioms.log
lake env lean checks/Conformance.lean
```

The selective cache covers the project's imports and their transitive dependencies.
For Windows, `tools/install-lean.ps1` installs the verified portable toolchain
inside `.tools/`, and `tools/smoke.ps1` runs the selective cache and build steps.

## Verification

The [Lean workflow](https://github.com/kostadinstoyanovuk/schur-cohn/actions/workflows/ci.yml)
checks the pinned setup and smoke build.
[Recorded local verification](evidence/README.md) includes the successful
2026-09-24 build, the verified download digest and the initial cache failure.
The polynomial example depends on `propext`, `Classical.choice` and `Quot.sound`;
the arithmetic example has no axiom dependencies.

Lemma A, `SchurCohn.lemmaA`, states

```text
‖z - α‖ ^ 2 - ‖1 - conj α * z‖ ^ 2 = (‖z‖ ^ 2 - 1) * (1 - ‖α‖ ^ 2)
```

for all complex `α` and `z`, with a `Complex.normSq` form `SchurCohn.lemmaA_normSq`. Both are
checked with no `sorry` and depend only on `propext`, `Classical.choice` and
`Quot.sound` ([build log](evidence/lemmaA-build.log)). The workflow also rejects any `sorry`
in the project sources.

The smoke examples verify the build environment. Neither they nor Lemma A
establish a programme theorem or satisfy the formal proof gates.

Programme methods and records are maintained in
[unit-circle](https://github.com/kostadinstoyanovuk/unit-circle).
Project licensing remains undecided; dependencies retain their upstream terms.
