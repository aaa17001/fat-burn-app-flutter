# 架构设计文档

## 📋 技术选型矩阵

### 前端框架

| 选项 | Flutter | React Native | Native |
|------|---------|-------------|--------|
| **开发效率** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐ |
| **性能** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **跨平台** | ✅ iOS+Android+Web | ✅ iOS+Android | ❌ 需分别开发 |
| **学习曲线** | 中等 | 低（JS 开发者） | 高 |
| **推荐度** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐ |

**决策：选择 Flutter**

**理由：**
- 一套代码，多端运行（iOS+Android+Web）
- 性能接近原生（Skia 引擎直接渲染）
- 丰富的 UI 组件库
- 状态管理方案成熟（Provider/Riverpod）
- 适合快速迭代和 MVP 验证

---

### 状态管理

| 选项 | Provider | Riverpod | Bloc | Zustand (RN) |
|------|---------|---------|------|-------------|
| **学习曲线** | 低 | 中等 | 高 | 低 |
| **性能** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **可测试性** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| **社区支持** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ (RN) |
| **推荐度** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ | N/A |

**决策：使用 Provider**

**理由：**
- 官方推荐，文档完善
- 学习曲线低，团队快速上手
- 性能满足需求
- 与 Flutter 集成度高
- 社区资源丰富

**注意：** PM 建议中提到的 Zustand 是 React Native 的方案，Flutter 对应使用 Provider。

---

### 传感器接入

| 功能 | Flutter 方案 | React Native 方案 |
|------|------------|-----------------|
| **加速度计** | sensors_plus | expo-sensors |
| **心率监测** | flutter_bluetooth_serial | react-native-ble-plx |
| **Google Fit** | flutter_google_fit | react-native-google-fit |
| **HealthKit** | flutter_health | react-native-health |

**决策：**
- **加速度计：** `sensors_plus` (跨平台，支持加速度计、陀螺仪)
- **心率监测：** `flutter_bluetooth_serial` (连接蓝牙心率带)
- **Google Fit：** `flutter_google_fit` (官方支持良好)
- **HealthKit：** `flutter_health` (iOS 健康数据)

---

### 数据存储

| 选项 | SQLite | Hive | SharedPreferences | Firebase |
|------|--------|------|------------------|---------|
| **数据类型** | 结构化 | 键值 | 简单键值 | 云存储 |
| **查询能力** | SQL | 简单 | 无 | 强大 |
| **性能** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| **离线支持** | ✅ | ✅ | ✅ | ⚠️ 部分 |
| **隐私性** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| **推荐度** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐ |

**决策：SQLite (本地存储优先)**

**理由：**
- 用户数据隐私保护（不上传云端）
- 支持复杂查询（统计历史数据）
- 成熟稳定，社区支持好
- 符合 GDPR 等隐私法规
- 离线可用

**表结构设计：**

