import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('👤 个人中心'),
        backgroundColor: const Color(0xFFFF6B35),
      ),
      body: const Center(
        child: Text(
          '个人中心页面 - 开发中',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
