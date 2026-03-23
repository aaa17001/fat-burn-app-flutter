import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/exercise_provider.dart';
import '../models/exercise_record.dart';

/// 历史记录页面
/// 显示用户的运动历史记录，支持日期筛选和删除
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // 当前选择的日期
  DateTime _selectedDate = DateTime.now();
  
  // 搜索控制器
  final TextEditingController _searchController = TextEditingController();
  
  // 过滤后的记录
  List<ExerciseRecord> _filteredRecords = [];

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// 加载历史记录
  Future<void> _loadRecords() async {
    final provider = context.read<ExerciseProvider>();
    await provider.loadHistoryRecords();
    _filterRecords();
  }

  /// 过滤记录
  void _filterRecords() {
    final provider = context.read<ExerciseProvider>();
    final records = provider.getRecordsByDate(_selectedDate);
    
    if (_searchController.text.isEmpty) {
      setState(() {
        _filteredRecords = records;
      });
    } else {
      final keyword = _searchController.text.toLowerCase();
      setState(() {
        _filteredRecords = records.where((record) {
          return record.exerciseTypeChinese.toLowerCase().contains(keyword);
        }).toList();
      });
    }
  }

  /// 选择日期
  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFFF6B35), // 橙色主题
              onPrimary: Colors.white,
              surface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      _filterRecords();
    }
  }

  /// 删除记录
  Future<void> _deleteRecord(ExerciseRecord record) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除这条${record.exerciseTypeChinese}记录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final provider = context.read<ExerciseProvider>();
      await provider.deleteExerciseRecord(record.id!);
      _filterRecords();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('删除成功'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  /// 显示记录详情
  void _showRecordDetail(ExerciseRecord record) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(record.exerciseTypeChinese),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('时长', record.formattedDuration),
            _buildDetailRow('消耗卡路里', '${record.caloriesBurned.toStringAsFixed(1)} kcal'),
            if (record.fatBurnedGrams != null)
              _buildDetailRow('脂肪燃烧', '${record.fatBurnedGrams} g'),
            if (record.avgHeartRate != null)
              _buildDetailRow('平均心率', '${record.avgHeartRate} bpm'),
            if (record.maxHeartRate != null)
              _buildDetailRow('最大心率', '${record.maxHeartRate} bpm'),
            _buildDetailRow('开始时间', record.formattedStartTime),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('历史记录'),
        backgroundColor: const Color(0xFFFF6B35), // 橙色主题
        elevation: 0,
        actions: [
          // 日期选择按钮
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
            tooltip: '选择日期',
          ),
        ],
      ),
      body: Column(
        children: [
          // 日期显示栏
          Container(
            padding: const EdgeInsets.all(16.0),
            color: const Color(0xFFFF6B35).withOpacity(0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '选择日期:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${_selectedDate.month}/${_selectedDate.day} (${_getWeekDay(_selectedDate)})',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFFFF6B35),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // 搜索框
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '搜索运动类型...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (_) => _filterRecords(),
            ),
          ),
          
          // 记录列表
          Expanded(
            child: Consumer<ExerciseProvider>(
              builder: (context, provider, child) {
                final records = provider.records
                    .where((r) => _isSameDate(r.startedAt, _selectedDate))
                    .toList();
                
                if (records.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          size: 80,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '暂无历史记录',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '开始运动后，记录会显示在这里',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: records.length,
                  itemBuilder: (context, index) {
                    final record = records[index];
                    return _buildRecordCard(record);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordCard(ExerciseRecord record) {
    return Dismissible(
      key: Key(record.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16.0),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) async {
        await _deleteRecord(record);
        return false; // 已经手动删除了，不需要 Dismissible 再删除
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12.0),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          onTap: () => _showRecordDetail(record),
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // 图标
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6B35).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Icon(
                    _getExerciseIcon(record.exerciseType),
                    color: const Color(0xFFFF6B35),
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                
                // 信息
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record.exerciseTypeChinese,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        record.formattedStartTime,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildStatChip(
                            icon: Icons.local_fire_department,
                            label: '${record.caloriesBurned.toStringAsFixed(0)}',
                            unit: 'kcal',
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 8),
                          _buildStatChip(
                            icon: Icons.timer,
                            label: '${record.durationMinutes}',
                            unit: '分钟',
                            color: Colors.blue,
                          ),
                          if (record.fatBurnedGrams != null) ...[
                            const SizedBox(width: 8),
                            _buildStatChip(
                              icon: Icons.monitor_weight,
                              label: record.fatBurnedGrams!,
                              unit: 'g',
                              color: Colors.green,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                
                // 箭头
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip({
    required IconData icon,
    required dynamic label,
    required String unit,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            '$label',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              fontSize: 10,
              color: color.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getExerciseIcon(String exerciseType) {
    switch (exerciseType) {
      case 'walking':
        return Icons.directions_walk;
      case 'incline_walking':
        return Icons.hiking;
      case 'jogging':
        return Icons.directions_run;
      case 'cycling':
        return Icons.pedal_bike;
      case 'swimming':
        return Icons.pool;
      default:
        return Icons.fitness_center;
    }
  }

  String _getWeekDay(DateTime date) {
    const weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    return weekdays[date.weekday - 1];
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
