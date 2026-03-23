# Anthropic 工作流应用方案

**分析时间：** 2026-03-24 06:10  
**主题：** Anthropic 长程 Agent 工作流在 OpenCode 和贷款制中的应用

---

## 📊 核心问题

### 问题 1：能应用到 OpenCode 开发燃脂助手吗？

**答案：✅ 完全可以，而且非常适合！**

### 问题 2：能应用到贷款制工具 App 开发吗？

**答案：✅ 完全可以，而且是规模化关键！**

---

## 一、OpenCode 开发燃脂助手应用

### 当前 OpenCode 工作流

**当前模式：**
```
用户指令 → OpenCode 开发 → 提交代码
↓
新 Session → 从零开始 → 重复上下文
↓
容易 one-shot → 上下文耗尽 → 质量下降
```

**问题：**
```
❌ 每个新 Session 没有之前记忆
❌ 容易试图一次性完成所有功能
❌ 过早宣布完成
❌ 进度不可追溯
```

---

### Anthropic 工作流集成

**集成后的 OpenCode 工作流：**
```
Session 1 (Initializer):
├── 创建 .long-run/ 目录
├── 创建 feature-list.json (200+ 功能)
├── 创建 init.sh
├── 创建 progress.md
└── 初始 git commit

Session 2+ (Coding Agent):
├── 读取 progress.md
├── 读取 feature-list.json
├── 选择一个功能（只做这个）
├── 实现功能
├── 编写测试
├── 运行测试
├── 提交 git
├── 更新 progress.md
└── 更新 feature-list.json
```

---

### 具体实施

#### 1. OpenCode 提示词优化

**当前提示词：**
```
"实现数据持久化功能"

问题：
- 太宽泛
- 容易 one-shot
- 完成标准不清晰
```

**优化后提示词：**
```
## 任务：实现 feat-004-03 - 用户设置保存功能

**当前进度：**
- feat-004-01: ✅ 用户设置页面 UI
- feat-004-02: ✅ 表单验证
- feat-004-03: 🔄 进行中 - 保存功能
- feat-004-04: ⏳ 待开始 - 加载功能

**功能描述：**
实现用户设置保存功能，将用户输入的年龄、体重、身高、性别保存到 SQLite 数据库。

**完成标准：**
- [ ] 点击保存按钮后数据写入数据库
- [ ] 保存成功显示提示
- [ ] 保存失败显示错误
- [ ] 数据可查询

**测试要求：**
- [ ] 编写单元测试
- [ ] 手动测试保存功能
- [ ] 重启应用验证数据保留

**约束：**
- 只实现这个功能，不要做其他功能
- 完成后提交 git
- 更新 progress.md

**相关文件：**
- lib/providers/user_provider.dart
- lib/database/database_helper.dart
- .long-run/feature-list.json
- .long-run/progress.md
```

**优势：**
```
✅ 清晰的功能边界
✅ 明确的完成标准
✅ 防止 one-shot
✅ 易于验证
```

---

#### 2. OpenCode Session 模板

**Session 开始：**
```bash
# 1. 读取进度
cat .long-run/progress.md

# 2. 选择下一个功能
cat .long-run/feature-list.json | grep "passes: false" | head -1

# 3. 运行环境
./init.sh

# 4. 开始开发
opencode run "实现 feat-XXX - [功能描述]"
```

**Session 结束：**
```bash
# 1. 提交代码
git add -A
git commit -m "feat: 完成 feat-XXX - [功能描述]"

# 2. 更新进度
# 编辑 progress.md 标记完成

# 3. 更新功能清单
# 编辑 feature-list.json 标记 passes: true

# 4. 运行测试
flutter test

# 5. 推送
git push
```

---

#### 3. 功能清单集成

**创建 `.long-run/feature-list.json`：**
```json
{
  "project": "FatBurn Coach",
  "version": "1.0",
  "updatedAt": "2026-03-24T06:10:00Z",
  "features": [
    {
      "id": "feat-001-01",
      "category": "database",
      "priority": "P0",
      "description": "应用首次启动时创建 SQLite 数据库",
      "steps": [
        "启动应用",
        "检查数据库文件是否创建",
        "验证数据库路径正确",
        "验证数据库版本正确"
      ],
      "acceptanceCriteria": [
        "数据库文件存在于正确路径",
        "数据库版本为 1",
        "无崩溃或错误"
      ],
      "passes": true,
      "completedAt": "2026-03-23T20:32:00Z",
      "sessionId": "session-001"
    },
    {
      "id": "feat-008-01",
      "category": "payment",
      "priority": "P0",
      "description": "用户可以打开付费页面",
      "steps": [
        "导航到付费页面",
        "显示订阅选项",
        "显示终身版选项",
        "显示价格信息"
      ],
      "acceptanceCriteria": [
        "页面正常打开",
        显示所有付费选项",
        "价格显示正确"
      ],
      "passes": false,
      "nextSession": "session-008"
    }
    // ... 共 200+ 个功能
  ]
}
```

