$ErrorActionPreference = 'Stop'
$repoDir = Split-Path -Parent $PSScriptRoot
$toolsDir = Join-Path $repoDir '.tools'
$archive = Join-Path $toolsDir 'lean-4.32.2-windows.zip'
$expected = '369c2b480a2a6f8bfb727af42c333c894c4872a73b3503099abad7bef67549fa'
New-Item -ItemType Directory -Path $toolsDir -Force | Out-Null
if (!(Test-Path -LiteralPath $archive)) {
    Invoke-WebRequest -Uri 'https://github.com/leanprover/lean4/releases/download/v4.32.2/lean-4.32.2-windows.zip' -OutFile $archive
}
$actual = (Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash.ToLowerInvariant()
if ($actual -ne $expected) { throw 'Official release SHA-256 mismatch' }
"Verified archive SHA256 $actual" | Set-Content -LiteralPath (Join-Path $repoDir 'evidence/lean-download.log')
if (!(Test-Path -LiteralPath (Join-Path $toolsDir 'lean-4.32.2-windows/bin/lean.exe'))) {
    Expand-Archive -LiteralPath $archive -DestinationPath $toolsDir
}
& (Join-Path $toolsDir 'lean-4.32.2-windows/bin/lean.exe') --version
if ($LASTEXITCODE -ne 0) { throw 'Lean executable failed' }
# No user/system PATH or global toolchain is modified.
