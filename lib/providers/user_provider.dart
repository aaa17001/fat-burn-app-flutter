import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/user.dart';

/// 用户 Provider
/// 管理用户信息和设置的持久化
class UserProvider extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  
  User? _currentUser;
  bool _isLoading = false;
  
  // getters
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  
  // 便捷属性
  double get weight => _currentUser?.weight ?? 70.0;
  int get height => _currentUser?.height ?? 170;
  int get age => _currentUser?.age ?? 25;
  String get gender => _currentUser?.gender ?? 'male';
  
  // BMI 计算
  double get bmi {
    if (_currentUser == null) return 0.0;
    return _currentUser!.bmi;
  }
  
  // BMI 分类
  String get bmiCategory {
    if (_currentUser == null) return '未知';
    return _currentUser!.bmiCategory;
  }
  
  // BMR 计算 (Mifflin-St Jeor 公式)
  int get bmr {
    if (_currentUser == null) return 1500;
    double base = 10 * weight + 6.25 * height - 5 * age;
    return (base + (gender == 'male' ? 5 : -161)).toInt();
  }
  
  /// 初始化 - 加载用户数据
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await loadUserSettings();
    } catch (e) {
      debugPrint('加载用户数据失败：$e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// 加载用户设置
  Future<void> loadUserSettings() async {
    try {
      _currentUser = await _dbHelper.getCurrentUser();
      debugPrint('加载用户数据：$_currentUser');
      notifyListeners();
    } catch (e) {
      debugPrint('加载用户数据失败：$e');
      rethrow;
    }
  }
  
  /// 保存用户设置
  Future<void> saveUserSettings({
    required int age,
    required double weight,
    required int height,
    required String gender,
  }) async {
    try {
      final user = User(
        age: age,
        weight: weight,
        height: height ?? 170,
        gender: gender,
        createdAt: _currentUser?.createdAt,
        updatedAt: DateTime.now(),
      );
      
      final userId = await _dbHelper.saveUser(user);
      _currentUser = user.copyWith(id: userId);
      
      debugPrint('保存用户数据成功：$_currentUser');
      notifyListeners();
    } catch (e) {
      debugPrint('保存用户数据失败：$e');
      rethrow;
    }
  }
  
  /// 更新用户信息
  Future<void> updateUserInfo({
    double? weight,
    int? height,
    int? age,
    String? gender,
  }) async {
    if (_currentUser == null) {
      // 如果没有用户数据，先保存
      await saveUserSettings(
        age: age ?? 25,
        weight: weight ?? 70.0,
        height: height ?? 170,
        gender: gender ?? 'male',
      );
      return;
    }
    
    try {
      final updatedUser = _currentUser!.copyWith(
        weight: weight,
        height: height,
        age: age,
        gender: gender,
        updatedAt: DateTime.now(),
      );
      
      await _dbHelper.saveUser(updatedUser);
      _currentUser = updatedUser;
      
      debugPrint('更新用户数据成功：$_currentUser');
      notifyListeners();
    } catch (e) {
      debugPrint('更新用户数据失败：$e');
      rethrow;
    }
  }
  
  /// 删除用户数据
  Future<void> deleteUser() async {
    try {
      await _dbHelper.deleteAllUsers();
      _currentUser = null;
      debugPrint('删除用户数据成功');
      notifyListeners();
    } catch (e) {
      debugPrint('删除用户数据失败：$e');
      rethrow;
    }
  }
  
  /// 检查是否已设置用户信息
  bool get isUserConfigured => _currentUser != null;
}
