# Diagnosing Crashes

Process notes from the 2026-08-30 crash investigation (see
[crash-audit-2026-08-29.md](crash-audit-2026-08-29.md) for the null-deref
findings that came out of it). Written so the next crash investigation
doesn't have to rediscover this from scratch.

## Where crash reports live

`C:\Users\<user>\AppData\Local\REDEngine\ReportQueue\` — one folder per crash,
named `Cyberpunk2077-<date>-<time>-<pid>-<tid>`. Each folder has:

- `Cyberpunk2077.dmp` — the minidump. Usually a **mini** dump (registers,
  stack, partial memory only) not a full dump, which limits how far a
  debugger can unwind (see below).
- `stacktrace.txt` — one-paragraph summary: exception type
  (`EXCEPTION_ACCESS_VIOLATION`), and the message (e.g. "attempted to read
  inaccessible data at 0x...").
- `report.txt` — `LoadedModule[N]=...` list (every DLL/ASI loaded, i.e. every
  mod running that session) plus a `StackHash`/build version block. **Read
  this first** — the loaded-module list alone tells you what else was in
  play that session, useful for ruling mods in or out even before opening
  the dump.
- `sysinfo.json`, `integrity.json`, `attch/` — hardware/OS info and misc
  attachments; rarely needed for a scripting-level bug.

Cross-reference crash folder timestamps against
`Z:\GOG\Cyberpunk 2077\red4ext\logs\` and
`Z:\GOG\Cyberpunk 2077\red4ext\plugins\<Plugin>\<Plugin>-<timestamp>.log` —
per-plugin logs are named with the session start time, so you can tell which
session (and which set of just-loaded mods) a given crash belongs to.

## Quick triage with WinDbg (`cdb`)

WinDbg (Store version) ships a command-line front end at:

```
C:\Program Files\WindowsApps\Microsoft.WinDbg_<version>_x64__8wekyb3d8bbwe\amd64\cdb.exe
```

Run it non-interactively against a dump:

```
cdb.exe -z "<path>\Cyberpunk2077.dmp" -c "!analyze -v; q" > analysis.txt
```

`!analyze -v` gives the important bits without needing to drive WinDbg
interactively:

- `Failure.Bucket` / `FAILURE_BUCKET_ID` — e.g.
  `INVALID_POINTER_READ_c0000005_Cyberpunk2077.exe!Unknown`. The module name
  in this string is the single most useful fact: it tells you whether the
  fault happened in the base game (`Cyberpunk2077.exe`), in `RED4ext.dll`,
  or in a specific mod's own native DLL (e.g. `ArchiveXL.dll`). That alone
  can rule this codebase in or out.
- `EXCEPTION_PARAMETER2` / `Attempt to read from address ...` — the bad
  address. A small value (e.g. `0x3258`) is the classic null-pointer +
  small-member-offset signature — a native field/vtable read through a null
  or garbage object handle.
- `Failure.Exception.IP.Offset` — the offset within the faulting module.
  **This is the key correlation field across multiple dumps**: if two
  crashes show the same module + same offset + same bad-read address, it's
  the same bug hit twice, not two unrelated instabilities. That's strong
  evidence worth chasing; a one-off address+offset combination is weaker
  signal and could easily be a different mod or a one-time race.

### What this can't tell you (retail build limits)

- No public PDB for `Cyberpunk2077.exe` — WinDbg's symbol server lookup
  comes back empty, so the fault resolves to `Cyberpunk2077+0x<offset>`,
  never a function name.
- A mini dump frequently can't unwind past the faulting frame
  (`FRAME_ONE_INVALID: 1` in the `!analyze -v` output) — no call stack above
  frame 0, so you can't see what called into the crashing code.
- Net effect: WinDbg alone can confirm *that* it's a null/invalid-pointer
  read and roughly *where* (which module), and — critically — whether the
  same fault recurred across multiple crashes. It generally cannot tell you
  *which RedScript call site* caused it. For that, treat the address/offset
  as a fingerprint to test a fix against (did it stop recurring?), not as a
  pointer straight to a line of `.reds`.

## Correlating with source once you have a lead

Once WinDbg confirms "null/invalid read, inside the base engine, in a shape
that looks like a native call through a bad handle," the rest is manual:
cross-check whatever RedScript API calls run on the hot path in question
against the decompiled source dump at `E:\Tools\mods\cp77\redscript\source`
(per this repo's root `CLAUDE.md`). Technique that worked well in the
2026-08-29 audit (see finding 8 there):

- Read the **actual vanilla implementation** being wrapped/called, not just
  its name — a field vanilla explicitly null-checks is CDPR telling you,
  from production experience, that it goes null.
- Check whether a **sibling method** in the same vanilla class guards a call
  the one you're using doesn't (e.g. `HasCombatTarget` guarding
  `GetOwnerPuppet()` while `HandleStimEvent` doesn't) — that asymmetry is a
  strong signal the unguarded one is the trap.
- Check where the field/component is actually **populated** (grep for the
  assignment, not just the accessor) to know which part of an entity's
  lifecycle (spawn/attach, vehicle mount/dismount, despawn) it's unsafe
  during.
- `wrapMethod` runs the full vanilla body via `wrappedMethod(...)` before
  your own code continues — vanilla's own early-exit guards do **not**
  protect code that runs after that call returns.

## The `attch/` breadcrumb file — check this before reaching for WinDbg

Every crash report — raw minidump *and* REDscope alike — bundles
`attch/Cyberpunk2077.exe-<timestamp>-<pid>-<tid>.txt`. This is CDPR's own
internal engine telemetry snapshot, not a REDscope or WinDbg artifact, so
it needs neither installed. It's a flat list of `"Key@id#TID=<n>":"value"`
lines, most tagged `TID=0` (global counters) but some tagged with a real
thread ID.

The single most useful line, when present: grep the file for
`TID=<crashing tid>` (the crashing TID is `stopThreadID` a few lines up,
and also the trailing number in the crash folder's own name) and look for
`SystemUpdate/DebugName@...#TID=<n>`. When it hits, it names the exact
native system that was ticking on the crashing thread — e.g.
`DynamicSpawnSystem/Update`, `QuestsSystem/Tick` — with zero inference
required. It doesn't always fire (some crashing threads aren't the
per-frame system-update thread, e.g. a load-time or job-worker thread), but
when it does, it's a free, first-party confirmation that beats guessing
from a raw offset. `Game/LoadingStage` in the same file (`"Finished"` vs
e.g. `"Spawning player"`) is also a fast way to separate a load-time crash
from a live-gameplay one before spending time on anything else.

