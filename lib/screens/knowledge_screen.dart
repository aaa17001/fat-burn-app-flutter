import 'package:flutter/material.dart';

class KnowledgeScreen extends StatelessWidget {
  const KnowledgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('💡 科学知识')),
      body: const Center(child: Text('科学知识页面 - 开发中')),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('👤 个人中心')),
      body: const Center(child: Text('个人中心页面 - 开发中')),
    );
  }
}
