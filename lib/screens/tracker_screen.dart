import 'package:flutter/material.dart';

class TrackerScreen extends StatelessWidget {
  const TrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📊 数据追踪'),
        backgroundColor: const Color(0xFFFF6B35),
      ),
      body: const Center(
        child: Text(
          '数据追踪页面 - 开发中',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
