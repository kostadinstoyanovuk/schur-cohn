import SchurCohn.Defs

/-!
# The conjugate-reciprocal API (C4.D)

Blueprint nodes `lem:conjRecip-coeff`, `lem:conjRecip-ends`, `lem:conjRecip-invol`,
`lem:conjRecip-natDegree`, `lem:conjRecip-linear`, `lem:conjRecip-X-mul`, `lem:conjRecip-mul`,
`lem:conjRecip-eval`, `lem:conjRecip-circle` and `lem:reverse-trap`. The plan's "Done"
criterion for C4.D (p. 16) is `conjRecip_conjRecip`, `coeff_conjRecip` and `eval_conjRecip`.
-/

namespace SchurCohn

open Polynomial ComplexConjugate

section Coeff

/-- `lem:conjRecip-coeff`, general form. -/
theorem coeff_conjRecip (n k : ℕ) (p : ℂ[X]) :
    (conjRecip n p).coeff k = conj (p.coeff (revAt n k)) := by
  rw [conjRecip, coeff_reflect, coeff_map]

/-- `lem:conjRecip-coeff`, for `k ≤ n`. -/
theorem coeff_conjRecip_of_le {n k : ℕ} (p : ℂ[X]) (hk : k ≤ n) :
    (conjRecip n p).coeff k = conj (p.coeff (n - k)) := by
  rw [coeff_conjRecip, revAt_le hk]

/-- `lem:conjRecip-coeff`, for `k > n`; needs `natDegree p ≤ n`. -/
theorem coeff_conjRecip_of_lt {n k : ℕ} {p : ℂ[X]} (hp : p.natDegree ≤ n) (hk : n < k) :
    (conjRecip n p).coeff k = 0 := by
  rw [coeff_conjRecip, revAt_eq_self_of_lt hk, coeff_eq_zero_of_natDegree_lt (hp.trans_lt hk),
    map_zero]

/-- `lem:conjRecip-ends`, constant coefficient (no degree hypothesis). -/
theorem conjRecip_coeff_zero (n : ℕ) (p : ℂ[X]) :
    (conjRecip n p).coeff 0 = conj (p.coeff n) := by
  rw [coeff_conjRecip, revAt_zero]

/-- `lem:conjRecip-ends`, coefficient of `X ^ n` (no degree hypothesis). -/
theorem conjRecip_coeff_self (n : ℕ) (p : ℂ[X]) :
    (conjRecip n p).coeff n = conj (p.coeff 0) := by
  rw [coeff_conjRecip_of_le p le_rfl, Nat.sub_self]

end Coeff

/-- `lem:conjRecip-invol`, the route of the plan (p. 16) and blueprint: `reflect_map` moves the
conjugation outside the reflection. -/
theorem conjRecip_eq_map_reflect (n : ℕ) (p : ℂ[X]) :
    conjRecip n p = (p.reflect n).map (starRingEnd ℂ) := by
  rw [conjRecip, reflect_map]

/-- `lem:conjRecip-invol`: the conjugate reciprocal is an involution at every fixed formal
degree, with no degree hypothesis (in particular when `p.coeff 0 = 0`). Conjugating twice is the
identity (`Polynomial.map_map`, `Complex.conj_conj`) and `reflect_reflect` gives the reflection
part. -/
theorem conjRecip_conjRecip (n : ℕ) (p : ℂ[X]) :
    conjRecip n (conjRecip n p) = p := by
  have hconj : (starRingEnd ℂ).comp (starRingEnd ℂ) = RingHom.id ℂ :=
    RingHom.ext Complex.conj_conj
  rw [conjRecip, conjRecip_eq_map_reflect, Polynomial.map_map, hconj, Polynomial.map_id,
    reflect_reflect]

/-- `lem:conjRecip-natDegree`: a bound only (equality fails when `p.coeff 0 = 0`). -/
theorem natDegree_conjRecip_le {n : ℕ} {p : ℂ[X]} (hp : p.natDegree ≤ n) :
    (conjRecip n p).natDegree ≤ n :=
  natDegree_le_iff_coeff_eq_zero.mpr fun _ hk => coeff_conjRecip_of_lt hp hk

