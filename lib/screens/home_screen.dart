import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/stats_card.dart';
import '../widgets/exercise_recommendation.dart';
import '../widgets/neat_progress.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🔥 燃脂助手'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 欢迎卡片
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B35), Color(0xFF00D9B6)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '科学燃脂，越动越瘦！',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Consumer<UserProvider>(
                    builder: (context, user, _) {
                      return Text(
                        '今日缺口：-${user.dailyDeficit} 大卡',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // 数据概览
            Row(
              children: [
                Expanded(
                  child: StatsCard(
                    icon: Icons.restaurant,
                    title: '摄入',
                    value: '1500',
                    unit: '大卡',
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatsCard(
                    icon: Icons.local_fire_department,
                    title: '消耗',
                    value: '2000',
                    unit: '大卡',
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatsCard(
                    icon: Icons.trending_down,
                    title: '缺口',
                    value: '500',
                    unit: '大卡',
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // 推荐运动
            const Text(
              '⭐ 推荐运动',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            ExerciseRecommendation(
              icon: Icons.directions_walk,
              name: '快走',
              duration: '30 分钟',
              fatBurn: '11.7g',
              fatPercentage: 70,
              isRecommended: true,
              onTap: () {},
            ),
            
            const SizedBox(height: 12),
            
            ExerciseRecommendation(
              icon: Icons.hiking,
              name: '爬坡走 (10%)',
              duration: '30 分钟',
              fatBurn: '23.3g',
              fatPercentage: 60,
              isRecommended: true,
              onTap: () {},
            ),
            
            const SizedBox(height: 20),
            
            // NEAT 进度
            const NeatProgress(currentSteps: 6543, targetSteps: 10000),
          ],
        ),
      ),
    );
  }
}
