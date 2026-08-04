# Push to GitHub

## Prerequisites

1. GitHub account: [github.com/lanshenghai](https://github.com/lanshenghai)
2. Git installed (already available)

## Step 1 — Create Repository on GitHub

1. Go to https://github.com/new
2. Repository name: `UP-Analyzer-showcase`
3. Description: `Portfolio showcase for UP-Analyzer engineering diagnostics platform`
4. Public
5. **Do NOT** initialize with README (we already have one)
6. Click **Create repository**

## Step 2 — Push from Local

```powershell
cd "c:\Users\qrb378\OneDrive\文档\UP-Analyzer-showcase"

git init
git add .
git commit -m "Initial showcase: architecture docs, demo mock, video script"

git branch -M main
git remote add origin https://github.com/lanshenghai/UP-Analyzer-showcase.git
git push -u origin main
```

If prompted for credentials, use a [GitHub Personal Access Token](https://github.com/settings/tokens) instead of password.

## Step 3 — Enable GitHub Pages (Optional)

1. Repo → Settings → Pages
2. Source: Deploy from branch `main`, folder `/demo`
3. Save → visit `https://lanshenghai.github.io/UP-Analyzer-showcase/`

## Step 4 — Update Resume

Add to resume / LinkedIn:

```
UP-Analyzer Showcase: https://github.com/lanshenghai/UP-Analyzer-showcase
Live Demo: https://lanshenghai.github.io/UP-Analyzer-showcase/
```

## Step 5 — After Recording Video

1. Upload to Bilibili / YouTube
2. Edit `README.md` — replace the demo video placeholder with your URL
3. Add screenshots to `assets/screenshots/`
4. Commit and push:

```powershell
git add .
git commit -m "Add demo video link and screenshots"
git push
```

## Important

- **Never** push `c:\work\UP-Analyzer\` to this repo
- Review [desensitization-checklist.md](docs/desensitization-checklist.md) before every push
- Video files (`.mp4`) are gitignored — host on Bilibili/YouTube only
