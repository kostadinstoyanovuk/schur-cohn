import Mathlib.Algebra.Order.BigOperators.GroupWithZero.Multiset
import Mathlib.Data.Real.Basic

/-!
# Product inequalities over a multiset of reals (C4.LEM helpers)

The strict product inequality used by Lemma B (strict form) and Lemma C. mathlib's
`Multiset.prod_lt_prod_of_nonempty` assumes `MulLeftStrictMono`, which `ℝ` does not satisfy, so
the multiset form is proved here from `Multiset.prod_map_le_prod_map₀` and `Multiset.prod_pos`
(C4.B `open-obligations.md`, O-LEM-2).
-/

namespace SchurCohn

/-- A product over a non-empty multiset of strict inequalities `0 ≤ f i < g i` is strict. -/
theorem multiset_prod_map_lt_prod_map {ι : Type*} {s : Multiset ι} (hs : s ≠ 0) {f g : ι → ℝ}
    (h0 : ∀ i ∈ s, 0 ≤ f i) (hlt : ∀ i ∈ s, f i < g i) :
    (s.map f).prod < (s.map g).prod := by
  obtain ⟨a, ha⟩ := Multiset.exists_mem_of_ne_zero hs
  obtain ⟨t, rfl⟩ := Multiset.exists_cons_of_mem ha
  have ht : ∀ i ∈ t, i ∈ a ::ₘ t := fun i hi => Multiset.mem_cons_of_mem hi
  have haf := h0 a (Multiset.mem_cons_self a t)
  have hag := hlt a (Multiset.mem_cons_self a t)
  rw [Multiset.map_cons, Multiset.map_cons, Multiset.prod_cons, Multiset.prod_cons]
  have hG : 0 < (t.map g).prod := Multiset.prod_pos fun x hx => by
    obtain ⟨i, hi, rfl⟩ := Multiset.mem_map.mp hx
    exact (h0 i (ht i hi)).trans_lt (hlt i (ht i hi))
  have hFG : (t.map f).prod ≤ (t.map g).prod :=
    Multiset.prod_map_le_prod_map₀ f g (fun i hi => h0 i (ht i hi))
      (fun i hi => (hlt i (ht i hi)).le)
  calc f a * (t.map f).prod ≤ f a * (t.map g).prod := mul_le_mul_of_nonneg_left hFG haf
    _ < g a * (t.map g).prod := mul_lt_mul_of_pos_right hag hG

/-- A product over a non-empty multiset of numbers in `[0, 1)` is `< 1`. -/
theorem multiset_prod_map_lt_one {ι : Type*} {s : Multiset ι} (hs : s ≠ 0) {f : ι → ℝ}
    (h0 : ∀ i ∈ s, 0 ≤ f i) (h1 : ∀ i ∈ s, f i < 1) : (s.map f).prod < 1 := by
  simpa using multiset_prod_map_lt_prod_map hs h0 (g := fun _ => 1) h1

end SchurCohn
