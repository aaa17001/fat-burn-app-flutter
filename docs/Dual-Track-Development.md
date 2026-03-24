# 双轨开发策略

**制定时间：** 2026-03-24 09:20  
**策略：** 燃脂助手 + 贷款制项目并行

---

## 🎯 双轨开发模式

### 轨道 1：燃脂助手（持续开发）

**状态：** 🔄 进行中（88% 完成）

**待完成：** 9 个支付功能
```
⏳ feat-008-02: 显示订阅选项
⏳ feat-008-03: 显示终身版选项
⏳ feat-008-04: 功能列表显示
⏳ feat-008-05: 终身版功能列表
⏳ feat-008-06: 购买按钮功能
⏳ feat-008-07: Google Play IAP 集成
⏳ feat-008-08: 商品查询和加载
⏳ feat-008-09: 购买流程实现
⏳ feat-008-10: 购买成功处理
```

**预计完成：** 今天 17:00（9 个 Session）

---

### 轨道 2：贷款制项目（试点开发）

**项目：** calculator（房贷计算器）

**状态：** 🔄 Session 1 准备中

**总功能：** 50 个

**预计完成：** 今天 17:00（50 个 Session）

---

## ⚡ 双轨并行执行

### 执行模式

```
时间轴:
09:20-10:00  燃脂助手 Session 5 (feat-008-02)
             calculator Session 1 (feat-001-01) [并行]

10:00-10:45  燃脂助手 Session 6 (feat-008-03)
             calculator Session 2 (feat-001-02) [并行]

10:45-11:30  燃脂助手 Session 7 (feat-008-04)
             calculator Session 3 (feat-001-03) [并行]

...

17:00        燃脂助手完成 (100%)
             calculator 完成 (100%)
```

---

### Session 调度

**燃脂助手（9 个 Session）：**
```
Session 5:  feat-008-02 (订阅选项显示)
Session 6:  feat-008-03 (终身版选项显示)
Session 7:  feat-008-04 (功能列表显示)
Session 8:  feat-008-05 (终身版功能列表)
Session 9:  feat-008-06 (购买按钮功能)
Session 10: feat-008-07 (IAP 集成)
Session 11: feat-008-08 (商品查询)
Session 12: feat-008-09 (购买流程)
Session 13: feat-008-10 (购买处理)

预计：9 Session × 30 分钟 = 4.5 小时
```

**calculator（50 个 Session）：**
```
批量 1: feat-001-01 ~ 001-10 (核心功能)
批量 2: feat-002-01 ~ 002-10 (UI 功能)
批量 3: feat-003-01 ~ 003-10 (支付功能)
批量 4: feat-004-01 ~ 004-10 (计算器功能)
批量 5: feat-005-01 ~ 005-10 (特定功能)

预计：50 Session × 30 分钟 = 25 小时
```

---

## 📊 时间分配

### 方案 A：交替执行

```
09:20-10:00  燃脂助手 Session 5
10:00-10:45  calculator Session 1
10:45-11:30  燃脂助手 Session 6
11:30-12:15  calculator Session 2
...

优势：
✅ 两个项目都有进展
✅ 避免单一任务疲劳
✅ 及时发现和解决问题
```

### 方案 B：批量执行

```
09:20-14:00  燃脂助手 9 个 Session (批量完成)
14:00-次日   calculator 50 个 Session (批量完成)

优势：
✅ 专注单一项目
✅ 上下文切换少
✅ 燃脂助手优先完成
```

---

## 🎯 推荐方案

### 推荐：方案 A（交替执行）

**理由：**
```
✅ 燃脂助手优先（88% → 100%）
✅ calculator 同时开始（0% → 进展中）
✅ 两个项目都有进展
✅ 及时记录 calculator 开发经验
✅ 为后续 4 个项目积累经验
```

**执行计划：**
```
上午 (09:20-12:00):
├── 燃脂助手 Session 5-7 (3 个)
└── calculator Session 1-3 (3 个)

下午 (14:00-18:00):
├── 燃脂助手 Session 8-13 (6 个) ✅ 完成
└── calculator Session 4-10 (7 个)

晚上 (19:00-次日):
└── calculator Session 11-50 (40 个) ✅ 完成
```

---

## 📋 立即执行

### 第一步：启动燃脂助手 Session 5

```bash
cd /home/lh/.openclaw/workspace/fat-burn-app-flutter
./scripts/opencode-session.sh

# 自动选择：feat-008-02 - 显示订阅选项
```

### 第二步：启动 calculator Session 1

```bash
cd /home/lh/.openclaw/workspace/fat-burn-app-flutter/apps/calculator
../../scripts/opencode-session.sh

# 自动选择：feat-001-01 - 应用启动
```

### 第三步：交替执行

```
燃脂助手 Session 完成后 → calculator Session
calculator Session 完成后 → 燃脂助手 Session
...
```

---

## 📈 预期效果

### 燃脂助手

**当前：** 88% (68/77)  
**今日目标：** 100% (77/77)  
**预计完成：** 今天 18:00

### calculator

**当前：** 0% (0/50)  
**今日目标：** 20% (10/50)  
**预计完成：** 次日 10:00

### 经验积累

**每个 calculator Session 记录：**
```
✅ 开发时间
✅ 遇到的问题
✅ 解决方案
✅ 流程优化建议
✅ 可复用代码
```

**每日复盘：**
```
✅ 燃脂助手完成总结
✅ calculator 开发经验
✅ 流程优化清单
✅ 下一步改进计划
```

---

## 🎊 总结

### 双轨开发策略

```
轨道 1: 燃脂助手 (优先完成)
轨道 2: calculator (积累经验)

执行模式：交替执行
目标：燃脂助手 100% + calculator 20%
```

### 关键要点

```
✅ 燃脂助手优先（今天完成）
✅ calculator 同时开始（积累经验）
✅ 交替执行（避免疲劳）
✅ 记录经验（为后续项目）
✅ 流程优化（持续改进）
```

---

**准备好开始双轨开发了吗？** 🚀
