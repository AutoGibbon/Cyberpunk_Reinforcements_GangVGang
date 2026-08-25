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

## Code Style & Conventions

### RedScript (.reds files)

- Use PascalCase for class names and public methods
- Use camelCase for variables and private methods
- Use m_varName for private/protected class fields
- Follow RedScript naming conventions for game API calls
- Use descriptive names for gang-related variables and methods
- Comment complex logic, especially game API interactions
- raw source dumps for api reference: E:\Tools\mods\cp77\redscript\source

### YAML Configuration

- Use snake_case for file names
- Keep YAML structure consistent across gang files
- Use meaningful keys that match gang names
- Maintain consistent indentation (2 spaces)

## Development Guidelines

### Delay system

- used when we want something to happen later, or to throttle requests for a certain activity to be performed
- managed using the DelaySystem native class, and 'callback handlers'
- example of a callback handler

```
public class GRSpawnTrafficCallback extends DelayCallback {
    let handler: wref<GRReinforcementSystem>;

    public static func Create(handler: ref<GRReinforcementSystem>) -> ref<GRSpawnTrafficCallback> {
        let self: ref<GRSpawnTrafficCallback> = new GRSpawnTrafficCallback();
        self.handler = handler;
        return self;
    }

    public func Call() -> Void {
        this.handler.SpawnTrafficVehiclesCallback();
    }
}
```

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

## Notes

- This mod modifies game behavior at runtime
- Be careful with game API calls to avoid crashes
- PERFORMANCE IS KING

## Deployment target

Z:\\GOG\\Cyberpunk 2077

- game root contains the r6 folder, where these files can be deposited without special steps.
