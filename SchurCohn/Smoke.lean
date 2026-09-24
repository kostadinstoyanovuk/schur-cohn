import Mathlib.Algebra.Polynomial.Eval.Defs

/-!
Infrastructure smoke only. Independently written; no programme theorem is
claimed. The polynomial identity holds for every natural-number input and
checks that mathlib polynomial definitions and simplification are available.
-/

namespace SchurCohn

theorem polynomial_smoke (n : Nat) :
    Polynomial.eval n (Polynomial.X + Polynomial.C 1 : Polynomial Nat) = n + 1 := by
  simp

theorem arithmetic_smoke : (2 : Nat) + 2 = 4 := by
  rfl

end SchurCohn

#print axioms SchurCohn.polynomial_smoke
#print axioms SchurCohn.arithmetic_smoke
