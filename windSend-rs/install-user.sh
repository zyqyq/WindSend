#!/bin/bash

# 定义变量
INSTALL_DIR="$HOME/.windSend"
EXECUTABLE_NAME="windSend-rs"
SERVICE_NAME="com.user.windSend"
LAUNCH_AGENTS_DIR="$HOME/Library/LaunchAgents"

# 检查是否已安装
if [ -d "$INSTALL_DIR" ]; then
    echo "WindSend Rust Server 已经安装在 $INSTALL_DIR。如果需要重新安装，请先卸载。"
    exit 1
fi

# 创建安装目录
mkdir -p "$INSTALL_DIR"
echo "创建安装目录: $INSTALL_DIR"

# 复制可执行文件到安装目录
cp "./$EXECUTABLE_NAME" "$INSTALL_DIR/$EXECUTABLE_NAME"
chmod +x "$INSTALL_DIR/$EXECUTABLE_NAME"
echo "复制可执行文件到安装目录"

# 创建 LaunchAgent 配置文件
cat > "$LAUNCH_AGENTS_DIR/$SERVICE_NAME.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>$SERVICE_NAME</string>
    <key>ProgramArguments</key>
    <array>
        <string>$INSTALL_DIR/$EXECUTABLE_NAME</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>$INSTALL_DIR/output.log</string>
    <key>StandardErrorPath</key>
    <string>$INSTALL_DIR/error.log</string>
</dict>
</plist>
EOF
echo "创建 LaunchAgent 配置文件: $LAUNCH_AGENTS_DIR/$SERVICE_NAME.plist"

# 设置权限
chmod 644 "$LAUNCH_AGENTS_DIR/cargo build --release --target aarch64-apple-darwin && cp target/aarch64-apple-darwin/release/<your_program_name> /path/to/destination$SERVICE_NAME.plist"
echo "设置 LaunchAgent 配置文件权限"

# 加载并启动服务
launchctl load "$LAUNCH_AGENTS_DIR/$SERVICE_NAME.plist"
launchctl start "$SERVICE_NAME"
echo "服务已加载并启动"

echo "WindSend Rust Server 安装完成！"