# Multi-Agent + OpenCode 协作架构

## 🤖 智能体角色清晰划分

### 第一类：我的智能体团队（OpenClaw Multi-Agent）

这些是**我（OpenClaw Agent）扮演或协调的智能体**：

| 智能体 | 实际执行者 | 职责 |
|--------|----------|------|
| **PM Agent** | 我（OpenClaw） | 项目管理、任务分配、进度跟踪 |
| **Research Agent** | 我（OpenClaw） | 研究权威数据、查找论文 |
| **Architecture Agent** | 我（OpenClaw） | 架构设计、技术选型 |
| **Test Agent** | 我（OpenClaw） | 测试计划、质量审核 |
| **Deploy Agent** | 我（OpenClaw） | 发布计划、部署策略 |
| **Analytics Agent** | 我（OpenClaw） | 数据分析、报告生成 |

**关键点：**
- ✅ 这些智能体**都是我**（OpenClaw Agent）
- ✅ 我通过**切换角色**来执行不同任务
- ✅ 我负责**规划、审核、验收**
- ✅ 我**不写代码**，我**管理**

---

### 第二类：OpenCode（外部 AI 编码工具）

**OpenCode 是独立的 AI 编码工具**，不是我的智能体：

| 属性 | 说明 |
|------|------|
| **角色** | 高级开发工程师 |
| **职责** | 代码实现、单元测试 |
| **能力** | Flutter 开发、代码生成 |
| **定位** | 执行者，不是决策者 |

**关键点：**
- ✅ OpenCode **独立运行**
- ✅ OpenCode **负责写代码**
- ✅ OpenCode **不听命于我的智能体**
- ✅ OpenCode **直接对你负责**

---

## 📊 完整架构图

```
┌─────────────────────────────────────────────────────────┐
│                      你 (用户)                           │
│                   最终决策者                             │
└─────────────────────────────────────────────────────────┘
                          ↑ ↓
┌─────────────────────────────────────────────────────────┐
│              我 (OpenClaw Agent) - PM                    │
│                   项目管理者                             │
│  ┌─────────────────────────────────────────────────┐   │
│  │  智能体角色（我切换扮演）：                        │   │
│  │  • PM Agent      - 项目管理                       │   │
│  │  • Research Agent - 研究分析                      │   │
│  │  • Architecture Agent - 架构设计                  │   │
│  │  • Test Agent      - 测试审核                     │   │
│  │  • Deploy Agent    - 发布策略                     │   │
│  │  • Analytics Agent - 数据分析                     │   │
│  └─────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
                          ↑ ↓ 任务分配 + 验收
┌─────────────────────────────────────────────────────────┐
│              OpenCode (独立 AI 编码工具)                  │
│                   代码执行者                             │
│  ┌─────────────────────────────────────────────────┐   │
│  │  能力：                                          │   │
│  │  • Flutter 开发                                  │   │
│  │  • 代码生成                                      │   │
│  │  • 单元测试                                      │   │
│  │  • Bug 修复                                       │   │
│  └─────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
```

---

## 🔄 信息同步机制

### 核心原则：文件即接口

```
所有智能体（包括 OpenCode）通过文件交换信息
```

### 文件结构

```
fat-burn-app-flutter/
├── .agents/                    # Agent 工作区
│   ├── pm/                     # PM Agent 工作区
│   │   ├── project-plan.md     # 项目计划
│   │   ├── task-board.md       # 任务看板
│   │   └── meeting-notes.md    # 会议记录
│   ├── research/               # Research Agent 工作区
│   │   ├── data-sources.md     # 数据来源
│   │   ├── papers/             # 论文 PDF
│   │   └── research-report.md  # 研究报告
│   ├── architecture/           # Architecture Agent 工作区
│   │   ├── tech-stack.md       # 技术选型
│   │   ├── system-design.md    # 系统设计
│   │   └── api-docs.md         # API 文档
│   └── test/                   # Test Agent 工作区
│       ├── test-plan.md        # 测试计划
│       ├── bug-report.md       # Bug 报告
│       └── quality-report.md   # 质量报告
│
├── .opencode/                  # OpenCode 工作区
│   ├── tasks/                  # 开发任务
│   │   ├── task-001.md         # 任务 1：运动计时
│   │   ├── task-002.md         # 任务 2：数据追踪
│   │   └── ...
│   ├── sessions/               # 开发会话记录
│   │   ├── session-001.md      # 会话 1 记录
│   │   └── ...
│   └── output/                 # 代码输出
│       ├── generated/          # 生成的代码
│       └── tests/              # 生成的测试
│
└── lib/                        # 实际代码
    ├── screens/
    ├── widgets/
    └── ...
```

