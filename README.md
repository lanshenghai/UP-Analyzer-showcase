# UP-Analyzer Showcase

> **工程日志智能分析平台** — 从碎片化脚本到日活过万的桌面产品，再到 IDE 原生 AI 排障工作流。

[![在线演示](https://img.shields.io/badge/在线演示-立即体验-blue)](https://lanshenghai.github.io/UP-Analyzer-showcase/)
[![作者](https://img.shields.io/badge/作者-兰生海-green)](https://github.com/lanshenghai)

**作者：** [兰生海](https://github.com/lanshenghai)  
**角色：** 独立发起人、架构师、核心开发者（2018 — 至今）  
**规模：** v12+，6000+ commit，全球研发日活约 1 万

---

## UP-Analyzer 是什么？

UP-Analyzer 是我在担任实时系统架构师的本职工作之余，独立构建的**桌面工程诊断平台**。它将二进制 Trace、Snapshot、系统日志、网络抓包、KPI 计数器等异构工程日志，统一到一条交互式工作流中。

平台历经 **8 年**演进，从个人 Python 脚本成长为：

- **Electron + React** 跨平台桌面产品（Windows / Linux）
- 捆绑 **嵌入式 Python 运行时**，含 500+ 领域解析脚本
- 解耦的**二进制 Trace 解码引擎**（TtiTraceHelper）
- **IDE 插件**（Cursor / VS Code），让 AI Agent 直接查询本机解析会话
- **分阶段 AI 调查流水线**（Planner → Worker → Reviewer → Gate），用于回归根因分析

**实测效果：** 平均排障时间从**数周级降至数小时级**。

> ⚠️ **说明：** 本仓库是面向作品集与面试的**公开展示**，不含生产环境专有代码。所有截图、数据与示例均为合成或脱敏内容。

---

## 快速导航

| 资源 | 说明 |
|------|------|
| [架构设计](docs/architecture.md) | 系统分层与关键工程决策 |
| [5 分钟演示脚本](docs/demo-video-script.md) | 录制作品集 Demo 视频的分镜稿 |
| [录制指南](docs/recording-guide.md) | OBS 设置、脱敏检查、导出参数 |
| [AI 调查流水线](docs/ai-investigation.md) | 分阶段 Gate 自动化根因分析 |
| [调查报告样例](examples/sample-investigation-report.md) | 脱敏端到端调查示例 |
| [在线交互演示](https://lanshenghai.github.io/UP-Analyzer-showcase/) | 浏览器 UI 模拟，可用于截图与录屏 |

---

## 架构概览

```
┌─────────────────────────────────────────────────────────┐
│  Cursor / VS Code（IDE 插件）                            │
│  斜杠命令 · Prompt 编排 · Stage A–E 调查                 │
└───────────────────────────┬─────────────────────────────┘
                            │ parser_servers 注册表
┌───────────────────────────▼─────────────────────────────┐
│  Electron + React（桌面壳 + 可视化）                     │
│  Snapshot · KPI · Syslog · PCAP · 跨版本对比             │
└───────────────────────────┬─────────────────────────────┘
                            │
        ┌───────────────────┼───────────────────┐
        ▼                   ▼                   ▼
  嵌入式 Python          解码引擎              发布流水线
  500+ 解析脚本          多产品线统一          S3 · 签名 · 自动更新
```

详见 [docs/architecture.md](docs/architecture.md)。

---

## 演进时间线

| 年份 | 里程碑 | 解锁的能力 |
|------|--------|-----------|
| 2018 | v1–v4 原型 | 领域可视化（Beam / Trace / KPI） |
| 2019 | v5–v6 桌面产品 | 可安装、可自动更新 |
| 2020–21 | v7–v8 平台化 + 获奖 | Snapshot 工作流、嵌入式 Python、组织级推广 |
| 2022 | v9–v10 品牌升级 + 引擎解耦 | UP-Analyzer 命名、TtiTraceHelper 解码引擎 |
| 2023–25 | v10–v11 规模化 | 多域扩展、版本兼容治理 |
| 2026 | v12 + IDE/AI | Copilot 集成、分阶段调查流水线 |

---

## 关键指标

| 指标 | 数值 |
|------|------|
| 持续开发 | 2018.02 — 至今 |
| 主仓 Commit | 6000+ |
| 解析脚本 | ~500 |
| 功能域 | 8+（L1–L3 全栈） |
| 日活用户 | ~10,000 |
| 支持平台 | Windows、Linux |
| 效率提升 | 数周 → 数小时（平均排障） |

---

## 技术栈

- **桌面端：** Electron、React、Node.js
- **解析层：** Python 3.12（嵌入式）、多线程解码
- **IDE：** VS Code Extension API、Cursor 插件集成
- **AI：** 分阶段 Gate 编排、知识库、RAG 式上下文
- **发布：** 代码签名、S3 自动更新、跨 Release 格式兼容

---

## 演示视频

按 [docs/demo-video-script.md](docs/demo-video-script.md) 录制 5 分钟 walkthrough。

**建议流程：**
1. 问题背景（30 秒）
2. Snapshot 一键分析（60 秒）
3. KPI / Trace 可视化（60 秒）
4. IDE 插件 + AI 查询（90 秒）
5. 分阶段调查结果（60 秒）
6. 总结与指标（30 秒）

上传至 B 站 / YouTube 后在此附上链接：

```
🎬 演示视频：（待录制 — 见 docs/recording-guide.md）
```

**在线演示：** https://lanshenghai.github.io/UP-Analyzer-showcase/

---

## 截图

将脱敏截图放入 `assets/screenshots/`：

| 文件 | 内容 |
|------|------|
| `01-snapshot-overview.png` | 主界面，Snapshot 已加载 |
| `02-kpi-dashboard.png` | KPI 对比视图 |
| `03-trace-visualization.png` | Trace / Beam 可视化 |
| `04-ide-integration.png` | Cursor/VS Code 斜杠命令 |
| `05-ai-investigation.png` | 分阶段调查输出 |

可使用 [在线交互演示](https://lanshenghai.github.io/UP-Analyzer-showcase/) 或本地 `demo/index.html` 截图。

一键截图引导：运行 `scripts/capture-screenshots.bat`

---

## 关于作者

**兰生海** — 20 余年实时嵌入式 / 通信软件经验，哈尔滨工业大学硕士。带领 5G 调度团队的同时，以产品 Owner 身份独立构建并运营 UP-Analyzer。

- GitHub：[lanshenghai](https://github.com/lanshenghai)
- 邮箱：lanshenghai@126.com

---

## 许可

展示材料（文档、演示 HTML、架构图）以 [MIT](LICENSE) 许可发布。

生产环境 UP-Analyzer 代码**不在**本仓库中，仍为专有资产。
