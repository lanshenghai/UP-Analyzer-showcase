# Interactive Demo

Open `index.html` in any modern browser. No server required.

## Usage

```powershell
# Windows
Start-Process "index.html"

# Or double-click index.html in Explorer
```

## Features

- **Snapshot load simulation** — click the drop zone to animate parsing
- **KPI comparison chart** — synthetic OK vs NOK counter deltas
- **TTI trace timeline** — auto-generated event blocks
- **AI investigation stages** — A through E with verdict
- **IDE agent panel** — mock Cursor/VS Code chat with curl commands

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
