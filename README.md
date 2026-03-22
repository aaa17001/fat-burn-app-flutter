# 🚀 燃脂助手 Flutter App - 构建指南

## 📱 项目信息

- **名称**: 燃脂助手 FatBurn Coach
- **平台**: iOS + Android
- **框架**: Flutter
- **版本**: 1.0.0

## 🛠️ 环境要求

- Flutter SDK >= 3.0.0
- Dart >= 3.0.0
- Android Studio / Xcode

## 📦 快速开始

### 1. 安装依赖

```bash
cd fat-burn-app-flutter
flutter pub get
```

### 2. 运行 App

**Android:**
```bash
flutter run
```

**iOS:**
```bash
flutter run -d ios
```

### 3. 构建 APK

```bash
flutter build apk --release
```

输出位置：`build/app/outputs/flutter-apk/app-release.apk`

### 4. 构建 iOS

```bash
flutter build ios --release
```

## 📁 项目结构

```
fat-burn-app-flutter/
├── lib/
│   ├── main.dart                    # 入口文件
│   ├── screens/                     # 页面
│   │   ├── home_screen.dart        # 首页
│   │   ├── exercise_screen.dart    # 运动推荐
│   │   ├── tracker_screen.dart     # 数据追踪
│   │   ├── knowledge_screen.dart   # 科学知识
│   │   └── profile_screen.dart     # 个人中心
│   ├── providers/                   # 状态管理
│   │   ├── user_provider.dart      # 用户数据
│   │   └── exercise_provider.dart  # 运动数据
│   └── widgets/                     # 组件
│       ├── stats_card.dart         # 数据卡片
│       ├── exercise_recommendation.dart # 运动推荐
│       └── neat_progress.dart      # NEAT 进度
├── assets/                          # 资源文件
│   ├── images/
│   ├── icons/
│   └── fonts/
├── pubspec.yaml                     # 项目配置
└── README.md                        # 本文档
```

## 🎨 核心功能

### 已实现

- ✅ 首页数据概览
- ✅ 运动推荐列表
- ✅ 脂肪燃烧计算
- ✅ NEAT 步数追踪
- ✅ 底部导航
- ✅ 活力风 UI 设计

### 待开发

- ⏳ 用户数据输入
- ⏳ 体重追踪
- ⏳ 饮食记录
- ⏳ 图表统计
- ⏳ 平台期检测
- ⏳ 成就系统
- ⏳ 设置页面

## 🔧 核心算法

### BMR 计算（Mifflin-St Jeor 公式）

```dart
int calculateBMR() {
  double base = 10 * weight + 6.25 * height - 5 * age;
  return (base + (gender == 'male' ? 5 : -161)).toInt();
}
```

### 脂肪燃烧计算

```dart
Map<String, dynamic> calculateFatBurn(String exerciseId, int duration, double weight) {
  final exercise = exercises.firstWhere((e) => e['id'] == exerciseId);
  final calories = exercise['met'] * weight * (duration / 60);
  final fatGrams = (calories * exercise['fatPercentage']) / 9;
  
  return {
    'calories': calories.round(),
    'fatGrams': fatGrams.toStringAsFixed(1),
    'fatPercentage': (exercise['fatPercentage'] * 100).round(),
  };
}
```

## 📊 运动数据库

| 运动 | MET | 脂肪% | 推荐指数 |
|------|-----|------|---------|
| 🚶 快走 | 4.0 | 70% | ⭐⭐⭐⭐⭐ |
| 🏃 爬坡走 | 8.0 | 60% | ⭐⭐⭐⭐⭐ |
| 🏃 慢跑 | 8.0 | 45% | ⭐⭐⭐ |
| 🚴 骑车 | 6.0 | 50% | ⭐⭐⭐⭐ |
| 🏊 游泳 | 7.0 | 50% | ⭐⭐⭐⭐ |

## 🎯 下一步

1. **完善其他页面**
   - 数据追踪页面
   - 科学知识页面
   - 个人中心页面

2. **添加功能**
   - 用户数据输入表单
   - 体重记录图表
   - 饮食记录
   - 运动记录

3. **集成设备**
   - 计步器集成
   - Apple Health / Google Fit

4. **测试发布**
   - 真机测试
   - 应用商店上架

## 📱 截图预览

（待添加）

## 📄 许可证

MIT License
