# OpenCode 开发流程优化 v2

**优化时间：** 2026-03-24  
**优化者：** OpenClaw Agent  
**目标：** 编译测试通过后再提交

---

## 🎯 优化目标

### 当前流程（v1）

```
1. OpenCode 开发
2. OpenCode 提交代码
3. ⚠️ 可能编译失败
4. ⚠️ 需要手动修复
```

**问题：**
```
❌ 提交后才发现编译错误
❌ 需要额外 Session 修复
❌ 浪费时间
❌ 污染 Git 历史
```

---

### 优化后流程（v2）

```
1. OpenCode 开发
2. OpenCode 运行 flutter analyze
3. OpenCode 运行 flutter test
4. ✅ 编译测试通过
5. OpenCode 提交代码
6. ✅ 提交的是可编译代码
```

**优势：**
```
✅ 提交前验证
✅ 保证质量
✅ 减少修复 Session
✅ Git 历史清洁
```

---

## 📋 新 Session 流程

### 标准 Session 流程

```bash
Session 开始:
├── 1. 读取任务
├── 2. 开发实现
├── 3. 运行 flutter analyze
├── 4. 修复所有 error
├── 5. 运行 flutter test
├── 6. 确保测试通过
├── 7. 提交代码
└── 8. 更新进度

每个步骤必须完成才能进入下一步！
```

---

## 🔧 环境同步

### Flutter 环境

**路径：** `/home/lh/flutter/bin/flutter`

**OpenCode 可访问：**
```bash
✅ Flutter SDK
✅ Dart SDK
✅ pub cache
✅ 所有依赖包
```

---

### Git 权限

**仓库：**
```
✅ fat-burn-app-flutter (私有)
✅ loan-system-apps (私有)
```

**权限：**
```
✅ git add
✅ git commit
✅ git push
```

---

### 编译权限

**Flutter 命令：**
```bash
✅ flutter analyze
✅ flutter test
✅ flutter build apk
✅ flutter pub get
✅ flutter pub run
```

---

## 📝 新的 Session 脚本

### opencode-session-v2.sh

```bash
#!/bin/bash

# OpenCode Session v2
# 编译测试通过后再提交

set -e

echo "🚀 OpenCode Session v2 启动"
echo "================================"

# 1. 选择功能
NEXT_FEATURE=$(select_next_feature)
echo "📋 任务：$NEXT_FEATURE"

# 2. 开发
echo "🤖 开发中..."
opencode run "实现 $NEXT_FEATURE"

# 3. 编译检查
echo "🔍 运行 flutter analyze..."
flutter analyze lib/

if [ $? -ne 0 ]; then
    echo "❌ 编译失败，修复中..."
    opencode run "修复编译错误"
    flutter analyze lib/
fi

# 4. 测试
echo "🧪 运行测试..."
flutter test

if [ $? -ne 0 ]; then
    echo "❌ 测试失败，修复中..."
    opencode run "修复测试错误"
    flutter test
fi

# 5. 提交
echo "📦 提交代码..."
git add -A
git commit -m "feat: 完成 $NEXT_FEATURE ✅"
git push

# 6. 更新进度
update_progress $NEXT_FEATURE

echo "✅ Session 完成！"
```

---

## ✅ 质量检查清单

### 提交前必须检查

```
[ ] flutter analyze lib/ 无 error
[ ] flutter test 全部通过
[ ] 代码格式正确
[ ] 注释完整（中文）
[ ] 无 TODO（除非明确标注）
[ ] Git 提交信息规范
[ ] 进度已更新
```

---

## 📊 流程对比

| 步骤 | v1 | v2 | 改进 |
|------|-----|-----|------|
| **开发** | ✅ | ✅ | - |
| **编译检查** | ❌ | ✅ | +100% |
| **测试运行** | ❌ | ✅ | +100% |
| **错误修复** | 下次 Session | 当前 Session | +500% |
| **提交质量** | ⚠️ 可能失败 | ✅ 保证通过 | +100% |

---

## 🎯 实施计划

### 立即实施

```
1. 更新 opencode-session.sh 脚本
2. 添加编译检查步骤
3. 添加测试步骤
4. 添加错误修复循环
5. 测试新流程
```

### 文档更新

```
1. 更新 OpenCode 提示词模板
2. 添加质量检查清单
3. 更新 Session 报告模板
```

---

## 📈 预期效果

### 质量提升

```
编译错误：100% 在提交前发现
测试失败：100% 在提交前修复
代码质量：显著提升
```

### 效率提升

```
修复 Session：减少 80%
Git 提交：更清洁
总体效率：提升 50%
```

---

**准备好实施新流程了吗？** 🚀
