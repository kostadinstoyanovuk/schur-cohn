import SchurCohn

/-!
# Axiom audit (C4.D and C4.LEM)

`#print axioms` for every declaration added in C4.D and C4.LEM, plus Lemma A. Run with
`lake env lean checks/Axioms.lean`; `checks/check_axioms.py` compares the output with the
allowlist `propext`, `Classical.choice`, `Quot.sound` (plan p. 17, G7).
-/

#print axioms SchurCohn.conjRecip
#print axioms SchurCohn.IsStable
#print axioms SchurCohn.schur
#print axioms SchurCohn.coeff_conjRecip
#print axioms SchurCohn.coeff_conjRecip_of_le
#print axioms SchurCohn.coeff_conjRecip_of_lt
#print axioms SchurCohn.conjRecip_coeff_zero
#print axioms SchurCohn.conjRecip_coeff_self
#print axioms SchurCohn.conjRecip_conjRecip
#print axioms SchurCohn.conjRecip_eq_map_reflect
#print axioms SchurCohn.natDegree_conjRecip_le
#print axioms SchurCohn.conjRecip_add
#print axioms SchurCohn.conjRecip_sub
#print axioms SchurCohn.conjRecip_C_mul
#print axioms SchurCohn.conjRecip_zero
#print axioms SchurCohn.conjRecip_C
#print axioms SchurCohn.conjRecip_X_mul
#print axioms SchurCohn.conjRecip_mul
#print axioms SchurCohn.eval_map_conj
#print axioms SchurCohn.eval_conjRecip
#print axioms SchurCohn.norm_eval_conjRecip_of_norm_eq_one
#print axioms SchurCohn.conjRecip_ne_reverse
#print axioms SchurCohn.not_isStable_zero
#print axioms SchurCohn.isStable_C
#print axioms SchurCohn.isStable_iff_of_natDegree_eq_zero
#print axioms SchurCohn.isStable_C_mul_iff
#print axioms SchurCohn.isStable_iff_roots
#print axioms SchurCohn.IsStable.eval_ne_zero
#print axioms SchurCohn.lemmaA_normSq
#print axioms SchurCohn.lemmaA
#print axioms SchurCohn.norm_one_sub_conj_mul_le
#print axioms SchurCohn.norm_one_sub_conj_mul_lt
#print axioms SchurCohn.norm_one_sub_conj_mul_eq
#print axioms SchurCohn.multiset_prod_map_lt_prod_map
#print axioms SchurCohn.multiset_prod_map_lt_one
#print axioms SchurCohn.eval_eq_prod_roots_of_natDegree
#print axioms SchurCohn.conjRecip_X_sub_C
#print axioms SchurCohn.conjRecip_prod_X_sub_C
#print axioms SchurCohn.conjRecip_eq_prod_roots
#print axioms SchurCohn.eval_conjRecip_eq_prod_roots
#print axioms SchurCohn.norm_multiset_prod_complex
#print axioms SchurCohn.norm_eval_eq_prod_roots
#print axioms SchurCohn.norm_eval_conjRecip_eq_prod_roots
#print axioms SchurCohn.IsStable.norm_coeff_pos
#print axioms SchurCohn.roots_ne_zero_of_natDegree
#print axioms SchurCohn.lemmaB
#print axioms SchurCohn.lemmaB_strict
#print axioms SchurCohn.lemmaB_eq_iff
#print axioms SchurCohn.coeff_zero_eq_mul_prod_roots
#print axioms SchurCohn.lemmaC
