# OpenCode 环境配置

**配置时间：** 2026-03-24  
**项目：** 燃脂助手 FatBurn Coach

---

## 🎯 环境同步

### Flutter 环境

**Flutter SDK 路径：**
```bash
/home/lh/flutter/bin/flutter
```

**Dart SDK 路径：**
```bash
/home/lh/flutter/bin/dart
```

**版本信息：**
```bash
Flutter 3.16.0
Dart 3.2.0
```

---

### 项目路径

**主项目：**
```bash
/home/lh/.openclaw/workspace/fat-burn-app-flutter
```

**贷款制项目：**
```bash
/home/lh/.openclaw/workspace/loan-system-apps
```

---

### Git 配置

**用户信息：**
```bash
git config --global user.email "lh17001@gmail.com"
git config --global user.name "OpenClaw Agent"
```

**仓库访问：**
```bash
✅ fat-burn-app-flutter (私有)
✅ loan-system-apps (私有)
```

**权限：**
```bash
✅ git add
✅ git commit
✅ git push
✅ git pull
✅ git branch
✅ git merge
```

---

### 编译权限

**Flutter 命令：**
```bash
✅ flutter analyze          # 代码分析
✅ flutter test             # 运行测试
✅ flutter build apk        # 构建 APK
✅ flutter build ios        # 构建 iOS
✅ flutter pub get          # 获取依赖
✅ flutter pub run          # 运行 Dart 程序
✅ flutter clean            # 清理构建
✅ flutter doctor           # 检查环境
```

---

### 环境变量

**PATH：**
```bash
/home/lh/flutter/bin:$PATH
```

**其他变量：**
```bash
PUB_CACHE=/home/lh/.pub-cache
ANDROID_HOME=/home/lh/android-sdk
JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
```

---

## 📋 Session 流程 v2

### 标准流程

```bash
1. 选择功能
   ↓
2. OpenCode 开发
   ↓
3. flutter analyze lib/  ← 新增
   ↓
4. 修复所有 error  ← 新增
   ↓
5. flutter test  ← 新增
   ↓
6. 确保测试通过  ← 新增
   ↓
7. git commit
   ↓
8. git push
   ↓
9. 更新进度
```

---

### 使用脚本

**启动 Session v2：**
```bash
cd /home/lh/.openclaw/workspace/fat-burn-app-flutter
./scripts/opencode-session-v2.sh
```

**脚本功能：**
```
✅ 自动选择下一个功能
✅ 构建 OpenCode 提示词
✅ 运行 flutter analyze
✅ 自动修复编译错误
✅ 运行 flutter test
✅ 自动修复测试错误
✅ 提交代码
✅ 更新进度
```

---

## 🔧 OpenCode 提示词模板

### 标准开发提示词

```
实现 [功能 ID] - [功能描述]

**项目：** 燃脂助手 FatBurn Coach
**Flutter 路径：** /home/lh/flutter/bin/flutter

**需求:**
- 只实现这个功能
- 遵循 Flutter 最佳实践
- 代码注释使用中文

**重要：**
1. 开发完成后必须运行 flutter analyze
2. 修复所有编译错误（error 级别）
3. 运行 flutter test
4. 确保测试通过
5. 然后才能提交代码

**下一步:**
1. 实现功能
2. 运行：/home/lh/flutter/bin/flutter analyze lib/
3. 修复所有 error
4. 运行：/home/lh/flutter/bin/flutter test
5. 确保测试通过
6. 提交 git
7. 更新 .long-run/feature-list.json
```

---

### 错误修复提示词

```
修复以下编译错误：

[错误列表]

**Flutter 路径：** /home/lh/flutter/bin/flutter

**要求:**
1. 修复所有 error 级别错误
2. 运行 flutter analyze lib/ 验证
3. 确保无 error
4. warning 和 info 可以忽略
```

---

## ✅ 质量检查清单

### 提交前检查

```
[ ] flutter analyze lib/ 无 error
[ ] flutter test 全部通过
[ ] 代码格式正确
[ ] 代码注释完整（中文）
[ ] 无 TODO（除非明确标注）
[ ] Git 提交信息规范
[ ] 进度已更新
[ ] 代码已推送到远程仓库
```

---

### 编译标准

**必须通过：**
```bash
flutter analyze lib/
```

**允许：**
- warning（警告）
- info（信息）

**不允许：**
- error（错误）❌

---

### 测试标准

**必须通过：**
```bash
flutter test
```

**要求：**
- 所有测试通过 ✅
- 无失败测试 ❌
- 无超时测试 ❌

---

## 📊 环境验证

### 验证命令

**检查 Flutter：**
```bash
/home/lh/flutter/bin/flutter --version
```

**检查项目：**
```bash
cd /home/lh/.openclaw/workspace/fat-burn-app-flutter
/home/lh/flutter/bin/flutter doctor
```

**检查依赖：**
```bash
/home/lh/flutter/bin/flutter pub get
```

**检查编译：**
```bash
/home/lh/flutter/bin/flutter analyze lib/
```

**检查测试：**
```bash
/home/lh/flutter/bin/flutter test
```

---

## 🎯 最佳实践

### 开发流程

```
1. 小步提交
   - 每个功能一个提交
   - 提交信息清晰

2. 及时验证
   - 开发后立即 analyze
   - 修复后立即 test

3. 质量保证
   - 不提交编译错误
   - 不提交失败测试

4. 文档完整
   - 代码注释
   - 提交信息
   - 进度更新
```

---

### Git 规范

**提交信息格式：**
```
feat: 完成 [功能 ID] - [功能描述] ✅

- 编译检查通过
- 测试通过
- 代码质量符合标准
```

**分支管理：**
```
main: 主分支（稳定）
dev: 开发分支（可选）
feature/*: 功能分支（可选）
```

---

## 🚀 快速开始

### 开始新 Session

```bash
# 1. 进入项目目录
cd /home/lh/.openclaw/workspace/fat-burn-app-flutter

# 2. 启动 Session v2
./scripts/opencode-session-v2.sh

# 3. 按照提示操作
# - 复制提示词到 OpenCode
# - 等待开发完成
# - 自动编译测试
# - 自动提交代码
```

---

### 手动 Session

```bash
# 1. 启动 OpenCode
opencode

# 2. 输入提示词
实现 feat-XXX - [功能描述]

# 3. 开发完成后
/home/lh/flutter/bin/flutter analyze lib/
/home/lh/flutter/bin/flutter test

# 4. 提交代码
git add -A
git commit -m "feat: 完成 feat-XXX"
git push
```

---

## 📁 相关文件

**脚本：**
- `scripts/opencode-session-v2.sh` - Session 管理脚本
- `scripts/opencode-batch.sh` - 批处理脚本
- `scripts/opencode-parallel.sh` - 并行执行脚本

**文档：**
- `docs/OpenCode-Workflow-v2.md` - 工作流程文档
- `docs/OPENCODE-ENV.md` - 环境配置文档（本文件）
- `.long-run/feature-list.json` - 功能清单
- `.long-run/progress.md` - 进度日志

---

## 🎊 总结

**环境已完全同步给 OpenCode：**
```
✅ Flutter SDK
✅ Git 权限
✅ 编译权限
✅ 测试权限
✅ 提交权限
```

**流程已优化：**
```
✅ 编译后提交
✅ 测试后提交
✅ 质量保证
✅ 减少修复 Session
```

**准备好开始高效开发了吗？** 🚀
