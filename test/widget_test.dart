import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fat_burn_coach/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FatBurnCoachApp());

    // Verify that the home screen is displayed.
    expect(find.text('🔥 燃脂助手'), findsOneWidget);
  });
}
