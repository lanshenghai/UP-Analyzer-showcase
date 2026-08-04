# UP-Analyzer Showcase — Screenshot Capture Helper
# Usage: Right-click → "Run with PowerShell", or:
#   powershell -ExecutionPolicy Bypass -File scripts/capture-screenshots.ps1

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$DemoHtml = Join-Path $RepoRoot "demo\index.html"
$ScreenshotDir = Join-Path $RepoRoot "assets\screenshots"

if (-not (Test-Path $DemoHtml)) {
    Write-Host "ERROR: Demo not found at $DemoHtml" -ForegroundColor Red
    exit 1
}

New-Item -ItemType Directory -Force -Path $ScreenshotDir | Out-Null

function Show-Step {
    param([int]$Num, [string]$Title, [string]$Action, [string]$Filename)
    Write-Host ""
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
    Write-Host "  Step $Num/5 — $Title" -ForegroundColor Cyan
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
    Write-Host "  Action : $Action"
    Write-Host "  Save as: assets\screenshots\$Filename" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  Press Win+Shift+S → drag region → save to folder above" -ForegroundColor Green
    Write-Host "  Then press Enter here to continue..." -ForegroundColor Gray
    Read-Host
}

Write-Host ""
Write-Host "  UP-Analyzer Showcase — Screenshot Guide" -ForegroundColor White
Write-Host "  =======================================" -ForegroundColor DarkGray
Write-Host ""
Write-Host "  Opening demo in browser..."
Write-Host "  Screenshot folder: $ScreenshotDir"
Write-Host ""

# Open demo (first time)
Start-Process $DemoHtml
Start-Sleep -Seconds 2

# Open screenshot folder in Explorer for easy paste/save
Start-Process explorer.exe $ScreenshotDir

Write-Host "  Tips:" -ForegroundColor DarkYellow
Write-Host "  - Browser F11 = fullscreen (recommended)"
Write-Host "  - Hide the yellow demo banner if you want a cleaner look"
Write-Host "  - Do NOT include real customer/site IDs"
Write-Host ""

Show-Step 1 "Snapshot Overview" `
    "Click 'Open Folder' → wait for parse → stay on 5G > Snapshot > CellMapping tab" `
    "01-snapshot-overview.png"

Show-Step 2 "KPI Dashboard" `
    "Click tab 'KPI Analyzer' → wait for bars to animate" `
    "02-kpi-dashboard.png"

Show-Step 3 "Trace Visualization" `
    "Click tab 'L2Ps Trace Analyzer' → wait for timeline to render" `
    "03-trace-visualization.png"

Show-Step 4 "IDE Integration" `
    "Click top-right 'IDE Demo' button → capture the Cursor popup window" `
    "04-ide-integration.png"

Show-Step 5 "AI Investigation" `
    "In IDE Demo popup, scroll to show Stage E / HOLDS verdict (or capture Comparing tab as backup)" `
    "05-ai-investigation.png"

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host "  Done! Verify files in assets\screenshots\" -ForegroundColor Green
Write-Host ""
Write-Host "  Next steps:" -ForegroundColor Cyan
Write-Host "    git add assets/screenshots/*.png"
Write-Host "    git commit -m ""Add showcase screenshots"""
Write-Host "    git push"
Write-Host ""

$count = (Get-ChildItem $ScreenshotDir -Filter "*.png" -ErrorAction SilentlyContinue).Count
Write-Host "  Current PNG count in folder: $count / 5" -ForegroundColor $(if ($count -ge 5) { "Green" } else { "Yellow" })
