import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  bool _isPurchased = false;
  bool _isSubscribed = false;

  bool get isPurchased => _isPurchased;
  bool get isSubscribed => _isSubscribed;

  Future<void> setPurchased(bool value) async {
    _isPurchased = value;
    notifyListeners();
  }

  Future<void> setSubscribed(bool value) async {
    _isSubscribed = value;
    notifyListeners();
  }
}
