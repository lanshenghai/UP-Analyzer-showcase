# UP-Analyzer Showcase

> **Engineering log intelligence platform** — from fragmented scripts to a daily-driver desktop product with IDE-native AI investigation workflows.

[![Demo](https://img.shields.io/badge/Demo-5%20min%20video-blue)](docs/demo-video-script.md)
[![Author](https://img.shields.io/badge/Author-Lan%20Shenghai-green)](https://github.com/lanshenghai)

**Author:** [兰生海 / Lan Shenghai](https://github.com/lanshenghai)  
**Role:** Independent initiator, architect, and lead developer (2018 — present)  
**Scale:** v12+, 6,000+ commits, ~10K DAU across global R&D teams

---

## What is UP-Analyzer?

UP-Analyzer is a **desktop engineering diagnostics platform** I built alongside my day job as a real-time systems architect. It unifies heterogeneous engineering logs — binary traces, snapshots, system logs, network captures, and KPI counters — into one interactive workflow.

The platform evolved over **8 years** from a personal Python script into:

- An **Electron + React** cross-platform desktop product (Windows / Linux)
- An embedded **Python runtime** with 500+ domain-specific parsers
- A decoupled **binary trace decode engine** (TtiTraceHelper)
- **IDE plugins** for Cursor / VS Code that let AI agents query live parsed sessions
- A **staged AI investigation pipeline** (Planner → Worker → Reviewer → Gate) for regression root-cause analysis

**Measured impact:** average troubleshooting time reduced from **weeks to hours**.

> ⚠️ **Note:** This repository is a **public showcase** for portfolio and interview purposes. The production codebase is proprietary and not included here. All screenshots, data, and examples use synthetic or desensitized content.

---

## Quick Links

| Resource | Description |
|----------|-------------|
| [Architecture](docs/architecture.md) | System design, layering, and key engineering decisions |
| [5-Min Demo Script](docs/demo-video-script.md) | Storyboard for recording a portfolio demo video |
| [Recording Guide](docs/recording-guide.md) | OBS setup, desensitization steps, export settings |
| [AI Investigation Overview](docs/ai-investigation.md) | Staged gate workflow for automated root-cause analysis |
| [Sample Report](examples/sample-investigation-report.md) | Desensitized end-to-end investigation example |
| [Interactive Mock](https://lanshenghai.github.io/UP-Analyzer-showcase/) | Browser-based UI mock for screenshots and demo B-roll |

---

## Architecture at a Glance

```
┌─────────────────────────────────────────────────────────┐
│  Cursor / VS Code (IDE Extension)                       │
│  Slash commands · Prompt orchestration · Stage A–E      │
└───────────────────────────┬─────────────────────────────┘
                            │ parser_servers registry
┌───────────────────────────▼─────────────────────────────┐
│  Electron + React (Desktop Shell + Visualization)       │
│  Snapshot · KPI · Syslog · PCAP · Cross-version Compare │
└───────────────────────────┬─────────────────────────────┘
                            │
        ┌───────────────────┼───────────────────┐
        ▼                   ▼                   ▼
  Embedded Python      Decode Engine         Release Pipeline
  500+ parsers         Multi-product         S3 · Signing · Auto-update
```

See [docs/architecture.md](docs/architecture.md) for the full breakdown.

---

## Evolution Timeline

| Year | Milestone | Capability unlocked |
|------|-----------|---------------------|
| 2018 | v1–v4 prototype | Domain visualization (beam / trace / KPI) |
| 2019 | v5–v6 Electron product | Installable desktop app, auto-update |
| 2020–21 | v7–v8 platform + award | Snapshot workflow, embedded Python, org-wide adoption |
| 2022 | v9–v10 rebrand + engine split | UP-Analyzer naming, TtiTraceHelper decode engine |
| 2023–25 | v10–v11 scale | Multi-domain expansion, release compatibility governance |
| 2026 | v12 + IDE/AI | Copilot integration, staged investigation pipeline |

---

## Key Metrics (Portfolio)

| Metric | Value |
|--------|-------|
| Active development | 2018.02 — present |
| Commits (main repo) | 6,000+ |
| Parser scripts | ~500 |
| Functional domains | 8+ (L1–L3 stack) |
| Daily active users | ~10,000 |
| Platforms | Windows, Linux |
| Efficiency gain | Weeks → hours (avg. troubleshooting) |

---

## Tech Stack

- **Desktop:** Electron, React, Node.js
- **Parsing:** Python 3.12 (embedded), multi-threaded decode
- **IDE:** VS Code Extension API, Cursor plugin integration
- **AI:** LLM orchestration with staged gates, knowledge base, RAG-style context
- **Release:** Code signing, S3 auto-update, cross-release format compatibility

---

## Demo Video

Record a 5-minute walkthrough following [docs/demo-video-script.md](docs/demo-video-script.md).

**Suggested flow:**
1. Problem context (30s)
2. Snapshot one-click analysis (60s)
3. KPI / trace visualization (60s)
4. IDE plugin + AI query (90s)
5. Staged investigation result (60s)
6. Summary + metrics (30s)

Upload to Bilibili / YouTube and link here:

```
<!-- Replace with your video URL after recording -->
🎬 Demo video: (pending — see docs/recording-guide.md)
```

**Live demo:** https://lanshenghai.github.io/UP-Analyzer-showcase/

---

## Screenshots

Place desensitized screenshots in `assets/screenshots/`:

| File | Content |
|------|---------|
| `01-snapshot-overview.png` | Main window with synthetic snapshot loaded |
| `02-kpi-dashboard.png` | KPI comparison view |
| `03-trace-visualization.png` | Trace / beam visualization |
| `04-ide-integration.png` | Cursor/VS Code with slash commands |
| `05-ai-investigation.png` | Staged investigation output |

Use the [interactive mock](demo/index.html) if you cannot capture the production UI.

---

## About the Author

**兰生海 (Lan Shenghai)** — 20+ years in real-time embedded / telecom software. HIT master's degree. Led 5G scheduling teams while independently building and operating UP-Analyzer as a product owner.

- GitHub: [lanshenghai](https://github.com/lanshenghai)
- Email: lanshenghai@126.com

---

## License

Showcase materials (documentation, demo HTML, diagrams) are released under [MIT](LICENSE).

The production UP-Analyzer codebase is **not** part of this repository and remains proprietary.
