import SchurCohn.Defs
import Mathlib.Algebra.Polynomial.Roots

/-!
# Basic facts on stability (C4.D)

Blueprint node `lem:stable-basic`.
-/

namespace SchurCohn

open Polynomial

/-- `lem:stable-basic` (i): the zero polynomial is not stable. -/
theorem not_isStable_zero : ¬ IsStable 0 := fun h => h.1 rfl

/-- `lem:stable-basic` (ii): a non-zero constant is stable (it has no roots). -/
theorem isStable_C {c : ℂ} (hc : c ≠ 0) : IsStable (C c) :=
  ⟨C_ne_zero.mpr hc, fun z hz => absurd (by simpa [IsRoot] using hz) hc⟩

/-- `lem:stable-basic` (iii) -/
theorem isStable_iff_of_natDegree_eq_zero {p : ℂ[X]} (hp : p.natDegree = 0) :
    IsStable p ↔ p.coeff 0 ≠ 0 := by
  have hpC := eq_C_of_natDegree_eq_zero hp
  refine ⟨fun h h0 => ?_, fun h => ?_⟩
  · rw [hpC, h0, C_0] at h
    exact not_isStable_zero h
  · rw [hpC]
    exact isStable_C h

/-- `lem:stable-basic` (iv): scaling by a non-zero constant. -/
theorem isStable_C_mul_iff {c : ℂ} (hc : c ≠ 0) {p : ℂ[X]} :
    IsStable (C c * p) ↔ IsStable p := by
  have hroot : ∀ z, (C c * p).IsRoot z ↔ p.IsRoot z := fun z => by
    simp [IsRoot, hc]
  simp only [IsStable, hroot, ne_eq, mul_eq_zero, C_eq_zero, hc, false_or]

/-- `lem:stable-basic` (v): stability through the root multiset. -/
theorem isStable_iff_roots {p : ℂ[X]} :
    IsStable p ↔ p ≠ 0 ∧ ∀ w ∈ p.roots, ‖w‖ < 1 := by
  refine ⟨fun h => ⟨h.1, fun w hw => h.2 w ((mem_roots h.1).mp hw)⟩,
    fun h => ⟨h.1, fun z hz => h.2 z ((mem_roots h.1).mpr hz)⟩⟩

/-- A stable polynomial does not vanish at any `z` with `1 ≤ ‖z‖`. -/
theorem IsStable.eval_ne_zero {p : ℂ[X]} (hs : IsStable p) {z : ℂ} (hz : 1 ≤ ‖z‖) :
    p.eval z ≠ 0 := fun h => (hs.2 z h).not_ge hz

end SchurCohn
