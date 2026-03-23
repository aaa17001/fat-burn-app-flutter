import 'package:flutter/material.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final String exerciseName;
  final IconData icon;
  final int fatPercentage;
  final String duration;
  final String fatBurn;

  const ExerciseDetailScreen({
    super.key,
    required this.exerciseName,
    required this.icon,
    required this.fatPercentage,
    required this.duration,
    required this.fatBurn,
  });

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  bool _isRunning = false;
  int _seconds = 0;
  int _calories = 0;

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
    });
    _showResultDialog();
  }

  void _resetTimer() {
    setState(() {
      _isRunning = false;
      _seconds = 0;
      _calories = 0;
    });
  }

  void _showResultDialog() {
    final minutes = _seconds ~/ 60;
    final secs = _seconds % 60;
    final fatBurned = (_calories * widget.fatPercentage / 100) / 9;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🎉 运动完成！'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildResultItem('⏱️ 运动时长', '$minutes 分 $secs 秒'),
            _buildResultItem('🔥 消耗热量', '$_calories 大卡'),
            _buildResultItem('💪 脂肪燃烧', '${fatBurned.toStringAsFixed(1)}g'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetTimer();
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  Widget _buildResultItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF6B35),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exerciseName),
        backgroundColor: const Color(0xFFFF6B35),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 运动图标和信息
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B35), Color(0xFF00D9B6)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Icon(widget.icon, size: 80, color: Colors.white),
                  const SizedBox(height: 20),
                  Text(
                    widget.exerciseName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildInfoChip('💪 脂肪供能', '${widget.fatPercentage}%'),
                      const SizedBox(width: 20),
                      _buildInfoChip('⏱️ 建议时长', widget.duration),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 计时器
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    '运动计时',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${(_seconds ~/ 60).toString().padLeft(2, '0')}:${(_seconds % 60).toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF6B35),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '消耗：$_calories 大卡',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 控制按钮
            Row(
              children: [
                if (!_isRunning)
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _startTimer,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('开始运动'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00D9B6),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _stopTimer,
                      icon: const Icon(Icons.stop),
                      label: const Text('结束运动'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                if (_seconds > 0 && !_isRunning) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _resetTimer,
                      icon: const Icon(Icons.refresh),
                      label: const Text('重置'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 30),

            // 运动说明
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '💡 运动说明',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildTip('保持匀速，不要过快或过慢'),
                  _buildTip('注意呼吸节奏'),
                  _buildTip('运动前后记得热身和拉伸'),
                  _buildTip('建议每天坚持 30 分钟'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(width: 8),
          Text(value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Text('✅ ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(tip, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