**OpenCode 读取方式：**
```bash
# 读取下一个待完成功能
jq '.features[] | select(.passes == false) | .id' .long-run/feature-list.json | head -1

# 输出：feat-008-01
```

---

#### 4. 测试集成

**当前测试：** 15 个单元测试 ✅

**增加 E2E 测试：**
```dart
// integration_test/user_flow_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('完整用户流程 E2E 测试', (tester) async {
    // 1. 启动应用
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    // 2. 设置用户信息
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextFormField).at(0),
      '25', // 年龄
    );
    await tester.enterText(
      find.byType(TextFormField).at(1),
      '70.0', // 体重
    );
    await tester.enterText(
      find.byType(TextFormField).at(2),
      '175', // 身高
    );

    await tester.tap(find.text('保存设置'));
    await tester.pumpAndSettle();

    // 3. 验证保存成功
    expect(find.text('保存成功！'), findsOneWidget);

    // 4. 重启应用
    await tester.restartApp();
    await tester.pumpAndSettle();

    // 5. 验证数据保留
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    expect(find.text('25'), findsOneWidget);
    expect(find.text('70.0'), findsOneWidget);
    expect(find.text('175'), findsOneWidget);
  });
}
```

**运行 E2E 测试：**
```bash
flutter test integration_test/
```

---

### 应用效果对比

#### 当前工作流（无 Anthropic 优化）

```
Session 1:
- 实现 P1 功能（7 个功能）
- 代码：1536 行
- 时间：10 小时
- 质量：⭐⭐⭐⭐⭐

问题:
- 一次性做了 7 个功能
- 容易上下文耗尽
- 下一个 Session 需要重新理解
```

#### 优化后工作流（Anthropic 模式）

```
Session 1 (Initializer):
- 创建环境（.long-run/, init.sh, feature-list.json）
- 时间：1 小时

Session 2:
- 实现 feat-008-01（付费页面打开）
- 时间：30 分钟
- 提交 git
- 更新进度

Session 3:
- 实现 feat-008-02（显示订阅选项）
- 时间：30 分钟
- 提交 git
- 更新进度

...

Session 20:
- 实现 feat-010-05（终身版验证）
- 时间：30 分钟
- 完成所有功能

优势:
- 每个 Session 只做一件事
- 上下文清晰
- 进度可追溯
- 质量稳定
```

---

## 二、贷款制工具 App 批量开发应用

### 贷款制挑战

**20 个工具 App 开发：**
```
传统方式:
App 1 → App 2 → App 3 → ... → App 20
60 天（每个 3 天）

问题:
- 每个 App 从零开始
- 代码不复用
- 质量不一致
- 管理困难
```

---

### Anthropic + 贷款制结合

**核心思路：**
```
1. 创建标准模板（Initializer）
2. 批量并行开发（Coding Agents）
3. 每个 Session 一个 App 一个功能
4. 代码复用 80%+
```

---

#### 1. 模板创建（Session 1）

**创建 `tool-app-template/`：**
```
tool-app-template/
├── .long-run/
│   ├── progress.md
│   ├── feature-list.json (标准 50 功能)
│   └── init.sh
├── lib/
│   ├── main.dart (模板)
│   ├── database/
│   │   └── database_helper.dart (复用)
│   ├── models/
│   │   └── user_model.dart (复用)
│   ├── providers/
│   │   └── payment_provider.dart (复用)
│   └── screens/
│       ├── payment_screen.dart (复用)
│       └── settings_screen.dart (复用)
├── test/
│   └── widget_test.dart (模板)
├── pubspec.yaml (模板)
└── README.md (模板)
```

