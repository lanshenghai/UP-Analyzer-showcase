# UP-Analyzer Showcase — 截图引导脚本
# 用法：右键 →「使用 PowerShell 运行」，或：
#   powershell -ExecutionPolicy Bypass -File scripts/capture-screenshots.ps1

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$DemoHtml = Join-Path $RepoRoot "demo\index.html"
$ScreenshotDir = Join-Path $RepoRoot "assets\screenshots"

if (-not (Test-Path $DemoHtml)) {
    Write-Host "错误：未找到演示页 $DemoHtml" -ForegroundColor Red
    exit 1
}

New-Item -ItemType Directory -Force -Path $ScreenshotDir | Out-Null

function Show-Step {
    param([int]$Num, [string]$Title, [string]$Action, [string]$Filename)
    Write-Host ""
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
    Write-Host "  步骤 $Num/5 — $Title" -ForegroundColor Cyan
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
    Write-Host "  操作   : $Action"
    Write-Host "  保存为 : assets\screenshots\$Filename" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  按 Win+Shift+S 框选区域 → 保存到上方文件夹" -ForegroundColor Green
    Write-Host "  完成后按 Enter 继续..." -ForegroundColor Gray
    Read-Host
}

Write-Host ""
Write-Host "  UP-Analyzer Showcase — 截图引导" -ForegroundColor White
Write-Host "  ================================" -ForegroundColor DarkGray
Write-Host ""
Write-Host "  正在打开演示页..."
Write-Host "  截图目录: $ScreenshotDir"
Write-Host ""

Start-Process $DemoHtml
Start-Sleep -Seconds 2
Start-Process explorer.exe $ScreenshotDir

Write-Host "  提示:" -ForegroundColor DarkYellow
Write-Host "  - 浏览器 F11 全屏（推荐）"
Write-Host "  - 需要更干净画面时可隐藏顶部黄色提示条"
Write-Host "  - 不要包含真实客户/站点 ID"
Write-Host ""

Show-Step 1 "Snapshot 总览" `
    "点击「打开文件夹」→ 等待解析完成 → 停留在 5G > Snapshot > CellMapping" `
    "01-snapshot-overview.png"

Show-Step 2 "KPI 仪表盘" `
    "切换到「KPI Analyzer」Tab → 等待柱状图动画完成" `
    "02-kpi-dashboard.png"

Show-Step 3 "Trace 可视化" `
    "切换到「L2Ps Trace Analyzer」Tab → 等待时间轴渲染" `
    "03-trace-visualization.png"

Show-Step 4 "IDE 集成" `
    "点击右上角「IDE 演示」→ 截取 Cursor 弹窗" `
    "04-ide-integration.png"

Show-Step 5 "AI 调查" `
    "在 IDE 弹窗中展示 Stage E / HOLDS 结论（或截取 Comparing Tab 作备选）" `
    "05-ai-investigation.png"

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host "  完成！请检查 assets\screenshots\ 中的文件" -ForegroundColor Green
Write-Host ""
Write-Host "  后续步骤:" -ForegroundColor Cyan
Write-Host "    git add assets/screenshots/*.png"
Write-Host "    git commit -m ""添加作品集截图"""
Write-Host "    git push"
Write-Host ""

$count = (Get-ChildItem $ScreenshotDir -Filter "*.png" -ErrorAction SilentlyContinue).Count
Write-Host "  当前 PNG 数量: $count / 5" -ForegroundColor $(if ($count -ge 5) { "Green" } else { "Yellow" })
