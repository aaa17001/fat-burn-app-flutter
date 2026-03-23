# OpenCode 开发任务 - P1 功能实现

**任务创建时间：** 2026-03-23 20:30  
**优先级：** ⭐⭐⭐⭐⭐ (P1)  
**预计完成：** 2026-03-25 (1-2 天)  
**开发工具：** OpenCode v1.3.0 + Bailian API

---

## 🎯 任务目标

**实现数据持久化功能，让 App 可以正式使用**

**核心问题：**
- ❌ 当前数据无法保存（重启丢失）
- ❌ 用户设置每次重新输入
- ❌ 运动记录无法查看历史

**解决后：**
- ✅ 数据本地保存（SQLite）
- ✅ 用户设置自动保存
- ✅ 历史记录可查看
- ✅ App 可以正式使用

---

## 📋 开发任务清单

### Task 1.1: 添加 SQLite 依赖

**状态：** ⏳ 待开始  
**优先级：** ⭐⭐⭐⭐⭐  
**预计时间：** 15 分钟

**任务内容：**
```yaml
文件：pubspec.yaml
操作:
  - 添加 sqflite 依赖
  - 添加 path_provider 依赖
  - 添加 path 依赖
  - 运行 flutter pub get
```

**依赖配置：**
```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
  sqflite: ^2.3.0
  path_provider: ^2.1.0
  path: ^1.8.0
```

**验收标准：**
- [ ] pubspec.yaml 已更新
- [ ] flutter pub get 成功
- [ ] 无依赖冲突

---

### Task 1.2: 创建数据库帮助类

**状态：** ⏳ 待开始  
**优先级：** ⭐⭐⭐⭐⭐  
**预计时间：** 30 分钟

**任务内容：**
```yaml
文件：lib/database/database_helper.dart
操作:
  - 创建 DatabaseHelper 单例类
  - 实现数据库初始化
  - 创建用户表
  - 创建运动记录表
  - 实现 CRUD 操作
```

**数据库表结构：**

**用户表 (users)：**
```sql
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  age INTEGER NOT NULL,
  weight REAL NOT NULL,
  height INTEGER NOT NULL,
  gender TEXT NOT NULL,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);
```

**运动记录表 (exercise_records)：**
```sql
CREATE TABLE exercise_records (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  exercise_type TEXT NOT NULL,
  duration_seconds INTEGER NOT NULL,
  calories_burned REAL NOT NULL,
  fat_burned_grams REAL,
  avg_heart_rate INTEGER,
  max_heart_rate INTEGER,
  started_at TEXT NOT NULL,
  ended_at TEXT,
  created_at TEXT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

**验收标准：**
- [ ] DatabaseHelper 单例实现
- [ ] 数据库版本管理
- [ ] 表结构正确
- [ ] CRUD 方法完整

---

### Task 1.3: 创建数据模型

**状态：** ⏳ 待开始  
**优先级：** ⭐⭐⭐⭐⭐  
**预计时间：** 20 分钟

**任务内容：**
```yaml
文件:
  - lib/models/user.dart
  - lib/models/exercise_record.dart
操作:
  - 创建 User 模型类
  - 创建 ExerciseRecord 模型类
  - 实现 fromMap/toMap 方法
  - 实现 copyWith 方法
```

**User 模型：**
```dart
class User {
  final int? id;
  final int age;
  final double weight;
  final int height;
  final String gender;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // 构造函数
  // fromMap 方法
  // toMap 方法
  // copyWith 方法
}
```

**ExerciseRecord 模型：**
```dart
class ExerciseRecord {
  final int? id;
  final int userId;
  final String exerciseType;
  final int durationSeconds;
  final double caloriesBurned;
  final double? fatBurnedGrams;
  final int? avgHeartRate;
  final int? maxHeartRate;
  final DateTime startedAt;
  final DateTime? endedAt;
  final DateTime createdAt;
  
  // 构造函数
  // fromMap 方法
  // toMap 方法
}
```

**验收标准：**
- [ ] 模型类完整
- [ ] fromMap/toMap 正确
- [ ] 数据类型匹配

---

### Task 1.4: 实现用户设置保存

**状态：** ⏳ 待开始  
**优先级：** ⭐⭐⭐⭐⭐  
**预计时间：** 40 分钟

**任务内容：**
```yaml
文件：lib/providers/user_provider.dart
操作:
  - 集成 DatabaseHelper
  - 实现保存用户设置
  - 实现加载用户设置
  - 实现更新用户设置
  - 实现删除用户设置
```

**功能实现：**
```dart
class UserProvider with ChangeNotifier {
  User? _currentUser;
  final DatabaseHelper _dbHelper = DatabaseHelper();
  
