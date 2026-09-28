import SchurCohn.Factor
import SchurCohn.LemmaAFactor
import SchurCohn.MultisetProd

/-!
# Lemma B (C4.LEM)

Blueprint nodes `lem:B` (weak form, every `n ≥ 0`) and `lem:B-strict` (strict form, `n ≥ 1`),
the split of D-025 (4). Proof as on plan p. 15: factorise over `ℂ`, apply Lemma A to each factor
(`lem:A-factor`), and multiply over the root multiset.
-/

namespace SchurCohn

open Polynomial ComplexConjugate

/-- `lem:B`, weak form, used by the main theorem. Every `n ≥ 0`, including a non-zero constant.
If `p` is stable with `natDegree p = n` and `‖z‖ ≥ 1`, then `p(z) ≠ 0` and `‖p*(z)‖ ≤ ‖p(z)‖`. -/
theorem lemmaB {p : ℂ[X]} {n : ℕ} (hs : IsStable p) (hp : p.natDegree = n) {z : ℂ}
    (hz : 1 ≤ ‖z‖) : p.eval z ≠ 0 ∧ ‖(conjRecip n p).eval z‖ ≤ ‖p.eval z‖ := by
  refine ⟨hs.eval_ne_zero hz, ?_⟩
  have hroots := (isStable_iff_roots.mp hs).2
  rw [norm_eval_conjRecip_eq_prod_roots hp, norm_eval_eq_prod_roots hp]
  exact mul_le_mul_of_nonneg_left
    (Multiset.prod_map_le_prod_map₀ _ _ (fun _ _ => norm_nonneg _)
      (fun w hw => (norm_one_sub_conj_mul_le (hroots w hw) hz).2)) (norm_nonneg _)

/-- `lem:B-strict`: for `n ≥ 1` and `‖z‖ > 1`, `‖p*(z)‖ < ‖p(z)‖`. -/
theorem lemmaB_strict {p : ℂ[X]} {n : ℕ} (hs : IsStable p) (hp : p.natDegree = n) (hn : 1 ≤ n)
    {z : ℂ} (hz : 1 < ‖z‖) : ‖(conjRecip n p).eval z‖ < ‖p.eval z‖ := by
  have hroots := (isStable_iff_roots.mp hs).2
  rw [norm_eval_conjRecip_eq_prod_roots hp, norm_eval_eq_prod_roots hp]
  exact mul_lt_mul_of_pos_left
    (multiset_prod_map_lt_prod_map (roots_ne_zero_of_natDegree hp hn) (fun _ _ => norm_nonneg _)
      (fun w hw => norm_one_sub_conj_mul_lt (hroots w hw) hz)) (hs.norm_coeff_pos hp)

/-- `lem:B-strict`, equality case: for `n ≥ 1` and `‖z‖ ≥ 1`, `‖p*(z)‖ = ‖p(z)‖` iff `‖z‖ = 1`
(plan p. 15). For `n = 0` equality holds everywhere, so `n ≥ 1` is needed. -/
theorem lemmaB_eq_iff {p : ℂ[X]} {n : ℕ} (hs : IsStable p) (hp : p.natDegree = n) (hn : 1 ≤ n)
    {z : ℂ} (hz : 1 ≤ ‖z‖) : ‖(conjRecip n p).eval z‖ = ‖p.eval z‖ ↔ ‖z‖ = 1 := by
  refine ⟨fun h => ?_, fun h => norm_eval_conjRecip_of_norm_eq_one hp.le h⟩
  by_contra hne
  exact (lemmaB_strict hs hp hn (lt_of_le_of_ne hz (Ne.symm hne))).ne h

end SchurCohn
