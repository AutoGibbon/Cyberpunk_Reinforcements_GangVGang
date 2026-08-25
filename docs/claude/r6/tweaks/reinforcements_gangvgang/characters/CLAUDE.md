Reference `tweak_data_references/` (repo root, alongside `r6/` — not inside it) for the various record types when constructing new character records:

- `archetypedatas` - valid `ArchetypeData.*` values
- `attachmentslots` - valid equip slots (`WeaponRight`/`WeaponLeft`/etc.) and body slots (`ItemSlotGenericRanged`/`ItemSlotSMG`/etc.)
- `itempresets` - a non-exhaustive list of confirmed-working `Items.Preset_*` records, grouped by weapon category
- `lootdrops` - valid `Loot.*` values
- `npcrarity` - valid `NPCRarity.*` values
- `weaponconditions` - valid `WeaponConditions.*` equip/unequip condition pairs
- `weapons_used_by_gangs.txt` - which gangs use which weapons today, which weapon presets are confirmed vs. unconfirmed, and the `$base` naming convention (`<gang>_<role><tier>_<weaponclass><tier#>_<weaponname>_<suffix>`)

These files are references, not exhaustive specs — a preset or base missing from them isn't necessarily invalid, but anything not listed should be confirmed (e.g. via Wolvenkit) rather than guessed from the pattern.
