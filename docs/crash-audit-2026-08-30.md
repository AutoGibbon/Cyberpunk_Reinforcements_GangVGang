# Crash Audit — 2026-08-30 (batch: 7 player-submitted crashes + 2 later REDscope reports)

Cross-reference of a batch of crash reports against
[crash-audit-2026-08-29.md](crash-audit-2026-08-29.md)'s findings. Raw
per-crash evidence: [docs/crashes/](crashes/). Process/tooling notes
(WinDbg, REDscope, the engine's `attch/` breadcrumb file, the
stale-compile-cache trap): [../../_shared/diagnosing-crashes.md](../../_shared/diagnosing-crashes.md).

## Batch contents

| Time | Source | Bad address | Offset | Attribution |
|---|---|---|---|---|
| 09:25:57 | raw | `0x3258` | `+0x2f098b` | `DynamicSpawnSystem/Update` (engine breadcrumb) |
| 09:38:34 | raw | `0xFFFFFFFFFFFFFFFF` | `+0x53f9d4` | unattributed — load-time ("Spawning player") |
| 09:44:18 | raw | `0xFFFFFFFFFFFFFFFF` | `+0x1f571a` | unattributed — load-time; different offset from 09:38:34 despite the same address, treated as a separate fault |
| 10:01:10 | raw | `0x8` | `+0x1dab43` | `QuestsSystem/Tick` (engine breadcrumb) — **vanilla, not this mod** |
| 10:21:54 | raw | `0x3258` | `+0x2f098b` | `DynamicSpawnSystem/Update` (engine breadcrumb) |
| 12:45:38 | raw | `0x8` | `+0x149157` | unattributed; different offset from 10:01:10 despite the same address, treated as a separate fault |
| 14:52:15 | REDscope | `0x3258` | `+0x2f098b` | `DynamicSpawnSystem/Update` (engine breadcrumb — REDscope's own script stack was inconclusive this time) |
| 17:08:24 | REDscope | `0x3258` | `+0x2f098b` | direct: `SpawnRequestFinished;DSSSpawnRequestResult` |
| 17:41:33 | REDscope | `0x3258` | `+0x2f098b` | direct: `SpawnRequestFinished;DSSSpawnRequestResult` |

Per-crash write-ups with the raw register/evidence detail:
[2026-08-30-092557-raw.md](crashes/2026-08-30-092557-raw.md),
[093834](crashes/2026-08-30-093834-raw.md),
[094418](crashes/2026-08-30-094418-raw.md),
[100110](crashes/2026-08-30-100110-raw.md),
[102154](crashes/2026-08-30-102154-raw.md),
[124538](crashes/2026-08-30-124538-raw.md),
[145215](crashes/2026-08-30-145215-redscope.md),
[170824](crashes/2026-08-30-170824-redscope.md),
[174133](crashes/2026-08-30-174133-redscope.md).

## Conclusions

**09:25:57, 10:21:54, 14:52:15 are the same fault recurring** — identical
full register state and resolvable caller return address across all
three, plus the engine breadcrumb independently naming
`DynamicSpawnSystem/Update` (confirms it for the two pre-REDscope dumps,
and resolves 14:52:15's own inconclusive script-stack capture). This is
`crash-audit-2026-08-29.md` finding #2, on the pre-fix 3.1.0 build — fixed
in `d8ac682`.

**09:38:34 / 09:44:18** — both load-time, "Spawning player," reading a
garbage float-bit-pattern value (type confusion, not a clean null) through
the pointer. This mod has no code on the player-spawn path; unattributed
to any specific other mod.

**10:01:10** — confirmed vanilla (`QuestsSystem/Tick` breadcrumb hit),
unrelated to this mod.

**12:45:38** — shares only the bad address with 10:01:10 (different
offset, no breadcrumb); logged as its own unattributed single occurrence.

**17:08:24** ran on a build with finding #2 *and* finding #10 both already
in place (confirmed directly by the user), ruling both out. Found two more
gaps in the same function: unguarded `GetAIComponent()`/
`GetVehicleComponent()` chains in the vehicle-command loop, and an
unguarded `spawnedObject` before `.IsPuppet()`/`.IsVehicle()` in the first
loop (the sibling `SpawnCallback` method already guarded its own parameter
the same way). Both fixed.

**17:41:33** ran on a **stale pre-fix build** — a compile error at
17:32:22 (wrong return type on the 17:08:24 fix) meant RED4ext silently
fell back to the last successfully-compiled cache from before that
session's edits; see the compile-cache-trap note in
[diagnosing-crashes.md](../../_shared/diagnosing-crashes.md). Independent of
that mixup, a fresh read found the real bug: `ChangeHighLevelState` in the
first loop ran unconditionally on **every** spawned puppet from any
source, not just this mod's own `GRModPuppet`-tagged ones —
`DynamicSpawnSystem` is shared vanilla infrastructure, so this was forcing
arbitrary unrelated NPCs into `Combat` state game-wide. Three earlier
fixes on this call site (finding #2, finding #10, the component guards
above) had each narrowed the null-safety without ever questioning whether
the call belonged there at all — see the "Beyond null guards" section in
[diagnosing-crashes.md](../../_shared/diagnosing-crashes.md). **Fix:
removed the call from the unscoped branch entirely.**

**Status: CONFIRMED via reliable repro** (build `17:47:17+`): enter combat
somewhere reinforcements can't reach by line of sight → the upstream
`ReinforcementsSystem` mod (not this mod's own tagged spawns) calls its
own backup → player wins → that spawn funnels through this mod's
`SpawnRequestFinished` → player re-enters combat as new spawns arrive
(vanilla behavior) → crash, every time, with the call present; no crash,
same sequence, with it removed. This fingerprint (`0x3258` /
`+0x2F098B` via `SpawnRequestFinished`) is resolved; a future recurrence
on a build carrying this fix is a new bug, not a continuation of this
cluster.
