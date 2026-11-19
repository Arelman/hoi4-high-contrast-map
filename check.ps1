# Shows whether the last HOI4 run accepted dlc_load.json and whether any shader/mod errors were logged.
$root = Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'Paradox Interactive\Hearts of Iron IV'
Write-Host "--- dlc_load.json"; Get-Content "$root\dlc_load.json"
Write-Host "--- error.log lines about mods / shaders / our files"
Select-String -Path "$root\logs\error.log" -Pattern 'dlcs/mods|high_contrast|shader|border|maparrow|zz_high' | ForEach-Object { $_.Line }
Write-Host "--- (no lines above = nothing wrong was logged)"
