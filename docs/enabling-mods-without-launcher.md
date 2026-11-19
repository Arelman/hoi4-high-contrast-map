# Enabling and checking mods when the Paradox launcher is not installed

HOI4 1.19.4 started directly from `hoi4.exe` has no mods menu. It reads the list of enabled mods from
`Documents\Paradox Interactive\Hearts of Iron IV\dlc_load.json`.

```json
{"enabled_mods":["mod/high_contrast_map.mod"],"disabled_dlcs":[]}
```

- Entries must be **plain strings**. A list of objects (`{"path": ...}`) makes the game log
  `Expect only strings in dlcs/mods arrays.` in `logs\error.log` and ignore the whole list.
- `mod/<name>.mod` is a descriptor file in `Documents\...\Hearts of Iron IV\mod\`; its `path=` points at the mod folder.
  Order in the array is load order.
- Restart the game after any change; the file is read only at start-up.
- The launcher, if installed, overwrites this file.

Logs are in `Documents\...\Hearts of Iron IV\logs\` (`error.log` first). `check.ps1` prints the relevant lines.

The game's own reference docs (script, effects, triggers, modifiers) are in `<game folder>\documentation`.
There is no modding-structure or shader documentation there; the community wiki
<https://hoi4.paradoxwikis.com/Modding> covers mod structure.