  // 获取当前用户
  User? get currentUser => _currentUser;
  
  // 保存用户设置
  Future<void> saveUserSettings({
    required int age,
    required double weight,
    required int height,
    required String gender,
  }) async {
    // 实现逻辑
  }
  
  // 加载用户设置
  Future<void> loadUserSettings() async {
    // 实现逻辑
  }
  
  // 更新用户设置
  Future<void> updateUserSettings(User user) async {
    // 实现逻辑
  }
}
```

**验收标准：**
- [ ] 保存功能正常
- [ ] 加载功能正常
- [ ] 更新功能正常
- [ ] 数据持久化验证通过

---

### Task 1.5: 实现运动记录保存

**状态：** ⏳ 待开始  
**优先级：** ⭐⭐⭐⭐⭐  
**预计时间：** 40 分钟

**任务内容：**
```yaml
文件：lib/providers/exercise_provider.dart
操作:
  - 集成 DatabaseHelper
  - 实现保存运动记录
  - 实现加载历史记录
  - 实现删除运动记录
```

**功能实现：**
```dart
class ExerciseProvider with ChangeNotifier {
  List<ExerciseRecord> _records = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();
  
  // 获取所有记录
  List<ExerciseRecord> get records => _records;
  
  // 保存运动记录
  Future<void> saveExerciseRecord({
    required String exerciseType,
    required int durationSeconds,
    required double caloriesBurned,
    double? fatBurnedGrams,
    int? avgHeartRate,
    int? maxHeartRate,
  }) async {
    // 实现逻辑
  }
  
  // 加载历史记录
  Future<void> loadHistoryRecords() async {
    // 实现逻辑
  }
  
  // 按日期查询记录
  Future<List<ExerciseRecord>> getRecordsByDate(DateTime date) async {
    // 实现逻辑
  }
}
```

**验收标准：**
- [ ] 保存功能正常
- [ ] 查询功能正常
- [ ] 历史记录可查看
- [ ] 数据持久化验证通过

---

### Task 1.6: 创建历史记录页面

**状态：** ⏳ 待开始  
**优先级：** ⭐⭐⭐⭐  
**预计时间：** 60 分钟

**任务内容：**
```yaml
文件：lib/screens/history_screen.dart
操作:
  - 创建历史记录页面
  - 实现日期筛选
  - 实现列表展示
  - 实现详情查看
  - 实现删除功能
```

**页面功能：**
```dart
// 历史记录页面
- 按日期分组显示
- 显示运动类型、时长、卡路里
- 点击查看详情
- 左滑删除记录
```

**验收标准：**
- [ ] 页面 UI 完整
- [ ] 数据正确显示
- [ ] 日期筛选正常
- [ ] 删除功能正常

---

### Task 1.7: 完善用户设置页面

**状态：** ⏳ 待开始  
**优先级：** ⭐⭐⭐⭐  
**预计时间：** 40 分钟

**任务内容：**
```yaml
文件：lib/screens/profile_screen.dart
操作:
  - 实现用户信息表单
  - 实现保存按钮
  - 实现加载已有数据
  - 实现表单验证
  - 实现保存提示
```

**页面功能：**
```dart
// 用户设置页面
- 年龄输入（数字键盘）
- 体重输入（小数，kg）
- 身高输入（整数，cm）
- 性别选择（男/女）
- 保存按钮
- 自动加载已有数据
```

**验收标准：**
- [ ] 表单 UI 完整
- [ ] 输入验证正常
- [ ] 保存功能正常
- [ ] 数据自动加载

---

### Task 1.8: 测试和验证

**状态：** ⏳ 待开始  
**优先级：** ⭐⭐⭐⭐⭐  
**预计时间：** 60 分钟

**测试内容：**
```yaml
测试项目:
  - 用户设置保存测试
  - 用户设置加载测试
  - 运动记录保存测试
  - 历史记录查询测试
  - 数据持久化测试（重启验证）
  - 边界条件测试
```

**测试用例：**

**测试 1：用户设置保存**
```
1. 打开用户设置页面
2. 输入年龄、体重、身高、性别
3. 点击保存
4. 重启应用
5. 验证数据是否保留
```

**测试 2：运动记录保存**
```
1. 开始运动计时
2. 完成运动
3. 验证记录是否保存
4. 查看历史记录
5. 验证数据正确性
```

**测试 3：数据持久化**
```
1. 保存用户设置和运动记录
2. 完全关闭应用
3. 重新打开应用
4. 验证所有数据是否保留
```

**验收标准：**
- [ ] 所有测试用例通过
- [ ] 无数据丢失
- [ ] 无崩溃
- [ ] 性能正常

---

### Task 1.9: 重新构建 APK

**状态：** ⏳ 待开始  
**优先级：** ⭐⭐⭐⭐⭐  
**预计时间：** 30 分钟

**任务内容：**
```yaml
操作:
  - 提交代码到 Git
  - 推送到私有仓库
  - 触发 GitHub Actions 构建
  - 下载新 APK
  - 发送给用户测试
