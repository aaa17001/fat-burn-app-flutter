# 📱 燃脂助手 - APK 安装包获取指南

## 🎯 三种获取 APK 的方式

---

### 【方式 A】GitHub Actions 自动构建（推荐）⭐

**步骤：**

1. **推送代码到 GitHub**
   ```bash
   cd fat-burn-app-flutter
   git remote add origin https://github.com/aaa17001/fat-burn-app-flutter.git
   git branch -M main
   git push -u origin main
   ```

2. **在 GitHub 创建仓库**
   - 访问：https://github.com/new
   - 仓库名：`fat-burn-app-flutter`
   - 公开（Public）

3. **查看构建进度**
   - 访问：https://github.com/aaa17001/fat-burn-app-flutter/actions
   - 等待绿色对勾 ✅（约 10-15 分钟）

4. **下载 APK**
   - 点击最新的构建记录
   - 在 "Artifacts" 部分下载 `fat-burn-coach-apk.zip`
   - 解压得到 `app-release.apk`

**优势：**
- ✅ 无需安装 Flutter
- ✅ 自动构建
- ✅ 每次推送自动更新

---

### 【方式 B】本地安装 Flutter

**步骤：**

1. **下载 Flutter SDK**
   ```bash
   cd /home/lh
   wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.16.0-stable.tar.xz
   ```

2. **解压**
   ```bash
   tar xf flutter_linux_3.16.0-stable.tar.xz
   export PATH="$PATH:$HOME/flutter/bin"
   ```

3. **接受许可**
   ```bash
   flutter doctor --android-licenses
   ```

4. **构建 APK**
   ```bash
   cd fat-burn-app-flutter
   flutter pub get
   flutter build apk --release
   ```

5. **APK 位置**
   ```
   build/app/outputs/flutter-apk/app-release.apk
   ```

**预计时间：** 30-60 分钟（含下载）
**所需空间：** 约 3GB

---

### 【方式 C】使用 Codemagic（在线构建）

**步骤：**

1. **访问 Codemagic**
   - https://codemagic.io

2. **连接 GitHub**
   - 使用 GitHub 登录
   - 授权访问仓库

3. **创建项目**
   - 选择 `fat-burn-app-flutter` 仓库
   - 选择 "Flutter" 模板

4. **开始构建**
   - 点击 "Start build"
   - 等待完成（约 15-20 分钟）

5. **下载 APK**
   - 构建完成后下载
   - 扫描 QR 码安装到手机

**优势：**
- ✅ 无需配置
- ✅ 免费额度：500 分钟/月
- ✅ 支持 iOS 和 Android

---

## 📦 APK 信息

| 项目 | 信息 |
|------|------|
| 应用名称 | 燃脂助手 FatBurn Coach |
| 版本 | 1.0.0 |
| 平台 | Android 5.0+ |
| 大小 | 约 30-50 MB |
| 架构 | arm64-v8a, armeabi-v7a |

---

## 📱 安装到手机

**方式 1：USB 传输**
1. 手机连接电脑
2. 复制 APK 到手机
3. 在手机上安装

**方式 2：二维码**
1. 上传 APK 到网盘
2. 生成下载二维码
3. 手机扫码下载安装

**方式 3：ADB 安装**
```bash
adb install app-release.apk
```

---

## ⚠️ 注意事项

1. **未知来源应用**
   - 手机需要允许"未知来源"安装
   - 设置 → 安全 → 未知来源

2. **签名**
   - 当前是 Debug 签名
   - 正式发布需要配置签名

3. **权限**
   - 首次运行需要授予权限
   - 计步器、通知等

---

## 🚀 推荐方案

**立即获取 APK：**
- 使用 **方式 A**（GitHub Actions）
- 推送代码后 10-15 分钟即可下载

**长期开发：**
- 使用 **方式 B**（本地安装 Flutter）
- 方便调试和快速迭代

---

## 📞 需要帮助？

如果遇到问题：
1. 检查 GitHub Actions 日志
2. 查看构建错误信息
3. 根据错误调整配置

---

**现在选择一种方式获取 APK 吧！** 📱
