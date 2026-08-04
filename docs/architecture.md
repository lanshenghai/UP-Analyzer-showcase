# 架构设计

> 面向作品集的脱敏架构说明。不含专有协议细节与内部 URL。

## 设计目标

1. **统一碎片化工作流** — 一个产品替代数十个脚本和解码器
2. **跟上版本迭代** — 解析器随软件 Release 演进，无需重写外壳
3. **支撑数千工程师规模** — 自动更新、代码签名、跨平台交付
4. **嵌入日常工具** — IDE 插件让 AI 查询解析数据，无需切换上下文
5. **约束 AI 幻觉** — 分阶段调查 + 确定性 Gate，而非自由对话

---

## 分层架构

```
┌──────────────────────────────────────────────────────────────────┐
│                     IDE Layer (2026+)                            │
│  ┌─────────────┐  ┌──────────────┐  ┌────────────────────────┐ │
│  │ Slash cmds  │  │ Prompt lib   │  │ Stage A–E orchestration  │ │
│  │ /query etc. │  │ + knowledge  │  │ Planner/Worker/Reviewer  │ │
│  └──────┬──────┘  └──────┬───────┘  └───────────┬────────────┘ │
│         └────────────────┴──────────────────────┘              │
│                            │ ide_integration.json                │
│                            │ parser_servers/*.json (per session) │
└────────────────────────────┼─────────────────────────────────────┘
                             │ HTTP (localhost, curl --noproxy)
┌────────────────────────────▼─────────────────────────────────────┐
│                   Desktop Shell (Electron + React)               │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌───────────────────┐  │
│  │ Snapshot │ │ KPI      │ │ Syslog   │ │ Compare / Report  │  │
│  │ workflow │ │ dashboard│ │ browser  │ │ cross-version     │  │
│  └────┬─────┘ └────┬─────┘ └────┬─────┘ └─────────┬─────────┘  │
│       └────────────┴────────────┴─────────────────┘              │
│                            │ spawn / IPC                           │
└────────────────────────────┼─────────────────────────────────────┘
                             │
        ┌────────────────────┼────────────────────┐
        ▼                    ▼                    ▼
┌───────────────┐  ┌─────────────────┐  ┌──────────────────┐
│ Embedded      │  │ Decode Engine   │  │ Release System   │
│ Python 3.12   │  │ (TtiTraceHelper)│  │ S3 · MSI/AppImage│
│ 500+ parsers  │  │ auto-detect     │  │ code signing     │
│ parserServer  │  │ multi-product   │  │ What's New       │
└───────────────┘  └─────────────────┘  └──────────────────┘
```

---

## Component Responsibilities

### Desktop Shell (Electron + React)

- File drop / folder selection for engineering log bundles
- Tab-based navigation across functional domains
- Interactive charts (Plotly / D3) for time-series and spatial data
- Session management: each parsed dataset registers a `parserServer` instance

### Embedded Python Runtime

- Bundled interpreter (Windows + Linux) — users never install Python manually
- `parserServer` exposes parsed modules as HTTP endpoints on localhost
- 500+ scripts organized by domain (trace, snapshot, KPI, syslog, PCAP, etc.)
- Output schema stable enough for IDE agents to discover and query programmatically

### Decode Engine (TtiTraceHelper)

Extracted in 2022 when binary trace decoding became shared across product lines:

| Before | After |
|--------|-------|
| Per-page decoder scripts | Unified engine with product auto-detection |
| Manual product/version selection | Version probe + on-demand decoder fetch |
| GUI release tied to decoder changes | Engine updates independently |

Capabilities: multi-threaded decode, large file chunking, GUI + CLI modes, 90+ unit tests.

### IDE Extension

- Writes `ide_integration.json` with environment metadata and parser instance registry
- Provides slash commands for AI agents (`/query`, `/status`, `/investigate`, etc.)
- Agents use `curl --noproxy '*'` against `parser_servers/*.json` base URLs
- Supports local workspace and Remote SSH (extension runs on same host as UP-Analyzer)

### AI Investigation Pipeline

Not a chat wrapper — a **state machine with gates**:

```
Stage A: Working set definition (which counters / KPIs matter)
    ↓ Gate: evidence present?
Stage B: Quantify OK vs NOK (PM windows, steady-state rules)
    ↓ Gate: gap confirmed?
Stage C: Call-site handoff (which code paths write the counter)
    ↓ Gate: primary suspect identified?
Stage D: Mechanism analysis (invocation gap vs computation gap)
    ↓ Gate: mechanism typed?
Stage E: Adversarial review (challenge the hypothesis)
    ↓ Gate: HOLDS / REFUTED
Conclusion: candidate commit + caveats
```

Key design choices:
- **Planner** orchestrates stages; **Worker** executes; **Reviewer** challenges
- Deterministic gates block progression without evidence
- Separate `/stage-*` (validate-only) vs `/investigate` (commit) entry points for prompt iteration

---

## Key Engineering Decisions

| Decision | Rationale | Trade-off |
|----------|-----------|-----------|
| Electron over web app | Local file access, offline, embedded runtime | Larger install size |
| Embedded Python | Eliminate "works on my machine" | Bundle size + LFS management |
| Decode engine split | Reuse across GUI, CLI, IDE | More integration surface |
| localhost HTTP API | Simple for AI agents via curl | Must handle proxy bypass |
| Stage gates for AI | Reduce hallucinated root causes | More complex prompt engineering |
| VSIX separate from app | AI features iterate faster than desktop releases | Two release pipelines |

---

## Data Flow: Typical Troubleshooting Session

```
1. Engineer drops Snapshot folder into desktop app
2. Shell discovers components, spawns Python parsers per module
3. parserServer registers session → parser_servers/<pid>.json
4. IDE extension detects new instance via file watcher
5. Engineer asks AI: "Compare KPI X between OK and NOK logs"
6. Agent reads registry → curls parsed_modules → drills into KPI data
7. For regressions: /investigate runs staged pipeline → structured report
```

---

## Compatibility Governance

Production challenge: base station software changes log formats every release.

Strategy:
- Test fixtures per release train (synthetic IDs, no customer data)
- CI regression on parser outputs
- Graceful degradation when unknown fields appear
- `What's New` changelog tied to release compatibility matrix

This is why the platform survived 8 years without a rewrite — **compatibility is treated as a first-class feature**, not maintenance overhead.

---

## What Is NOT in This Repo

- Proprietary protocol parsers and decoder binaries
- Internal artifact servers and authentication
- Customer/site identifiers in test data
- Production IDE extension VSIX (install via internal distribution only)

See [desensitization-checklist.md](desensitization-checklist.md) before publishing any screenshots or recordings.
