import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        backgroundColor: const Color(0xFFFF6B35),
      ),
      body: const Center(
        child: Text('Settings Screen'),
      ),
    );
  }
}