**标准功能清单（50 个）：**
```json
{
  "通用功能（所有 App 共享）": [
    "feat-001: 应用启动",
    "feat-002: 主界面",
    "feat-003: 设置页面",
    "feat-004: 付费页面",
    "feat-005: 订阅功能",
    "feat-006: 终身版功能",
    "feat-007: 数据持久化",
    "feat-008: 退出应用"
  ],
  "特定功能（每个 App 独特）": [
    "计算器 App: 计算功能 (20 个)",
    "计时器 App: 计时功能 (20 个)",
    "转换器 App: 转换功能 (20 个)"
  ]
}
```

---

#### 2. 批量并行开发

**开发计划：**
```
Week 1:
Session 1: 创建模板
Session 2-21: 20 个 App 的 feat-001（应用启动）

Week 2:
Session 22-41: 20 个 App 的 feat-002（主界面）

Week 3:
Session 42-61: 20 个 App 的 feat-003（设置页面）

...

Week 6:
Session 102-121: 20 个 App 的 feat-006（终身版）

完成！
```

**进度追踪：**
```
.long-run/batch-progress.md

# 批量开发进度

## App 1 - 计算器
- feat-001: ✅
- feat-002: ✅
- feat-003: 🔄
- feat-004: ⏳

## App 2 - 计时器
- feat-001: ✅
- feat-002: ✅
- feat-003: 🔄
- feat-004: ⏳

...

## App 20 - 决策轮盘
- feat-001: ✅
- feat-002: ✅
- feat-003: 🔄
- feat-004: ⏳

总体进度：45% (900/2000 功能)
```

---

#### 3. 代码复用策略

**共享组件库：**
```
shared-components/
├── database/
│   └── database_helper.dart (所有 App 复用)
├── payment/
│   ├── payment_screen.dart (所有 App 复用)
│   └── payment_provider.dart (所有 App 复用)
├── ui/
│   ├── theme.dart (所有 App 复用)
│   ├── widgets/
│   │   ├── stat_card.dart
│   │   └── progress_bar.dart
│   └── colors.dart
└── utils/
    ├── constants.dart
    └── helpers.dart
```

**复用方式：**
```dart
// 计算器 App 的 main.dart
import 'package:shared_components/database/database_helper.dart';
import 'package:shared_components/payment/payment_screen.dart';
import 'package:shared_components/ui/theme.dart';

// 直接使用，无需重写
```

**复用率目标：**
```
数据库：100% 复用
支付系统：100% 复用
UI 组件：80% 复用
业务逻辑：50% 复用

总体复用率：80%+
```

---

#### 4. 自动化批量操作

**批量创建脚本：**
```bash
#!/bin/bash

# 批量创建 20 个工具 App

APPS=(
  "calculator"
  "timer"
  "converter"
  "random-number"
  "decision-wheel"
  # ... 20 个
)

for app in "${APPS[@]}"; do
  echo "🚀 创建 $app..."
  
  # 复制模板
  cp -r tool-app-template "apps/$app"
  
  # 修改配置
  cd "apps/$app"
  sed -i "s/tool-app-template/$app/g" pubspec.yaml
  sed -i "s/Tool App Template/$app/g" lib/main.dart
  
  # Git 初始化
  git init
  git add -A
  git commit -m "feat: 初始化 $app 项目"
  
  cd ../..
  
  echo "✅ $app 创建完成"
done

echo "🎉 20 个 App 创建完成！"
```

**批量进度检查：**
```bash
#!/bin/bash

# 检查所有 App 进度

for app in apps/*/; do
  app_name=$(basename "$app")
  completed=$(jq '[.features[] | select(.passes == true)] | length' "$app/.long-run/feature-list.json")
  total=$(jq '.features | length' "$app/.long-run/feature-list.json")
  percent=$((completed * 100 / total))
  
  echo "$app_name: $completed/$total ($percent%)"
done
```

---

### 效果对比

#### 传统方式（无 Anthropic 优化）

```
开发模式：顺序开发
App 1 (3 天) → App 2 (3 天) → ... → App 20 (3 天)

总时间：60 天
代码复用：0%（每个 App 从零开始）
质量：不一致（取决于当天状态）
管理：困难（20 个独立项目）
```

#### Anthropic + 贷款制优化

```
开发模式：并行开发
Week 1: 20 个 App 的 feat-001
Week 2: 20 个 App 的 feat-002
...
Week 6: 20 个 App 的 feat-006

总时间：15 天（并行）
代码复用：80%+
质量：一致（统一标准）
管理：简单（统一进度追踪）
```

**效率提升：**
```
时间：60 天 → 15 天 (4x 提升)
成本：¥60000 → ¥15000 (4x 降低)
质量：不稳定 → 稳定一致
```