```

**验收标准：**
- [ ] 代码已提交
- [ ] APK 构建成功
- [ ] 新版本已发送

---

## 📊 进度追踪

### 总体进度

```
总进度：████████░░░░░░░░ 0%
```

### 任务状态

| 任务 | 状态 | 进度 |
|------|------|------|
| 1.1 添加 SQLite 依赖 | ⏳ | 0% |
| 1.2 创建数据库帮助类 | ⏳ | 0% |
| 1.3 创建数据模型 | ⏳ | 0% |
| 1.4 用户设置保存 | ⏳ | 0% |
| 1.5 运动记录保存 | ⏳ | 0% |
| 1.6 历史记录页面 | ⏳ | 0% |
| 1.7 用户设置页面 | ⏳ | 0% |
| 1.8 测试和验证 | ⏳ | 0% |
| 1.9 重新构建 APK | ⏳ | 0% |

---

## 📅 时间计划

### Day 1 (2026-03-23 晚上)

```
20:30 - 20:45  Task 1.1: 添加 SQLite 依赖
20:45 - 21:15  Task 1.2: 创建数据库帮助类
21:15 - 21:35  Task 1.3: 创建数据模型
21:35 - 22:15  Task 1.4: 用户设置保存
22:15 - 22:30  每日总结
```

### Day 2 (2026-03-24)

```
09:00 - 09:40  Task 1.5: 运动记录保存
09:40 - 10:40  Task 1.6: 历史记录页面
10:40 - 11:20  Task 1.7: 用户设置页面
14:00 - 15:00  Task 1.8: 测试和验证
15:00 - 15:30  Task 1.9: 重新构建 APK
15:30 - 16:00  发送给用户测试
```

---

## 🎯 验收标准

### 功能验收

- [ ] 用户设置可以保存
- [ ] 用户设置重启后保留
- [ ] 运动记录可以保存
- [ ] 历史记录可以查看
- [ ] 数据不会丢失

### 技术验收

- [ ] SQLite 数据库正常
- [ ] CRUD 操作完整
- [ ] 代码符合 Flutter 最佳实践
- [ ] 无内存泄漏
- [ ] 性能正常

### 用户验收

- [ ] APK 可以安装
- [ ] 界面正常显示
- [ ] 操作流畅
- [ ] 数据持久化验证通过

---

## 🚨 风险管理

### 技术风险

| 风险 | 概率 | 影响 | 应对措施 |
|------|------|------|---------|
| SQLite 版本冲突 | 低 | 中 | 使用最新稳定版 |
| 数据迁移问题 | 低 | 中 | 版本管理 |
| 性能问题 | 中 | 低 | 异步操作 |

### 时间风险

| 风险 | 概率 | 影响 | 应对措施 |
|------|------|------|---------|
| 开发超时 | 中 | 中 | 优先级调整 |
| 测试发现问题 | 高 | 中 | 预留修复时间 |

---

## 📞 开发工具

### OpenCode 命令

```bash
# 启动开发
cd /home/lh/.openclaw/workspace/fat-burn-app-flutter
opencode

# 开发任务
"实现数据持久化功能

需求:
1. 添加 SQLite 依赖
2. 创建数据库帮助类
3. 实现用户设置保存
4. 实现运动记录保存
5. 创建历史记录页面
6. 测试和验证

请按任务清单逐步实现。"
```

### Git 命令

```bash
# 提交代码
git add -A
git commit -m "feat: 实现数据持久化功能

- 添加 SQLite 依赖
- 创建数据库帮助类
- 实现用户设置保存
- 实现运动记录保存
- 创建历史记录页面

Closes #10"

# 推送到私有仓库
git push private-origin main
```

---

## 🎊 总结

**目标：** 实现数据持久化，让 App 可以正式使用

**预计完成：** 2026-03-24 16:00

**开发内容：**
- ✅ SQLite 数据库集成
- ✅ 用户设置保存
- ✅ 运动记录保存
- ✅ 历史记录查看
- ✅ 测试和验证
- ✅ 重新构建 APK

**预期结果：**
- ✅ 数据可以本地保存
- ✅ 重启后数据不丢失
- ✅ App 可以正式使用
- ✅ 用户满意度提升

---

**任务状态：** 🚀 准备启动  
**开发者：** OpenCode (Dev Agent)  
**监督者：** OpenClaw Agent (PM)

**立即开始开发！** 💪
