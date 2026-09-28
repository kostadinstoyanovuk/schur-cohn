# C4.LEAN node status

State on 2026-09-28 (UTC) of the 56 nodes of the C4.B blueprint (`blueprint/src/content.tex`) against the Lean sources in this repository. Plan pages refer to the working edition (SHA-256 `c195cea6…5b3b5a`).

## Status legend

| Status | Meaning |
|---|---|
| **proved** | Declared in `SchurCohn/`, no `sorry`, `lake build` passes (`evidence/c4-lean/lake-build.log`), `#print axioms` gives only `propext`, `Classical.choice`, `Quot.sound` (`evidence/c4-lean/axioms.log`, `evidence/c4-lean/axioms-check.log`), and the statement is the C4.B statement copied verbatim (`checks/Conformance.lean`, `evidence/c4-lean/conformance.log`). |
| **defined** | A definition with the blueprint's body, checked by `rfl` against that body in `checks/Conformance.lean`; axioms as above. |
| **mathlib** | Existing mathlib declarations. Every cited name resolves at the pin (`evidence/c4-lean/blueprint-decls.log`); the names the proofs actually use are `#check`ed in `checks/MathlibNames.lean` (`evidence/c4-lean/mathlib-names.log`). |
| **stated with sorry** | None. No declaration in this project uses `sorry` (`evidence/c4-lean/sorry-grep.log`). |
| **not started** | No Lean declaration of that name exists in this project (`evidence/c4-lean/blueprint-decls.log`: "MISSING"). |

Counts: 18 proved, 3 defined, 4 mathlib, 0 stated with sorry, 31 not started (56 nodes). Of the 124 names in `blueprint/lean_decls`, 66 resolve (30 mathlib, 36 `SchurCohn`) and 58 do not (all in C4.THM, C4.REC and C4.COR).

## Library facts (mathlib)

| Node | Status | Names used by the proofs (all `#check`ed at the pin) |
|---|---|---|
| `ml:reflect` | mathlib | `reflect`, `coeff_reflect`, `reflect_map`, `reflect_reflect`, `reflect_mul`, `eval₂_reflect_mul_pow`, `reflect_sub`, `reflect_C`, `reflect_monomial`, `reflect_one_X`, `reflect_one`, `revAt`, `revAt_le`, `revAt_eq_self_of_lt`, `revAt_invol`, `revAt_zero` (and `reverse`, only in `lem:reverse-trap`). Cited but not used: `natDegree_reflect_le`, `reflect_add`, `reflect_C_mul`. |
| `ml:divX` | mathlib | `divX` (in `def:schur` only). The other cited names are for C4.THM. |
| `ml:splits` | mathlib | `C_leadingCoeff_mul_prod_multiset_X_sub_C`, `IsAlgClosed.card_roots_eq_natDegree`, `Complex.isAlgClosed`, `natDegree_multiset_prod_X_sub_C_eq_card`, `mem_roots`. Cited but not used: `IsAlgClosed.splits`, `Splits.eq_prod_roots`, `Splits.eval_eq_prod_roots`, `Splits.coeff_zero_eq_leadingCoeff_mul_prod_roots`. |
| `ml:norm` | mathlib | `Complex.norm_conj`, `Complex.norm_mul`, `Complex.norm_pow`, `norm_mul`, `Complex.normSq_eq_norm_sq`, `Complex.inv_def`, `Complex.conj_conj`, `Multiset.prod_map_le_prod_map₀`, `Multiset.prod_pos`, `normHom`, `map_multiset_prod`, `eval_multiset_prod`, `coeff_map`, `eval_map`, `eval₂_at_apply`, `pow_le_pow_iff_left₀`, `pow_lt_pow_iff_left₀`, `pow_left_inj₀`, `norm_sub_norm_le`. Cited but not used: `Complex.mul_conj`. |

## Definitions and conjugate-reciprocal API (C4.D, plan p. 16)

