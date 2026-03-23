import 'package:flutter/material.dart';
import 'exercise_detail_screen.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final exercises = [
      {
        'name': '快走',
        'icon': Icons.directions_walk,
        'fatPercentage': 70,
        'duration': '30 分钟',
        'fatBurn': '11.7g',
        'desc': '最佳燃脂运动，适合所有人',
      },
      {
        'name': '爬坡走 (10%)',
        'icon': Icons.hiking,
        'fatPercentage': 60,
        'duration': '30 分钟',
        'fatBurn': '23.3g',
        'desc': '高效燃脂，突破平台期',
      },
      {
        'name': '负重走',
        'icon': Icons.backpack,
        'fatPercentage': 65,
        'duration': '30 分钟',
        'fatBurn': '14.1g',
        'desc': '增加消耗，强化训练',
      },
      {
        'name': '骑车',
        'icon': Icons.pedal_bike,
        'fatPercentage': 50,
        'duration': '30 分钟',
        'fatBurn': '13.9g',
        'desc': '低冲击，适合大体重',
      },
      {
        'name': '游泳',
        'icon': Icons.pool,
        'fatPercentage': 50,
        'duration': '30 分钟',
        'fatBurn': '16.7g',
        'desc': '全身运动，零冲击',
      },
      {
        'name': '慢跑',
        'icon': Icons.directions_run,
        'fatPercentage': 45,
        'duration': '20 分钟',
        'fatBurn': '15.0g',
        'desc': '传统有氧，注意平台期',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('🏃 运动推荐'),
        backgroundColor: const Color(0xFFFF6B35),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseDetailScreen(
                      exerciseName: exercise['name'] as String,
                      icon: exercise['icon'] as IconData,
                      fatPercentage: exercise['fatPercentage'] as int,
                      duration: exercise['duration'] as String,
                      fatBurn: exercise['fatBurn'] as String,
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B35).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        exercise['icon'] as IconData,
                        color: const Color(0xFFFF6B35),
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exercise['name'] as String,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            exercise['desc'] as String,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _buildInfoChip(
                                Icons.local_fire_department,
                                '${exercise['fatPercentage']}% 脂肪',
                              ),
                              const SizedBox(width: 12),
                              _buildInfoChip(
                                Icons.timer,
                                exercise['duration'] as String,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