```sql
-- 用户表
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  age INTEGER,
  gender TEXT,
  weight REAL,
  height REAL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 运动记录表
CREATE TABLE exercise_records (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER,
  exercise_type TEXT,
  duration_seconds INTEGER,
  calories_burned REAL,
  fat_burned_grams REAL,
  avg_heart_rate INTEGER,
  max_heart_rate INTEGER,
  started_at TIMESTAMP,
  ended_at TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 每日步数表
CREATE TABLE daily_steps (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER,
  date DATE,
  steps INTEGER,
  distance_meters REAL,
  calories_burned REAL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(user_id, date)
);

-- 用户设置表
CREATE TABLE user_settings (
  user_id INTEGER PRIMARY KEY,
  daily_step_goal INTEGER DEFAULT 10000,
  daily_calorie_goal INTEGER DEFAULT 500,
  notification_enabled INTEGER DEFAULT 1,
  notification_time TEXT DEFAULT '09:00',
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

---

## 🏗️ 系统架构

### 整体架构

```
┌─────────────────────────────────────────────────────────┐
│                    Flutter App                          │
├─────────────────────────────────────────────────────────┤
│  Presentation Layer (UI)                                │
│  ├── Screens (Home, Exercise, Tracker, Stats, Profile) │
│  └── Widgets (Cards, Charts, Buttons)                  │
├─────────────────────────────────────────────────────────┤
│  Business Logic Layer (Provider)                        │
│  ├── TimerProvider (运动计时)                           │
│  ├── ExerciseProvider (运动推荐)                        │
│  ├── StatsProvider (数据统计)                           │
│  └── SettingsProvider (用户设置)                        │
├─────────────────────────────────────────────────────────┤
│  Data Layer                                             │
│  ├── Repositories (ExerciseRepo, UserRepo, StatsRepo)  │
│  ├── Models (Exercise, User, Stats)                     │
│  └── Local Database (SQLite)                            │
├─────────────────────────────────────────────────────────┤
│  Services Layer                                         │
│  ├── SensorService (加速度计)                           │
│  ├── HeartRateService (心率监测)                        │
│  ├── GoogleFitService (Google Fit 集成)                 │
│  └── NotificationService (通知提醒)                     │
└─────────────────────────────────────────────────────────┘
```

### 目录结构

```
lib/
├── main.dart                      # 应用入口
├── app.dart                       # App 配置
│
├── screens/                       # 页面
│   ├── home_screen.dart           # 首页
│   ├── exercise_screen.dart       # 运动推荐页
│   ├── exercise_timer_screen.dart # 运动计时页
│   ├── tracker_screen.dart        # 数据追踪页
│   ├── stats_screen.dart          # 统计页
│   └── profile_screen.dart        # 个人页
│
├── widgets/                       # 组件
│   ├── exercise_card.dart         # 运动卡片
│   ├── stats_card.dart            # 统计卡片
│   ├── progress_chart.dart        # 进度图表
│   └── neaT_progress.dart         # NEAT 进度条
│
├── providers/                     # 状态管理
│   ├── timer_provider.dart        # 计时 Provider
│   ├── exercise_provider.dart     # 运动 Provider
│   ├── stats_provider.dart        # 统计 Provider
│   └── settings_provider.dart     # 设置 Provider
│
├── repositories/                  # 数据仓库
│   ├── exercise_repository.dart   # 运动数据
│   ├── user_repository.dart       # 用户数据
│   └── stats_repository.dart      # 统计数据
│
├── models/                        # 数据模型
│   ├── exercise.dart              # 运动模型
│   ├── user.dart                  # 用户模型
│   ├── exercise_record.dart       # 运动记录模型
│   └── daily_steps.dart           # 每日步数模型
│
├── services/                      # 服务层
│   ├── database_service.dart      # 数据库服务
│   ├── sensor_service.dart        # 传感器服务
│   ├── heart_rate_service.dart    # 心率服务
│   ├── google_fit_service.dart    # Google Fit 服务
│   └── notification_service.dart  # 通知服务
│
├── utils/                         # 工具类
│   ├── calorie_calculator.dart    # 卡路里计算器
│   ├── heart_rate_calculator.dart # 心率计算器
│   └── constants.dart             # 常量定义
│
└── routes/                        # 路由
    └── app_routes.dart            # 路由配置
```

---

## 🔌 核心接口定义

### TimerProvider

```dart
abstract class TimerProvider extends ChangeNotifier {
  // 状态
  bool get isRunning;
  Duration get elapsed;
  int get calories;
  double get fatBurned;
  
  // 操作
  void start(String exerciseType, double weight);
  void stop();
  void reset();
  void pause();
  void resume();
  
  // 回调
  void Function(Duration elapsed, int calories)? onTick;
  void Function(ExerciseRecord record)? onComplete;
}
```

### ExerciseRepository

```dart
abstract class ExerciseRepository {
  // 获取推荐运动
  Future<List<Exercise>> getRecommendations({
    required double bmi,
    required bool jointIssues,
    required String goal,
  });
  
  // 获取运动详情
  Future<Exercise> getExerciseById(String id);
  
  // 获取 MET 值
  Future<double> getMETValue(String exerciseType, {double? incline});
  
  // 验证数据来源
  Future<DataSource> verifyDataSource(String exerciseId);
}
```

### DatabaseService

```dart
abstract class DatabaseService {
  // 初始化
  Future<void> init();
  
  // 运动记录
  Future<int> insertExerciseRecord(ExerciseRecord record);
  Future<List<ExerciseRecord>> getExerciseRecords({
    DateTime? startDate,
    DateTime? endDate,
    String? exerciseType,
  });
  Future<void> deleteExerciseRecord(int id);
  
  // 每日步数
  Future<int> insertDailySteps(DailySteps steps);
  Future<DailySteps?> getDailySteps(DateTime date, int userId);
  Future<List<DailySteps>> getDailyStepsRange({
    required DateTime startDate,
    required DateTime endDate,
    required int userId,
  });
  
  // 统计
  Future<Map<String, dynamic>> getStats({
    required DateTime startDate,
    required DateTime endDate,
    required int userId,
  });
  
  // 备份和恢复
  Future<Map<String, dynamic>> exportData();
  Future<void> importData(Map<String, dynamic> data);
}
```

---

## 📱 UI 设计规范

### 配色方案

```dart
// 主色调（活力风）
static const Color primary = Color(0xFFFF6B35);      // 橙色 - 活力
static const Color secondary = Color(0xFF00D9B6);    // 绿色 - 健康
static const Color accent = Color(0xFF4ECDC4);       // 蓝色 - 科技

