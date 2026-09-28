import SchurCohn

/-!
# Boundary cases of Lemma B (D-025 (4))

(1) The weak Lemma B holds at degree `0`: a non-zero constant `C c` with `natDegree = 0`.
(2) It fails at a formal degree above `natDegree` (C4.B `dependency-status.md`, `lem:B`: take
`p = 1`, `n = 1`, `‖z‖ > 1`), which is why `lemmaB` assumes `natDegree p = n`, not `≤ n`.
(3) The strict form needs `n ≥ 1`: at degree `0` equality holds at every `z`.
-/

open Polynomial SchurCohn

example {c : ℂ} (hc : c ≠ 0) {z : ℂ} (hz : 1 ≤ ‖z‖) :
    (C c).eval z ≠ 0 ∧ ‖(conjRecip 0 (C c)).eval z‖ ≤ ‖(C c).eval z‖ :=
  lemmaB (isStable_C hc) (natDegree_C c) hz

example : IsStable (1 : ℂ[X]) ∧ (1 : ℂ[X]).natDegree = 0 ∧ conjRecip 1 (1 : ℂ[X]) = X ∧
    ¬ ‖(conjRecip 1 (1 : ℂ[X])).eval 2‖ ≤ ‖(1 : ℂ[X]).eval 2‖ := by
  have h : conjRecip 1 (1 : ℂ[X]) = X := by
    rw [conjRecip, Polynomial.map_one, reflect_one, pow_one]
  refine ⟨by simpa using isStable_C (one_ne_zero : (1 : ℂ) ≠ 0), natDegree_one, h, ?_⟩
  rw [h, eval_X, eval_one, norm_one]
  norm_num

example {c : ℂ} (z : ℂ) : ‖(conjRecip 0 (C c)).eval z‖ = ‖(C c).eval z‖ := by
  rw [conjRecip_C, eval_C, eval_C, Complex.norm_conj]
