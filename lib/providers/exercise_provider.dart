import 'package:flutter/material.dart';

class ExerciseProvider extends ChangeNotifier {
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
  
  // 根据 BMI 推荐运动
  List<Map<String, dynamic>> recommendExercises(double bmi, bool jointIssues) {
    if (bmi > 28 || jointIssues) {
      return _exercises.where((e) => 
        e['jointImpact'] == 'low' || e['jointImpact'] == 'very_low'
      ).toList();
    }
    return _exercises;
  }
  
  // 计算脂肪燃烧量
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
}
