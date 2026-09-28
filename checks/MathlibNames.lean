import SchurCohn

/-!
# mathlib names relied on (C4.D and C4.LEM)

`#check` of every mathlib declaration that the proofs in `SchurCohn/` rewrite with or apply, at the
pin (Lean `v4.32.2`, mathlib `905b958`). Run with `lake env lean checks/MathlibNames.lean`; the
signatures are recorded in `logs/mathlib-names.log`.
-/

-- ml:reflect
#check @Polynomial.reflect
#check @Polynomial.coeff_reflect
#check @Polynomial.reflect_map
#check @Polynomial.reflect_reflect
#check @Polynomial.reflect_mul
#check @Polynomial.eval₂_reflect_mul_pow
#check @Polynomial.reflect_sub
#check @Polynomial.reflect_C
#check @Polynomial.reflect_monomial
#check @Polynomial.reflect_one_X
#check @Polynomial.reflect_one
#check @Polynomial.revAt
#check @Polynomial.revAt_le
#check @Polynomial.revAt_eq_self_of_lt
#check @Polynomial.revAt_invol
#check @Polynomial.revAt_zero
#check @Polynomial.reverse
-- ml:divX
#check @Polynomial.divX
-- coefficients, map, degree
#check @Polynomial.map
#check @Polynomial.coeff_map
#check @Polynomial.map_map
#check @Polynomial.map_id
#check @Polynomial.map_mul
#check @Polynomial.map_sub
#check @Polynomial.map_X
#check @Polynomial.map_C
#check @Polynomial.map_one
#check @Polynomial.natDegree_map_le
#check @Polynomial.natDegree_le_iff_coeff_eq_zero
#check @Polynomial.coeff_eq_zero_of_natDegree_lt
#check @Polynomial.coeff_X_mul
#check @Polynomial.coeff_X_mul_zero
#check @Polynomial.coeff_C_zero
#check @Polynomial.coeff_C_of_ne_zero
#check @Polynomial.coeff_C_mul
#check @Polynomial.coeff_add
#check @Polynomial.coeff_sub
#check @Polynomial.natDegree_sub_eq_left_of_natDegree_lt
#check @Polynomial.natDegree_sub_eq_right_of_natDegree_lt
#check @Polynomial.natDegree_X
#check @Polynomial.natDegree_C
#check @Polynomial.natDegree_one
#check @Polynomial.eq_C_of_natDegree_eq_zero
#check @Polynomial.C_0
#check @Polynomial.C_ne_zero
#check @Polynomial.C_eq_zero
#check @Polynomial.leadingCoeff_ne_zero
-- evaluation
#check @Polynomial.eval_map
#check @Polynomial.eval₂_at_apply
#check @Polynomial.eval₂_id
#check @Polynomial.eval_multiset_prod
#check @Polynomial.coeff_zero_eq_eval_zero
-- ml:splits
#check @Polynomial.roots
#check @Polynomial.mem_roots
#check @IsAlgClosed.card_roots_eq_natDegree
#check @Complex.isAlgClosed
#check @Polynomial.C_leadingCoeff_mul_prod_multiset_X_sub_C
#check @Polynomial.natDegree_multiset_prod_X_sub_C_eq_card
#check @Polynomial.natDegree_X_sub_C
-- ml:norm
#check @Complex.conj_conj
#check @Complex.inv_def
#check @Complex.normSq_eq_norm_sq
#check @Complex.norm_conj
#check @Complex.norm_mul
#check @Complex.norm_pow
#check @norm_mul
#check @normHom
#check @map_multiset_prod
#check @Multiset.prod_map_le_prod_map₀
#check @Multiset.prod_pos
#check @norm_sub_norm_le
#check @pow_le_pow_iff_left₀
#check @pow_lt_pow_iff_left₀
#check @pow_left_inj₀
-- multisets and inverses
#check @Multiset.exists_mem_of_ne_zero
#check @Multiset.exists_cons_of_mem
#check @Multiset.mem_cons_self
#check @Multiset.induction_on
#check @invertibleOfNonzero
#check @invOf_eq_inv
#check @map_inv₀