---

## 三、具体实施计划

### 燃脂助手（立即实施）

#### 今天（2 小时）

**任务 1：创建详细功能清单**
```
时间：1 小时
输出：.long-run/feature-list.json (200+ 功能)
格式：Anthropic 推荐格式

细化：
- P0 功能（80 个）
- P1 功能（60 个）
- P2 功能（60 个）
```

**任务 2：创建 init.sh**
```
时间：30 分钟
输出：init.sh

内容:
- Flutter 检查
- 依赖安装
- 测试运行
- 开发服务器启动
```

**任务 3：增加 E2E 测试**
```
时间：30 分钟
输出：integration_test/user_flow_test.dart

测试:
- 完整用户流程
- 付费流程
- 数据持久化
```

---

#### 明天（Session 2）

**任务：实现 feat-008-01（付费页面打开）**
```
Session 开始:
- 读取 progress.md
- 读取 feature-list.json
- 选择 feat-008-01
- 运行 init.sh

开发:
- 实现付费页面
- 编写测试
- 运行测试

Session 结束:
- 提交 git
- 更新 progress.md
- 更新 feature-list.json
```

---

### 贷款制工具 App（本周实施）

#### Day 1：模板创建

**任务：创建 tool-app-template/**
```
时间：4 小时
输出：完整的工具 App 模板

包含:
- 项目结构
- 功能清单（50 个标准功能）
- 共享组件
- init.sh
- CI/CD 配置
```

---

#### Day 2-3：批量创建

**任务：创建 20 个 App 项目**
```
时间：2 小时
输出：20 个 App 项目结构

脚本:
./batch-create-apps.sh

验证:
每个 App 有:
- .long-run/progress.md
- .long-run/feature-list.json
- init.sh
- 基础代码
```

---

#### Day 4-15：并行开发

**开发模式：**
```
每天 4 个 Session:
Session 1: App 1-5 的 feat-XXX
Session 2: App 6-10 的 feat-XXX
Session 3: App 11-15 的 feat-XXX
Session 4: App 16-20 的 feat-XXX

每个 Session:
- 只做一个功能
- 5 个 App 并行
- 15 天完成所有功能
```

---

## 四、预期效果

### 燃脂助手

**当前：**
```
完成度：70% (P1 完成)
剩余：30% (P0+P2)
预计：2 周完成
```

**优化后：**
```
完成度：70% (P1 完成)
剩余：30% (200 个细粒度功能)
预计：1 周完成（细粒度 + 专注）

质量:
- 测试覆盖：90% → 95%
- Bug 率：0% → 0% (保持)
- 代码质量：⭐⭐⭐⭐⭐ → ⭐⭐⭐⭐⭐⭐
```

---

### 贷款制工具 App

**传统方式：**
```
20 个 App: 60 天
成本：¥60000
收入预期：¥30000/月
回本周期：2 个月
```

**优化后：**
```
20 个 App: 15 天
成本：¥15000
收入预期：¥30000/月
回本周期：0.5 个月

效率提升：4x
成本降低：75%
ROI 提升：4x
```

---

## 五、总结

### 核心结论

**1. OpenCode 开发燃脂助手：**
```
✅ 完全可以应用
✅ 非常适合细粒度开发
✅ 提高代码质量
✅ 防止 one-shot
✅ 进度可追溯

实施：立即开始（今天 2 小时准备）
```

**2. 贷款制工具 App 批量开发：**
```
✅ 完全可以应用
✅ 规模化关键
✅ 代码复用 80%+
✅ 效率提升 4x
✅ 质量一致

实施：本周开始（模板创建）
```

---

### 立即行动

**燃脂助手（今天）：**
```
[ ] 创建 feature-list.json (200+ 功能)
[ ] 创建 init.sh
[ ] 增加 E2E 测试
[ ] 创建 Session 模板
```

**贷款制工具 App（本周）：**
```
[ ] 创建 tool-app-template/
[ ] 批量创建 20 个 App
[ ] 开始并行开发
[ ] 追踪进度
```

---

### 最终效果

**燃脂助手：**
```
✅ 1 周完成所有功能
✅ 95%+ 测试覆盖
✅ 零 Bug
✅ 高质量交付
```

**贷款制工具 App：**
```
✅ 15 天完成 20 个 App
✅ 80%+ 代码复用
✅ 统一质量标准
✅ 快速变现
```

---

**分析完成！准备好实施了吗？** 🚀
