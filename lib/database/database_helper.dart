import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:fat_burn_coach/models/user.dart';
import 'package:fat_burn_coach/models/exercise_record.dart';

/// 数据库帮助类 - 单例模式
/// 负责数据库的初始化、版本管理和 CRUD 操作
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  /// 获取数据库实例
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// 初始化数据库
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'fat_burn_coach.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  /// 创建数据库表
  Future<void> _onCreate(Database db, int version) async {
    // 创建用户表
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        age INTEGER NOT NULL,
        weight REAL NOT NULL,
        height INTEGER NOT NULL,
        gender TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // 创建运动记录表
    await db.execute('''
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
      )
    ''');
  }

  /// 数据库升级处理
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // 未来版本升级时在此添加迁移逻辑
    if (oldVersion < 2) {
      // 示例：添加新字段
      // await db.execute('ALTER TABLE users ADD COLUMN new_column TEXT');
    }
  }

  // ==================== User 表的 CRUD 操作 ====================

  /// 插入或更新用户（单例用户）
  Future<int> saveUser(User user) async {
    final db = await database;
    
    // 检查是否已有用户
    final existingUsers = await db.query('users', limit: 1);
    
    if (existingUsers.isEmpty) {
      // 插入新用户
      return await db.insert('users', user.toMap());
    } else {
      // 更新现有用户
      final userId = existingUsers.first['id'] as int;
      await db.update(
        'users',
        user.toMap(),
        where: 'id = ?',
        whereArgs: [userId],
      );
      return userId;
    }
  }

  /// 获取当前用户
  Future<User?> getCurrentUser() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      orderBy: 'id ASC',
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  /// 删除所有用户数据
  Future<void> deleteAllUsers() async {
    final db = await database;
    await db.delete('users');
  }

  // ==================== ExerciseRecord 表的 CRUD 操作 ====================

  /// 插入运动记录
  Future<int> insertExerciseRecord(ExerciseRecord record) async {
    final db = await database;
    return await db.insert('exercise_records', record.toMap());
  }

  /// 获取所有运动记录
  Future<List<ExerciseRecord>> getAllExerciseRecords() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'exercise_records',
      orderBy: 'started_at DESC',
    );

    return List.generate(maps.length, (i) {
      return ExerciseRecord.fromMap(maps[i]);
    });
  }

  /// 按日期获取运动记录
  Future<List<ExerciseRecord>> getRecordsByDate(DateTime date) async {
    final db = await database;
    final startDate = DateTime(date.year, date.month, date.day);
    final endDate = startDate.add(const Duration(days: 1));

    final List<Map<String, dynamic>> maps = await db.query(
      'exercise_records',
      where: 'started_at >= ? AND started_at < ?',
      whereArgs: [startDate.toIso8601String(), endDate.toIso8601String()],
      orderBy: 'started_at DESC',
    );

    return List.generate(maps.length, (i) {
      return ExerciseRecord.fromMap(maps[i]);
    });
  }

  /// 获取指定用户的运动记录
  Future<List<ExerciseRecord>> getRecordsByUserId(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'exercise_records',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'started_at DESC',
    );

    return List.generate(maps.length, (i) {
      return ExerciseRecord.fromMap(maps[i]);
    });
  }

  /// 删除运动记录
  Future<int> deleteExerciseRecord(int id) async {
    final db = await database;
    return await db.delete(
      'exercise_records',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// 删除所有运动记录
  Future<void> deleteAllExerciseRecords() async {
    final db = await database;
    await db.delete('exercise_records');
  }

  /// 获取统计数据
  Future<Map<String, dynamic>> getStatistics() async {
    final db = await database;
    
    // 总运动次数
    final totalRecords = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM exercise_records'),
    ) ?? 0;

    // 总消耗卡路里
    final totalCalories = Sqflite.firstIntValue(
      await db.rawQuery('SELECT SUM(calories_burned) FROM exercise_records'),
    ) ?? 0.0;

    // 总运动时长（秒）
    final totalDuration = Sqflite.firstIntValue(
      await db.rawQuery('SELECT SUM(duration_seconds) FROM exercise_records'),
    ) ?? 0;

    // 总脂肪燃烧（克）
    final totalFatBurned = Sqflite.firstIntValue(
      await db.rawQuery('SELECT SUM(fat_burned_grams) FROM exercise_records'),
    ) ?? 0.0;

    return {
      'totalRecords': totalRecords,
      'totalCalories': totalCalories,
      'totalDurationSeconds': totalDuration,
      'totalFatBurnedGrams': totalFatBurned,
    };
  }

  /// 关闭数据库
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