## Quirk: `cdb -z` needs `.ecxr` before `r` means anything

Opening a dump with `cdb -z <dump>.dmp` and immediately running `r` (or `~`
for the thread list) shows the *debugger's own attach context* — some
arbitrary thread doing an `ntdll` wait, not the crash. Registers will look
identical across unrelated dumps and won't match `!analyze -v`'s
`EXCEPTION_PARAMETER2`. Run `.ecxr` first to load the actual stored
exception context, *then* `r`/`kb` — only then do the registers and any
manually-walked stack frames reflect the real fault. `!analyze -v` does
this internally already; it's only an issue when driving `cdb` by hand for
extra detail (e.g. comparing full register sets across dumps to confirm
two crashes are the literal same occurrence, not just the same offset).

## REDscope (added 2026-08-30, confirmed working same day)

[REDscope](https://github.com/qcargile/REDscope) is a third-party crash
logger plugin (RED4ext/CET/redscript, MIT-licensed) layered on top of CDPR's
built-in minidump reporter. Where the base reporter gives just the `.dmp`,
REDscope writes a **plain-text, human-readable** report next to it —
intended to close exactly the gap this session ran into (no symbols, no
RedScript-level attribution).

**Case study, same day it was installed:** a crash on 2026-08-30 15:35
(`REDscope-2026-08-30_15-35-10.crash`) shared the identical fault
fingerprint (read of `0x3258` at `Cyberpunk2077.exe+0x2F098B`) as two
earlier crashes from the previous night that had been diagnosed blind with
raw WinDbg on the `.dmp` alone — that process (below) could confirm *that*
it was a null/invalid-pointer read and *that* the same one recurred, but
never *which function* caused it. REDscope's report named it directly:
`SpawnRequestFinished;DSSSpawnRequestResult on gameDynamicSpawnSystem` was
the RedScript frame actually in flight — turning three sessions of "read
the source and guess" into a two-minute read of one report. See finding 2's
confirmation note in
[crash-audit-2026-08-29.md](crash-audit-2026-08-29.md) for the full
resolution. This is the reason to prefer REDscope's output over the raw
WinDbg process below whenever a `.crash` file exists for the crash in
question.

**Output location:** `red4ext/plugins/REDscope/crashes/` under the game
install (Overwrite folder if running under MO2) — `<name>.crash` (plain
text) plus a `<name>.crash.json` sidecar. Its own internal log
(`REDscope-*.log`, same directory) records what each analysis step
attempted, useful if the report itself looks incomplete.

**What it adds over a raw `.dmp` + WinDbg:**

- A `LIKELY CULPRIT` line with a confidence rating — names a specific mod
  DLL, the game's own code, a driver, or flags an out-of-memory condition.
- A `CRASH ID` fingerprint — lets you confirm whether a fix actually stopped
  the recurrence (the same manual check this doc does by comparing
  module+offset+address across dumps, but automated). The in-game panel
  flags when the same ID recurs.
- **Both** the native call stack (module-attributed per frame) **and** the
  in-flight RedScript call stack on the crashing thread — this is the part
  that directly addresses this session's biggest limitation (no frames
  beyond the fault point, no script-level attribution).
- A `@wrapMethod` wrap-chain scan — directly relevant to this codebase,
  since nearly every hook here is a `@wrapMethod`; it should show which
  wrap chain was executing at crash time.
