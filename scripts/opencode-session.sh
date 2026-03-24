#!/bin/bash

# OpenCode Session 管理脚本
# 基于 Anthropic 长程 Agent 工作流
# 自动选择功能、调用 OpenCode、更新进度

set -e

echo "🚀 OpenCode Session 启动"
echo "================================"
echo ""

# 1. 检查环境
if [ ! -f ".long-run/feature-list.json" ]; then
    echo "❌ 功能清单不存在：.long-run/feature-list.json"
    exit 1
fi

if [ ! -f ".long-run/progress.md" ]; then
    echo "❌ 进度日志不存在：.long-run/progress.md"
    exit 1
fi

echo "✅ 环境检查通过"
echo ""

# 2. 读取下一个待完成功能
echo "📋 读取下一个功能..."
NEXT_FEATURE=$(jq -r '.features[] | select(.passes == false) | .id' .long-run/feature-list.json | head -1)

if [ -z "$NEXT_FEATURE" ]; then
    echo "✅ 所有功能已完成！"
    exit 0
fi

echo "✅ 下一个功能：$NEXT_FEATURE"
echo ""

# 3. 读取功能详情
echo "📖 读取功能详情..."
FEATURE_DESC=$(jq -r ".features[] | select(.id == \"$NEXT_FEATURE\") | .description" .long-run/feature-list.json)
FEATURE_CATEGORY=$(jq -r ".features[] | select(.id == \"$NEXT_FEATURE\") | .category" .long-run/feature-list.json)
FEATURE_PRIORITY=$(jq -r ".features[] | select(.id == \"$NEXT_FEATURE\") | .priority" .long-run/feature-list.json)

# 读取步骤
STEPS=$(jq -r ".features[] | select(.id == \"$NEXT_FEATURE\") | .steps[]" .long-run/feature-list.json)

# 读取验收标准
CRITERIA=$(jq -r ".features[] | select(.id == \"$NEXT_FEATURE\") | .acceptanceCriteria[]" .long-run/feature-list.json)

echo "✅ 功能描述：$FEATURE_DESC"
echo "✅ 分类：$FEATURE_CATEGORY"
echo "✅ 优先级：$FEATURE_PRIORITY"
echo ""

# 4. 构建 OpenCode 提示词
echo "📝 构建 OpenCode 提示词..."

PROMPT="实现 $NEXT_FEATURE - $FEATURE_DESC

**项目：** 燃脂助手 FatBurn Coach
**当前进度：** $(grep -c '"passes": true' .long-run/feature-list.json)/$(grep -c '"id":' .long-run/feature-list.json) 功能完成

**需求:**
$STEPS

**验收标准:**
$CRITERIA

**约束:**
- 只实现这个功能，不要做其他功能
- 遵循 Flutter 最佳实践
- 代码注释使用中文
- 完成后运行测试
- 确保代码清洁

**下一步:**
1. 实现功能
2. 运行测试 (flutter test)
3. 提交 git
4. 更新 .long-run/feature-list.json 标记 $NEXT_FEATURE passes: true"

echo "✅ 提示词构建完成"
echo ""

# 5. 显示 Session 信息
echo "================================"
echo "📊 Session 信息"
echo "================================"
echo "功能 ID: $NEXT_FEATURE"
echo "功能描述：$FEATURE_DESC"
echo "优先级：$FEATURE_PRIORITY"
echo "预计时间：30-45 分钟"
echo "================================"
echo ""

# 6. 运行 OpenCode
echo "🤖 启动 OpenCode 开发..."
echo ""
echo "提示词:"
echo "$PROMPT"
echo ""
echo "================================"
echo "请复制以上提示词到 OpenCode:"
echo ""
echo "  cd /home/lh/.openclaw/workspace/fat-burn-app-flutter"
echo "  opencode"
echo ""
echo "然后粘贴提示词开始开发"
echo "================================"
echo ""
read -p "按回车键继续..."

# 7. 运行测试
echo "🧪 运行测试..."
flutter test
flutter test integration_test/
echo "✅ 测试完成"
echo ""

# 8. 提交代码
echo "📦 提交代码..."
git add -A
git commit -m "feat: 完成 $NEXT_FEATURE - $FEATURE_DESC"
echo "✅ 代码已提交"
echo ""

# 9. 更新进度
echo "📊 更新进度..."

# 获取当前时间
CURRENT_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# 更新 feature-list.json
jq "(.features[] | select(.id == \"$NEXT_FEATURE\")).passes = true" .long-run/feature-list.json > .long-run/feature-list.json.tmp
jq "(.features[] | select(.id == \"$NEXT_FEATURE\")).completedAt = \"$CURRENT_TIME\"" .long-run/feature-list.json.tmp > .long-run/feature-list.json.tmp2
jq "(.features[] | select(.id == \"$NEXT_FEATURE\")).sessionId = \"session-$(date +%Y%m%d-%H%M)\"" .long-run/feature-list.json.tmp2 > .long-run/feature-list.json

rm -f .long-run/feature-list.json.tmp .long-run/feature-list.json.tmp2

echo "✅ 进度已更新"
echo ""

# 10. 显示进度
COMPLETED=$(grep -c '"passes": true' .long-run/feature-list.json)
TOTAL=$(grep -c '"id":' .long-run/feature-list.json)
PERCENT=$((COMPLETED * 100 / TOTAL))

echo "================================"
echo "📊 进度更新"
echo "================================"
echo "功能：$NEXT_FEATURE ✅"
echo "进度：$COMPLETED/$TOTAL ($PERCENT%)"
echo "================================"
echo ""

# 11. 显示下一个功能
echo "📋 下一个功能:"
NEXT_NEXT=$(jq -r '.features[] | select(.passes == false) | .id' .long-run/feature-list.json | head -1)
if [ -n "$NEXT_NEXT" ]; then
    NEXT_DESC=$(jq -r ".features[] | select(.id == \"$NEXT_NEXT\") | .description" .long-run/feature-list.json)
    echo "$NEXT_NEXT - $NEXT_DESC"
else
    echo "🎉 所有功能已完成！"
fi
echo ""

echo "✅ Session 完成！"
echo ""
echo "下一步:"
echo "1. 运行 ./scripts/opencode-session.sh 继续下一个功能"
echo "2. 或手动开始下一个 Session"
echo ""
