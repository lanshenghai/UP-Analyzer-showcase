# Interactive Demo

Open `index.html` in any modern browser. No server required.

**界面已对齐真实 UP-Analyzer：**
- 浅色主题 + 蓝色 Tab 边框（`#2196F3`）
- 顶部居中版本号 + 右侧 LogBrowser / TtiTraceHelper / Help
- 一级 Tab：LTE · **5G** · RF · eCPRI · CRM · AirPhone · MSI · Troubleshooting
- 5G 二级 Tab：Snapshot · KPI Analyzer · Comparing · L2Ps Trace Analyzer · …
- Snapshot 内层 Tab：CellMapping · Syslog · KPI · …
- **IDE Demo** 按钮：弹出独立的 Cursor 插件演示窗（非 UP-Analyzer 主界面）

## Usage

```powershell
# Windows
Start-Process "index.html"

# Or double-click index.html in Explorer
```

## Features

- **Open Files / Open Folder** — 点击后模拟解析进度条 + 彩色文件列表
- **KPI Analyzer** — OK vs NOK 柱状对比
- **Comparing** — SCF 选择 + TTI Trace 对比摘要
- **L2Ps Trace Analyzer** — 时序色块可视化
- **IDE Demo** — 独立弹窗展示 Cursor Agent + `/upa-*` 命令

## For Video Recording

1. Open in Chrome/Edge at 1920×1080 fullscreen (F11)
2. Uncomment the last line in `index.html` for auto-demo mode:

```javascript
setTimeout(autoDemo, 2000);
```

3. This will automatically cycle through Snapshot → KPI → Trace → Investigation every 3 seconds

## Quick Start (Screenshots)

**一键截图引导：**

```powershell
# 方式 1：双击运行
scripts\capture-screenshots.bat

# 方式 2：PowerShell
powershell -ExecutionPolicy Bypass -File scripts/capture-screenshots.ps1
```

脚本会：打开 `demo/index.html` → 打开 `assets/screenshots/` 文件夹 → 分 5 步提示你按 Win+Shift+S 截图保存。

| # | 操作 | 保存为 |
|---|------|--------|
| 1 | 5G → Snapshot → 点 Open Folder | `01-snapshot-overview.png` |
| 2 | 切到 KPI Analyzer | `02-kpi-dashboard.png` |
| 3 | 切到 L2Ps Trace Analyzer | `03-trace-visualization.png` |
| 4 | 点 IDE Demo 按钮 | `04-ide-integration.png` |
| 5 | IDE 弹窗里显示调查结论 | `05-ai-investigation.png` |

## Screenshot Targets (manual)

Capture these views for `assets/screenshots/`:

| Tab | Filename |
|-----|----------|
| Snapshot (after load) | `01-snapshot-overview.png` |
| KPI Compare | `02-kpi-dashboard.png` |
| TTI Trace | `03-trace-visualization.png` |
| Investigation | `05-ai-investigation.png` |
| Full window with agent panel | `04-ide-integration.png` |
