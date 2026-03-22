import 'package:flutter/material.dart';

class NeatProgress extends StatelessWidget {
  final int currentSteps;
  final int targetSteps;
  
  const NeatProgress({
    super.key,
    required this.currentSteps,
    required this.targetSteps,
  });
  
  @override
  Widget build(BuildContext context) {
    final percentage = currentSteps / targetSteps;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.directions_walk, color: Color(0xFF00D9B6)),
                const SizedBox(width: 8),
                const Text(
                  'NEAT 进度',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '今日步数',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                Text(
                  '$currentSteps / $targetSteps',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percentage > 1 ? 1 : percentage,
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF00D9B6),
                ),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '还需 ${targetSteps - currentSteps} 步达成目标！',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
