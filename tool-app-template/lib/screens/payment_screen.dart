import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('升级高级版'),
        backgroundColor: const Color(0xFFFF6B35),
      ),
      body: const Center(
        child: Text('Payment Screen - TODO'),
      ),
    );
  }
}
