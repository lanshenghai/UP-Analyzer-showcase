# UP-Analyzer-Extra — 插件与伴生工具生态

> UP-Analyzer 主平台之外的**独立工具聚合仓库**，以 Git Submodule 管理多个模块，统一集成、测试与安装包打包。

**维护者：** [兰生海](https://github.com/lanshenghai)（仓库 Owner；bfcali 模块核心开发）  
**关系：** 各子模块通过 submodule 指针、CLI 调用或 Python 路径注入接入主平台

---

## 架构关系

```
┌─────────────────────────────────────────────────────────────┐
│                    UP-Analyzer（主平台）                       │
│  Electron + React · 嵌入式 Python · 500+ 解析脚本            │
└────────────┬────────────────────────────────────────────────┘
             │ 集成
   ┌─────────┼─────────┬─────────────┬──────────────┐
   ▼         ▼         ▼             ▼              ▼
LogBrowser  PMAT    bfcali      nidd_check   tti_trace_reminder
  日志浏览   KPI转换  射频校准解码   SCF配置对比    TTI规则引擎
```

---

## 模块一览

| 模块 | 技术栈 | 功能 | 主平台入口 |
|------|--------|------|-----------|
| **minilogbrowser** | Electron + React + Vite | 轻量日志浏览器：过滤、高亮、书签、多文件 Tab | 顶部 **LogBrowser** 按钮 |
| **PMAT** | C# (.NET) | PM Peg 处理、NIDD Release / KPI 定义转换 | KPI Analyzer 后台；安装包内 `PMAT.exe` |
| **bfcali** | C++ (pybind11) + Python | 射频校准 historyLog 解码（FlatBuffers、波束权重） | Snapshot → RF Syslog → Calibration |
| **nidd_check** | Python | SCF XML 与 NIDD 默认值 / Golden vs Used 差异比对 | 5G **Comparing** |
| **tti_trace_reminder** | Python | TTI Trace 小区级 / UE 级异常规则检测 | L2Ps Trace → **AutoAnalyzer** Tab |
| **random_forest** | C++ + Python | 实验性随机森林（特征重要性） | 按需链入解析流水线 |

---

## 集成模式

### 子窗口嵌入 — Log Browser

主应用 `logBrowserWindow.js` 创建独立 Electron 窗口，加载 minilogbrowser 构建产物。工程师可在不离开 UP-Analyzer 的情况下对大体积 Syslog 做正则检索与高亮。

### CLI 捆绑 — PMAT

```
PMAT --nrc <in> <out> <release> <product>   # NIDD Release 转换
PMAT --nkc <kpi> <pm> <release> <dest> ...  # KPI 映射生成
```

随安装包分发并代码签名；Release 升级时 KPI 模块自动调用 PMAT 刷新计数器定义。

### Native 扩展 — bfcali

C++ pybind11 模块 `L1HB` 解析二进制校准帧（`RtBfWeightVectorDumpData`、Q15 复数等）。Snapshot 配置 `bfcali.json` 按正则匹配 RMOD tar 包，路由至解码管道输出 CSV。

### Python 注入 — nidd_check & tti_trace_reminder

- **Comparing：** `CompareScfs.py` 实例化 `NIDD_Checker`，对比 Used / Golden SCF
- **AutoAnalyzer：** 动态加载 `RuleChecker`，按时间窗扫描 TTI Trace 并输出规则命中

---

## 设计价值

| 维度 | 收益 |
|------|------|
| **解耦** | 各工具独立版本与构建链，主仓只保留集成胶水 |
| **复用** | PMAT、Log Browser 可被其他诊断工具引用 |
| **协作** | 多作者并行开发，Submodule 指针控制升级节奏 |
| **测试** | 主仓集成测试覆盖 bfcali、TtiTrace、Comparing 等端到端路径 |

---

## 在线演示中的对应位置

在 [在线交互演示](demo.html) 中可看到以下集成点（脱敏数据）：

- 顶部 **LogBrowser** 按钮 → 弹出日志浏览器模拟窗
- **5G → Comparing** → SCF 差异检查（nidd_check）+ TTI Trace 对比
- **5G → L2Ps Trace Analyzer** → **AutoAnalyzer** 规则命中（tti_trace_reminder）
- **5G → KPI Analyzer** → PM 计数器对比（PMAT 驱动的定义转换）

---

## 相关页面

- [项目介绍](about.html) — 平台整体概述
- [架构设计](architecture.html) — 主平台分层
- [在线演示](demo.html) — 含插件集成标注的 UI 模拟

> ⚠️ 本页为脱敏公开展示，不含生产代码与内部仓库地址。
