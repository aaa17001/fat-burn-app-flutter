#!/bin/bash

# 燃脂助手开发环境初始化脚本
# 每个 Session 开始时运行

set -e

echo "🚀 燃脂助手开发环境初始化"
echo "================================"
echo ""

# 1. 检查 Flutter
echo "📱 检查 Flutter..."
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter 未安装，请先安装 Flutter"
    exit 1
fi
flutter --version
echo "✅ Flutter 检查通过"
echo ""

# 2. 检查依赖
echo "📦 检查依赖..."
flutter pub get
echo "✅ 依赖检查通过"
echo ""

# 3. 运行单元测试
echo "🧪 运行单元测试..."
flutter test
if [ $? -ne 0 ]; then
    echo "❌ 单元测试失败，请先修复"
    exit 1
fi
echo "✅ 单元测试通过"
echo ""

# 4. 检查数据库文件
echo "🗄️ 检查数据库..."
if [ -f "build/ios/Debug-iphoneos/Runner.app/fat_burn_coach.db" ]; then
    echo "✅ 数据库文件存在"
else
    echo "ℹ️  数据库将在首次运行时创建"
fi
echo ""

# 5. 读取进度
echo "📊 读取开发进度..."
if [ -f ".long-run/progress.md" ]; then
    echo "✅ 进度日志存在"
    tail -n 20 .long-run/progress.md
else
    echo "❌ 进度日志不存在"
fi
echo ""

# 6. 读取功能清单
echo "📋 读取功能清单..."
if [ -f ".long-run/feature-list.json" ]; then
    COMPLETED=$(grep -c '"passes": true' .long-run/feature-list.json || echo "0")
    PENDING=$(grep -c '"passes": false' .long-run/feature-list.json || echo "0")
    TOTAL=$((COMPLETED + PENDING))
    PERCENT=$((COMPLETED * 100 / TOTAL))
    echo "✅ 功能清单：$COMPLETED/$TOTAL ($PERCENT%)"
    echo ""
    echo "下一个待完成功能:"
    grep -A 5 '"passes": false' .long-run/feature-list.json | head -10
else
    echo "❌ 功能清单不存在"
fi
echo ""

# 7. 启动开发服务器（可选）
echo "🔥 准备启动开发服务器..."
echo "运行以下命令启动:"
echo "  flutter run -d chrome"
echo ""

echo "================================"
echo "✅ 初始化完成！"
echo ""
echo "下一步:"
echo "1. 读取 .long-run/progress.md 了解最近工作"
echo "2. 读取 .long-run/feature-list.json 选择下一个功能"
echo "3. 开始开发"
echo ""
