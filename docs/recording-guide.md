# 录制指南

## 工具

| 工具 | 用途 | 下载 |
|------|------|------|
| **OBS Studio** | 屏幕 + 麦克风录制 | https://obsproject.com |
| **ShareX**（可选） | 截图 | https://getsharex.com |
| **DaVinci Resolve**（可选） | 免费视频剪辑 | https://blackmagicdesign.com |

---

## OBS 设置（推荐）

### 场景集合

1. **场景：桌面演示**
   - 来源：显示器采集（主屏）
   - 如需可裁切为 1920×1080

2. **场景：IDE 演示**
   - 来源：窗口采集 → Cursor 或 VS Code
   - 留边距便于阅读

3. **场景：浏览器模拟**（备选）
   - 来源：窗口采集 → Chrome/Edge 打开 `demo/index.html`

### 音频

- 输入：麦克风（内置可用；耳机麦更佳）
- 降噪：OBS 滤镜 → 噪声抑制（−30 dB）
- 正式录制前先录 10 秒试听

### 输出设置

```
格式：     mp4
编码器：   x264 或 NVENC（NVIDIA 显卡）
分辨率：   1920×1080
帧率：     30
码率：     8000–12000 Kbps
```

保存路径：`assets/demo-video.mp4`（已 gitignore — 请上传 B 站/YouTube）

---

## 录制流程

```
1. 通读 demo-video-script.md
2. 试录 30 秒 → 检查音质与文字清晰度
3. 一次录完场景 2–3（桌面/模拟页）
4. 一次录完场景 4–5（IDE）
5. 场景 1 + 6 旁白可后期单独录（可选）
6. 在剪辑软件或 OBS 中组接
7. 导出最终 MP4
```

**提示：** 若不习惯边录边讲，可先录屏再按分镜稿后期配音。

---

## 截图采集

录制过程中或之后截取以下画面：

```powershell
# 在浏览器打开演示页
Start-Process "c:\Users\qrb378\OneDrive\文档\UP-Analyzer-showcase\demo\index.html"

# Win+Shift+S 区域截图
# 保存到 assets/screenshots/，命名见 README
```

| # | 文件名 | 截取时机 |
|---|--------|----------|
| 1 | `01-snapshot-overview.png` | Snapshot 树完全展开 |
| 2 | `02-kpi-dashboard.png` | KPI 柱状图 OK/NOK |
| 3 | `03-trace-visualization.png` | Trace 时间轴视图 |
| 4 | `04-ide-integration.png` | 斜杠命令菜单可见 |
| 5 | `05-ai-investigation.png` | Stage E 结论面板 |

---

## 使用生产环境应用（离职前若仍可用）

1. 仅加载合成测试数据（`test/data/**/ENB_9999_*`）
2. 遵循 [desensitization-checklist.md](desensitization-checklist.md)
3. 隐藏/打码：标题栏主机名、邮件托盘、内部 URL
4. **不要**录制：内部 GitLab、Pronto 网页、代理配置

---

## 上传检查清单

- [ ] 视频已上传（B 站 / YouTube）
- [ ] README 中演示视频链接已更新
- [ ] 5 张截图已提交到 `assets/screenshots/`
- [ ] 最终检查：视频与图片中无专有名称
- [ ] 已 `git push` 到 `github.com/lanshenghai/UP-Analyzer-showcase`

---

## GitHub Pages

在线演示已部署在：

**https://lanshenghai.github.io/UP-Analyzer-showcase/**

源目录为 `docs/`（`main` 分支）。若需重新配置：仓库 Settings → Pages → Source：`main` / `/docs`。
