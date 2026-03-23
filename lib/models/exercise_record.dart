/// 运动记录模型类
/// 表示一次运动的详细记录
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

  ExerciseRecord({
    this.id,
    required this.userId,
    required this.exerciseType,
    required this.durationSeconds,
    required this.caloriesBurned,
    this.fatBurnedGrams,
    this.avgHeartRate,
    this.maxHeartRate,
    required this.startedAt,
    this.endedAt,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// 从 Map 创建 ExerciseRecord 对象
  factory ExerciseRecord.fromMap(Map<String, dynamic> map) {
    return ExerciseRecord(
      id: map['id'] as int?,
      userId: map['user_id'] as int,
      exerciseType: map['exercise_type'] as String,
      durationSeconds: map['duration_seconds'] as int,
      caloriesBurned: (map['calories_burned'] as num).toDouble(),
      fatBurnedGrams: map['fat_burned_grams'] != null 
          ? (map['fat_burned_grams'] as num).toDouble() 
          : null,
      avgHeartRate: map['avg_heart_rate'] as int?,
      maxHeartRate: map['max_heart_rate'] as int?,
      startedAt: DateTime.parse(map['started_at'] as String),
      endedAt: map['ended_at'] != null 
          ? DateTime.parse(map['ended_at'] as String) 
          : null,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  /// 转换为 Map
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'exercise_type': exerciseType,
      'duration_seconds': durationSeconds,
      'calories_burned': caloriesBurned,
      if (fatBurnedGrams != null) 'fat_burned_grams': fatBurnedGrams,
      if (avgHeartRate != null) 'avg_heart_rate': avgHeartRate,
      if (maxHeartRate != null) 'max_heart_rate': maxHeartRate,
      'started_at': startedAt.toIso8601String(),
      if (endedAt != null) 'ended_at': endedAt!.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// 复制并修改
  ExerciseRecord copyWith({
    int? id,
    int? userId,
    String? exerciseType,
    int? durationSeconds,
    double? caloriesBurned,
    double? fatBurnedGrams,
    int? avgHeartRate,
    int? maxHeartRate,
    DateTime? startedAt,
    DateTime? endedAt,
    DateTime? createdAt,
  }) {
    return ExerciseRecord(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      exerciseType: exerciseType ?? this.exerciseType,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      fatBurnedGrams: fatBurnedGrams ?? this.fatBurnedGrams,
      avgHeartRate: avgHeartRate ?? this.avgHeartRate,
      maxHeartRate: maxHeartRate ?? this.maxHeartRate,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// 获取运动类型中文名称
  String get exerciseTypeChinese {
    switch (exerciseType) {
      case 'walking':
        return '快走';
      case 'incline_walking':
        return '爬坡走';
      case 'jogging':
        return '慢跑';
      case 'running':
        return '跑步';
      case 'cycling':
        return '骑行';
      default:
        return exerciseType;
    }
  }

  /// 获取时长（分钟）
  int get durationMinutes {
    return durationSeconds ~/ 60;
  }

  /// 获取时长（格式化）
  String get formattedDuration {
    final hours = durationSeconds ~/ 3600;
    final minutes = (durationSeconds % 3600) ~/ 60;
    final seconds = durationSeconds % 60;
    
    if (hours > 0) {
      return '${hours}小时${minutes}分钟';
    } else if (minutes > 0) {
      return '${minutes}分钟${seconds}秒';
    } else {
      return '${seconds}秒';
    }
  }

  /// 获取开始时间（格式化）
  String get formattedStartTime {
    return '${startedAt.month}/${startedAt.day} ${startedAt.hour.toString().padLeft(2, '0')}:${startedAt.minute.toString().padLeft(2, '0')}';
  }

  @override
  String toString() {
    return 'ExerciseRecord(id: $id, type: $exerciseType, duration: $formattedDuration, calories: $caloriesBurned)';
  }
}