// 辅助色
static const Color success = Color(0xFF00D9B6);
static const Color warning = Color(0xFFFFE66D);
static const Color danger = Color(0xFFFF6B6B);
static const Color premium = Color(0xFFA8E6CF);

// 中性色
static const Color background = Color(0xFFF5F5F5);
static const Color surface = Color(0xFFFFFFFF);
static const Color text = Color(0xFF333333);
static const Color textLight = Color(0xFF999999);
```

### 字体规范

```dart
// 字体
static const String fontFamily = '思源黑体';

// 字号
static const TextStyle h1 = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
);

static const TextStyle h2 = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
);

static const TextStyle h3 = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

static const TextStyle body = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.normal,
);

static const TextStyle caption = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.normal,
);
```

### 组件规范

```dart
// 卡片
BoxDecoration cardDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(16),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 10,
      offset: Offset(0, 5),
    ),
  ],
);

// 按钮
ElevatedButtonThemeData buttonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: primary,
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);

// 输入框
InputDecoration inputDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
);
```

---

## 🔒 隐私和安全

### 数据隐私

```
原则：
✅ 所有数据本地存储
✅ 不上传用户个人信息
✅ 不追踪用户行为
✅ 用户可随时导出/删除数据

实现：
- 使用 SQLite 本地存储
- 不集成任何分析 SDK
- 不请求不必要的权限
- 符合 GDPR 要求
```

### 权限管理

```xml
<!-- AndroidManifest.xml -->
<!-- 必要权限 -->
<uses-permission android:name="android.permission.ACTIVITY_RECOGNITION" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />

<!-- 可选权限 -->
<uses-permission android:name="android.permission.BLUETOOTH" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />

<!-- 不需要以下权限 -->
<!-- ❌ 不请求位置权限 -->
<!-- ❌ 不请求通讯录权限 -->
<!-- ❌ 不请求相机权限 -->
```

---

## 📊 性能指标

### 目标性能

| 指标 | 目标值 | 测量方式 |
|------|--------|---------|
| 启动时间 | <2 秒 | 冷启动到首页 |
| 页面切换 | <300ms | 路由切换时间 |
| 帧率 | 60fps | 滚动和动画 |
| 内存占用 | <200MB | 稳定状态 |
| 安装包大小 | <50MB | APK 大小 |
| 数据库查询 | <100ms | 复杂查询 |

### 优化策略

```
1. 懒加载
   - 页面按需加载
   - 图片懒加载
   - 数据分页加载

2. 缓存策略
   - 运动数据缓存
   - 图片缓存
   - 配置缓存

3. 代码优化
   - 避免不必要的 rebuild
   - 使用 const 构造函数
   - 减少 setState 调用

4. 数据库优化
   - 合理使用索引
   - 批量操作
   - 异步查询
```

---

## 🚀 发布策略

### 版本规划

| 版本 | 功能 | 预计时间 |
|------|------|---------|
| **v0.1 (MVP)** | 运动推荐、计时、基础统计 | Week 5 |
| **v0.2 (Beta)** | 数据追踪、NEAT、通知提醒 | Week 7 |
| **v1.0 (Release)** | 完整功能、性能优化 | Week 8 |
| **v1.1** | 社交分享、挑战功能 | Week 10 |
| **v1.2** | 数字产品、订阅功能 | Week 12 |

### 发布渠道

| 平台 | 策略 | 时间 |
|------|------|------|
| **Google Play** | 先 Beta 测试 14 天 | Week 6-7 |
| **App Store** | 同步提交审核 | Week 8 |
| **Web (PWA)** | 作为补充渠道 | Week 9 |

---

## 📝 开发规范

### 代码规范

```dart
// 命名规范
// 类：PascalCase
class ExerciseCard {}

// 变量和方法：camelCase
int caloriesBurned;
void startTimer() {}

// 常量：lowerCamelCase 或 UPPER_SNAKE_CASE
const int maxRetryCount = 3;
const String API_KEY = 'xxx';

// 文件命名：snake_case
exercise_card.dart
timer_provider.dart

// 注释：中文注释
/// 计算卡路里消耗
/// 
/// 基于 MET 值公式：
/// 卡路里 = MET × 体重 (kg) × 时间 (小时)
int calculateCalories(double met, double weight, Duration duration) {}
```

### Git 规范

```bash
# Commit 消息格式
<type>(<scope>): <subject>

# type 类型
feat:     新功能
fix:      Bug 修复
docs:     文档更新
style:    代码格式
refactor: 重构
test:     测试
chore:    构建/工具

# 示例
feat(timer): 实现运动计时功能
fix(stats): 修复统计图表显示问题
docs(readme): 更新 README 文档
```

---

**文档生成时间：** 2026-03-23  
**Architecture Agent：** OpenCode + Bailian Qwen3.5-plus  
**状态：** ✅ 技术选型完成，可开始开发
