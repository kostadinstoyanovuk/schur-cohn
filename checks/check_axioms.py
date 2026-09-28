"""Allowlist check of `#print axioms` output (plan p. 17, G7).

Usage: python3 check_axioms.py decls.txt axioms.log
Exit 0 only if every declaration in decls.txt has an axioms line in the log and every listed
axiom is one of propext, Classical.choice, Quot.sound.
"""
import re
import sys

ALLOWED = {"propext", "Classical.choice", "Quot.sound"}

decls = [line.strip() for line in open(sys.argv[1]) if line.strip()]
log = open(sys.argv[2]).read()
found = {}
for m in re.finditer(r"'([^']+)' depends on axioms: \[([^\]]*)\]", log):
    found[m.group(1)] = [a.strip() for a in m.group(2).replace("\n", " ").split(",") if a.strip()]
for m in re.finditer(r"'([^']+)' does not depend on any axioms", log):
    found[m.group(1)] = []

bad = 0
for d in decls:
    if d not in found:
        print(f"MISSING  {d}")
        bad += 1
        continue
    extra = [a for a in found[d] if a not in ALLOWED]
    status = "OK" if not extra else "FAIL"
    if extra:
        bad += 1
    print(f"{status:8} {d}: [{', '.join(found[d])}]")
print(f"{len(decls)} declarations checked, {bad} failing")
sys.exit(1 if bad else 0)
