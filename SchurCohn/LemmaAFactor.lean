import SchurCohn.LemmaA

/-!
# Lemma A for one factor (C4.LEM)

Blueprint node `lem:A-factor`, derived from Lemma A (`SchurCohn.lemmaA`, proved at schur-cohn
`a907f99` and reused here unchanged).
-/

namespace SchurCohn

open ComplexConjugate

/-- `lem:A-factor`: for `‖α‖ < 1` and `‖z‖ ≥ 1`, `0 < ‖z - α‖` and
`‖1 - conj α * z‖ ≤ ‖z - α‖`. -/
theorem norm_one_sub_conj_mul_le {α z : ℂ} (hα : ‖α‖ < 1) (hz : 1 ≤ ‖z‖) :
    0 < ‖z - α‖ ∧ ‖1 - conj α * z‖ ≤ ‖z - α‖ := by
  have hA := lemmaA α z
  have hα0 := norm_nonneg α
  have hpos : 0 < ‖z - α‖ := by
    have := norm_sub_norm_le z α
    linarith
  refine ⟨hpos, ?_⟩
  have hsq : ‖1 - conj α * z‖ ^ 2 ≤ ‖z - α‖ ^ 2 := by
    have : 0 ≤ (‖z‖ ^ 2 - 1) * (1 - ‖α‖ ^ 2) := mul_nonneg (by nlinarith) (by nlinarith)
    linarith
  exact (pow_le_pow_iff_left₀ (norm_nonneg _) hpos.le two_ne_zero).mp hsq

/-- `lem:A-factor`, strict form: for `‖α‖ < 1` and `‖z‖ > 1`. -/
theorem norm_one_sub_conj_mul_lt {α z : ℂ} (hα : ‖α‖ < 1) (hz : 1 < ‖z‖) :
    ‖1 - conj α * z‖ < ‖z - α‖ := by
  have hA := lemmaA α z
  have hα0 := norm_nonneg α
  have hsq : ‖1 - conj α * z‖ ^ 2 < ‖z - α‖ ^ 2 := by
    have : 0 < (‖z‖ ^ 2 - 1) * (1 - ‖α‖ ^ 2) := mul_pos (by nlinarith) (by nlinarith)
    linarith
  exact (pow_lt_pow_iff_left₀ (norm_nonneg _) (norm_nonneg _) two_ne_zero).mp hsq

/-- `lem:A-factor`, the circle: for `‖z‖ = 1` and every `α`, `‖1 - conj α * z‖ = ‖z - α‖`. -/
theorem norm_one_sub_conj_mul_eq (α : ℂ) {z : ℂ} (hz : ‖z‖ = 1) :
    ‖1 - conj α * z‖ = ‖z - α‖ := by
  have hA := lemmaA α z
  rw [hz, one_pow, sub_self, zero_mul, sub_eq_zero] at hA
  exact (pow_left_inj₀ (norm_nonneg _) (norm_nonneg _) two_ne_zero).mp hA.symm

end SchurCohn
