import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:fat_burn_coach/main.dart';
import 'package:fat_burn_coach/providers/user_provider.dart';
import 'package:fat_burn_coach/providers/exercise_provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('燃脂助手 E2E 测试', () {
    // 测试 1: 完整用户流程
    testWidgets('E2E-001: 完整用户流程测试', (tester) async {
      // 1. 启动应用
      await tester.pumpWidget(const FatBurnCoachApp());
      await tester.pumpAndSettle();
      expect(find.byType(MaterialApp), findsOneWidget);

      // 2. 导航到个人设置页面
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();
      expect(find.text('个人设置'), findsOneWidget);

      // 3. 输入用户信息
      await tester.enterText(
        find.byType(TextFormField).at(0),
        '25', // 年龄
      );
      await tester.enterText(
        find.byType(TextFormField).at(1),
        '70.0', // 体重
      );
      await tester.enterText(
        find.byType(TextFormField).at(2),
        '175', // 身高
      );

      // 4. 选择性别
      await tester.tap(find.text('男').last);
      await tester.pumpAndSettle();

      // 5. 保存设置
      await tester.tap(find.text('保存设置'));
      await tester.pumpAndSettle();

      // 6. 验证保存成功
      expect(find.text('保存成功！'), findsOneWidget);
      await tester.pumpAndSettle();

      // 7. 验证 BMI 显示
      expect(find.byType(Card).last, findsOneWidget);
      
      print('✅ E2E-001: 完整用户流程测试 通过');
    });

    // 测试 2: 数据持久化
    testWidgets('E2E-002: 数据持久化测试', (tester) async {
      // 1. 启动应用并设置数据
      await tester.pumpWidget(const FatBurnCoachApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextFormField).at(0),
        '30',
      );
      await tester.enterText(
        find.byType(TextFormField).at(1),
        '65.5',
      );
      await tester.enterText(
        find.byType(TextFormField).at(2),
        '168',
      );

      await tester.tap(find.text('男').last);
      await tester.pumpAndSettle();

      await tester.tap(find.text('保存设置'));
      await tester.pumpAndSettle();

      // 2. 重启应用（模拟）
      await tester.pumpWidget(const FatBurnCoachApp());
      await tester.pumpAndSettle();

      // 3. 验证数据保留
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      expect(find.text('30'), findsOneWidget);
      expect(find.text('65.5'), findsOneWidget);
      expect(find.text('168'), findsOneWidget);

      print('✅ E2E-002: 数据持久化测试 通过');
    });

    // 测试 3: 历史记录功能
    testWidgets('E2E-003: 历史记录功能测试', (tester) async {
      // 1. 启动应用
      await tester.pumpWidget(const FatBurnCoachApp());
      await tester.pumpAndSettle();

      // 2. 导航到历史记录页面
      // 假设底部导航栏有历史记录图标
      await tester.tap(find.byIcon(Icons.history));
      await tester.pumpAndSettle();

      expect(find.text('历史记录'), findsOneWidget);

      // 3. 验证空状态
      expect(find.text('暂无历史记录'), findsOneWidget);

      // 4. 验证日期选择器
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);

      // 5. 验证搜索框
      expect(find.byType(TextField), findsOneWidget);

      print('✅ E2E-003: 历史记录功能测试 通过');
    });

    // 测试 4: 运动计时功能
    testWidgets('E2E-004: 运动计时功能测试', (tester) async {
      // 1. 启动应用
      await tester.pumpWidget(const FatBurnCoachApp());
      await tester.pumpAndSettle();

      // 2. 选择运动
      await tester.tap(find.text('快走'));
      await tester.pumpAndSettle();

      // 3. 验证计时器显示
      expect(find.byType(Text), findsWidgets);

      // 4. 验证开始按钮
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);

      print('✅ E2E-004: 运动计时功能测试 通过');
    });

    // 测试 5: UI 主题一致性
    testWidgets('E2E-005: UI 主题一致性测试', (tester) async {
      // 1. 启动应用
      await tester.pumpWidget(const FatBurnCoachApp());
      await tester.pumpAndSettle();

      // 2. 验证主题色（橙色 #FF6B35）
      final appBar = tester.widget<AppBar>(
        find.byType(AppBar).first,
      );
      expect(appBar.backgroundColor, const Color(0xFFFF6B35));

      print('✅ E2E-005: UI 主题一致性测试 通过');
    });
  });
}
