# Recording Guide

## Tools

| Tool | Purpose | Download |
|------|---------|----------|
| **OBS Studio** | Screen + mic recording | https://obsproject.com |
| **ShareX** (optional) | Screenshot capture | https://getsharex.com |
| **DaVinci Resolve** (optional) | Free video editing | https://blackmagicdesign.com |

---

## OBS Setup (Recommended)

### Scene Collection

1. **Scene: Desktop Demo**
   - Source: Display Capture (primary monitor)
   - Crop to 1920×1080 if needed

2. **Scene: IDE Demo**
   - Source: Window Capture → Cursor or VS Code
   - Add margin for readability

3. **Scene: Browser Mock** (fallback)
   - Source: Window Capture → Chrome/Edge with `demo/index.html`

### Audio

- Input: Microphone (built-in OK; headset preferred)
- Noise suppression: OBS filter → Noise Suppression (−30 dB)
- Test 10 seconds, play back before full recording

### Output Settings

```
Format:     mp4
Encoder:    x264 or NVENC (if NVIDIA GPU)
Resolution: 1920×1080
FPS:        30
Bitrate:    8000–12000 Kbps
```

Path: save to `assets/demo-video.mp4` (gitignored — upload to Bilibili/YouTube instead)

---

## Recording Workflow

```
1. Read through demo-video-script.md once
2. Do a 30-second test recording → check audio + text readability
3. Record Scene 2–3 (desktop/mock) as one take
4. Record Scene 4–5 (IDE) as one take
5. Record narration for Scene 1 + 6 separately (optional, easier to edit)
6. Assemble in editor or OBS with scene cuts
7. Export final MP4
```

**Tip:** Record narration **after** screen capture if you're not comfortable doing both simultaneously. Match voiceover to the script timestamps in post.

---

## Screenshot Capture

During or after recording, capture these frames:

```powershell
# Open the mock in browser
Start-Process "c:\Users\qrb378\OneDrive\文档\UP-Analyzer-showcase\demo\index.html"

# Use Win+Shift+S for region capture
# Save to assets/screenshots/ with naming from README
```

| # | Filename | When to capture |
|---|----------|-----------------|
| 1 | `01-snapshot-overview.png` | Snapshot tree fully expanded |
| 2 | `02-kpi-dashboard.png` | KPI chart with OK/NOK bars |
| 3 | `03-trace-visualization.png` | Trace timeline view |
| 4 | `04-ide-integration.png` | Slash command menu visible |
| 5 | `05-ai-investigation.png` | Stage E conclusion panel |

---

## Using Production App (If Permitted Before Departure)

1. Load synthetic test data only (`test/data/**/ENB_9999_*`)
2. Follow [desensitization-checklist.md](desensitization-checklist.md)
3. Hide/blur: title bar hostname, email tray, internal URLs
4. Do NOT record: internal GitLab, Pronto web UI, proxy config

---

## Upload Checklist

- [ ] Video uploaded (Bilibili / YouTube)
- [ ] README demo link updated
- [ ] 5 screenshots committed to `assets/screenshots/`
- [ ] Final review: no proprietary names visible in video or images
- [ ] Git push to `github.com/lanshenghai/UP-Analyzer-showcase`

---

## GitHub Pages (Optional)

Enable GitHub Pages on the repo to host the interactive mock:

1. Repo Settings → Pages → Source: `main` branch, `/demo` folder
2. URL: `https://lanshenghai.github.io/UP-Analyzer-showcase/`

Or use the `docs/` folder — move `index.html` there if preferred.
