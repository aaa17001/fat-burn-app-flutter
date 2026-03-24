#!/bin/bash

# 创建工具 App 模板脚本

set -e

echo "🚀 创建工具 App 模板"
echo "================================"
echo ""

# 模板目录
TEMPLATE_DIR="tool-app-template"

# 检查是否已存在
if [ -d "$TEMPLATE_DIR" ]; then
    echo "⚠️  模板目录已存在：$TEMPLATE_DIR"
    read -p "是否删除并重新创建？(y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$TEMPLATE_DIR"
    else
        echo "❌ 已取消"
        exit 1
    fi
fi

# 创建模板目录
echo "📁 创建模板目录..."
mkdir -p "$TEMPLATE_DIR"/{lib/{database,models,providers,screens,widgets},test,integration_test,.long-run}
echo "✅ 目录结构创建完成"
echo ""

# 创建 pubspec.yaml
echo "📝 创建 pubspec.yaml..."
cat > "$TEMPLATE_DIR/pubspec.yaml" << 'EOF'
name: tool-app-template
description: "工具 App 模板 - 可复用的基础结构"
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.2.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  provider: ^6.0.0
  sqflite: ^2.3.0
  path_provider: ^2.1.0
  path: ^1.8.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
  integration_test:
    sdk: flutter

flutter:
  uses-material-design: true
EOF
echo "✅ pubspec.yaml 创建完成"
echo ""

# 创建 main.dart
echo "📝 创建 main.dart..."
cat > "$TEMPLATE_DIR/lib/main.dart" << 'EOF'
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'screens/home_screen.dart';
import 'screens/payment_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Tool App Template',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: const Color(0xFFFF6B35),
          scaffoldBackgroundColor: Colors.grey[50],
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
EOF
echo "✅ main.dart 创建完成"
echo ""

# 创建基础屏幕
echo "📝 创建基础屏幕..."

# home_screen.dart
cat > "$TEMPLATE_DIR/lib/screens/home_screen.dart" << 'EOF'
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tool App Template'),
        backgroundColor: const Color(0xFFFF6B35),
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
EOF

# payment_screen.dart (占位)
cat > "$TEMPLATE_DIR/lib/screens/payment_screen.dart" << 'EOF'
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('升级高级版'),
        backgroundColor: const Color(0xFFFF6B35),
      ),
      body: const Center(
        child: Text('Payment Screen - TODO'),
      ),
    );
  }
}
EOF

# settings_screen.dart
cat > "$TEMPLATE_DIR/lib/screens/settings_screen.dart" << 'EOF'
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        backgroundColor: const Color(0xFFFF6B35),
      ),
      body: const Center(
        child: Text('Settings Screen'),
      ),
    );
  }
}
EOF

echo "✅ 基础屏幕创建完成"
echo ""

# 创建共享组件
echo "📝 创建共享组件..."

# database_helper.dart
cat > "$TEMPLATE_DIR/lib/database/database_helper.dart" << 'EOF'
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tool_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        settings TEXT,
        created_at TEXT NOT NULL
      )
    ''');
  }
}
EOF

# user_provider.dart
cat > "$TEMPLATE_DIR/lib/providers/user_provider.dart" << 'EOF'
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  bool _isPurchased = false;
  bool _isSubscribed = false;

  bool get isPurchased => _isPurchased;
  bool get isSubscribed => _isSubscribed;

  Future<void> setPurchased(bool value) async {
    _isPurchased = value;
    notifyListeners();
  }

  Future<void> setSubscribed(bool value) async {
    _isSubscribed = value;
    notifyListeners();
  }
}
EOF

echo "✅ 共享组件创建完成"
echo ""

# 创建 .long-run 目录
echo "📝 创建进度追踪..."

# progress.md
cat > "$TEMPLATE_DIR/.long-run/progress.md" << 'EOF'
# 项目开发进度

**项目：** Tool App Template
**开始日期：** 2026-03-24
**当前 Session：** Session 1

---

## 📊 总体进度

**总功能数：** 50
**已完成：** 0
**待完成：** 50
**完成率：** 0%

---

## 📝 Session 日志

### Session 1 (2026-03-24)

**完成内容：**
- 创建项目模板
- 创建基础结构
- 创建共享组件

**下一步：**
- 实现 feat-001-01
- 实现 feat-001-02
- ...

EOF

# feature-list.json (简化版)
cat > "$TEMPLATE_DIR/.long-run/feature-list.json" << 'EOF'
{
  "project": "Tool App Template",
  "version": "1.0",
  "features": [
    {
      "id": "feat-001-01",
      "category": "core",
      "priority": "P0",
      "description": "应用启动",
      "steps": ["启动应用", "验证无崩溃"],
      "acceptanceCriteria": ["应用正常启动"],
      "passes": false
    },
    {
      "id": "feat-001-02",
      "category": "core",
      "priority": "P0",
      "description": "主界面显示",
      "steps": ["显示主界面", "验证 UI"],
      "acceptanceCriteria": ["主界面正常显示"],
      "passes": false
    },
    {
      "id": "feat-002-01",
      "category": "payment",
      "priority": "P0",
      "description": "付费页面打开",
      "steps": ["导航到付费页", "显示选项"],
      "acceptanceCriteria": ["付费页面正常"],
      "passes": false
    }
  ]
}
EOF

echo "✅ 进度追踪创建完成"
echo ""

# 创建测试文件
echo "📝 创建测试文件..."

# widget_test.dart
cat > "$TEMPLATE_DIR/test/widget_test.dart" << 'EOF'
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tool_app_template/main.dart';

void main() {
  testWidgets('App 启动测试', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
EOF

echo "✅ 测试文件创建完成"
echo ""

# 设置执行权限
chmod +x "$TEMPLATE_DIR/.long-run/"*.md 2>/dev/null || true

# 创建 README
echo "📝 创建 README..."
cat > "$TEMPLATE_DIR/README.md" << 'EOF'
# Tool App Template

工具 App 模板 - 用于批量创建工具类 App

## 📁 目录结构

```
tool-app-template/
├── lib/
│   ├── database/          # 数据库
│   ├── models/            # 数据模型
│   ├── providers/         # 状态管理
│   ├── screens/           # 屏幕页面
│   └── widgets/           # 组件
├── test/                  # 单元测试
├── integration_test/      # E2E 测试
├── .long-run/             # 进度追踪
└── pubspec.yaml           # 依赖配置
```

## 🚀 使用方法

### 1. 复制模板

```bash
cp -r tool-app-template apps/my-app
```

### 2. 修改配置

```bash
cd apps/my-app
# 修改 pubspec.yaml 中的 name 和 description
# 修改 lib/main.dart 中的应用名称
```

### 3. 开始开发

```bash
./scripts/opencode-session.sh
```

## 📊 功能清单

标准功能（50 个）：
- 核心功能（8 个）
- UI 功能（20 个）
- 支付功能（10 个）
- 特定功能（12 个）

## 📈 进度追踪

查看 `.long-run/progress.md` 和 `.long-run/feature-list.json`

EOF

echo "✅ README 创建完成"
echo ""

# 完成
echo "================================"
echo "🎉 模板创建完成！"
echo "================================"
echo ""
echo "模板位置：$TEMPLATE_DIR/"
echo ""
echo "下一步:"
echo "  1. 查看模板：cd $TEMPLATE_DIR && ls -la"
echo "  2. 批量创建：./scripts/batch-create-apps.sh"
echo "  3. 开始开发：cd apps/[app_name] && ./scripts/opencode-session.sh"
echo ""
