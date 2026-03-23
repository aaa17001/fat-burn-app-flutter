/// 用户模型类
/// 表示应用中的用户信息
class User {
  final int? id;
  final int age;
  final double weight;
  final int height;
  final String gender;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    this.id,
    required this.age,
    required this.weight,
    required this.height,
    required this.gender,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  /// 从 Map 创建 User 对象
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      age: map['age'] as int,
      weight: (map['weight'] as num).toDouble(),
      height: map['height'] as int,
      gender: map['gender'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  /// 转换为 Map
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'age': age,
      'weight': weight,
      'height': height,
      'gender': gender,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// 复制并修改
  User copyWith({
    int? id,
    int? age,
    double? weight,
    int? height,
    String? gender,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      gender: gender ?? this.gender,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// 计算 BMI
  double get bmi {
    final heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  }

  /// 获取 BMI 分类
  String get bmiCategory {
    if (bmi < 18.5) return '偏瘦';
    if (bmi < 24) return '正常';
    if (bmi < 28) return '偏胖';
    return '肥胖';
  }

  @override
  String toString() {
    return 'User(id: $id, age: $age, weight: $weight, height: $height, gender: $gender, bmi: ${bmi.toStringAsFixed(1)})';
  }
}
