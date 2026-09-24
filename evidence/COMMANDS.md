# Local preparation, 2026-09-24

1. Retrieved the official Lean GitHub release API metadata into `lean-release.json`.
2. Downloaded its `lean-4.32.2-windows.zip` asset and verified SHA-256 against the
   release asset's `digest` before extraction or execution. The expected hash is
   `369c2b480a2a6f8bfb727af42c333c894c4872a73b3503099abad7bef67549fa`.
3. Extracted the portable toolchain inside this repository's ignored `.tools/`.
   Ran `lean --version` and `lake --version` using their absolute local paths.
4. Ran `git clone --depth 1 --branch v4.32.2 https://github.com/leanprover-community/mathlib4.git .lake/packages/mathlib`.
   `git rev-parse HEAD` returned `905b95818eb32af7874a58b427f50c1711a5e96c`.
5. Ran `.tools/lean-4.32.2-windows/bin/lake.exe update` with
   `MATHLIB_NO_CACHE_ON_UPDATE=1` and `LEAN_NUM_THREADS=4` in that process.
6. The resumable selective-cache and build command is `./tools/smoke.ps1`.
   Its first attempt failed because the cache tool invokes `lean --print-prefix`
   and Lean was absent from PATH. `cache-first-attempt.log` preserves the failure.
   The script was corrected to prepend the portable bin only to its process PATH
   and restore it afterward. The second attempt downloaded and decompressed all
   1,166 requested files, and `lake build` completed successfully (1,184 total
   jobs including cached dependencies). The polynomial example reports exactly
   `propext`, `Classical.choice`, and `Quot.sound`; the arithmetic example reports
   no axioms. See `cache-get.log` and `lake-build.log` for the actual output.

`tools/install-lean.ps1` reproduces steps 2–3. The portable toolchain uses a
process-local PATH. `.tools/` and `.lake/` are excluded from version control.
Full mathlib cache download is disabled; only the requested import closure is
selected.

The proof examples are setup checks and do not satisfy programme gates G6 or G7.
