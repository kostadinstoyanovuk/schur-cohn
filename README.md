# schur-cohn

Lean formalisation development for the Unit Circle Programme, which studies
autoregressive roots and time-series stability.

The current repository establishes a reproducible Lean environment with
arithmetic and polynomial smoke examples. It does not yet contain a Schur–Cohn
result, a stability definition or a programme theorem. Substantive formal
development follows the programme's blueprint and coordination requirements;
formal proof gates G6 and G7 remain open.

## Build

The environment is pinned to Lean `v4.32.2` and mathlib commit
`905b95818eb32af7874a58b427f50c1711a5e96c` (release tag `v4.32.2`).
`lake-manifest.json` records the transitive dependencies.

With the pinned toolchain available, set `MATHLIB_NO_CACHE_ON_UPDATE=1` before
dependency resolution, then run:

```text
lake exe cache get Mathlib.Algebra.Polynomial.Eval.Defs
lake build
```

The selective cache covers the smoke import and its transitive dependencies.
For Windows, `tools/install-lean.ps1` installs the verified portable toolchain
inside `.tools/`, and `tools/smoke.ps1` runs the selective cache and build steps.

## Verification

The [Lean workflow](https://github.com/kostadinstoyanovuk/schur-cohn/actions/workflows/ci.yml)
checks the pinned setup and smoke build.
[Recorded local verification](evidence/README.md) includes the successful
2026-09-24 build, the verified download digest and the initial cache failure.
The polynomial example depends on `propext`, `Classical.choice` and `Quot.sound`;
the arithmetic example has no axiom dependencies.

These examples verify the build environment. They do not establish a programme
theorem or satisfy the formal proof gates.

Programme methods and records are maintained in
[unit-circle](https://github.com/kostadinstoyanovuk/unit-circle).
Project licensing remains undecided; dependencies retain their upstream terms.
