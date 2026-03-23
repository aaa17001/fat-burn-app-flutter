# OpenCode 快速启动指南

## ✅ 配置完成

**API 配置：**
- 提供商：Bailian (阿里云百炼)
- API 密钥：sk-1904184044234598
- 默认模型：qwen3.5-plus (通义千问)

---

## 🚀 启动方式

### 方式 1: TUI 模式（推荐）

```bash
# 进入项目目录
cd /home/lh/.openclaw/workspace/fat-burn-app-flutter

# 启动 OpenCode
opencode
```

### 方式 2: 命令行模式

```bash
# 运行单个任务
opencode run "实现运动计时功能"

# 指定项目目录
opencode run -p /home/lh/.openclaw/workspace/fat-burn-app-flutter "实现运动计时功能"
```

### 方式 3: Web 模式

```bash
# 启动 Web 界面
opencode web
```

---

## 📋 第一个开发任务

### 任务：实现运动计时功能

**步骤 1: 启动 OpenCode**
```bash
cd /home/lh/.openclaw/workspace/fat-burn-app-flutter
opencode
```

**步骤 2: 输入任务**
```
实现运动计时功能

需求:
- 开始/停止/重置按钮
- 实时显示时长 (MM:SS)
- 实时计算消耗卡路里
- 使用 Provider 状态管理
- 遵循现有代码风格

参考文档:
- .agents/pm/task-board.md
- .agents/research/data-sources.md
- .agents/architecture/task-001-design.md
```

**步骤 3: 使用计划模式**
```
1. 按 Tab 切换到计划模式
2. OpenCode 会先制定实现计划
3. 审查计划
4. 按 Tab 切换到构建模式
5. 开始实施
```

**步骤 4: 验收代码**
```
OpenCode 完成后:
1. 检查生成的代码
2. 运行测试
3. 确认功能正常
4. 提交代码
```

---

## 💡 使用技巧

### 1. 计划模式（推荐）

```
按 Tab 切换到计划模式

优势:
- 先制定计划再实施
- 可以审查和修改计划
- 减少错误和返工
```

### 2. 引用文件

```
使用 @ 引用文件:
@lib/screens/home_screen.dart
@lib/providers/timer_provider.dart

让 OpenCode 理解上下文
```

### 3. 撤销修改

```
/undo  - 撤销上一步修改
/redo  - 重做上一步修改
```

### 4. 分享对话

```
/share - 生成对话链接
可以分享给团队查看
```

### 5. 使用规则

```
配置中的规则会自动应用:
- 使用中文交流
- 代码注释使用中文
- 遵循 Flutter 最佳实践
- 所有数据必须有科学依据
```

---

## 🔧 常用命令

### MCP 服务器管理

```bash
# 查看已安装的 MCP
opencode mcp list

# 安装 MCP
opencode mcp install @modelcontextprotocol/server-filesystem
opencode mcp install @modelcontextprotocol/server-git

# 卸载 MCP
opencode mcp uninstall @modelcontextprotocol/server-filesystem
```

### Provider 管理

```bash
# 查看 Provider
opencode providers

# 添加 Provider
opencode providers add

# 切换默认 Provider
opencode providers default bailian
```

### 调试工具

```bash
# 调试模式
opencode debug

# 查看日志
opencode debug logs

# 检查配置
opencode debug config
```

---

## 📊 项目结构

```
fat-burn-app-flutter/
├── .agents/                    # Agent 工作区
│   ├── pm/                     # PM 工作区
│   ├── research/               # 研究工作区
│   ├── architecture/           # 架构工作区
│   └── test/                   # 测试工作区
│
├── .opencode/                  # OpenCode 工作区
│   ├── tasks/                  # 开发任务
│   ├── sessions/               # 会话记录
│   └── output/                 # 代码输出
│
├── lib/                        # Flutter 代码
│   ├── screens/
│   ├── widgets/
│   └── providers/
│
└── PROJECT-PLAN.md             # 项目规划
```

---

## 🎯 开发流程

### 标准流程

```
1. PM (我) 创建任务
   ↓
   文件：.opencode/tasks/task-001.md

2. Research (我) 提供数据
   ↓
   文件：.agents/research/data-sources.md

3. Architecture (我) 提供方案
   ↓
   文件：.agents/architecture/task-001-design.md

4. 调用 OpenCode 执行
   ↓
   opencode /path/to/project

5. OpenCode 开发
   ↓
   输出：.opencode/output/

6. Test (我) 验收
   ↓
   文件：.agents/test/task-001-report.md
```

---

## 📞 故障排除

### 问题 1: API 密钥错误

```
错误：Invalid API key

解决:
1. 检查 ~/.opencode/config.json
2. 确认 API 密钥正确
3. 确认 API 密钥有足够余额
```

### 问题 2: 模型不可用

```
错误：Model not available

解决:
1. 检查模型名称是否正确
2. 确认模型在 Bailian 平台可用
3. 尝试切换模型
```

### 问题 3: MCP 安装失败

```
错误：Failed to install MCP

解决:
1. 检查网络连接
2. 检查 npm 权限
3. 手动安装：
   npm install -g @modelcontextprotocol/server-filesystem
```

---

## 🎊 准备就绪！

**配置完成，可以开始开发了！**

**下一步：**
1. ✅ 启动第一个开发任务
2. ✅ 实现运动计时功能
3. ✅ 开始 Multi-Agent 协作

**启动命令：**
```bash
cd /home/lh/.openclaw/workspace/fat-burn-app-flutter
opencode
```

**或者：**
```bash
opencode run "实现运动计时功能"
```

---

**准备好开始了吗？** 🚀