---

## 📋 工作流程示例

### 示例：开发"运动计时"功能

#### 步骤 1: PM Agent（我）制定任务

```
文件：.agents/pm/task-board.md

## 待开发任务

### Task 001: 运动计时功能
优先级：P0
负责人：OpenCode
状态：待开始

需求描述:
- 实现运动计时器
- 开始/停止/重置按钮
- 实时显示时长 (MM:SS)
- 实时计算消耗卡路里
- 使用 Provider 状态管理

验收标准:
- [ ] 计时准确
- [ ] UI 流畅
- [ ] 单元测试通过
- [ ] 代码审查通过

科学依据:
- 卡路里计算基于 MET 值
- 来源：PubMed ID: XXXXX
```

#### 步骤 2: Research Agent（我）提供数据

```
文件：.agents/research/data-sources.md

## 卡路里计算公式

公式:
卡路里 = MET × 体重 (kg) × 时间 (小时)

MET 值来源:
- 快走：4.0 MET (PubMed ID: 12345)
- 爬坡走：8.0 MET (PubMed ID: 67890)
- 慢跑：8.0 MET (PubMed ID: 11111)

验证状态: ✅ 已验证
```

#### 步骤 3: Architecture Agent（我）提供技术方案

```
文件：.agents/architecture/task-001-design.md

## Task 001: 运动计时功能 - 技术方案

### 技术选型
- 状态管理：Provider
- 定时器：Timer.periodic
- UI 组件：Material Design

### 文件结构
lib/
├── screens/
│   └── exercise_timer_screen.dart
├── providers/
│   └── timer_provider.dart
└── utils/
    └── calorie_calculator.dart

### 接口定义
class TimerProvider {
  void start();
  void stop();
  void reset();
  Duration get elapsed;
  int get calories;
}
```

#### 步骤 4: 调用 OpenCode 执行开发

```bash
# 我（PM）调用 OpenCode
opencode /home/lh/.openclaw/workspace/fat-burn-app-flutter

# 输入任务
"实现运动计时功能

参考文档:
- 需求：.agents/pm/task-board.md
- 数据：.agents/research/data-sources.md
- 设计：.agents/architecture/task-001-design.md

要求:
- 按照技术方案实现
- 使用提供的 MET 值数据
- 编写单元测试
- 遵循现有代码风格"
```

#### 步骤 5: OpenCode 开发并输出

```
OpenCode 工作区：.opencode/output/

生成的文件:
├── lib/screens/exercise_timer_screen.dart
├── lib/providers/timer_provider.dart
├── lib/utils/calorie_calculator.dart
└── test/timer_test.dart
```

#### 步骤 6: Test Agent（我）审核验收

```
文件：.agents/test/quality-report.md

## Task 001 质量报告

### 代码审查
- [✅] 代码规范
- [✅] 状态管理正确
- [✅] 定时器释放
- [✅] 错误处理

### 测试覆盖
- [✅] 单元测试通过
- [✅] 覆盖率 85%
- [✅] 边界条件测试

### 数据准确性
- [✅] MET 值使用正确
- [✅] 计算公式准确
- [✅] 来源可查

### 验收结果：✅ 通过
```

---

## 🔌 同步机制详解

### 机制 1: 文件监控

```
所有智能体监控特定目录的文件变化

我（OpenClaw）监控:
- .agents/ 所有文件
- .opencode/tasks/ 任务文件
- lib/ 代码文件

OpenCode 监控:
- .opencode/tasks/ 任务文件
- .agents/architecture/ 技术文档
- lib/ 代码文件
```

### 机制 2: 任务状态机

```
文件：.agents/pm/task-board.md

任务状态流转:
待开始 → 进行中 → 待审核 → 已完成
   ↑         ↑         ↑
   │         │         │
 PM 分配   OpenCode  Test 审核
          开始开发
```

### 机制 3: 会话记录

```
文件：.opencode/sessions/session-001.md

## 会话记录

时间：2026-03-23 11:00
任务：Task 001 - 运动计时功能
参与：OpenCode

对话摘要:
11:00 - 开始任务
11:05 - 完成技术方案理解
11:10 - 开始编写代码
11:30 - 完成代码实现
11:35 - 完成单元测试
11:40 - 提交审核

输出文件:
- lib/screens/exercise_timer_screen.dart
- lib/providers/timer_provider.dart
- test/timer_test.dart

状态：待审核
```

