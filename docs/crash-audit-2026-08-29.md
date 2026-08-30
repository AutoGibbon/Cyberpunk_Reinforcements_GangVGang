# Crash Audit — 2026-08-29

Null-deref hunt across the RedScript sources, run in passes: 1-5 from
reading the hot paths manually, 6-7 from checking this codebase against
redscript's own documented pitfalls, 8 from reading the actual vanilla
implementation being wrapped rather than guessing at its contract. Finding
9 and the confirmation note on finding 2 were added 2026-08-30, once real
crash reports (see [crash-audit-2026-08-30.md](crash-audit-2026-08-30.md))
gave something to check the earlier findings against.

**All findings below are fixed.** The generic techniques and rules this
audit produced now live in
[../../_shared/redscript-practices.md](../../_shared/redscript-practices.md)
(null-safety requirements, the callback/downcast patterns) and
[../../_shared/diagnosing-crashes.md](../../_shared/diagnosing-crashes.md)
(crash-report triage) — this doc keeps only what's specific to this
codebase's history.

## Findings

1. **[HIGH]** `GetFactionHandler` (`ReinforcementSystem.reds:282-321`) fell
   off its switch with no explicit `null` for most unhandled
   `gamedataAffiliation` values; three call sites (`:333`, `:340`, `:152`)
   and `SpawnAttiutudeFixer.reds:11-13` chained off the result unguarded.
   Fixed: explicit `null` default, `IsDefined()` guard at every call site.

2. **[HIGH, REDscope-confirmed]** `SpawnRequestFinished`
   (`DynamicSpawnSystem.reds`, originally ~29-42) cast every non-vehicle
   spawned object straight to `ScriptedPuppet` with no cast-check, on the
   **shared vanilla** `DynamicSpawnSystem` — any mod's or vanilla's own
   spawn completion runs through it, not just this mod's. Fixed:
   per-iteration `candidatePuppet` local, guarded by `IsDefined()`.
   **Confirmed by a real crash** on the pre-fix 3.1.0 build (REDscope crash
   ID `HJBGKZX7`, fingerprint `0x3258` / `Cyberpunk2077.exe+0x2F098B`).
   Two further related bugs surfaced in the same function later — see
   findings 9-10 below and [crash-audit-2026-08-30.md](crash-audit-2026-08-30.md)
   for the full timeline.

3. **[MEDIUM]** `PreventionSystem.GetCurrentDistrict()` returns null on an
   empty district stack; unguarded at `ReinforcementSystem.reds:210` and in
   `GangData/Common.reds:17-28` (`IsDistrictWithinZones`). Fixed:
   `IsDistrictWithinZones` treats null as `false`; `ReinforcementsChecksCall`
   bails early on a null district.

4. **[LOW]** Stale `puppet` reference reused across `SpawnRequestFinished`'s
   batch loop (same code as #2) — later puppets in a batch got
   `ChangeHighLevelState` applied to the first-found puppet instead of
   themselves. Fixed alongside #2.

5. **[LOW]** `ReinforcementSystem.reds:268-272` chained
   `player.GetMountedVehicle()` into `.IsPlayerMounted()` with no
   `IsDefined()` check. Fixed.

6. **[HIGH]** All 31 `DelayCallback.Call()` implementations (15 gang
   handler files + `ReinforcementSystem.reds:449-451`) skipped the
   `IsDefined(this.handler)` guard the documented redscript callback
   pattern requires. Fixed everywhere; the guarded pattern is now the
   canonical example in
   [../../_shared/redscript-practices.md](../../_shared/redscript-practices.md).

7. **[MEDIUM]** `ReinforcementSystem.reds:156` (pre-fix) downcast the raw
   stim-event target `GameObject` to `NPCPuppet` with no cast-check before
   chaining into `GRGangHandler.HandleReinforcementCall`, which read
   `target.GetAttitudeAgent()` inside an (always-evaluated) `GRLog`
   interpolation. Fixed: cast once, check `IsDefined()`, bail before
   calling in.

8. **[HIGH]** `ReinforcementsCall.reds`'s `HandleStimEvent` wrap
   dereferenced `stimData.cachedEvt`, `GetOwnerPuppet()`, and
   `GetInstance()` results unguarded — found by reading the actual vanilla
   `reactionComponent.script:405-477` it wraps, which null-checks
   `cachedEvt` at its own entry (proof it goes null in production, since
   the event is captured then processed on a delayed queue). Fixed:
   mirrored vanilla's guard, added `IsDefined()` on `ownerPuppet`/
   `reinSystem`. Traced the full downstream call chain to confirm a
   same-frame kill delivering a stale stim can't reach an unguarded
   `GetAttitudeAgent()` elsewhere — the one call site that was unguarded
   (a `GRLog` interpolation in `GRGangHandler.reds`) was removed outright.

9. **[SPECULATIVE, superseded]** Added 2026-08-30 defensively: guarded
   `ownerPuppet.GetPuppetStateBlackboard()` before `IsInCombatWithTarget()`
   in `ReinforcementsCall.reds:100`, reasoning from CDPR's own inconsistent
   guarding of the same accessor elsewhere. Never confirmed as an actual
   crash cause — the REDscope report that landed the same day attributed
   the crash to finding #2 instead. Kept as harmless hardening.
   **Superseded by finding 10**, which found the same root cause (an
   unguarded blackboard read) at a different call site a real crash did
   land on.

10. **[HIGH, confirmed via repro]** Same function as #2, different call
    site: `NPCPuppet.ChangeHighLevelState(candidatePuppet, ...)` ran
    unconditionally on every spawned puppet in the batch, internally
    reading `m_puppetStateBlackboard.GetInt(...)` with no null check —
    unsafe on a puppet mid-spawn. Null-guarding this call was the first fix
    attempt, but a later crash proved the guard, while correct, wasn't the
    real fix: the call was **unscoped** (it ran on any spawn from any
    source, not just this mod's tagged puppets) and was ultimately removed
    outright rather than further guarded. Full timeline, including the
    confirmed repro:
    [crash-audit-2026-08-30.md](crash-audit-2026-08-30.md).

## Research notes

- [Generic callbacks](https://wiki.redmodding.org/redscript/references-and-examples/common-patterns/generic-callbacks)
  and
  [Safe downcasting](https://wiki.redmodding.org/redscript/references-and-examples/common-patterns/safe-downcasting)
  on the redmodding wiki are what findings 6-7 came from checking against;
  both patterns are now generalized in
  [../../_shared/redscript-practices.md](../../_shared/redscript-practices.md).
- Reviewed and judged safe, no change: `SpawnAttiutudeFixer.reds`'s
  `combatant as ScriptedPuppet` / `squadmate as ScriptedPuppet` casts are
  upcasts of an already-known `NPCPuppet` to its own ancestor type, which
  cannot fail — unlike finding 7, where the runtime type was never
  established.
- General redscript troubleshooting resources (Nexus/Steam/redmodding
  wiki) mostly cover compile-time/install issues, not runtime scripting
  pitfalls — didn't turn up anything beyond the two patterns above.
