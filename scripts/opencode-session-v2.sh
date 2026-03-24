#!/bin/bash

# OpenCode Session v2
# 编译测试通过后再提交

set -e

echo "🚀 OpenCode Session v2 启动"
echo "================================"
echo ""

# 配置
FLUTTER="/home/lh/flutter/bin/flutter"
PROJECT_DIR="${1:-.}"

cd "$PROJECT_DIR"

# 1. 选择下一个功能
echo "📋 选择任务..."
NEXT_FEATURE=$($FLUTTER pub run jq -r '.features[] | select(.passes == false) | .id' .long-run/feature-list.json 2>/dev/null | head -1)

if [ -z "$NEXT_FEATURE" ]; then
    echo "✅ 所有功能已完成！"
    exit 0
fi

echo "✅ 下一个功能：$NEXT_FEATURE"
echo ""

# 2. 读取功能详情
echo "📖 读取功能详情..."
FEATURE_DESC=$($FLUTTER pub run jq -r ".features[] | select(.id == \"$NEXT_FEATURE\") | .description" .long-run/feature-list.json 2>/dev/null)
echo "✅ 功能描述：$FEATURE_DESC"
echo ""

# 3. 构建 OpenCode 提示词
echo "📝 构建 OpenCode 提示词..."

PROMPT="实现 $NEXT_FEATURE - $FEATURE_DESC

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
7. 更新 .long-run/feature-list.json 标记 $NEXT_FEATURE passes: true"

echo "✅ 提示词构建完成"
echo ""

# 4. 显示 Session 信息
echo "================================"
echo "📊 Session 信息"
echo "================================"
echo "功能 ID: $NEXT_FEATURE"
echo "功能描述：$FEATURE_DESC"
echo "预计时间：30-45 分钟"
echo "================================"
echo ""

# 5. 运行 OpenCode 开发
echo "🤖 启动 OpenCode 开发..."
echo ""
echo "提示词:"
echo "$PROMPT"
echo ""
echo "================================"
echo "请复制以上提示词到 OpenCode:"
echo ""
echo "  cd $PROJECT_DIR"
echo "  opencode"
echo ""
echo "然后粘贴提示词开始开发"
echo "================================"
echo ""
read -p "按回车键继续（OpenCode 开发完成后）..."

# 6. 编译检查
echo ""
echo "🔍 运行 flutter analyze..."
echo ""

$FLUTTER analyze lib/ 2>&1 | tee /tmp/analyze_output.txt

# 检查是否有 error
if grep -q "^  error" /tmp/analyze_output.txt; then
    echo ""
    echo "❌ 发现编译错误，需要修复！"
    echo ""
    echo "请启动 OpenCode 修复编译错误："
    echo ""
    echo "opencode run \"修复以下编译错误："
    echo ""
    grep "^  error" /tmp/analyze_output.txt
    echo ""
    echo "Flutter 路径：/home/lh/flutter/bin/flutter\""
    echo ""
    read -p "按回车键继续（修复完成后）..."
    
    # 重新检查
    $FLUTTER analyze lib/ 2>&1 | tee /tmp/analyze_output2.txt
    
    if grep -q "^  error" /tmp/analyze_output2.txt; then
        echo ""
        echo "❌ 仍有编译错误，请继续修复！"
        exit 1
    fi
fi

echo ""
echo "✅ 编译检查通过！"
echo ""

# 7. 运行测试
echo "🧪 运行 flutter test..."
echo ""

if ! $FLUTTER test; then
    echo ""
    echo "❌ 测试失败，需要修复！"
    echo ""
    echo "请启动 OpenCode 修复测试错误"
    echo ""
    read -p "按回车键继续（修复完成后）..."
    
    # 重新测试
    if ! $FLUTTER test; then
        echo ""
        echo "❌ 测试仍失败，请继续修复！"
        exit 1
    fi
fi

echo ""
echo "✅ 测试通过！"
echo ""

# 8. 提交代码
echo "📦 提交代码..."
echo ""

git add -A
git commit -m "feat: 完成 $NEXT_FEATURE - $FEATURE_DESC ✅

- 编译检查通过
- 测试通过
- 代码质量符合标准"

if git push; then
    echo "✅ 代码已提交并推送"
else
    echo "⚠️ 推送失败，请手动推送"
fi

echo ""

# 9. 更新进度
echo "📊 更新进度..."
echo ""

# 使用 Python 更新 JSON（更可靠）
python3 << EOF
import json
from datetime import datetime

# 读取功能清单
with open('.long-run/feature-list.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

# 更新当前功能
for feature in data['features']:
    if feature['id'] == '$NEXT_FEATURE':
        feature['passes'] = True
        feature['completedAt'] = datetime.utcnow().isoformat() + 'Z'
        break

# 写回文件
with open('.long-run/feature-list.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)

print(f"✅ 进度已更新：$NEXT_FEATURE passes: true")
EOF

echo ""

# 10. 显示进度
COMPLETED=$(grep -c '"passes": true' .long-run/feature-list.json 2>/dev/null || echo "0")
TOTAL=$(grep -c '"id":' .long-run/feature-list.json 2>/dev/null || echo "0")
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
NEXT_NEXT=$(grep -A 2 '"passes": false' .long-run/feature-list.json | grep '"id":' | head -1 | sed 's/.*"id": "\([^"]*\)".*/\1/')

if [ -n "$NEXT_NEXT" ]; then
    NEXT_DESC=$(grep -A 5 "\"id\": \"$NEXT_NEXT\"" .long-run/feature-list.json | grep '"description":' | head -1 | sed 's/.*"description": "\([^"]*\)".*/\1/')
    echo "$NEXT_NEXT - $NEXT_DESC"
else
    echo "🎉 所有功能已完成！"
fi
echo ""

echo "✅ Session 完成！"
echo ""
echo "下一步:"
echo "  运行 ./scripts/opencode-session-v2.sh 继续下一个功能"
echo ""