section Linear

/-- `lem:conjRecip-linear` -/
theorem conjRecip_add (n : ℕ) (p r : ℂ[X]) :
    conjRecip n (p + r) = conjRecip n p + conjRecip n r := by
  ext k
  simp only [coeff_conjRecip, coeff_add, map_add]

/-- `lem:conjRecip-linear` -/
theorem conjRecip_sub (n : ℕ) (p r : ℂ[X]) :
    conjRecip n (p - r) = conjRecip n p - conjRecip n r := by
  ext k
  simp only [coeff_conjRecip, coeff_sub, map_sub]

/-- `lem:conjRecip-linear`: the scalar is conjugated. -/
theorem conjRecip_C_mul (n : ℕ) (c : ℂ) (p : ℂ[X]) :
    conjRecip n (C c * p) = C (conj c) * conjRecip n p := by
  ext k
  simp only [coeff_conjRecip, coeff_C_mul, map_mul]

/-- `lem:conjRecip-linear` -/
theorem conjRecip_zero (n : ℕ) : conjRecip n 0 = 0 := by
  ext k
  simp only [coeff_conjRecip, coeff_zero, map_zero]

/-- `lem:conjRecip-linear`: a constant at formal degree `0`. -/
theorem conjRecip_C (c : ℂ) : conjRecip 0 (C c) = C (conj c) := by
  ext k
  rcases Nat.eq_zero_or_pos k with rfl | hk
  · rw [conjRecip_coeff_zero, coeff_C_zero, coeff_C_zero]
  · rw [coeff_conjRecip, revAt_eq_self_of_lt hk, coeff_C_of_ne_zero hk.ne',
      coeff_C_of_ne_zero hk.ne', map_zero]

end Linear

/-- `lem:conjRecip-X-mul`: the reciprocal of `X * q` at `n` is the reciprocal of `q` at `n - 1`.
Needs `1 ≤ n` and `natDegree q ≤ n - 1`. -/
theorem conjRecip_X_mul {n : ℕ} (hn : 1 ≤ n) {q : ℂ[X]} (hq : q.natDegree ≤ n - 1) :
    conjRecip n (X * q) = conjRecip (n - 1) q := by
  obtain ⟨m, rfl⟩ : ∃ m, n = m + 1 := ⟨n - 1, by omega⟩
  rw [Nat.add_sub_cancel] at hq ⊢
  ext k
  rw [coeff_conjRecip, coeff_conjRecip]
  rcases Nat.lt_or_ge m k with hk | hk
  · rw [revAt_eq_self_of_lt hk, coeff_eq_zero_of_natDegree_lt (hq.trans_lt hk)]
    rcases Nat.lt_or_ge (m + 1) k with hk' | hk'
    · obtain ⟨j, rfl⟩ : ∃ j, k = j + 1 := ⟨k - 1, by omega⟩
      rw [revAt_eq_self_of_lt hk', coeff_X_mul, coeff_eq_zero_of_natDegree_lt (by omega)]
    · obtain rfl : k = m + 1 := by omega
      rw [revAt_le le_rfl, Nat.sub_self, coeff_X_mul_zero]
  · rw [revAt_le hk, revAt_le (by omega : k ≤ m + 1), show m + 1 - k = m - k + 1 by omega,
      coeff_X_mul]

/-- `lem:conjRecip-mul`: needs degree bounds on both factors. -/
theorem conjRecip_mul {F G : ℕ} {f g : ℂ[X]} (hf : f.natDegree ≤ F) (hg : g.natDegree ≤ G) :
    conjRecip (F + G) (f * g) = conjRecip F f * conjRecip G g := by
  rw [conjRecip, Polynomial.map_mul,
    reflect_mul _ _ (natDegree_map_le.trans hf) (natDegree_map_le.trans hg)]
  rfl

/-- Evaluating the conjugated polynomial: `(p.map conj).eval w = conj (p.eval (conj w))`. -/
theorem eval_map_conj (p : ℂ[X]) (w : ℂ) :
    (p.map (starRingEnd ℂ)).eval w = conj (p.eval (conj w)) := by
  rw [eval_map, ← eval₂_at_apply, Complex.conj_conj]

/-- `lem:conjRecip-eval`: `p*(z) = zⁿ · conj (p (1 / conj z))` for `z ≠ 0` when
`natDegree p ≤ n` (plan p. 16, C4.D "Done"). -/
theorem eval_conjRecip {n : ℕ} {p : ℂ[X]} (hp : p.natDegree ≤ n) {z : ℂ} (hz : z ≠ 0) :
    (conjRecip n p).eval z = z ^ n * conj (p.eval (conj z)⁻¹) := by
  letI : Invertible z⁻¹ := invertibleOfNonzero (inv_ne_zero hz)
  have h := eval₂_reflect_mul_pow (RingHom.id ℂ) z⁻¹ n (p.map (starRingEnd ℂ))
    (natDegree_map_le.trans hp)
  rw [invOf_eq_inv, inv_inv, eval₂_id, eval₂_id, eval_map_conj, map_inv₀] at h
  rw [conjRecip, ← h, mul_left_comm, ← mul_pow, mul_inv_cancel₀ hz, one_pow, mul_one]

/-- `lem:conjRecip-circle`: on the unit circle, `‖p*(z)‖ = ‖p(z)‖` when `natDegree p ≤ n`. -/
theorem norm_eval_conjRecip_of_norm_eq_one {n : ℕ} {p : ℂ[X]} (hp : p.natDegree ≤ n) {z : ℂ}
    (hz : ‖z‖ = 1) : ‖(conjRecip n p).eval z‖ = ‖p.eval z‖ := by
  have hz0 : z ≠ 0 := norm_ne_zero_iff.mp (by rw [hz]; exact one_ne_zero)
  have hinv : (conj z)⁻¹ = z := by
    rw [← map_inv₀, Complex.inv_def, Complex.normSq_eq_norm_sq, hz]
    simp
  rw [eval_conjRecip hp hz0, hinv, Complex.norm_mul, Complex.norm_pow, hz, one_pow, one_mul,
    Complex.norm_conj]

/-- `lem:reverse-trap`: why `Polynomial.reverse` is not used. (i) `X` reflected at the formal
degree `2` is `X`, but `reverse` reflects at `natDegree X = 1` and gives `1`. (ii) `reverse` is not
an involution when the constant term is zero: `reverse (reverse (X ^ 2 - X)) = X - 1`, whereas
`conjRecip_conjRecip` holds at every fixed degree. -/
theorem conjRecip_ne_reverse :
    conjRecip 2 (X : ℂ[X]) = X ∧ ((X : ℂ[X]).map (starRingEnd ℂ)).reverse = 1 ∧
      ((X ^ 2 - X : ℂ[X]).reverse).reverse = X - 1 := by
  have h1 : reflect 2 (X : ℂ[X]) = X := by
    rw [← pow_one (X : ℂ[X]), reflect_monomial, revAt_le (by norm_num)]
  have hdeg2 : (X ^ 2 - X : ℂ[X]).natDegree = 2 := by
    rw [natDegree_sub_eq_left_of_natDegree_lt] <;> simp
  have hrev1 : (X ^ 2 - X : ℂ[X]).reverse = 1 - X := by
    rw [reverse, hdeg2, reflect_sub, reflect_monomial, h1, revAt_le le_rfl, Nat.sub_self,
      pow_zero]
  refine ⟨?_, ?_, ?_⟩
  · rw [conjRecip, Polynomial.map_X, h1]
  · rw [Polynomial.map_X, reverse, natDegree_X, reflect_one_X]
  · have hdeg1 : (1 - X : ℂ[X]).natDegree = 1 := by
      rw [natDegree_sub_eq_right_of_natDegree_lt] <;> simp
    rw [hrev1, reverse, hdeg1, reflect_sub, reflect_one_X, reflect_one, pow_one]

end SchurCohn
