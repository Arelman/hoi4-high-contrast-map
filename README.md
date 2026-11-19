# High Contrast Tactical Map (Hearts of Iron IV)

A small accessibility-oriented graphics mod for HOI4 **1.19.4**. It was made for low vision (retinitis pigmentosa), but anyone who struggles to read the map can use it.

## What it changes

- **Defence lines and other order lines** (`gfx/FX/maparrow.shader`, `ArrowPixelShaderNoHead`): more saturated and brighter, fully opaque, less darkened by map lighting and terrain shadows, so placed lines look like they do while you are drawing them.
- **Province and state borders** (`gfx/FX/border.shader`, `common/defines/zz_high_contrast_map.lua`): black, about 2.3x thicker, and visible from further away. Selection and hover highlights keep their colours.

All strengths are constants at the top of the changed shader blocks (`HC_*`) and in the defines file, so they are easy to tune.

## Install

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

Then enable **High Contrast Tactical Map** in the HOI4 launcher. Re-run the script after editing files.

## Compatibility

The mod replaces two vanilla shader files, so it conflicts with other mods that replace `gfx/FX/border.shader` or `gfx/FX/maparrow.shader`, and it needs to be checked after game updates. Supported version is set in `descriptor.mod`.

## Legal

Hearts of Iron IV is a trademark of Paradox Interactive. The two shader files are modified copies of the game's own files, shared for modding purposes; this project is unofficial and not affiliated with Paradox.
