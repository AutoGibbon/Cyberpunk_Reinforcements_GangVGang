# Crash Audit — 2026-08-29

Null-deref / crash hole hunt across the RedScript sources. Tracked here while fixing one at a time, high to low severity.

Findings 1-5 came from a manual read of the hot paths. Findings 6-7 came from a second pass that checked this codebase against redscript's own documented pitfalls (see Research notes at the bottom) rather than guessing.

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

## 6. [HIGH] Every `DelayCallback.Call()` dereferences its `wref` handler with no `IsDefined()` check

- Applies to all 31 `Call()` implementations across the 15 gang handler files plus `r6/scripts/reinforcements_gangvgang/ReinforcementSystem.reds:449-451` (`GRAuthorityInterventionCooldownEndCallback`).
- Redscript's own documented "Generic callbacks" pattern (wiki.redmodding.org) stores the callback target as a `wref` specifically so it can be garbage collected independently, and explicitly guards every use with `if !IsDefined(this.m_target) { return null; }` before dereferencing — this codebase's callbacks skip that guard entirely.
- Every gang handler and grace/cooldown timer in the mod goes through this exact shape, so a callback firing after its target has been torn down (session end, save load, hot-reload while dev-testing) would null-deref on `this.handler.OnGraceEnd()` / `OnCallSuccessCooldownEnd()` / `OnAuthorityInterventionCooldownEnd()`.

Fix: added `if !IsDefined(this.handler) { return; }` to the top of every `Call()` implementation.

Note: the `DelayCallback` example in this repo's own `CLAUDE.md` (Delay system section) shows the pattern without the guard — worth updating that example too so future gang handlers don't reintroduce this. Not changed here since it's a docs file, not one of the audited crash sites; flagged for a follow-up.

Status: **fixed**

## 7. [MEDIUM] Unguarded `target as NPCPuppet` downcast in `ReinforcementsCalled`

- `r6/scripts/reinforcements_gangvgang/ReinforcementSystem.reds:156` (pre-fix) — `puppetHandler.HandleReinforcementCall(puppet as NPCPuppet, target as NPCPuppet)`. `target` is the raw stim-event source object (`wref<GameObject>`), never validated as an actual `NPCPuppet` anywhere upstream (`ReinforcementsChecksCall` only validates the caller puppet, not the target).
- Redscript's documented "Safe downcasting" pattern: `as` returns `null` on a failed cast, so an unguarded downcast is a documented null-deref trap.
- If `target` isn't an `NPCPuppet` (e.g. a vehicle or other non-puppet `GameObject` the caller is in registered combat with), the failed cast is passed straight into `GRGangHandler.HandleReinforcementCall`, which immediately does `target.GetAttitudeAgent()` inside a `GRLog(s"...")` interpolation at `r6/scripts/reinforcements_gangvgang/GangHandlers/GRGangHandler.reds:128` — the string still gets built (and the null deref still happens) even though `GRLog`'s own body is a no-op, since interpolation arguments are evaluated before the call.

Fix: `ReinforcementsCalled` now downcasts `target` once, checks `IsDefined()`, and bails out if the cast failed, before ever reaching `HandleReinforcementCall`.

Status: **fixed**

## 8. [HIGH] `ReinforcementsCall.reds`'s `HandleStimEvent` wrap dereferenced `stimData.cachedEvt` (and, separately, `GetOwnerPuppet()`/`GetInstance()`) with no null check

Came from reading the actual crash report (repeatable crash on killing an enemy during a gang fight) against this mod's own hot entry point, `@wrapMethod(ReactionManagerComponent) HandleStimEvent`, and cross-checking it line-for-line against the vanilla method it wraps (`reactionComponent.script:405-477`).

