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

# Enable the mod. Without the Paradox launcher the game reads dlc_load.json directly.
# In 1.19.4 both arrays must contain plain strings (objects are rejected: "Expect only strings in dlcs/mods arrays").
$loadFile = Join-Path (Split-Path $modsDir -Parent) 'dlc_load.json'
$mods = @(); $dlcs = @()
if (Test-Path $loadFile) {
    $cfg = Get-Content -Raw $loadFile | ConvertFrom-Json
    if ($cfg.enabled_mods) { $mods = @($cfg.enabled_mods | ForEach-Object { "$_" }) }
    if ($cfg.disabled_dlcs) { $dlcs = @($cfg.disabled_dlcs | ForEach-Object { "$_" }) }
}
if ($mods -notcontains 'mod/high_contrast_map.mod') { $mods += 'mod/high_contrast_map.mod' }
$json = [ordered]@{ enabled_mods = $mods; disabled_dlcs = $dlcs } | ConvertTo-Json -Compress
if ($mods.Count -eq 1) { $json = $json -replace '"enabled_mods":"([^"]*)"', '"enabled_mods":["$1"]' }
if ($dlcs.Count -eq 0) { $json = $json -replace '"disabled_dlcs":(null|\[\])', '"disabled_dlcs":[]' }
[IO.File]::WriteAllText($loadFile, $json, (New-Object Text.UTF8Encoding($false)))

Write-Host "Installed to $dest"
Write-Host "Enabled in $loadFile"
Write-Host "Restart the game, then run .\check.ps1 to see whether it loaded."
