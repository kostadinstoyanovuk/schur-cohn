"""Which blueprint declarations exist in the built project.

Usage (from the project root):
  tr -d '\r' < blueprint/lean_decls > /tmp/lean_decls.txt
  python3 checks/blueprint_decls.py gen /tmp/lean_decls.txt        # writes checks/BlueprintDecls.lean
  lake env lean checks/BlueprintDecls.lean > /tmp/raw.log 2>&1
  python3 checks/blueprint_decls.py report /tmp/lean_decls.txt /tmp/raw.log > logs/blueprint-decls.log
Line 3 + i of BlueprintDecls.lean is `#check @<name i>`; a Lean error on that line means the name
does not resolve.
"""
import re
import sys

names = [l.strip() for l in open(sys.argv[2]) if l.strip()]
if sys.argv[1] == 'gen':
    with open('checks/BlueprintDecls.lean', 'w') as f:
        f.write('import SchurCohn\n\n' + ''.join(f'#check @{n}\n' for n in names))
else:
    raw = open(sys.argv[3]).read()
    bad = {int(m.group(1)) for m in re.finditer(r'BlueprintDecls\.lean:(\d+):\d+: error', raw)}
    res = [(n, 'MISSING' if 3 + i in bad else 'exists') for i, n in enumerate(names)]
    ne = sum(s == 'exists' for _, s in res)
    print(f'# `#check @name` for every entry of blueprint/lean_decls ({len(names)} names) against the built project')
    print('# (Lean v4.32.2, mathlib 905b958). "exists" = the name resolves; "MISSING" = not yet declared.')
    print(f'# {ne} exist, {len(res) - ne} missing. Errors reported by Lean: {len(bad)}.')
    for n, s in res:
        print(f'{s:8} {n}')
