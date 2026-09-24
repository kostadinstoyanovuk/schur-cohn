$ErrorActionPreference = 'Stop'
$repoDir = Split-Path -Parent $PSScriptRoot
$lakeExe = Join-Path $repoDir '.tools/lean-4.32.2-windows/bin/lake.exe'
if (!(Test-Path -LiteralPath $lakeExe)) {
    throw 'Portable Lean is missing. Follow tools/install-lean.ps1 first.'
}
$env:MATHLIB_NO_CACHE_ON_UPDATE = '1'
$env:LEAN_NUM_THREADS = '4'
$env:MATHLIB_CACHE_DIR = Join-Path $repoDir '.tools/mathlib-cache'
$previousProcessPath = $env:PATH
$env:PATH = (Split-Path -Parent $lakeExe) + [IO.Path]::PathSeparator + $env:PATH
Push-Location -LiteralPath $repoDir
try {
    & $lakeExe exe cache get Mathlib.Algebra.Polynomial.Eval.Defs 2>&1 |
        Tee-Object -FilePath 'evidence/cache-get.log'
    if ($LASTEXITCODE -ne 0) { throw 'Selective mathlib cache failed' }
    & $lakeExe build 2>&1 | Tee-Object -FilePath 'evidence/lake-build.log'
    if ($LASTEXITCODE -ne 0) { throw 'Lean smoke build failed' }
} finally {
    Pop-Location
    $env:PATH = $previousProcessPath
}