| Node | Lean declaration(s) | File | Status |
|---|---|---|---|
| `def:conjRecip` | `SchurCohn.conjRecip` | `SchurCohn/Defs.lean` | defined |
| `def:IsStable` | `SchurCohn.IsStable` | `SchurCohn/Defs.lean` | defined |
| `lem:conjRecip-coeff` | `coeff_conjRecip`, `coeff_conjRecip_of_le`, `coeff_conjRecip_of_lt` | `SchurCohn/ConjRecip.lean` | proved |
| `lem:conjRecip-ends` | `conjRecip_coeff_zero`, `conjRecip_coeff_self` | `SchurCohn/ConjRecip.lean` | proved |
| `lem:conjRecip-invol` | `conjRecip_conjRecip` (helper `conjRecip_eq_map_reflect`) | `SchurCohn/ConjRecip.lean` | proved |
| `lem:conjRecip-natDegree` | `natDegree_conjRecip_le` | `SchurCohn/ConjRecip.lean` | proved |
| `lem:conjRecip-linear` | `conjRecip_add`, `conjRecip_sub`, `conjRecip_C_mul`, `conjRecip_zero`, `conjRecip_C` | `SchurCohn/ConjRecip.lean` | proved |
| `lem:conjRecip-X-mul` | `conjRecip_X_mul` | `SchurCohn/ConjRecip.lean` | proved |
| `lem:conjRecip-mul` | `conjRecip_mul` | `SchurCohn/ConjRecip.lean` | proved |
| `lem:conjRecip-eval` | `eval_conjRecip` (helper `eval_map_conj`) | `SchurCohn/ConjRecip.lean` | proved |
| `lem:conjRecip-circle` | `norm_eval_conjRecip_of_norm_eq_one` | `SchurCohn/ConjRecip.lean` | proved |
| `lem:reverse-trap` | `conjRecip_ne_reverse` | `SchurCohn/ConjRecip.lean` | proved |
| `lem:stable-basic` | `not_isStable_zero`, `isStable_C`, `isStable_iff_of_natDegree_eq_zero`, `isStable_C_mul_iff`, `isStable_iff_roots` (helper `IsStable.eval_ne_zero`) | `SchurCohn/Stable.lean` | proved |

The plan's C4.D "Done" criterion (p. 16) is met by `conjRecip_conjRecip` (`(p*)* = p` at fixed `n`, via `reflect_reflect`), `coeff_conjRecip` (coefficient formula) and `eval_conjRecip` (`p*(z) = zⁿ·conj(p(1/conj z))` for `z ≠ 0`, `natDegree p ≤ n`).

## Lemmas A–C (C4.LEM, plan pp. 15–16)

| Node | Lean declaration(s) | File | Status |
|---|---|---|---|
| `lem:A` | `lemmaA`, `lemmaA_normSq` | `SchurCohn/LemmaA.lean` (unchanged from schur-cohn `a86ec28`) | proved (reused) |
| `lem:A-factor` | `norm_one_sub_conj_mul_le`, `norm_one_sub_conj_mul_lt`, `norm_one_sub_conj_mul_eq` | `SchurCohn/LemmaAFactor.lean` | proved |
| `lem:factor` | `eval_eq_prod_roots_of_natDegree` | `SchurCohn/Factor.lean` | proved |
| `lem:conjRecip-factor` | `conjRecip_eq_prod_roots` (helpers `conjRecip_X_sub_C`, `conjRecip_prod_X_sub_C`, `eval_conjRecip_eq_prod_roots`) | `SchurCohn/Factor.lean` | proved |
| `lem:B` | `lemmaB` (weak form, every `n ≥ 0`) | `SchurCohn/LemmaB.lean` | proved |
| `lem:B-strict` | `lemmaB_strict`, `lemmaB_eq_iff` (need `n ≥ 1`) | `SchurCohn/LemmaB.lean` | proved |
| `lem:C` | `lemmaC` (helper `coeff_zero_eq_mul_prod_roots`, Vieta for the constant term) | `SchurCohn/LemmaC.lean` | proved |

