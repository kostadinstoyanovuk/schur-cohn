import SchurCohn.Factor
import SchurCohn.MultisetProd

/-!
# Lemma C (C4.LEM)

Blueprint node `lem:C`: Vieta for the constant term (the product of the roots), plan p. 15.
-/

namespace SchurCohn

open Polynomial

/-- Vieta for the constant term at the exact degree:
`a₀ = aₙ · ∏_{w ∈ roots p} (-w)`. -/
theorem coeff_zero_eq_mul_prod_roots {p : ℂ[X]} {n : ℕ} (hp : p.natDegree = n) :
    p.coeff 0 = p.coeff n * (p.roots.map (fun w => -w)).prod := by
  rw [coeff_zero_eq_eval_zero, (eval_eq_prod_roots_of_natDegree hp 0).2.2]
  simp only [zero_sub]

/-- `lem:C`: if `p` is stable with `natDegree p = n ≥ 1` then `‖a₀‖ < ‖aₙ‖`, since
`‖a₀‖ = ‖aₙ‖ ∏ ‖w‖` and each `‖w‖ < 1`. (False for `n = 0`, where `a₀ = aₙ`.) -/
theorem lemmaC {p : ℂ[X]} {n : ℕ} (hs : IsStable p) (hp : p.natDegree = n) (hn : 1 ≤ n) :
    ‖p.coeff 0‖ < ‖p.coeff n‖ := by
  have hroots := (isStable_iff_roots.mp hs).2
  have hprod : (p.roots.map (fun w => ‖(0 : ℂ) - w‖)).prod < 1 :=
    multiset_prod_map_lt_one (roots_ne_zero_of_natDegree hp hn) (fun _ _ => norm_nonneg _)
      (fun w hw => by rw [zero_sub, norm_neg]; exact hroots w hw)
  rw [coeff_zero_eq_eval_zero, norm_eval_eq_prod_roots hp]
  calc ‖p.coeff n‖ * (p.roots.map (fun w => ‖(0 : ℂ) - w‖)).prod
      < ‖p.coeff n‖ * 1 := mul_lt_mul_of_pos_left hprod (hs.norm_coeff_pos hp)
    _ = ‖p.coeff n‖ := mul_one _

end SchurCohn
