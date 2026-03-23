import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/exercise_record.dart';
import 'user_provider.dart';

/// 运动 Provider
/// 管理运动数据和记录的持久化
class ExerciseProvider extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final UserProvider _userProvider;
  
  ExerciseProvider(this._userProvider);
  
  // 运动数据库
  final List<Map<String, dynamic>> _exercises = [
    {
      'id': 'walking',
      'name': '快走',
      'icon': Icons.directions_walk,
      'met': 4.0,
      'fatPercentage': 0.70,
      'intensity': 'low',
      'jointImpact': 'low',
      'description': '最佳燃脂运动，适合所有人',
    },
    {
      'id': 'incline_walking',
      'name': '爬坡走 (10%)',
      'icon': Icons.hiking,
      'met': 8.0,
      'fatPercentage': 0.60,
      'intensity': 'medium',
      'jointImpact': 'medium',
      'description': '高效燃脂，突破平台期',
    },
    {
      'id': 'jogging',
      'name': '慢跑',
      'icon': Icons.directions_run,
      'met': 8.0,
      'fatPercentage': 0.45,
      'intensity': 'medium',
      'jointImpact': 'medium',
      'description': '传统有氧，注意平台期',
    },
    {
      'id': 'cycling',
      'name': '骑车',
      'icon': Icons.pedal_bike,
      'met': 6.0,
      'fatPercentage': 0.50,
      'intensity': 'medium',
      'jointImpact': 'very_low',
      'description': '低冲击，适合大体重',
    },
    {
      'id': 'swimming',
      'name': '游泳',
      'icon': Icons.pool,
      'met': 7.0,
      'fatPercentage': 0.50,
      'intensity': 'medium',
      'jointImpact': 'very_low',
      'description': '全身运动，零冲击',
    },
  ];
  
  List<Map<String, dynamic>> get exercises => _exercises;
  
  // 运动记录列表
  List<ExerciseRecord> _records = [];
  List<ExerciseRecord> get records => _records;
  
  // 统计数据
  Map<String, dynamic> _statistics = {};
  Map<String, dynamic> get statistics => _statistics;
  
  // 加载状态
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  /// 初始化 - 加载运动记录
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await loadHistoryRecords();
      await loadStatistics();
    } catch (e) {
      debugPrint('加载运动数据失败：$e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// 根据 BMI 推荐运动
  List<Map<String, dynamic>> recommendExercises(double bmi, bool jointIssues) {
    if (bmi > 28 || jointIssues) {
      return _exercises.where((e) => 
        e['jointImpact'] == 'low' || e['jointImpact'] == 'very_low'
      ).toList();
    }
    return _exercises;
  }
  
  /// 计算脂肪燃烧量
  Map<String, dynamic> calculateFatBurn(String exerciseId, int duration, double weight) {
    final exercise = _exercises.firstWhere((e) => e['id'] == exerciseId);
    final calories = exercise['met'] * weight * (duration / 60);
    final fatGrams = (calories * exercise['fatPercentage']) / 9;
    
    return {
      'calories': calories.round(),
      'fatGrams': fatGrams.toStringAsFixed(1),
      'fatPercentage': (exercise['fatPercentage'] * 100).round(),
    };
  }
  
  /// 加载历史记录
  Future<void> loadHistoryRecords() async {
    try {
      _records = await _dbHelper.getAllExerciseRecords();
      debugPrint('加载运动记录：${_records.length} 条');
      notifyListeners();
    } catch (e) {
      debugPrint('加载运动记录失败：$e');
      rethrow;
    }
  }
  
  /// 加载统计数据
  Future<void> loadStatistics() async {
    try {
      _statistics = await _dbHelper.getStatistics();
      debugPrint('统计数据：$_statistics');
      notifyListeners();
    } catch (e) {
      debugPrint('加载统计数据失败：$e');
      rethrow;
    }
  }
  
  /// 保存运动记录
  Future<int> saveExerciseRecord({
    required String exerciseType,
    required int durationSeconds,
    required double caloriesBurned,
    double? fatBurnedGrams,
    int? avgHeartRate,
    int? maxHeartRate,
  }) async {
    try {
      // 获取当前用户 ID
      final userId = _userProvider.currentUser?.id;
      if (userId == null) {
        throw Exception('用户未设置，请先设置用户信息');
      }
      
      final record = ExerciseRecord(
        userId: userId,
        exerciseType: exerciseType,
        durationSeconds: durationSeconds,
        caloriesBurned: caloriesBurned,
        fatBurnedGrams: fatBurnedGrams,
        avgHeartRate: avgHeartRate,
        maxHeartRate: maxHeartRate,
        startedAt: DateTime.now().subtract(Duration(seconds: durationSeconds)),
        endedAt: DateTime.now(),
      );
      
      final recordId = await _dbHelper.insertExerciseRecord(record);
      _records.insert(0, record);
      
      // 更新统计数据
      await loadStatistics();
      
      debugPrint('保存运动记录成功：ID=$recordId');
      notifyListeners();
      return recordId;
    } catch (e) {
      debugPrint('保存运动记录失败：$e');
      rethrow;
    }
  }
  
  /// 按日期获取记录
  Future<List<ExerciseRecord>> getRecordsByDate(DateTime date) async {
    try {
      return await _dbHelper.getRecordsByDate(date);
    } catch (e) {
      debugPrint('查询记录失败：$e');
      rethrow;
    }
  }
  
  /// 删除运动记录
  Future<void> deleteExerciseRecord(int id) async {
    try {
      await _dbHelper.deleteExerciseRecord(id);
      _records.removeWhere((record) => record.id == id);
      notifyListeners();
      debugPrint('删除运动记录成功：ID=$id');
    } catch (e) {
      debugPrint('删除运动记录失败：$e');
      rethrow;
    }
  }
  
  /// 获取今日记录
  List<ExerciseRecord> getTodayRecords() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return _records.where((record) {
      return record.startedAt.isAfter(today);
    }).toList();
  }
  
  /// 获取本周记录
  List<ExerciseRecord> getThisWeekRecords() {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final startOfWeek = DateTime(weekStart.year, weekStart.month, weekStart.day);
    return _records.where((record) {
      return record.startedAt.isAfter(startOfWeek);
    }).toList();
  }
  
  /// 获取本月记录
  List<ExerciseRecord> getThisMonthRecords() {
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    return _records.where((record) {
      return record.startedAt.isAfter(monthStart);
    }).toList();
  }
}
