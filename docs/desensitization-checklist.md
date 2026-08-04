# 脱敏检查清单

在发布源自生产环境 UP-Analyzer 的截图、演示视频或任何公开材料之前，请逐项核对：

## 必须删除或替换

| 类别 | 需清理的示例 | 替换方式 |
|------|-------------|----------|
| 公司名称 | Nokia、Motorola、内部代号 | 「厂商 X」「某电信设备公司」 |
| 内部 URL | `gitlabe1.ext.net.nokia.com`、代理主机 | 删除或打码 |
| 站点/客户 ID | MRBTS-*、带真实站点码的 ENB 名 | `SITE-001`、`ENB_9999_000000` |
| 真实 Pronto/PR ID | PR895222、PR891909 | `ISSUE-001`、`CHG-0042` |
| 内部邮箱域 | `@nokia-sbell.com` | 仅个人邮箱 |
| AWS/S3 凭证 | 环境变量中的 Access Key | 切勿在终端画面中暴露 |
| 同事姓名 | UI 中的真实姓名 | 打码或使用合成名 |
| 含内部路径的构建串 | 完整 SVN/Git 内部 URL | 截断为 `Release R3.2.1` |

## 可以展示

- 通用 UI 布局与导航结构
- 合成 KPI 名称（如 `COUNTER_AVAIL_CH`、`COUNTER_USED_CH`）
- 架构图（本仓库）
- 分阶段调查**工作流**（非真实缺陷数据）
- 技术栈名称（Electron、React、Python、Cursor）
- Commit 数、版本号、日活指标（取整）

## 截图技巧

1. 使用 `test/data/` 下 `ENB_9999` 风格的**合成测试数据**
2. 或使用[在线交互演示](https://lanshenghai.github.io/UP-Analyzer-showcase/) — 零专有内容
3. 标题栏若显示内部主机名，请打码
4. 录屏时裁掉邮件/IM 通知
5. OBS 使用 **1080p** 画布；UI 缩放 125% 便于阅读

## 视频专项

- 旁白：说「某 5G 基站产品」，不说厂商名
- 不要录内部 Jira/Pronto 网页
- 若展示 IDE：用通用工作区路径，不要用 `c:\work\UP-Analyzer`
- 终端：`curl localhost:PORT` 使用合成端口号

## 法律说明

生产代码为公司知识产权。本展示仓库仅含：

- 为作品集撰写的原创文档
- 合成演示 HTML
- 脱敏示例报告

**切勿**将 `c:\work\UP-Analyzer\` 中的代码推送到公开 GitHub。
