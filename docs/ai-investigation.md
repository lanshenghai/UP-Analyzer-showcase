# AI Investigation Workflow

> Overview of the staged root-cause analysis pipeline integrated into the IDE extension.  
> All examples use desensitized identifiers.

## Problem

Regression investigations in telecom software follow a repeatable but expert-dependent path:

1. Read defect report → understand claimed symptom
2. Load OK and NOK logs into analysis tools
3. Quantify counter/KPI deltas with correct time windows
4. Trace counter writers to code call sites
5. Determine mechanism (invocation gap vs computation gap)
6. Attribute to a candidate code change
7. Challenge the hypothesis (adversarial review)

Each step has failure modes: wrong time window, wrong counter, premature conclusion, hallucinated code paths.

## Solution: Staged Pipeline with Gates

Instead of one giant prompt, the workflow splits into **stages** with **deterministic gates**:

```
                    ┌─────────────┐
                    │   Planner   │
                    │ orchestrates│
                    └──────┬──────┘
                           │
     ┌─────────────────────┼─────────────────────┐
     ▼                     ▼                     ▼
┌─────────┐          ┌─────────┐          ┌──────────┐
│ Worker  │          │ Reviewer│          │   Gate   │
│ executes│─────────▶│challenges│─────────▶│ pass/fail│
└─────────┘          └─────────┘          └────┬─────┘
                                               │
                                    pass → next stage
                                    fail → retry or halt
```

### Stage A — Working Set

**Goal:** Define which counters/KPIs are relevant to the reported symptom.

**Gate:** At least one primary counter identified with parser path.

### Stage B — Quantification

**Goal:** Compare OK vs NOK with correct PM windows, steady-state rules, load comparability.

**Gate:** Statistically significant delta confirmed (or symptom ruled out).

### Stage C — Call-Site Handoff

**Goal:** Map the primary counter to code paths that invoke its writer function.

**Gate:** `primarySuspectCounter` assigned with call-site evidence.

### Stage D — Mechanism

**Goal:** Classify the gap type:
- **Invocation gap:** writer called fewer times (code path skipped)
- **Computation gap:** writer called same times but values differ

**Gate:** Mechanism typed with evidence tier (Type-1 git diff, Type-2 behavioral delta).

### Stage E — Adversarial Review

**Goal:** Independent reviewer challenges the hypothesis. Must check configuration parity, alternative explanations, and evidence gaps.

**Gate:** Verdict `HOLDS` or `REFUTED`.

## Dual Entry Points

| Command | Mode | Use case |
|---------|------|----------|
| `/stage-*` | Validate only | Prompt engineering, A/B testing |
| `/investigate` | Planner + commit | Production end-to-end runs |

This separation allows iterating on individual stage prompts without corrupting committed investigation state.

## Anti-Hallucination Measures

| Technique | What it prevents |
|-----------|------------------|
| Deterministic gates | Skipping evidence collection |
| `curl`-based data access | Fabricated log contents |
| Working set pinning | Counter drift mid-investigation |
| Adversarial review stage | Confirmation bias |
| Separate validate/commit modes | Accidental state corruption during experiments |
| Evidence tiers (Type-1/2/3) | Mixing code-diff facts with behavioral inference |

## Prompt Optimization Loop

A separate evaluation harness measures whether prompt changes improve root-cause hit rate on fixed fixture cases — rather than relying on subjective "feels better" iteration.

```
Deploy plugin → Run fixture case → Score against gold report
    → Gap analysis → Edit prompts → Keep best iteration → Repeat
```

Constraints: generalize, zero answer leakage, delete rules before adding new ones.

## Example Output

See [sample-investigation-report.md](../examples/sample-investigation-report.md) for a complete desensitized report.

## What This Demonstrates (For Interviewers)

- **AI engineering**, not AI demo: state machines, gates, evaluation loops
- **Domain depth**: understanding PM counters, invocation vs computation gaps
- **Product thinking**: the pipeline encodes expert workflow, not generic chat
- **Iteration discipline**: measured prompt optimization instead of prompt sprawl
