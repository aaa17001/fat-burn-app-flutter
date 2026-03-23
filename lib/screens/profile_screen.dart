import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

/// 用户设置页面
/// 允许用户设置和修改个人信息（年龄、体重、身高、性别）
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // 表单 Key
  final _formKey = GlobalKey<FormState>();
  
  // 控制器
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  
  // 性别
  String _gender = 'male';
  
  // 加载状态
  bool _isLoading = true;
  
  // 保存状态
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  /// 加载用户数据
  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final provider = context.read<UserProvider>();
      await provider.loadUserSettings();
      
      if (provider.currentUser != null) {
        final user = provider.currentUser!;
        setState(() {
          _ageController.text = user.age.toString();
          _weightController.text = user.weight.toString();
          _heightController.text = user.height.toString();
          _gender = user.gender;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('加载数据失败：$e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 保存用户数据
  Future<void> _saveUserData() async {
    // 验证表单
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final age = int.parse(_ageController.text);
      final weight = double.parse(_weightController.text);
      final height = int.parse(_heightController.text);

      final provider = context.read<UserProvider>();
      await provider.saveUserSettings(
        age: age,
        weight: weight,
        height: height,
        gender: _gender,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('保存成功！'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('保存失败：$e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人设置'),
        backgroundColor: const Color(0xFFFF6B35), // 橙色主题
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 头部提示
                    _buildHeaderCard(),
                    
                    const SizedBox(height: 24),
                    
                    // 年龄输入
                    _buildAgeInput(),
                    
                    const SizedBox(height: 16),
                    
                    // 体重输入
                    _buildWeightInput(),
                    
                    const SizedBox(height: 16),
                    
                    // 身高输入
                    _buildHeightInput(),
                    
                    const SizedBox(height: 16),
                    
                    // 性别选择
                    _buildGenderSelector(),
                    
                    const SizedBox(height: 32),
                    
                    // 保存按钮
                    _buildSaveButton(),
                    
                    const SizedBox(height: 16),
                    
                    // BMI 显示
                    _buildBMICard(),
                    
                    const SizedBox(height: 16),
                    
                    // 说明文字
                    _buildInfoCard(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFFF6B35),
              const Color(0xFFFF6B35).withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                size: 36,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '个人设置',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '设置您的个人信息，获取个性化建议',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAgeInput() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cake,
                  color: const Color(0xFFFF6B35),
                ),
                const SizedBox(width: 8),
                const Text(
                  '年龄',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '请输入年龄',
                suffixText: '岁',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入年龄';
                }
                final age = int.tryParse(value);
                if (age == null) {
                  return '请输入有效的数字';
                }
                if (age < 10 || age > 100) {
                  return '年龄必须在 10-100 之间';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightInput() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.monitor_weight,
                  color: const Color(0xFFFF6B35),
                ),
                const SizedBox(width: 8),
                const Text(
                  '体重',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: '请输入体重',
                suffixText: 'kg',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入体重';
                }
                final weight = double.tryParse(value);
                if (weight == null) {
                  return '请输入有效的数字';
                }
                if (weight < 30 || weight > 200) {
                  return '体重必须在 30-200kg 之间';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeightInput() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.height,
                  color: const Color(0xFFFF6B35),
                ),
                const SizedBox(width: 8),
                const Text(
                  '身高',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '请输入身高',
                suffixText: 'cm',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入身高';
                }
                final height = int.tryParse(value);
                if (height == null) {
                  return '请输入有效的数字';
                }
                if (height < 100 || height > 220) {
                  return '身高必须在 100-220cm 之间';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.male,
                  color: const Color(0xFFFF6B35),
                ),
                const SizedBox(width: 8),
                const Text(
                  '性别',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('男'),
                    subtitle: const Text('男性'),
                    value: 'male',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                    activeColor: const Color(0xFFFF6B35),
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('女'),
                    subtitle: const Text('女性'),
                    value: 'female',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                    activeColor: const Color(0xFFFF6B35),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isSaving ? null : _saveUserData,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF6B35),
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: _isSaving
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                '保存设置',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildBMICard() {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        final bmi = provider.bmi;
        final category = provider.bmiCategory;
        
        Color bmiColor;
        if (bmi < 18.5) {
          bmiColor = Colors.blue;
        } else if (bmi < 24) {
          bmiColor = Colors.green;
        } else if (bmi < 28) {
          bmiColor = Colors.orange;
        } else {
          bmiColor = Colors.red;
        }

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.analytics,
                      color: bmiColor,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'BMI 指数',
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bmi.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: bmiColor,
                          ),
                        ),
                        Text(
                          category,
                          style: TextStyle(
                            fontSize: 14,
                            color: bmiColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: bmiColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Icon(
                        Icons.info_outline,
                        color: bmiColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'BMI 是评估体重是否健康的重要指标',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  color: Colors.blue[700],
                ),
                const SizedBox(width: 8),
                Text(
                  '温馨提示',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '• 数据会保存在本地，重启后不会丢失\n'
              '• 准确的个人信息有助于提供更精准的建议\n'
              '• 建议定期更新体重数据',
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue[900],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
