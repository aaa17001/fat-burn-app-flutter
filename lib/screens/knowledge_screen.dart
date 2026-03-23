import 'package:flutter/material.dart';

class KnowledgeScreen extends StatelessWidget {
  const KnowledgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('💡 科学知识'),
        backgroundColor: const Color(0xFFFF6B35),
      ),
      body: const Center(
        child: Text(
          '科学知识页面 - 开发中',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