Helpers that are not blueprint nodes (all proved, same axiom check): `multiset_prod_map_lt_prod_map` and `multiset_prod_map_lt_one` (`SchurCohn/MultisetProd.lean`; the multiset product lemmas the blueprint's proofs of `lem:B-strict` and `lem:C` require, O-LEM-2), `norm_multiset_prod_complex`, `norm_eval_eq_prod_roots`, `norm_eval_conjRecip_eq_prod_roots`, `IsStable.norm_coeff_pos`, `roots_ne_zero_of_natDegree` (`SchurCohn/Factor.lean`).

Boundary cases of D-025 (4) are checked in `checks/Boundary.lean` (`evidence/c4-lean/boundary.log`, exit 0): the weak Lemma B at degree `0`; its failure at a formal degree above `natDegree` (`p = 1`, `n = 1`, `z = 2`); equality everywhere at degree `0`.

## Schur transform and main theorem (C4.THM, plan pp. 15–16)

| Node | Lean declaration(s) | Status |
|---|---|---|
| `def:schur` | `SchurCohn.schur` (`SchurCohn/Defs.lean`) | defined (plan p. 16 lists the Schur transform under C4.D "Do"; the blueprint places the node in the C4.THM chapter) |
| `lem:schur-constant-cancel` | `coeff_zero_schurNumerator` | not started |
| `lem:schur-X-mul` | `X_mul_schur` | not started |
| `lem:schur-coeff` | `coeff_schur` | not started |
| `lem:schur-lead` | `natDegree_schur_le`, `coeff_schur_pred`, `natDegree_schur_eq`, `schur_ne_zero` | not started |
| `lem:qstar-identity` | `conjRecip_schur` | not started |
| `lem:displayed-identity` | `schur_identity` | not started |
| `lem:step-mp` | `isStable_schur_of_isStable` | not started |
| `lem:step-mpr` | `isStable_of_isStable_schur` | not started |
| `thm:step` | `isStable_iff_schur` | not started (main theorem) |

## Recursion and executable checker (C4.REC, plan p. 17)

| Node | Lean declaration(s) | Status |
|---|---|---|
| `def:SchurTest` | `SchurTest` | not started |
| `thm:SchurTest` | `schurTest_iff`, `schurTest_iff_of_natDegree_eq` | not started |
| `def:GZ` | `GZ`, `GQ`, `GZ.toC`, `GQ.toC`, `GZ.normSq`, `GQ.normSq` | not started |
| `lem:GZ-cast` | `GZ.toC_add`, `GZ.toC_sub`, `GZ.toC_mul`, `GZ.toC_conj`, `GZ.normSq_toC`, `GZ.toC_eq_zero`, `GQ.toC_mul`, `GQ.normSq_toC` | not started |
| `def:toPoly` | `toPoly`, `toPolyQ` | not started |
| `lem:toPoly-coeff` | `coeff_toPoly`, `natDegree_toPoly_le` | not started |
| `def:schurList` | `schurList` | not started |
| `lem:toPoly-schurList` | `length_schurList`, `toPoly_schurList` | not started |
| `def:check` | `checkAux`, `check` | not started |
| `lem:checkAux` | `checkAux_iff` | not started |
| `thm:check` | `check_iff` | not started |
| `def:checkQ` | `denProd`, `toGZ`, `checkQ` | not started |
| `thm:checkQ` | `toPoly_toGZ`, `checkQ_iff` | not started |
| `thm:pilot` | `pilot_check`, `pilot_isStable` | not started |

## Corollaries (C4.COR, plan pp. 16–17)

| Node | Lean declaration(s) | Status |
|---|---|---|
| `cor:1` | `ar2_triangle` | not started |
| `lem:quad` | `real_quadratic_iff` | not started |
| `cor:2` | `jury_cubic` | not started |
| `def:arPoly` | `arPoly`, `IsStationaryK`, `phiDownK` | not started |
| `lem:ar-bridge` | `isStationaryK_iff_isStable` | not started |
| `lem:schur-arPoly` | `schur_arPoly` | not started |
| `cor:3` | `isStable_arPoly_iff_stepDown`, `isStationaryK_iff_stepDown` | not started |
| `cor:4` | `spectralPeak_imp_complexRoots` | not started |
