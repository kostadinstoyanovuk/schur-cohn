import Mathlib.Analysis.Complex.Norm

/-!
# Lemma A: the Blaschke identity

For all complex `α` and `z`,
`‖z - α‖ ^ 2 - ‖1 - conj α * z‖ ^ 2 = (‖z‖ ^ 2 - 1) * (1 - ‖α‖ ^ 2)`.

This is Lemma A of section 14 of the programme plan. It is the identity used to
show that a stable polynomial dominates its conjugate reciprocal outside the
unit disc (Lemma B). Proving it here is the foundations exercise F6. The
blueprint of work package C4.B, gate G6, governs the programme's formal
development; this file states neither the Schur-Cohn step nor a stability
theorem. Independently written.
-/

namespace SchurCohn

open ComplexConjugate

/-- Lemma A with the squared modulus `Complex.normSq`. -/
theorem lemmaA_normSq (α z : ℂ) :
    Complex.normSq (z - α) - Complex.normSq (1 - conj α * z) =
      (Complex.normSq z - 1) * (1 - Complex.normSq α) := by
  simp only [Complex.normSq_apply, Complex.sub_re, Complex.sub_im, Complex.mul_re,
    Complex.mul_im, Complex.conj_re, Complex.conj_im, Complex.one_re, Complex.one_im]
  ring

/-- Lemma A as stated in the plan, with the complex norm. -/
theorem lemmaA (α z : ℂ) :
    ‖z - α‖ ^ 2 - ‖1 - conj α * z‖ ^ 2 = (‖z‖ ^ 2 - 1) * (1 - ‖α‖ ^ 2) := by
  simpa only [Complex.normSq_eq_norm_sq] using lemmaA_normSq α z

end SchurCohn

#print axioms SchurCohn.lemmaA_normSq
#print axioms SchurCohn.lemmaA
