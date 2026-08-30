# Crash Audit — 2026-08-30 (batch: 7 player-submitted crashes)

Cross-reference summary after handling each crash in isolation. Per-crash
write-ups: [docs/crashes/](crashes/). Process/tooling notes:
[diagnosing-crashes.md](diagnosing-crashes.md). Prior source-level findings
this batch is checked against: [crash-audit-2026-08-29.md](crash-audit-2026-08-29.md).

## Batch contents

| Time (2026-08-30) | Source | Bad address | Offset | Attribution |
|---|---|---|---|---|
| 09:25:57 | raw | `0x3258` | `+0x2f098b` | `DynamicSpawnSystem/Update` (engine breadcrumb) |
| 09:38:34 | raw | `0xFFFFFFFFFFFFFFFF` | `+0x53f9d4` | unattributed — load-time, "Spawning player" |
| 09:44:18 | raw | `0xFFFFFFFFFFFFFFFF` | `+0x1f571a` | unattributed — load-time, "Spawning player" |
| 10:01:10 | raw | `0x8` | `+0x1dab43` | `QuestsSystem/Tick` (engine breadcrumb) — **vanilla, not this mod** |
| 10:21:54 | raw | `0x3258` | `+0x2f098b` | `DynamicSpawnSystem/Update` (engine breadcrumb) |
| 12:45:38 | raw | `0x8` | `+0x149157` | unattributed — mid-gameplay, no breadcrumb hit |
| 14:52:15 | REDscope | `0x3258` | `+0x2f098b` | `DynamicSpawnSystem/Update` (engine breadcrumb; REDscope's own script stack was inconclusive) |

## Finding: three (likely four) recurrences of `crash-audit-2026-08-29.md` finding #2

The 09:25:57, 10:21:54, and 14:52:15 (REDscope) crashes are the same fault
recurring, not three similar-looking ones. Evidence, strongest first:

1. **Identical full register state** at the fault instruction across all
   three — not just the bad address, but `rdi=0`, `rbp=0`, `r12=0`,
   `r13=0`, `r14=0xFFFFFFFF`, and `rsi` holding the *same* captured-module
   pointer (`0x00007ff719e2b200` / `0x00007FF719E2B200`) in every one.
2. **Identical resolvable native caller** — the one frame WinDbg/REDscope
   could unwind to (`Cyberpunk2077+0x12CB2FE`) matches byte-for-byte across
   all three.
3. **The game engine's own crash-info breadcrumb** (independent of both
   WinDbg and REDscope — a first-party CDPR telemetry file dropped
   alongside every crash, `attch/Cyberpunk2077.exe-*.txt`) names
   `DynamicSpawnSystem/Update` as the system ticking on the crashing thread
   for all three.
