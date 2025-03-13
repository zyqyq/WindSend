#!/bin/bash

# 定义变量
WORK_DIR="/Users/zyqyq/Program/WindSend/windSend-rs"
BINARY_PATH="${WORK_DIR}/target/aarch64-apple-darwin/release/wind_send"
ICONS_PATH="/Users/zyqyq/Program/WindSend/app_icon/macos/AppIcon.icns"
ICON_PATH="/Users/zyqyq/Program/WindSend/windSend-rs/src/icon-192.png"
APP_NAME="Windsend"
VERSION="1.4.101"
APP_BUNDLE="${APP_NAME}.app"

# 编译项目
echo "开始编译项目..."
cargo build --release --target aarch64-apple-darwin
if [ $? -ne 0 ]; then
    echo "编译失败，请检查错误信息！"
    exit 1
fi
echo "编译完成！"

# 清理旧文件
rm -rf "${APP_BUNDLE}" "${APP_NAME}.dmg"

# 创建 .app 结构
mkdir -p "${APP_BUNDLE}/Contents/MacOS"
mkdir -p "${APP_BUNDLE}/Contents/Resources"

# 复制二进制文件并赋予可执行权限
cp "$BINARY_PATH" "${APP_BUNDLE}/Contents/MacOS/"
chmod +x "${APP_BUNDLE}/Contents/MacOS/wind_send"  # 关键修复：确保可执行权限

# 创建 Info.plist
cat <<EOF > "${APP_BUNDLE}/Contents/Info.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>wind_send</string>
    <key>CFBundleIdentifier</key>
    <string>com.zyqyq.windsend</string>
    <key>CFBundleName</key>
    <string>${APP_NAME}</string>
    <key>CFBundleVersion</key>
    <string>${VERSION}</string>
    <key>CFBundleShortVersionString</key>
    <string>${VERSION}</string>
    <key>CFBundleIconFile</key>
    <string>AppIcon.icns</string>
    <key>LSUIElement</key>
    <true/>
    <key>com.apple.security.network.client</key>
    <true/>
    <key>com.apple.security.files.user-selected.read-write</key>
    <true/>
</dict>
</plist>
EOF

# 复制图标文件
cp "$ICONS_PATH" "${APP_BUNDLE}/Contents/Resources/AppIcon.icns"
cp "$ICON_PATH" "${APP_BUNDLE}/Contents/Resources/icon-192.png"
echo "封装完成！生成的文件为 ${APP_NAME}.app"

# 创建 .dmg
# hdiutil create -volname "${APP_NAME}" \
#                -srcfolder "${APP_BUNDLE}" \
#                -ov \
#                -format UDZO \
#                "${APP_NAME}.dmg"

#echo "打包完成！生成的文件为 ${APP_NAME}.dmg"
