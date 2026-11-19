# Copies the mod into the HOI4 user "mod" folder and registers it for the launcher.
# Usage:  powershell -ExecutionPolicy Bypass -File .\install.ps1
$ErrorActionPreference = 'Stop'

$src     = $PSScriptRoot
$modsDir = Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'Paradox Interactive\Hearts of Iron IV\mod'
$dest    = Join-Path $modsDir 'high_contrast_map'

New-Item -ItemType Directory -Force $modsDir | Out-Null
if (Test-Path $dest) { Remove-Item -Recurse -Force $dest }
New-Item -ItemType Directory -Force $dest | Out-Null

foreach ($item in 'gfx', 'common', 'descriptor.mod') {
    Copy-Item -Recurse -Force (Join-Path $src $item) $dest
}

$descriptor = Get-Content -Raw (Join-Path $src 'descriptor.mod')
$descriptor = $descriptor.TrimEnd() + "`r`npath=`"mod/high_contrast_map`"`r`n"
[IO.File]::WriteAllText((Join-Path $modsDir 'high_contrast_map.mod'), $descriptor, (New-Object Text.UTF8Encoding($false)))

Write-Host "Installed to $dest"
Write-Host "Enable 'High Contrast Tactical Map' in the HOI4 launcher (Mods tab)."
