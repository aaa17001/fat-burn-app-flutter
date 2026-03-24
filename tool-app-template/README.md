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