- Engine state at crash (lifecycle stage, GPU/VRAM, OOM heuristic), what was
  streaming in, and a diff of mods added/removed/updated since the last
  working launch.
- A CET in-game panel to read the latest crash, module list, and crash
  history without alt-tabbing.

**Known limitations (from its own docs, still applicable):**

- Not a symbol server — third-party DLLs without shipped PDBs still resolve
  by name+offset only, and most `Cyberpunk2077.exe` frames still show as raw
  offsets (only ~84 engine functions are named in its public address
  database). The RedScript-level stack is the real upgrade, not native
  symbol resolution.
- Detects an attached debugger and defers to it (`respect_debugger=true` by
  default) — don't expect REDscope output if WinDbg/cdb is attached live.

**For next time:** attach both `.crash` and `.crash.json` when filing/
investigating a report — the sidecar carries the full per-mod modlist the
main report doesn't repeat. If a `.reds`-level call stack shows up in a
future `.crash` file, prefer it over the WinDbg-from-raw-dump process above;
fall back to the manual WinDbg process only for crashes predating REDscope's
install, or if its output looks incomplete (check `REDscope-*.log` first).

### The breadcrumb/state API (`REDscope.SetState`)

Confirmed by reading the actual source
(`src/breadcrumbs/BreadcrumbApi.cpp`), not just the docs page — the "ring of
breadcrumbs" language in the README oversells it slightly. What it actually
is: a **key → value map that replaces on write**, not an append-only log.
Calling it twice with the same key overwrites; it doesn't accumulate
history. Think "last known state per named thing," not a trace.

It's registered as a real native global function via RED4ext's RTTI, so it's
callable directly from RedScript — no CET/Lua indirection needed:

```
REDscope.SetState(key: String, value: String) -> Void
```

(Sibling natives exist too — `GetLatestCrashReport`, `GetLatestCrashJson`,
`GetDiagnosticJson`, `DownloadSymbolsNow`, `SetAutoDownload` — for reading
crash/diagnostic data back from script. Not relevant to breadcrumbing, but
useful to know they exist if we ever want to surface crash info in-game
ourselves.)

**Why it beats `GRLog` for this specific problem:** a value published via
`SetState` feeds REDscope's background snapshot worker, which runs
independently of whatever thread crashes. A `GRLog` write can be lost if the
process dies before its buffer flushes — exactly the failure mode we're
fighting (`EXCEPTION_ACCESS_VIOLATION` gives no graceful unwind to flush
anything). `SetState` is built to survive that: whatever was last published
is what shows up in the next `.crash` report's live-state section, even if
the crash happens on the very next line.

**Where to put calls, if this keeps recurring:** right before the specific
native call sites already under suspicion — not blanket-instrumented across
every stim event. Concretely, in priority order (highest-confidence lead
first, per crash-audit-2026-08-29.md):

- In `DynamicSpawnSystem.reds`'s `SpawnRequestFinished` wrap, around the
  spawn-batch loop — this is the **confirmed** crash site (finding 2), not
  a theory. If the same fault fingerprint (`0x3258` / `+0x2F098B`) ever
  recurs despite the fix, this is the first place to add a breadcrumb —
  publish which object in the batch failed the `ScriptedPuppet` cast (its
  record name, or "vehicle"/"other") to catch a related-but-distinct edge
  case the current guard doesn't cover.
- In `HandleStimEvent`, right before the `NPCPuppet.IsInCombatWithTarget(...)`
  calls ([ReinforcementsCall.reds:104-105](../r6/scripts/reinforcements_gangvgang/ReinforcementsCall.reds#L104-L105))
  — publish the stim type and the puppet's record name/entity ID. This is
  the site of finding 9's blackboard-null guard, added 2026-08-30 on
  circumstantial reasoning — **not yet confirmed as an actual crash
  cause** (see finding 9's status note). A breadcrumb here would settle
  that either way if a crash ever lands on this exact call.
- In `ReinforcementsChecksCall`, right before the `GetFactionHandler`'s
  `TweakDBInterface.GetCharacterRecord(...)` call and the
  `GetCurrentDistrict()` call — same idea, tag which check was about to
  execute.

If a crash lands after that's in place, the live-state section of the next
`.crash` report should show directly which puppet/stim/phase was in
flight — turning "read the source and guess" into "read it off the crash
report."

**The catch — don't blanket-instrument.** `HandleStimEvent` fires for every
stim event on every human NPC in earshot — the same volume problem
underlying this whole investigation. Calling `SetState` unconditionally on
every invocation adds a native call + string build to an already-hot path,
which cuts directly against "PERFORMANCE IS KING." Keep it narrow — only at
the handful of call sites actually under suspicion — and consider gating it
behind a diagnostic-mode setting that defaults off, so normal play pays
nothing once we're done chasing a given lead.

Not yet implemented — flagged for a follow-up if crashes recur after the
blackboard guard, or if a future lead needs this level of correlation.
