# 5-Minute Demo Video Script

> Total runtime: **4:30 – 5:30**. Narration in Chinese or English — both work for portfolio.  
> Record with OBS (see [recording-guide.md](recording-guide.md)).

---

## Pre-Recording Setup

- [ ] Close email / IM / internal chat
- [ ] Use synthetic data (`ENB_9999` style) or the [interactive mock](../demo/index.html)
- [ ] IDE workspace: generic folder name, not internal paths
- [ ] Display scale 125%, resolution 1920×1080
- [ ] Prepare 2 windows: Desktop app (or mock) + Cursor/VS Code

---

## Scene 1 — Problem Context (0:00 – 0:30)

**Visual:** Title card or talking-head optional; cut to messy folder of log files.

**Narration (CN):**
> 在电信基站软件开发中，工程师排障的典型路径是：收集 Snapshot、Trace、Syslog、PCAP 等多种日志，然后在十几个工具之间跳转，手工对齐时间轴，周期往往以周计算。UP-Analyzer 是我从 2018 年开始独立构建的一体化诊断平台，目标是把这条碎片化路径收敛到一个产品里。

**Narration (EN):**
> In telecom base station development, troubleshooting means juggling snapshots, traces, syslogs, and PCAPs across a dozen tools. Cycles are measured in weeks. UP-Analyzer is the unified platform I built since 2018 to collapse this fragmented workflow into one product.

**On-screen text:** `Weeks → Hours` | `10K DAU` | `8 years, v12+`

---

## Scene 2 — Snapshot Workflow (0:30 – 1:30)

**Visual:** Drag a snapshot folder into the app (or mock page "Snapshot" tab). Show auto-discovery of components and navigation tree.

**Actions:**
1. Drop folder → progress bar
2. Component tree expands (L2, L3, Syslog nodes)
3. Click one module → parsed data appears

**Narration:**
> 核心工作流是 Snapshot 一站式入口：拖入日志包，平台自动发现组件、选择对应版本的解析器、生成结构化数据。用户不需要知道底层有 500 多个 Python 脚本，也不需要手动配置 Python 环境——运行时已经捆绑好了。

**Highlight:** Embedded Python badge, "500+ parsers" callout

---

## Scene 3 — Visualization & KPI (1:30 – 2:30)

**Visual:** Switch to KPI dashboard; show OK vs NOK comparison chart. Optionally flash trace/beam visualization.

**Actions:**
1. Open KPI tab
2. Select two builds (OK / NOK)
3. Chart shows counter delta (−5.9% style synthetic data)
4. Quick pan to trace timeline view

**Narration:**
> 解析结果不只是表格。KPI 对比、时序图表、跨版本 diff 都在同一个界面完成。这张图展示的是一个典型的回归场景：升级后某个计数器下降了约 6%，但问题出在哪里，还需要进一步调查。

**Highlight:** Counter names are synthetic (`COUNTER_AVAIL_CH`)

---

## Scene 4 — IDE Integration (2:30 – 4:00)

**Visual:** Switch to Cursor or VS Code. Show slash command menu, agent querying parsed data.

**Actions:**
1. Show extension installed
2. Type `/` → pick a query command
3. Agent reads parser registry, runs curl against localhost
4. Show JSON response with parsed module paths
5. Agent summarizes findings in chat

**Narration:**
> 2026 年的关键演进是把平台嵌进开发者每天使用的 IDE。插件会注册本机正在运行的解析实例，AI Agent 通过 curl 直接查询结构化数据，不需要在工具和 IDE 之间来回切换。这不是套了一个 ChatUI，而是让 AI 能「看见」真实的工程数据。

**Highlight:** `parser_servers/*.json` registry (blur paths if needed), `curl --noproxy`

---

## Scene 5 — Staged AI Investigation (4:00 – 5:00)

**Visual:** Run investigation command or show pre-recorded output scrolling through stages A→E.

**Actions:**
1. Type investigate command with synthetic issue ID
2. Show stage progression: Working Set → Quantify → Call-site → Mechanism → Review
3. End with structured report (link to [sample report](../examples/sample-investigation-report.md))

**Narration:**
> 对于回归类问题，我设计了一套分阶段调查流水线：每个阶段有确定性 Gate，没有证据就不能进入下一步。最后经过对抗式审查，输出带候选 commit 的结构化报告。这把原来依赖专家经验的调查路径，变成了可重复执行的工程流程。

**Highlight:** `HOLDS` verdict, `invocation gap`, candidate commit hash (synthetic)

---

## Scene 6 — Summary (5:00 – 5:30)

**Visual:** Architecture diagram from README; metrics table.

**Narration:**
> 八年持续演进，6000 多次提交，日活约一万。从个人脚本到跨平台产品，再到 AI 原生排障工作流。这个项目证明的不只是全栈能力，而是能把领域经验产品化、工程化、智能化。

**On-screen text:**
```
Author: 兰生海 | Lan Shenghai
GitHub: github.com/lanshenghai
Email: lanshenghai@126.com
```

**End card:** 3 seconds silence → fade out

---

## B-Roll Alternatives

If you cannot screen-record the production app:

| Scene | Alternative |
|-------|-------------|
| 2–3 | Use [demo/index.html](../demo/index.html) in browser fullscreen |
| 4 | Record IDE with mock curl output pasted in terminal |
| 5 | Scroll through `examples/sample-investigation-report.md` in VS Code |

---

## Post-Production

1. Add subtitles (CN + EN optional)
2. Export: H.264, 1080p, 8–15 Mbps
3. Upload to Bilibili (国内) + YouTube (unlisted, 海外)
4. Update README demo link
5. Take 5 screenshots during export for `assets/screenshots/`