4. A fourth, separate REDscope-confirmed crash the same day (15:35:10,
   CRASH ID `HJBGKZX7`, not in either provided folder — already
   incorporated into `crash-audit-2026-08-29.md` finding #2) shares the
   identical `0x3258`/`+0x2f098b` fingerprint and got a direct RedScript
   attribution: `SpawnRequestFinished;DSSSpawnRequestResult`.

Point 3 is the important new piece this batch adds: it independently
confirms `DynamicSpawnSystem` for two crashes that predate REDscope's
install (09:25:57, 10:21:54) and resolves the one ambiguous case
(14:52:15, where REDscope's *own* script-stack capture was inconclusive —
see that crash's write-up for why). All four are the same bug: finding
#2's unguarded `ScriptedPuppet` cast in `SpawnRequestFinished`
(`DynamicSpawnSystem.reds:29-42`, pre-fix).

**This bug is already fixed** in the current codebase (commit `d8ac682`,
2026-08-29 20:26, shipped as part of the "3.1.1" changelog finalized
2026-08-30 03:20). No code change results from this batch.

## Open question: was the player actually on the fixed build yet?

All seven crashes in this batch (09:25 through 14:52) fall chronologically
**after** the fix was committed and the changelog finalized, yet three of
them reproduce the pre-fix bug identically. Two explanations, not mutually
exclusive:

- The player likely hadn't updated/redeployed to the build containing the
  fix yet during this play session — consistent with the previously-known
  15:35:10 confirmation explicitly being on the "pre-fix 3.1.0 build," and
  all seven of these crashes happening earlier in the same day.
- None of these crash reports carry a mod-version stamp we can check
  directly (raw dumps have no mod version info at all; the REDscope report
  lists RED4ext/Cyberpunk build versions but not this mod's own version).

**Recommend asking the user directly** which build (3.1.0 vs 3.1.1+) was
installed during this session, to confirm the fix is what resolved it
rather than assuming so. If a `0x3258`/`+0x2f098b` crash shows up again on
a confirmed-3.1.1-or-later build, treat it as a regression or a new bug
with the same symptom — not a repeat of this one (per the standing
guidance already in finding #2).

## The other four crashes: not this mod, on current evidence

- **10:01:10** is confirmed vanilla (`QuestsSystem/Tick`, direct engine
  breadcrumb hit) — unrelated to this mod with high confidence.
- **09:38:34** and **09:44:18** share a bad-address sentinel
  (`0xFFFFFFFFFFFFFFFF`) but land at two different code offsets and both
  occur during save-load / player-spawn (`"Game/LoadingStage":"Spawning
  player"`), a phase this mod has no code running in at all. Best read as
  two independent, unattributed faults elsewhere in the load pipeline
  (candidates among the other ~37 installed mods: anything resolving
  player appearance/inventory/stats at spawn — ArchiveXL, TweakXL,
  Codeware are the ones in the loaded-module list most plausibly on that
  path, but this is speculation, not a finding).
- **12:45:38** shares a bad address (`0x8`) with 10:01:10 but at a
  different offset and with no breadcrumb hit — no basis to link it to
  that crash or to this mod.

None of these four have REDscope data — all four predate its install. If
any recur now that REDscope is installed, the next report should carry a
proper RedScript attribution instead of requiring this manual process.

## Process notes worth keeping

Two techniques used in this batch aren't yet written up in
`diagnosing-crashes.md` and are worth folding in:

1. `cdb -z <dump> -c "r; ...; q"` shows the *debugger's own attach
   context* (some ntdll wait function), not the crash's registers — you
   must run `.ecxr` first to load the actual exception context before `r`
   means anything. Cost an extra round-trip this session.
2. The `attch/Cyberpunk2077.exe-<timestamp>-<pid>-<tid>.txt` file bundled
   with every crash report (raw *and* REDscope alike) is CDPR's own
   internal engine telemetry snapshot, keyed by `TID=<n>` per stat. Its
   `SystemUpdate/DebugName@...#TID=<crashing tid>` entry, when present,
   names the exact native system ticking on the crashing thread — a
   completely free, first-party source of attribution that doesn't depend
   on REDscope being installed. Worth grep'ing for on every future crash
   report before reaching for WinDbg at all; it directly resolved
   attribution for 3 of these 7 crashes (and would have covered a 4th,
   10:01:10, even if REDscope-quality RedScript stacks never existed).
   `Game/LoadingStage` in the same file is also a fast, free way to tell a
   load-time crash from a live-gameplay one.

## Addendum: an 8th report, same fingerprint, on 3.1.1

A separate player report came in (secondhand — a third-party "analysed by
AI" summary, no crash folder provided) citing the same fault: read of
`0x3258`, `mov al, byte ptr [rbx]` at `Cyberpunk2077+0x2f098b`. The
reporter said this was on **3.1.1** — i.e. after finding #2's fix (the
`ScriptedPuppet` cast guard) was already live, which the "was it actually
deployed yet" open question above couldn't have been asking about for
*this* report.

Since finding #2's own guard can't be the cause here, this ruled out a
simple repeat and prompted a fresh look at the same function. Two more
gaps were found and fixed the same session (before this report surfaced):
an unguarded `WheeledObject` cast on the vehicle side of the same loop,
and an unguarded `reinSystem` (`GRReinforcementSystem.GetInstance(...)`
result) — see `DynamicSpawnSystem.reds`. Neither fits this fingerprint:
both are RedScript-side failures (this mod's own compiled functions, or a
null-receiver RTTI dispatch), which don't resolve to a stable
`Cyberpunk2077.exe+0xNNNNNNN` static-image offset the way a fault inside
the shipped .exe's own native code does — see finding #10's full reasoning
in [crash-audit-2026-08-29.md](crash-audit-2026-08-29.md).

The call site that does fit: `NPCPuppet.ChangeHighLevelState(...)`,
called unconditionally on every freshly-spawned puppet in the same loop,
internally reads `this.m_puppetStateBlackboard.GetInt(...)` with no null
check on the blackboard — the same root cause finding #9 speculated about
for a different call site, now landing on one finding #9's guard never
covered. Fixed by skipping the call when
`candidatePuppet.GetPuppetStateBlackboard()` isn't defined yet. Recorded
as finding #10 in the 2026-08-29 doc rather than here, since it's a
source-level finding like the others in that doc — this addendum just
tracks how the new report led to it.

**Not proven** to the same standard as finding #2 (no REDscope/breadcrumb
data existed for this report) — it's the best fit given the native
fingerprint, the timing, and process of elimination against the two other
gaps fixed the same day. If this exact fingerprint shows up a fifth time
on a build with finding #10's guard in place, that would rule this out too
and point at something else again.

## Addendum 2: a REDscope-confirmed ninth report, 17:08:24, same day

A REDscope crash landed at 17:08:24 (CRASH ID `HJBGKZX7` — REDscope reuses
this ID per fingerprint, not per instance) with a **clean, direct**
RedScript attribution to `SpawnRequestFinished;DSSSpawnRequestResult`, no
ambiguity this time. Full write-up:
[2026-08-30-170824-redscope.md](crashes/2026-08-30-170824-redscope.md).

Game launch time for this session (15:28:16) was many hours after
`d8ac682` and the 3.1.1 changelog finalization, so — unlike the original
"was it actually deployed yet" open question above — a stale build is not
a live explanation here. The user confirmed this crash was produced by the
project in the exact working-tree state investigation began from, which
already included finding #10's blackboard guard (previous addendum) —
**ruling finding #10 out** as this crash's cause, since it was already in
place and the crash happened anyway.

Investigation found and fixed two remaining gaps still present in that
build: a second, previously-missed unguarded chain in the same function's
vehicle-command loop (`GetAIComponent()`/`GetVehicleComponent()` results
used without an `IsDefined()` check), and an unguarded `spawnedObject` in
the first loop (no `IsDefined()` check before `.IsPuppet()`/`.IsVehicle()`,
unlike the sibling `SpawnCallback` method). See the write-up for detail.
Both are now fixed; a future recurrence on a build carrying these fixes
plus finding #10's would need a new explanation.
