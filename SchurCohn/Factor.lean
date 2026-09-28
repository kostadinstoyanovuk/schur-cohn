import SchurCohn.ConjRecip
import SchurCohn.Stable
import Mathlib.Algebra.Polynomial.BigOperators
import Mathlib.Analysis.Complex.Polynomial.Basic

/-!
# Factorisation over ℂ (C4.LEM)

Blueprint nodes `lem:factor` and `lem:conjRecip-factor`. The factorisation is
`Polynomial.C_leadingCoeff_mul_prod_multiset_X_sub_C`, with the root count
`IsAlgClosed.card_roots_eq_natDegree` from the algebraic closedness of `ℂ`
(`Complex.isAlgClosed`) (plan p. 16, C4.LEM "Do").
-/

namespace SchurCohn

open Polynomial ComplexConjugate

/-- `lem:factor`: at the exact degree `natDegree p = n`, the root multiset has `n` elements,
`p.coeff n` is the leading coefficient, and `p(z) = aₙ ∏_{w ∈ roots p} (z - w)`. -/
theorem eval_eq_prod_roots_of_natDegree {p : ℂ[X]} {n : ℕ} (hp : p.natDegree = n) (z : ℂ) :
    Multiset.card p.roots = n ∧ p.coeff n = p.leadingCoeff ∧
      p.eval z = p.coeff n * (p.roots.map (fun w => z - w)).prod := by
  have hcard : Multiset.card p.roots = p.natDegree := IsAlgClosed.card_roots_eq_natDegree
  have hlc : p.coeff n = p.leadingCoeff := by rw [leadingCoeff, hp]
  refine ⟨hcard.trans hp, hlc, ?_⟩
  conv_lhs => rw [← C_leadingCoeff_mul_prod_multiset_X_sub_C hcard]
  simp only [eval_mul, eval_C, eval_multiset_prod, Multiset.map_map, Function.comp_def, eval_sub,
    eval_X, hlc]

/-- The conjugate reciprocal of one linear factor, at degree `1`. -/
theorem conjRecip_X_sub_C (a : ℂ) : conjRecip 1 (X - C a) = 1 - C (conj a) * X := by
  rw [conjRecip, Polynomial.map_sub, Polynomial.map_X, Polynomial.map_C, reflect_sub,
    reflect_one_X, reflect_C, pow_one]

/-- The conjugate reciprocal of `∏_{w ∈ s} (X - C w)` at the degree `card s`. -/
theorem conjRecip_prod_X_sub_C (s : Multiset ℂ) :
    conjRecip (Multiset.card s) (s.map fun w => X - C w).prod =
      (s.map fun w => 1 - C (conj w) * X).prod := by
  induction s using Multiset.induction_on with
  | empty => simpa using conjRecip_C (1 : ℂ)
  | cons a s ih =>
    rw [Multiset.card_cons, Multiset.map_cons, Multiset.prod_cons, Multiset.map_cons,
      Multiset.prod_cons, Nat.add_comm (Multiset.card s) 1,
      conjRecip_mul (natDegree_X_sub_C a).le (natDegree_multiset_prod_X_sub_C_eq_card s).le, ih,
      conjRecip_X_sub_C]

/-- `lem:conjRecip-factor`: at the exact degree `natDegree p = n`,
`p* = C (conj aₙ) * ∏_{w ∈ roots p} (1 - C (conj w) * X)`. The hypothesis is `natDegree p = n`,
not `≤ n`: at a larger formal degree a factor `X ^ (n - natDegree p)` appears. -/
theorem conjRecip_eq_prod_roots {p : ℂ[X]} {n : ℕ} (hp : p.natDegree = n) :
    conjRecip n p =
      C (conj (p.coeff n)) * (p.roots.map (fun w => 1 - C (conj w) * X)).prod := by
  obtain ⟨hcard, hlc, -⟩ := eval_eq_prod_roots_of_natDegree hp 0
  have hcard' : Multiset.card p.roots = p.natDegree := hcard.trans hp.symm
  rw [hlc]
  conv_lhs => rw [← C_leadingCoeff_mul_prod_multiset_X_sub_C hcard']
  rw [conjRecip_C_mul, ← hcard, conjRecip_prod_X_sub_C]

/-- Evaluation of the factorised reciprocal:
`p*(z) = conj aₙ · ∏_{w ∈ roots p} (1 - conj w · z)` (plan p. 15, Lemma B). -/
theorem eval_conjRecip_eq_prod_roots {p : ℂ[X]} {n : ℕ} (hp : p.natDegree = n) (z : ℂ) :
    (conjRecip n p).eval z =
      conj (p.coeff n) * (p.roots.map (fun w => 1 - conj w * z)).prod := by
  rw [conjRecip_eq_prod_roots hp]
  simp only [eval_mul, eval_C, eval_multiset_prod, Multiset.map_map, Function.comp_def, eval_sub,
    eval_one, eval_X]

/-- The norm of a product over a multiset of complex numbers. -/
theorem norm_multiset_prod_complex (s : Multiset ℂ) : ‖s.prod‖ = (s.map (‖·‖)).prod :=
  map_multiset_prod (normHom : ℂ →*₀ ℝ) s

/-- `‖p(z)‖ = ‖aₙ‖ · ∏ ‖z - w‖` at the exact degree. -/
theorem norm_eval_eq_prod_roots {p : ℂ[X]} {n : ℕ} (hp : p.natDegree = n) (z : ℂ) :
    ‖p.eval z‖ = ‖p.coeff n‖ * (p.roots.map (fun w => ‖z - w‖)).prod := by
  rw [(eval_eq_prod_roots_of_natDegree hp z).2.2, norm_mul, norm_multiset_prod_complex,
    Multiset.map_map]
  rfl

/-- `‖p*(z)‖ = ‖aₙ‖ · ∏ ‖1 - conj w · z‖` at the exact degree. -/
theorem norm_eval_conjRecip_eq_prod_roots {p : ℂ[X]} {n : ℕ} (hp : p.natDegree = n) (z : ℂ) :
    ‖(conjRecip n p).eval z‖ = ‖p.coeff n‖ * (p.roots.map (fun w => ‖1 - conj w * z‖)).prod := by
  rw [eval_conjRecip_eq_prod_roots hp, norm_mul, Complex.norm_conj, norm_multiset_prod_complex,
    Multiset.map_map]
  rfl

/-- For a stable `p` of exact degree `n`, the coefficient `aₙ` is non-zero. -/
theorem IsStable.norm_coeff_pos {p : ℂ[X]} (hs : IsStable p) {n : ℕ} (hp : p.natDegree = n) :
    0 < ‖p.coeff n‖ := by
  rw [(eval_eq_prod_roots_of_natDegree hp 0).2.1, norm_pos_iff, leadingCoeff_ne_zero]
  exact hs.1

/-- At the exact degree `n ≥ 1`, the root multiset is non-empty. -/
theorem roots_ne_zero_of_natDegree {p : ℂ[X]} {n : ℕ} (hp : p.natDegree = n) (hn : 1 ≤ n) :
    p.roots ≠ 0 := by
  intro h
  have hcard := (eval_eq_prod_roots_of_natDegree hp 0).1
  rw [h, Multiset.card_zero] at hcard
  omega

end SchurCohn
