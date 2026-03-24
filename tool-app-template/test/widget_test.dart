import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tool_app_template/main.dart';

void main() {
  testWidgets('App 启动测试', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
