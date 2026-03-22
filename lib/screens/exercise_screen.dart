import 'package:flutter/material.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🏃 运动推荐'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildExerciseCard(
            context,
            icon: Icons.directions_walk,
            name: '快走',
            description: '最佳燃脂运动，适合所有人',
            met: 4.0,
            fatPercentage: 70,
            color: const Color(0xFFFF6B35),
          ),
          const SizedBox(height: 12),
          _buildExerciseCard(
            context,
            icon: Icons.hiking,
            name: '爬坡走 (10%)',
            description: '高效燃脂，突破平台期',
            met: 8.0,
            fatPercentage: 60,
            color: const Color(0xFF00D9B6),
          ),
          const SizedBox(height: 12),
          _buildExerciseCard(
            context,
            icon: Icons.directions_run,
            name: '慢跑',
            description: '传统有氧，注意平台期',
            met: 8.0,
            fatPercentage: 45,
            color: Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildExerciseCard(
            context,
            icon: Icons.pedal_bike,
            name: '骑车',
            description: '低冲击，适合大体重',
            met: 6.0,
            fatPercentage: 50,
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          _buildExerciseCard(
            context,
            icon: Icons.pool,
            name: '游泳',
            description: '全身运动，零冲击',
            met: 7.0,
            fatPercentage: 50,
            color: Colors.cyan,
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(
    BuildContext context, {
    required IconData icon,
    required String name,
    required String description,
    required double met,
    required int fatPercentage,
    required Color color,
  }) {
    return Card(
      child: InkWell(
        onTap: () {
          _showExerciseDetail(context, name, description, met, fatPercentage, color);
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildInfoChip(
                          icon: Icons.local_fire_department,
                          label: '${met} MET',
                        ),
                        const SizedBox(width: 12),
                        _buildInfoChip(
                          icon: Icons.pie_chart,
                          label: '$fatPercentage% 脂肪',
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
  }

  Widget _buildInfoChip({required IconData icon, required String label}) {
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

  void _showExerciseDetail(
    BuildContext context,
    String name,
    String description,
    double met,
    int fatPercentage,
    Color color,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                _buildDetailItem(
                  icon: Icons.local_fire_department,
                  label: '强度',
                  value: '${met} MET',
                  color: color,
                ),
                const SizedBox(width: 24),
                _buildDetailItem(
                  icon: Icons.pie_chart,
                  label: '脂肪供能',
                  value: '$fatPercentage%',
                  color: color,
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('开始运动！')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '开始运动',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
