# Cyberpunk 2077 RedScript Mod - Reinforcements Gang vs Gang

## Project Overview

This is a Cyberpunk 2077 mod that implements a dynamic gang reinforcement system using RedScript.
The mod allows different gangs to call for reinforcements when fighting each other.
This system does not directly involve the player; it enables a form of combat voyeurism for the player.

It operates on a simple cyclic intensity system governed by cooldowns, where each gang starts at some initial heat, is allowed to make a few calls, and then resets to baseline.
This enables a lightweight and unobtrusive system that does not rely on complex game engine state management, and affords some semblance of organic behaviours to the player.

## File Structure

- `r6/scripts/` - RedScript source files
- `r6/tweaks/` - YAML configuration files for game tweaks - NEVER TOUCH THESE FILES EVER.
- `GangData/` - Gang-specific data definitions
- `GangHandlers/` - Gang-specific logic handlers
- `Localization/` - Multi-language support files

## Scoped Instructions

`pack.js`/`deploy.js` copy everything under `r6/` verbatim (only `.cursorrules` files are excluded), so directory-specific `CLAUDE.md` files live outside `r6/` under `docs/claude/`, mirroring the path they apply to. Check these when working in the corresponding directory:

- `docs/claude/r6/scripts/reinforcements_gangvgang/Localization/CLAUDE.md` - localization/translation guidelines, applies to `r6/scripts/reinforcements_gangvgang/Localization/`
- `docs/claude/r6/tweaks/reinforcements_gangvgang/characters/CLAUDE.md` - character tweak record guidance, applies to `r6/tweaks/reinforcements_gangvgang/characters/`

@../_shared/redscript-practices.md
@../_shared/tweakdb-practices.md

The imports above hold conventions shared with sibling redscript mods under `proj/`: RedScript naming/delay-system/null-safety rules (`redscript-practices.md`, imported by every redscript project in scope) and TweakDB YAML conventions (`tweakdb-practices.md`, imported only here since this is the only project that maintains `r6/tweaks/` — `AdaptiveTrafficHeadlights` doesn't touch TweakDB at all). Both live outside `proj/` itself so they don't auto-load as an ancestor CLAUDE.md for this repo's many unrelated sibling projects. This file only covers what's specific to this project.

## Code Style & Conventions

### RedScript (.reds files)

- Naming conventions, API-reference source dump: see `../_shared/redscript-practices.md`.
- Use descriptive names for gang-related variables and methods
- Comment complex logic, especially game API interactions

### YAML Configuration

General conventions: see `../_shared/tweakdb-practices.md`. Character-record-specific reference data (valid archetypes, item presets, weapon conditions, etc.) lives in `docs/claude/r6/tweaks/reinforcements_gangvgang/characters/CLAUDE.md` per Scoped Instructions above.

## Development Guidelines

### Delay system

- used when we want something to happen later, or to throttle requests for a certain activity to be performed
- managed using the DelaySystem native class, and 'callback handlers'
- see `../_shared/redscript-practices.md` for the general pattern (including the required `IsDefined()` guard on `Call()` — a crash audit, 2026-08-29 finding 6, found it missing on all 31 callback implementations in this codebase at the time)
- example of using the callback handler and delay system together, assuming the given class has this.m_delaySystem

```
	let delay: Float = 10.0 //seconds
	this.m_delaySystem.DelayCallback(GRSpawnTrafficCallback.Create(this), delay, false);
```

### Thread Safety

- member access between classes must be implemented via getter/setter

### Logging

- Logging always uses the GRLog function.
- Never prefix log call strings, this is already done by the wrapper function.
- Use string interpolation e.g GRLog(s"my random log message \\(someVar)")
- prefer concise log structures e.g "(affiliation), Vehicles: (count)"

### Settings

- All configurable options should go through the Settings system
- Use descriptive setting names
- Provide sensible defaults

### Null safety

The general rules (downcast guards, nullable-accessor guards, `@wrapMethod`/`wrappedMethod` safety, log-interpolation evaluation) live in `../_shared/redscript-practices.md` (imported above) — required here same as any other project in scope. This project is also where the two audits that produced those rules happened: `docs/crash-audit-2026-08-29.md`, `docs/crash-audit-2026-08-30.md`, and the log-call specifics apply directly (`GRLog(...)`, and `pack.js` disabling `LogChannel` calls before zipping).

See `../_shared/diagnosing-crashes.md` for the crash-report triage process (REDscope, WinDbg, the engine's own `attch/` breadcrumb file) if a new crash needs investigating.

## Notes

- This mod modifies game behavior at runtime
- Be careful with game API calls to avoid crashes
- PERFORMANCE IS KING

## Deployment target

Z:\\GOG\\Cyberpunk 2077

- game root contains the r6 folder, where these files can be deposited without special steps.

## Command: "deploy and launch"

When the user says "deploy and launch" (or equivalent), run this immediately, with no confirmation prompt and no re-derivation of what it does — this is standing pre-authorization:

```
node deploy.js && node launch.js
```

- `deploy.js` deletes `r6/scripts/reinforcements_gangvgang` and `r6/tweaks/reinforcements_gangvgang` under the deployment target, then copies the entire local `./r6` folder over the target's `r6` folder (this also overwrites any non-mod files under the target's `r6/`, not just this mod's subfolders).
- `launch.js` starts Cyberpunk 2077 via its shortcut, fire-and-forget (no wait for the game to actually launch).
- Pre-authorization covers only this exact two-step command as documented here. Any variation (different target, different scope, force-push-style destructive ops elsewhere) still needs explicit confirmation per the general safety rules above.

## Command: "pack"

When the user says "pack" (or equivalent), run this immediately, with no confirmation prompt and no re-derivation of what it does — this is standing pre-authorization:

```
node pack.js
```

- Deletes the local `./r6.zip` if it exists, then zips the entire local `./r6` folder (excluding any `.cursorrules` files) into `./r6.zip` via `7z`.
- Only touches the local `r6.zip` build artifact — does not touch the deployment target or the game.
