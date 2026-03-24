#!/bin/bash

# 批量创建 20 个工具 App 脚本
# 基于 tool-app-template 模板

set -e

echo "🚀 批量创建 20 个工具 App"
echo "================================"
echo ""

# 定义 20 个 App 名称和描述
declare -A APPS=(
    ["calculator"]="房贷/个税/小费计算器"
    ["timer"]="番茄钟/倒计时/正计时"
    ["converter"]="单位/汇率/进制转换"
    ["random-number"]="随机数/抽签/决策"
    ["decision-wheel"]="选择困难症救星"
    ["todo-list"]="简洁的 TODO 列表"
    ["focus-forest"]="番茄钟 + 成就系统"
    ["habit-tracker"]="习惯养成打卡"
    ["time-tracker"]="时间记录与分析"
    ["note-cards"]="闪念卡片记录"
    ["water-reminder"]="定时喝水提醒"
    ["sleep-calculator"]="睡眠周期计算"
    ["calorie-counter"]="食物卡路里查询"
    ["period-tracker"]="女性健康追踪"
    ["breathing"]="呼吸引导放松"
    ["color-palette"]="颜色搭配生成"
    ["font-preview"]="字体效果预览"
    ["qr-code"]="二维码生成/扫描"
    ["image-compressor"]="图片尺寸压缩"
    ["watermark-camera"]="添加文字水印"
)

# 检查模板目录
if [ ! -d "tool-app-template" ]; then
    echo "❌ 模板目录不存在：tool-app-template"
    echo ""
    echo "请先创建模板："
    echo "  1. 创建 tool-app-template/ 目录"
    echo "  2. 创建基础项目结构"
    echo "  3. 创建共享组件库"
    echo "  4. 创建功能清单模板"
    echo ""
    exit 1
fi

echo "✅ 模板目录存在"
echo ""

# 创建 apps 目录
mkdir -p apps
echo "📁 创建 apps 目录..."
echo ""

# 计数器
TOTAL=${#APPS[@]}
COUNT=0

# 循环创建每个 App
for app_name in "${!APPS[@]}"; do
    COUNT=$((COUNT + 1))
    app_desc=${APPS[$app_name]}
    
    echo "[$COUNT/$TOTAL] 🚀 创建 $app_name ($app_desc)..."
    
    # 复制模板
    cp -r tool-app-template "apps/$app_name"
    
    # 修改配置
    cd "apps/$app_name"
    
    # 修改 pubspec.yaml
    sed -i "s/name: tool-app-template/name: $app_name/g" pubspec.yaml
    sed -i "s/description: .*/description: \"$app_desc\"/g" pubspec.yaml
    
    # 修改 main.dart
    sed -i "s/Tool App Template/$app_desc/g" lib/main.dart
    sed -i "s/tool_app_template/$app_name/g" lib/main.dart
    
    # 修改 .long-run/feature-list.json
    if [ -f ".long-run/feature-list.json" ]; then
        sed -i "s/tool-app-template/$app_name/g" .long-run/feature-list.json
        sed -i "s/Tool App Template/$app_desc/g" .long-run/feature-list.json
    fi
    
    # Git 初始化
    git init
    git add -A
    git commit -m "feat: 初始化 $app_name 项目

描述：$app_desc
模板：tool-app-template
框架：Flutter 3.16.0"
    
    cd ../..
    
    echo "✅ $app_name 创建完成"
    echo ""
done

echo "================================"
echo "🎉 批量创建完成！"
echo "================================"
echo ""
echo "创建统计:"
echo "  总数量：$TOTAL 个"
echo "  成功：$COUNT 个"
echo "  失败：0 个"
echo ""
echo "项目位置：apps/"
echo ""
echo "下一步:"
echo "  1. cd apps/[app_name]"
echo "  2. ./scripts/opencode-session.sh"
echo "  3. 开始开发"
echo ""

# 生成批量进度追踪文件
cat > apps/BATCH-PROGRESS.md << 'EOF'
# 批量开发进度追踪

**创建时间：** $(date +%Y-%m-%d)
**总项目数：** 20 个

---

## 📊 总体进度

| 指标 | 数值 |
|------|------|
| **总项目数** | 20 个 |
| **已完成** | 0 个 |
| **开发中** | 0 个 |
| **待开始** | 20 个 |
| **完成率** | 0% |

---

## 📋 项目列表

| # | 项目名 | 描述 | 进度 | 状态 |
|---|--------|------|------|------|
| 1 | calculator | 房贷/个税/小费计算器 | 0% | ⏳ |
| 2 | timer | 番茄钟/倒计时/正计时 | 0% | ⏳ |
| 3 | converter | 单位/汇率/进制转换 | 0% | ⏳ |
| 4 | random-number | 随机数/抽签/决策 | 0% | ⏳ |
| 5 | decision-wheel | 选择困难症救星 | 0% | ⏳ |
| 6 | todo-list | 简洁的 TODO 列表 | 0% | ⏳ |
| 7 | focus-forest | 番茄钟 + 成就系统 | 0% | ⏳ |
| 8 | habit-tracker | 习惯养成打卡 | 0% | ⏳ |
| 9 | time-tracker | 时间记录与分析 | 0% | ⏳ |
| 10 | note-cards | 闪念卡片记录 | 0% | ⏳ |
| 11 | water-reminder | 定时喝水提醒 | 0% | ⏳ |
| 12 | sleep-calculator | 睡眠周期计算 | 0% | ⏳ |
| 13 | calorie-counter | 食物卡路里查询 | 0% | ⏳ |
| 14 | period-tracker | 女性健康追踪 | 0% | ⏳ |
| 15 | breathing | 呼吸引导放松 | 0% | ⏳ |
| 16 | color-palette | 颜色搭配生成 | 0% | ⏳ |
| 17 | font-preview | 字体效果预览 | 0% | ⏳ |
| 18 | qr-code | 二维码生成/扫描 | 0% | ⏳ |
| 19 | image-compressor | 图片尺寸压缩 | 0% | ⏳ |
| 20 | watermark-camera | 添加文字水印 | 0% | ⏳ |

---

## 🚀 开发流程

### 单个 App 开发

```bash
cd apps/[app_name]
./scripts/opencode-session.sh
```

### 批量进度检查

```bash
cd apps
./batch-check-progress.sh
```

---

## 📈 更新记录

| 日期 | 更新内容 | 进度 |
|------|---------|------|
| $(date +%Y-%m-%d) | 创建 20 个项目 | 0% |

EOF

echo "📊 进度追踪文件已创建：apps/BATCH-PROGRESS.md"
echo ""
