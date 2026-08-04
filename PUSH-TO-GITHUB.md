# 推送到 GitHub

## 前提

1. GitHub 账号：[github.com/lanshenghai](https://github.com/lanshenghai)
2. 已安装 Git

## 步骤 1 — 在 GitHub 创建仓库

1. 打开 https://github.com/new
2. 仓库名：`UP-Analyzer-showcase`
3. 描述：`UP-Analyzer 工程诊断平台作品集展示`
4. 选 **Public**
5. **不要**勾选初始化 README（本地已有）
6. 点击 **Create repository**

## 步骤 2 — 从本地推送

```powershell
cd "c:\Users\qrb378\OneDrive\文档\UP-Analyzer-showcase"

git init
git add .
git commit -m "Initial showcase: 架构文档、演示页、视频分镜稿"

git branch -M main
git remote add origin https://github.com/lanshenghai/UP-Analyzer-showcase.git
git push -u origin main
```

若提示输入凭据，请使用 [GitHub Personal Access Token](https://github.com/settings/tokens)，不要用账号密码。

或使用 GitHub CLI：

```powershell
& "C:\Program Files\GitHub CLI\gh.exe" auth login
& "C:\Program Files\GitHub CLI\gh.exe" repo create UP-Analyzer-showcase --public --source=. --remote=origin --push
```

若 remote 已存在，只需 `git push -u origin main`。

## 步骤 3 — 启用 GitHub Pages

1. 仓库 → Settings → Pages
2. Source：Deploy from branch `main`，文件夹 `/docs`
3. 保存 → 访问 https://lanshenghai.github.io/UP-Analyzer-showcase/

## 步骤 4 — 更新简历

```
UP-Analyzer 作品集：https://github.com/lanshenghai/UP-Analyzer-showcase
在线演示：https://lanshenghai.github.io/UP-Analyzer-showcase/
```

## 步骤 5 — 录制视频后

1. 上传至 B 站 / YouTube
2. 编辑 `README.md` — 填入演示视频链接
3. 将截图放入 `assets/screenshots/`
4. 提交并推送：

```powershell
git add .
git commit -m "添加演示视频链接与截图"
git push
```

## 重要提醒

- **切勿**将 `c:\work\UP-Analyzer\` 推送到本仓库
- 每次推送前查阅 [desensitization-checklist.md](docs/desensitization-checklist.md)
- 视频文件（`.mp4`）已 gitignore — 仅托管在 B 站/YouTube
