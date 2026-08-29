# Crash Audit — 2026-08-29

Null-deref / crash hole hunt across the RedScript sources. Tracked here while fixing one at a time, high to low severity.

## 1. [HIGH] `GetFactionHandler` returns null for unhandled affiliations, callers don't check

- `r6/scripts/reinforcements_gangvgang/ReinforcementSystem.reds:282-321` — switch covers 15 of 41 `gamedataAffiliation` values; `default` falls off the end with no return.
- `r6/scripts/reinforcements_gangvgang/ReinforcementSystem.reds:333,340` — `puppetHandler.TryCallingReinforcements(puppet)` called with no `IsDefined` check.
- `r6/scripts/reinforcements_gangvgang/ReinforcementSystem.reds:152` — `ReinforcementsCalled` recomputes the handler and chains a call with no check.
- `r6/scripts/reinforcements_gangvgang/SpawnAttiutudeFixer.reds:11-13` — same unguarded pattern (lower risk, gated on mod's own tag).

Fix: `default` now returns `null` explicitly; added `IsDefined()` guards before every chained call on a resolved handler (`ReinforcementsCalled`, `TryCallingReinforcements`, `SpawnAttiutudeFixer`'s `OnGameAttached` wrap).

Status: **fixed**

## 2. [HIGH] `SpawnRequestFinished` casts to `ScriptedPuppet` without checking the cast

- `r6/scripts/reinforcements_gangvgang/DynamicSpawnSystem.reds:29-42` — vanilla method proves non-puppet/non-vehicle objects can appear in a spawn batch; this wrap treats everything not `(!IsPuppet() && IsVehicle())` as a puppet and dereferences the cast result immediately.
- Hooks the global `DynamicSpawnSystem`, so any quest/system spawn through it can trigger this, not just this mod's own spawns.

Fix: cast into a per-iteration `candidatePuppet` local, guarded by `IsDefined()` before any use; `ChangeHighLevelState` now applies to each spawned puppet in the batch instead of a stale reference from the first mod-tagged one found.

Status: **fixed**

## 3. [MEDIUM] Unchecked null `District` from `PreventionSystem.GetCurrentDistrict()`

- Engine's `DistrictManager.GetCurrentDistrict()` explicitly returns null when its stack is empty; vanilla callers guard with `IsDefined()`.
- `r6/scripts/reinforcements_gangvgang/ReinforcementSystem.reds:210` — unguarded, in the hot per-stim-event check.
- `r6/scripts/reinforcements_gangvgang/GangData/Common.reds:17-28` (`IsDistrictWithinZones`) — unguarded, reached from `IsConsideredTurf` and `TryDispatchAuthority`.

Fix: `IsDistrictWithinZones` now returns `false` for a null district (single fix point covers `IsConsideredTurf` and `TryDispatchAuthority` too); `ReinforcementsChecksCall` bails out early if `GetCurrentDistrict()` comes back null.

Status: **fixed**

## 4. [LOW] Stale `puppet` reference reused across spawn-batch loop iterations

- `r6/scripts/reinforcements_gangvgang/DynamicSpawnSystem.reds:29-42` — `puppet` only reassigned while `!gotModTag`; later puppets in the same batch get `ChangeHighLevelState` applied to the wrong (first) puppet instead of themselves.
- Same code block as #2 — fixed together.

Status: **fixed** (fixed alongside #2, see above)

## 5. [LOW] Vehicle-mount race

- `r6/scripts/reinforcements_gangvgang/ReinforcementSystem.reds:268-272` — `player.GetMountedVehicle()` used right after `IsMountedToVehicle` without an `IsDefined()` check before calling `.IsPlayerMounted()`.

Fix: added `IsDefined(vehicle) &&` guard before the method chain.

Status: **fixed**
