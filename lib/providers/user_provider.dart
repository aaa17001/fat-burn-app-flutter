import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  // 用户信息
  double _weight = 70.0;
  double _height = 170.0;
  int _age = 25;
  String _gender = 'male';
  
  // 今日数据
  int _calorieIntake = 1500;
  int _calorieBurn = 2000;
  int _steps = 6543;
  
  // getters
  double get weight => _weight;
  double get height => _height;
  int get age => _age;
  String get gender => _gender;
  int get calorieIntake => _calorieIntake;
  int get calorieBurn => _calorieBurn;
  int get steps => _steps;
  int get dailyDeficit => _calorieBurn - _calorieIntake;
  
  // BMI 计算
  double get bmi {
    return _weight / ((_height / 100) * (_height / 100));
  }
  
  // BMR 计算 (Mifflin-St Jeor 公式)
  int get bmr {
    double base = 10 * _weight + 6.25 * _height - 5 * _age;
    return (base + (_gender == 'male' ? 5 : -161)).toInt();
  }
  
  // 更新数据
  void updateUserInfo({
    double? weight,
    double? height,
    int? age,
    String? gender,
  }) {
    if (weight != null) _weight = weight;
    if (height != null) _height = height;
    if (age != null) _age = age;
    if (gender != null) _gender = gender;
    notifyListeners();
  }
  
  void addCalorieIntake(int calories) {
    _calorieIntake += calories;
    notifyListeners();
  }
  
  void addCalorieBurn(int calories) {
    _calorieBurn += calories;
    notifyListeners();
  }
  
  void updateSteps(int steps) {
    _steps = steps;
    notifyListeners();
  }
}
