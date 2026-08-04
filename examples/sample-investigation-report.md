# 调查报告样例（脱敏）

> 展示分阶段 AI 调查输出格式的合成示例。  
> 基于真实回归工作流；所有标识、厂商名与代码路径均为虚构。

## 1. 问题确认

- **存在** — FDD 小区 CELL-111/112 在 Release R3 升级后 `COUNTER_AVAIL_CH`（信道可用性）下降约 6%；相关 KPI `KPI_5115a` 相应上升。
- **范围：** CELL-111（id 111），CELL-112（id 112）。
- **日志：** OK 构建 `R3.2.1_BLD_000006`；NOK 构建 `R3.2.1_BLD_000004`。

## 2. PM 窗口与量化

**comparisonContext（Stage B）：**

- **windowDuration：** OK 09:15–10:45；NOK 11:30–13:00（各 7×15 分钟区间）
- **steadyState：** 采集开始后排除前 2 个区间
- **loadComparable：** 同一测试线，模拟业务稳定性运行
- **normalization：** 调用跳过候选 — `COUNTER_AVAIL_CH` −5.9% vs `COUNTER_SLOT_CH` −0.05%

| 计数器 | OK | NOK | Δ | 写入函数 |
|--------|---:|---:|---:|----------|
| COUNTER_AVAIL_CH | 568,425,464 | 534,669,170 | −5.94% | `ChannelAvailUpdater::updateBothCounters` |
| COUNTER_USED_CH | 254,691,046 | 259,215,824 | +1.78% | `ChannelUsedUpdater::updateUsed` |
| COUNTER_SLOT_CH | 8,614,918 | 8,610,688 | −0.05% | `SlotCounterUpdater::updateDataSlot` |

## 3. 工作集（Stage A）

- `COUNTER_AVAIL_CH` → ws-avail
- `COUNTER_USED_CH` → ws-used
- `COUNTER_SLOT_CH` → ws-slot
- `KPI_5115a` → ws-kpi

## 4. 调用点交接（Stage C）

**primarySuspectCounter：** `COUNTER_AVAIL_CH`

| entryPath | callSite |
|-----------|----------|
| fd-ul-path | `UlCounterUpdater.cpp:77` |
| scheduler-wrapper | `scheduler/Counters.cpp:58` |
| regular-sched | `scheduler/selection/Counters.cpp:58` |
| initial-access | `scheduler/Msg3Handler.cpp:222` |

均为 `pm-only`；`invocationCount: open`。

## 5. 机制（Stage D）

| 字段 | 值 |
|------|-----|
| subtype | `invocation gap`（调用缺口） |
| focus | `behavior-control` |
| disposition | `open` |
| Type-1 | `bodyIdentical: true` on `ChannelAvailUpdater::updateBothCounters` |

**Type-2（blanked）：** `Msg3Armer::hasCommittedMsg3ToArm` — NOK 增加 `actUlSlotAgg()` 门控；`feedsWriterPath: scheduler-msg3`；`coverage: addressed`。

**gitUnlock 候选：** `abc123def456` [CHG-0042] — `Msg3Armer.cpp`

## 6. 对抗式审查（Stage E）

**overall：** `HOLDS`（成立）

关键裁决：OK/NOK 配置标志一致 — NOK 侧 armer 因禁用 slot 聚合提前返回，OK 在 enhancement 标志为真时仍可 arm。

## 7. 结论

| 项目 | 结果 |
|------|------|
| 缺口类型 | 调用缺口（写入路径跳过，非每时隙数值变化） |
| 机制 | NOK 收紧 blanked-slot MSG3 arm 门控 → scheduler-msg3 写入调用减少 |
| 候选 commit | `abc123def456` [CHG-0042] |
| 注意事项 | 未用 Trace 量化 msg3 跳过占 −5.94% 的比例；主 fd 路径未 Trace 量化 |

## 8. 已排除

- 写入方 Type-1 代码变更（git diff 0 行）
- 计算缺口叙事（时隙计数器持平；主路径为 pm-only）
- 主调度语法门控 OK→NOK 变更（调用链 `behaviorDelta=same`）

---

*本报告格式由分阶段调查流水线生成。工作流详见 [ai-investigation.md](../docs/ai-investigation.md)。*
