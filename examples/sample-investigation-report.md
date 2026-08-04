# Sample Investigation Report (Desensitized)

> Synthetic example demonstrating the staged AI investigation output format.  
> Based on a real regression workflow; all identifiers, vendor names, and code paths are fictional.

## 1. Problem Confirmation

- **Present** — FDD cells CELL-111/112 show `COUNTER_AVAIL_CH` (channel availability) down ~6% after Release R3 upgrade; related KPI `KPI_5115a` increased accordingly.
- **Scope:** CELL-111 (id 111), CELL-112 (id 112).
- **Logs:** OK build `R3.2.1_BLD_000006`; NOK build `R3.2.1_BLD_000004`.

## 2. PM Window and Quantities

**comparisonContext (Stage B):**

- **windowDuration:** OK 09:15–10:45; NOK 11:30–13:00 (7×15min intervals each)
- **steadyState:** Exclude first 2 intervals after capture start
- **loadComparable:** Same test line, simulated traffic stability run
- **normalization:** invocation-skip candidate — `COUNTER_AVAIL_CH` −5.9% vs `COUNTER_SLOT_CH` −0.05%

| Counter | OK | NOK | Δ | Writer function |
|---------|---:|---:|---:|-----------------|
| COUNTER_AVAIL_CH | 568,425,464 | 534,669,170 | −5.94% | `ChannelAvailUpdater::updateBothCounters` |
| COUNTER_USED_CH | 254,691,046 | 259,215,824 | +1.78% | `ChannelUsedUpdater::updateUsed` |
| COUNTER_SLOT_CH | 8,614,918 | 8,610,688 | −0.05% | `SlotCounterUpdater::updateDataSlot` |

## 3. Working Set (Stage A)

- `COUNTER_AVAIL_CH` → ws-avail
- `COUNTER_USED_CH` → ws-used
- `COUNTER_SLOT_CH` → ws-slot
- `KPI_5115a` → ws-kpi

## 4. Call-Site Handoff (Stage C)

**primarySuspectCounter:** `COUNTER_AVAIL_CH`

| entryPath | callSite |
|-----------|----------|
| fd-ul-path | `UlCounterUpdater.cpp:77` |
| scheduler-wrapper | `scheduler/Counters.cpp:58` |
| regular-sched | `scheduler/selection/Counters.cpp:58` |
| initial-access | `scheduler/Msg3Handler.cpp:222` |

All `pm-only`; `invocationCount: open`.

## 5. Mechanism (Stage D)

| Field | Value |
|-------|-------|
| subtype | `invocation gap` |
| focus | `behavior-control` |
| disposition | `open` |
| Type-1 | `bodyIdentical: true` on `ChannelAvailUpdater::updateBothCounters` |

**Type-2 (blanked):** `Msg3Armer::hasCommittedMsg3ToArm` — NOK adds `actUlSlotAgg()` gate; `feedsWriterPath: scheduler-msg3`; `coverage: addressed`.

**gitUnlock candidate:** `abc123def456` [CHG-0042] — `Msg3Armer.cpp`

## 6. Adversarial Review (Stage E)

**overall:** `HOLDS`

Key verdict: configuration flags identical OK/NOK — NOK armer early-returns via disabled slot aggregation, OK can still arm when enhancement flag is true.

## 7. Conclusion

| Item | Result |
|------|--------|
| Gap type | Invocation gap (writer path skip, not per-slot value change) |
| Mechanism | Blanked-slot MSG3 arm gate tightened in NOK → fewer scheduler-msg3 writer invocations |
| Candidate commit | `abc123def456` [CHG-0042] |
| Caveats | No trace quantification of msg3 skip share of −5.94%; primary fd path not trace-quantified |

## 8. Ruled Out

- Writer Type-1 code mutation (git diff 0 lines)
- Computation gap narrative (slot counter flat; pm-only primary)
- Primary scheduler syntax gates changed OK→NOK (call-site chains `behaviorDelta=same`)

---

*This report format is produced by the staged investigation pipeline. See [ai-investigation.md](ai-investigation.md) for workflow details.*
