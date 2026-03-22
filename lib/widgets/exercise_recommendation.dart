import 'package:flutter/material.dart';

class ExerciseRecommendation extends StatelessWidget {
  final IconData icon;
  final String name;
  final String duration;
  final String fatBurn;
  final int fatPercentage;
  final bool isRecommended;
  final VoidCallback onTap;
  
  const ExerciseRecommendation({
    super.key,
    required this.icon,
    required this.name,
    required this.duration,
    required this.fatBurn,
    required this.fatPercentage,
    required this.isRecommended,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      color: isRecommended ? 
        const Color(0xFFFFF3E0) : Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isRecommended ? 
                        const Color(0xFFFF6B35) : const Color(0xFF00D9B6),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (isRecommended) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF6B35),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  '推荐',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$duration · 燃烧脂肪 $fatBurn',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    '脂肪供能',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$fatPercentage%',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF6B35),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: fatPercentage / 100,
                        backgroundColor: Colors.grey[200],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFFFF6B35),
                        ),
                        minHeight: 6,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isRecommended ? 
                      const Color(0xFFFF6B35) : const Color(0xFF00D9B6),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('开始运动'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
