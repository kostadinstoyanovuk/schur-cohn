import Mathlib.Algebra.Polynomial.Reverse
import Mathlib.Algebra.Polynomial.Inductions
import Mathlib.Analysis.Complex.Norm

/-!
# Definitions (C4.D)

The three definitions of the C4.B blueprint (`def:conjRecip`, `def:IsStable`, `def:schur`),
with the bodies the blueprint specifies. Blueprint convention D-025 (1): every conjugate
reciprocal and every Schur transform takes an explicit formal degree `n`;
`Polynomial.reverse`, which reflects at `natDegree`, is never used.
-/

namespace SchurCohn

open Polynomial ComplexConjugate

/-- `def:conjRecip`. The conjugate reciprocal of `p` at the formal degree `n`: conjugate every
coefficient, then reflect at `n`. If `natDegree p ≤ n` then its coefficient of `X ^ k` is
`conj (p.coeff (n - k))` for `k ≤ n`, and it evaluates to `z ^ n * conj (p.eval (conj z)⁻¹)`
at `z ≠ 0` (see `SchurCohn.eval_conjRecip`). -/
noncomputable def conjRecip (n : ℕ) (p : ℂ[X]) : ℂ[X] :=
  (p.map (starRingEnd ℂ)).reflect n

/-- `def:IsStable`. `p` is non-zero and every root of `p` lies in the open unit disc. The zero
polynomial is not stable; a non-zero constant is. -/
def IsStable (p : ℂ[X]) : Prop :=
  p ≠ 0 ∧ ∀ z : ℂ, p.IsRoot z → ‖z‖ < 1

/-- `def:schur`. The Schur transform at the formal degree `n`:
`X * schur n p = C (conj aₙ) * p - C a₀ * conjRecip n p`, with `aₖ = p.coeff k`. It uses
`p.coeff n`, not `p.leadingCoeff`. -/
noncomputable def schur (n : ℕ) (p : ℂ[X]) : ℂ[X] :=
  (C (conj (p.coeff n)) * p - C (p.coeff 0) * conjRecip n p).divX

end SchurCohn
