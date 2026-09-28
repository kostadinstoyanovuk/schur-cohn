"""Generate checks/Conformance.lean from the C4.B statement file.

Usage: python3 gen_conformance.py SchurCohnStatements.lean > /dev/null
(the statement file is deliverables/C4.B/statements/SchurCohnStatements.lean at 20d4440,
SHA-256 98397a5f6852c87212a4c8d2b73baf3ec7589703e613185b331ad9b4937a463a).
Every theorem of the C4.D and C4.LEM sections is copied verbatim as an `example` and closed by
the SchurCohn declaration of the same name, with every binder passed by name.
"""
import re
import sys

src = open(sys.argv[1]).read()
start = src.index('/-! ## Definitions and conjugate-reciprocal API (C4.D) -/')
end_ = src.index('/-! ## Schur transform and main theorem (C4.THM) -/')
sec = src[start:end_]
blocks = re.findall(r'(/-- [^\n]*-/\n)?theorem (\S+)(.*?):=\s*sorry', sec, re.S)
out = [open(__file__.replace('gen_conformance.py', 'conformance_header.lean')).read()]
names = []
for _doc, name, rest in blocks:
    sig = rest.rstrip()
    depth, cut = 0, None
    for i, ch in enumerate(sig):
        if ch in '({[':
            depth += 1
        elif ch in ')}]':
            depth -= 1
        elif ch == ':' and depth == 0:
            cut = i
            break
    head, typ = sig[:cut], sig[cut + 1:]
    bnames = []
    for grp in re.findall(r'[({]([^(){}]*?):', head):
        bnames += grp.split()
    args = ' '.join(f'({b} := {b})' for b in bnames)
    out.append(f"-- `{name}`\nexample{head}:{typ} :=\n  SchurCohn.{name} {args}\n".replace(' \n', '\n'))
    names.append(name)
open(__file__.replace('gen_conformance.py', 'Conformance.lean'), 'w').write('\n'.join(out))
print(len(names), 'statements:', ' '.join(names))
