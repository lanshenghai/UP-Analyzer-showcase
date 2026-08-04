# 交互式演示

在任意现代浏览器中打开 `index.html` 即可，无需服务器。

**界面已对齐真实 UP-Analyzer：**
- 浅色主题 + 蓝色 Tab 边框（`#2196F3`）
- 顶部居中版本号 + 右侧 LogBrowser / TtiTraceHelper / Help
- 一级 Tab：LTE · **5G** · RF · eCPRI · CRM · AirPhone · MSI · Troubleshooting
- 5G 二级 Tab：Snapshot · KPI Analyzer · Comparing · L2Ps Trace Analyzer · …
- Snapshot 内层 Tab：CellMapping · Syslog · KPI · …
- **IDE 演示** 按钮：弹出独立的 Cursor 插件演示窗（非 UP-Analyzer 主界面）

## 使用方法

```powershell
# Windows
Start-Process "index.html"

# 或在资源管理器中双击 index.html
```

在线版：**https://lanshenghai.github.io/UP-Analyzer-showcase/**

## 功能

- **打开文件 / 打开文件夹** — 点击后模拟解析进度条 + 彩色文件列表
- **KPI Analyzer** — OK vs NOK 柱状对比
- **Comparing** — SCF 选择 + TTI Trace 对比摘要
- **L2Ps Trace Analyzer** — 时序色块可视化
- **IDE 演示** — 独立弹窗展示 Cursor Agent + `/upa-*` 命令

## 录制视频

1. 在 Chrome/Edge 中以 1920×1080 全屏（F11）打开
2. 取消 `index.html` 末尾注释以启用自动轮播：

```javascript
setTimeout(autoDemo, 2000);
```

3. 将自动循环：Snapshot → KPI → Trace → Comparing，并弹出 IDE 演示窗

## 一键截图

```powershell
# 方式 1：双击
scripts\capture-screenshots.bat

# 方式 2：PowerShell
powershell -ExecutionPolicy Bypass -File scripts/capture-screenshots.ps1
```

| # | 操作 | 保存为 |
|---|------|--------|
| 1 | 5G → Snapshot → 点「打开文件夹」 | `01-snapshot-overview.png` |
| 2 | 切到 KPI Analyzer | `02-kpi-dashboard.png` |
| 3 | 切到 L2Ps Trace Analyzer | `03-trace-visualization.png` |
| 4 | 点「IDE 演示」按钮 | `04-ide-integration.png` |
| 5 | IDE 弹窗显示调查结论 | `05-ai-investigation.png` |
