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

## Screenshot Targets

Capture these views for `assets/screenshots/`:

| Tab | Filename |
|-----|----------|
| Snapshot (after load) | `01-snapshot-overview.png` |
| KPI Compare | `02-kpi-dashboard.png` |
| TTI Trace | `03-trace-visualization.png` |
| Investigation | `05-ai-investigation.png` |
| Full window with agent panel | `04-ide-integration.png` |