### 机制 4: 变更通知

```
当代码变更时，OpenCode 自动更新:

文件：.opencode/output/CHANGELOG.md

## 2026-03-23 变更

### 新增文件
- lib/screens/exercise_timer_screen.dart
- lib/providers/timer_provider.dart

### 修改文件
- lib/main.dart (添加路由)

### 删除文件
- (无)

### 关联任务
- Task 001: 运动计时功能
```

---

## 📞 沟通协议

### PM → OpenCode（任务分配）

```markdown
文件：.opencode/tasks/task-001.md

# Task 001: 运动计时功能

## 状态
- 优先级：P0
- 负责人：OpenCode
- 截止日期：2026-03-25
- 状态：进行中

## 需求
[需求描述]

## 参考文档
- [技术方案](../../.agents/architecture/task-001-design.md)
- [数据来源](../../.agents/research/data-sources.md)

## 验收标准
- [ ] 功能完整
- [ ] 测试通过
- [ ] 代码审查通过

## 输出要求
- 代码位置：lib/screens/
- 测试位置：test/
- 文档位置：.opencode/output/
```

### OpenCode → PM（进度汇报）

```markdown
文件：.opencode/sessions/session-001.md

# 进度汇报

## Task 001

### 完成度：80%

### 已完成
- [✅] UI 页面实现
- [✅] 计时逻辑实现
- [✅] 卡路里计算实现

### 进行中
- [🔄] 单元测试编写 (70%)

### 待完成
- [⏳] 集成测试
- [⏳] 代码优化

### 问题/阻碍
- 无

### 预计完成
- 2026-03-24 15:00
```

### Test Agent → PM（验收报告）

```markdown
文件：.agents/test/task-001-report.md

# Task 001 验收报告

## 测试结果

### 单元测试
- 通过率：100%
- 覆盖率：85%

### 集成测试
- 通过率：100%
- 流程：通顺

### 性能测试
- 启动时间：<1 秒
- 内存占用：<50MB

## 问题列表

### P0 (严重)
- 无

### P1 (重要)
- 无

### P2 (建议)
- 建议添加加载动画

## 验收结论
✅ 通过 (P2 问题后续优化)
```

---

## 🎯 关键设计原则

### 1. 职责分离

```
我（OpenClaw）:
✅ 规划
✅ 审核
✅ 验收
❌ 不写代码

OpenCode:
✅ 写代码
✅ 写测试
✅ 修复 Bug
❌ 不做决策
```

### 2. 文件即接口

```
所有沟通通过文件
所有状态记录在文件
所有变更追踪在文件
```

### 3. 可追溯性

```
每个任务有记录
每个变更有文档
每个决策有依据
```

### 4. 自动化优先

```
能自动的自动
能检查的检查
能验证的验证
```

---

## 🚀 实际操作示例

### 启动 Multi-Agent 开发

```bash
# 1. 我（PM）创建任务
cat > .opencode/tasks/task-001.md << 'EOF'
# Task 001: 运动计时功能
[任务详情]
EOF

# 2. 我（Research）提供数据
cat > .agents/research/data-sources.md << 'EOF'
# 数据来源
[MET 值和公式]
EOF

# 3. 我（Architecture）提供方案
cat > .agents/architecture/task-001-design.md << 'EOF'
# 技术方案
[技术设计]
EOF

# 4. 调用 OpenCode
opencode /home/lh/.openclaw/workspace/fat-burn-app-flutter

# 5. OpenCode 开发
# (在 OpenCode 中输入任务)

# 6. 我（Test）验收
cat > .agents/test/task-001-report.md << 'EOF'
# 验收报告
[测试结果]
EOF
```

---

## 📊 总结

| 问题 | 答案 |
|------|------|
| **哪些是我的智能体？** | PM/Research/Architecture/Test/Deploy/Analytics - 都是我扮演 |
| **OpenCode 是什么？** | 独立的 AI 编码工具，负责写代码 |
| **如何同步信息？** | 通过文件系统和文档 |
| **谁做决策？** | 我（OpenClaw）做决策，OpenCode 执行 |
| **如何保证质量？** | 我审核验收，Test Agent 测试 |

**核心：**
> **我掌控全局 + OpenCode 专业执行 + 文件同步信息**

---

**明白了吗？还有什么疑问？** 🚀
