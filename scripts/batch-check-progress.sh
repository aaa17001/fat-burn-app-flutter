#!/bin/bash

# 批量检查所有 App 进度脚本

set -e

echo "📊 批量检查 App 进度"
echo "================================"
echo ""

cd apps

# 检查进度文件
if [ ! -f "BATCH-PROGRESS.md" ]; then
    echo "❌ 进度文件不存在：BATCH-PROGRESS.md"
    exit 1
fi

# 计数器
TOTAL=0
COMPLETED=0
IN_PROGRESS=0
PENDING=0

echo "项目进度:"
echo ""

# 循环检查每个 App
for app_dir in */; do
    # 跳过非目录和特殊文件
    [ -d "$app_dir" ] || continue
    [ "$app_dir" != "./" ] || continue
    
    TOTAL=$((TOTAL + 1))
    app_name=$(basename "$app_dir")
    
    # 检查功能清单
    if [ -f "$app_dir/.long-run/feature-list.json" ]; then
        # 读取进度
        app_total=$(grep -c '"id":' "$app_dir/.long-run/feature-list.json" 2>/dev/null || echo "0")
        app_completed=$(grep -c '"passes": true' "$app_dir/.long-run/feature-list.json" 2>/dev/null || echo "0")
        
        if [ "$app_total" -gt 0 ]; then
            percent=$((app_completed * 100 / app_total))
        else
            percent=0
        fi
        
        # 判断状态
        if [ "$percent" -eq 100 ]; then
            status="✅ 完成"
            COMPLETED=$((COMPLETED + 1))
        elif [ "$percent" -gt 0 ]; then
            status="🔄 进行中 ($percent%)"
            IN_PROGRESS=$((IN_PROGRESS + 1))
        else
            status="⏳ 待开始"
            PENDING=$((PENDING + 1))
        fi
        
        printf "  %-25s %s\n" "$app_name" "$status"
    else
        echo "  %-25s ❌ 无功能清单" "$app_name"
        PENDING=$((PENDING + 1))
    fi
done

echo ""
echo "================================"
echo "📊 进度统计"
echo "================================"
echo "总项目数：$TOTAL"
echo "已完成：$COMPLETED"
echo "进行中：$IN_PROGRESS"
echo "待开始：$PENDING"
echo ""

if [ "$TOTAL" -gt 0 ]; then
    total_percent=$(( (COMPLETED * 100 + IN_PROGRESS * 50) / TOTAL ))
    echo "总体进度：$total_percent%"
else
    echo "总体进度：0%"
fi

echo ""
echo "================================"
echo ""

# 更新 BATCH-PROGRESS.md
cd ..

if [ -f "apps/BATCH-PROGRESS.md" ]; then
    # 更新进度统计
    sed -i "s/| \*\*已完成\*\* | [0-9]* 个 |/| **已完成** | $COMPLETED 个 |/g" apps/BATCH-PROGRESS.md
    sed -i "s/| \*\*进行中\*\* | [0-9]* 个 |/| **进行中** | $IN_PROGRESS 个 |/g" apps/BATCH-PROGRESS.md
    sed -i "s/| \*\*待开始\*\* | [0-9]* 个 |/| **待开始** | $PENDING 个 |/g" apps/BATCH-PROGRESS.md
    
    if [ "$TOTAL" -gt 0 ]; then
        total_percent=$(( (COMPLETED * 100 + IN_PROGRESS * 50) / TOTAL ))
        sed -i "s/| \*\*完成率\*\* | [0-9]*% |/| **完成率** | $total_percent% |/g" apps/BATCH-PROGRESS.md
    fi
    
    echo "✅ 进度文件已更新：apps/BATCH-PROGRESS.md"
    echo ""
fi

# 显示下一个建议操作
echo "下一步建议:"
if [ "$COMPLETED" -lt "$TOTAL" ]; then
    # 找到第一个未完成的项目
    for app_dir in */; do
        [ -d "$app_dir" ] || continue
        app_name=$(basename "$app_dir")
        
        if [ -f "$app_dir/.long-run/feature-list.json" ]; then
            app_completed=$(grep -c '"passes": true' "$app_dir/.long-run/feature-list.json" 2>/dev/null || echo "0")
            app_total=$(grep -c '"id":' "$app_dir/.long-run/feature-list.json" 2>/dev/null || echo "0")
            
            if [ "$app_completed" -lt "$app_total" ]; then
                echo "  cd apps/$app_name"
                echo "  ./scripts/opencode-session.sh"
                echo ""
                break
            fi
        else
            echo "  cd apps/$app_name"
            echo "  # 开始开发"
            echo ""
            break
        fi
    done
else
    echo "  🎉 所有项目已完成！"
    echo ""
fi
