import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tool App Template'),
        backgroundColor: const Color(0xFFFF6B35),
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