- `r6/scripts/reinforcements_gangvgang/ReinforcementsCall.reds:78-84` (pre-fix) — the mod's own logic ran after `wrappedMethod(stimData)` and immediately did `Equals(stimData.cachedEvt.stimType, ...)`. `wrappedMethod` returning early internally does **not** protect this line: control returns to the wrap regardless of what vanilla decided.
- Vanilla's own `HandleStimEvent` explicitly guards the identical field right at its own entry (`reactionComponent.script:412`): `if !IsDefined(stimData) || !IsDefined(stimData.cachedEvt) { return; }`. `cachedEvt` is declared `ref<StimuliEvent>` (`stimuliEvents.script:11`), a real nullable ref — CDPR guarding it there is direct proof it can be null in production, most likely because `HandleStimEvent` runs as a `PostPhysics`-delayed queued task (`reactionComponent.script:391-395`): the event is captured now, processed a moment later.
- Also present (unrelated field, same root cause — code written/edited between the two commits that produced this file's history): `ownerPuppet = this.GetOwnerPuppet();` and `let reinSystem = GRReinforcementSystem.GetInstance(...);` were both used without an `IsDefined()` check at various points during this fix's iteration. `GetOwnerPuppet()` is itself an unguarded downcast internally (`reactionComponent.script:3813-3815`, `return this.GetOwner() as ScriptedPuppet;`), and a sibling method in the same vanilla class (`HasCombatTarget`, `:3817-3821`) explicitly null-checks its result before use — further proof the cast can fail. `NPCPuppet.IsInCombat`/`IsInCombatWithTarget` (`NPCPuppet.script:4167-4183`) do not null-check their `npc` parameter at all, so a null `ownerPuppet` would crash on the very next line.

Fix: `HandleStimEvent` now checks `!IsDefined(stimData) || !IsDefined(stimData.cachedEvt) || !this.IsEnabled()` first (mirroring vanilla's own guard, plus the `IsEnabled()` check vanilla also does at `:419`), reads the stim type via `stimData.cachedEvt.GetStimType()` instead of touching the field directly, filters `Dying` and `StimFilters.IsForTheDead(...)` stims (see reachability note below), then checks `IsDefined(ownerPuppet)` and `IsDefined(reinSystem)` before either is used.

**Reachability note, not itself a null-deref bug:** `StimFilters.CanTriggerAllyHelp` (`reactionComponent.script:71`) lists `Dying` alongside `Gunshot`/`Explosion`/`MeleeHit`/`VehicleHit`/`Alarm`/`Call` as stim types that trigger nearby-ally reactions, confirming `Dying` is the right, primary type to filter (its `sourceObject` is the dying entity itself). But because of the capture/process delay noted above, a same-frame kill could in principle still deliver a `Gunshot`/`CombatHit`/etc. stim whose `sourceObject` died in the interim, past the type filter. This was traced all the way through the call chain (`ReinforcementsChecksCall` → `ReinforcementsCalled` → `GRGangHandler.HandleReinforcementCall` → `SpawnAttiutudeFixer`'s `GRAttitudeFix`/`GRSetHostileTowardsCombatant`) and confirmed safe regardless: every `GetAttitudeAgent()` call site left in the codebase (6 total, all in `SpawnAttiutudeFixer.reds`) already null-checks its result before use — the one that didn't (a `GRLog` interpolation in `GRGangHandler.reds` calling `target.GetAttitudeAgent().GetAttitudeGroup()` unguarded, the likely actual cause of the reported crash) was removed outright rather than guarded. Every other touch on a possibly-dying target (`GetWorldPosition()`, `GetRecordID()`) only reads basic entity-level properties that stay valid on a dying-but-not-yet-destroyed puppet, not components torn down early. `AISquadHelper.GetSquadmates`/`GetSquadMemberInterface` (`aiHelpers`-style script, not native as initially assumed) were read directly and confirmed to guard `IsDefined(obj)` before touching `GetSquadMemberComponent()`, degrading to an empty member list rather than crashing on a null/torn-down puppet. A fully-despawned (not just dying) target is covered separately: `GRGangHandler`'s `m_lastTarget`/`m_lastSecondaryTarget` are `wref<NPCPuppet>` specifically so `DynamicSpawnSystem.reds`'s `GetLastTarget()`/`GetLastSecondaryTarget()` promotion-to-`ref` naturally comes back null once the target is gone, and that call site already checks `IsDefined()` (see finding on the `usedSecondaryTarget` fallback, part of the same safety pass).

Status: **fixed**

---

## Research notes

Findings 6 and 7 came from checking this codebase against redscript's own documented patterns rather than more manual reading:
- [Generic callbacks](https://wiki.redmodding.org/redscript/references-and-examples/common-patterns/generic-callbacks) — documents the `wref` + `IsDefined()` guard pattern for delayed callbacks (→ finding 6).
- [Safe downcasting](https://wiki.redmodding.org/redscript/references-and-examples/common-patterns/safe-downcasting) — documents that `as` returns `null` on a failed cast and must be checked (→ finding 7, and retroactively explains why finding 2's fix was the right shape).
- [Intrinsics](https://wiki.redmodding.org/redscript/language/language-features/intrinsics) — confirms `IsDefined` is the standard null-check for both `ref<T>` and `wref<T>`.

Reviewed and judged safe, no change made: `SpawnAttiutudeFixer.reds`'s `combatant as ScriptedPuppet` / `squadmate as ScriptedPuppet` casts (`GRSetHostileTowardsCombatant`, `GRAttitudeFix`) are all downcasting an already-known `NPCPuppet` (a `ScriptedPuppet` subtype) to its own ancestor type, which cannot fail — different from finding 7, where `target`'s actual runtime type was never established.

General redscript troubleshooting resources (Nexus/Steam/redmodding wiki user docs) mostly cover compile-time and installation-level crashes (bad install path, stale cache, mod conflicts, missing RED4ext/Codeware) rather than runtime scripting pitfalls, and didn't turn up anything applicable beyond the two patterns above.

Finding 8 used a different, more direct technique worth reusing: for any `@wrapMethod`/`@addMethod`, read the actual vanilla implementation being wrapped in the decompiled source dump (`E:\Tools\mods\cp77\redscript\source`, per this repo's `CLAUDE.md`) rather than guessing at its contract. Two things fell out of that read that a docs/pattern search wouldn't have surfaced:
- Vanilla's own early-exit guards on the wrapped method are a checklist, not just prior art — a field vanilla explicitly null-checks (`stimData.cachedEvt` in `HandleStimEvent`) is CDPR telling you, from production experience, that it goes null. `wrappedMethod(...)` running those guards first does not protect code that runs *after* it in the same wrap.
- A helper the wrap calls into (`GetOwnerPuppet()`, `IsInCombatWithTarget()`, `GetSquadmates()`) is worth opening too, even when it looks like a stable engine API — its real implementation, and any guard a *sibling* method in the same class puts around it, tells you directly whether the call is safe rather than leaving it to inference from naming or "surely the engine handles this."
