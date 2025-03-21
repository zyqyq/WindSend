<h3 align="center"> English | <a href='https://github.com/doraemonkeys/WindSend'>简体中文</a></h3>


# WindSend

## What is WindSend

A set of applications for quickly and securely transferring clipboards, transferring files or directories between different devices (supports image and file clipboards).

## Why choose WindSend

- **Security** - All data is transmitted encrypted (even if it is a LAN, some people want to be more secure, such as me)
- **Simple** - The interface is simple and easy to use, open source, free of advertising, and focuses on information transmission
- **Comprehensive** - Automatically match the computer with the same key in the LAN, and don't worry about switching wifi
- **Worry-free** - Don't worry about the connection status with the computer anymore, as long as the computer is online, the mobile phone can send
- **Fast** - Use multi-threaded asynchronous transmission of files to make full use of bandwidth.
- **Lightweight** - Does not depend on additional runtime environment, memory usage is less than 10M when idle, and basically no CPU consumption

![image-20231014225053389](https://raw.githubusercontent.com/doraemonkeys/picture/master/1/202310142251417.png)

## How to use

> **Note**: During the configuration phase, make sure that the computer and mobile phone are on the same network.



### Download

github：[Releases · WindSend](https://github.com/doraemonkeys/WindSend/releases)


> PC: Generally, you can choose to download the **x64 Rust** version (⚠️ Do not download the Flutter version!!!)
> 
> Mobile: Generally, you can choose to download WindSend-flutter-arm64-v8a-release.apk



### PC

#### Linux

1. Unzip **WindSend-linux-x64-S-Rust-v\*.zip** to any directory (minimum version 1.3.0).

   ```shell
    sudo apt install libxdo3
   ```
   ```shell
    nohup ./WindSend-S-Rust &
   ```
   > If GLIBC version does not match, you can download compatible version or compile it yourself

#### Windows

1. Unzip **WindSend-windows-x64-S-Rust-v\*.zip** to any directory (Take Windows).

2. Double-click the exe file to run:
   Please click to allow windows firewall, **Note** check the public network (bold check, all content is encrypted).

   ![image-20240124214446056](https://raw.githubusercontent.com/doraemonkeys/picture/master/1/202401242148675.png)

   You can see the app icon in the taskbar system tray, and the default configuration file is generated in the current directory.

   ![image-20240124202216544](https://raw.githubusercontent.com/doraemonkeys/picture/master/1/202401242022889.png)

   If you forget to check the public network, please manually set it in Windows Firewall, or **make sure you are using a dedicated network**.

   ![image-20240124214658197](https://raw.githubusercontent.com/doraemonkeys/picture/master/1/202401242148554.png)

3. Turn on fast pairing so that the phone can search (fast pairing will automatically turn off after the first successful pairing).

   ![image-20240124214230894](https://raw.githubusercontent.com/doraemonkeys/picture/master/1/202401242148592.png)

### Mobile

1. Install the APP.
2. Open the app and click the Add button to add a device.

   <img src="https://raw.githubusercontent.com/doraemonkeys/picture/master/1/202401242148381.png" alt="image-20240124214205549" style="zoom:50%;" />

3. After the computer turns on the quick pair,tap the phone a few times to search, and if you're lucky, you'll see the Secretkey filled in automatically.
4. Finally, the exciting moment has arrived. Copy a piece of text on your phone, open the app and click paste, and the computer will pop up a notification instantly. Congratulations, you have successfully completed the configuration and can use it happily.



### Failed pairing? Manually add the device key

Open the default configuration file `config.yaml`, copy secretKeyHex, and fill in the app configuration manually.

<img src="https://raw.githubusercontent.com/Doraemonkeys/picture/master/1/202306212049362.png" alt="image-20230621192929505" style="zoom: 67%;" />

> In most cases, failure to pair quickly means that the network between your devices is not connected. Please use your phone's hotspot and try again.



### Note

- The time difference between the two devices cannot exceed 5 minutes, otherwise the pairing will fail.
- Notification delivery on Windows relies on PowerShell, if you don't see notifications, check that PowerShell is in the environment variable.
- APP's location permission is used to obtain WIFI information.

## Tips

- **Long press to upload mobile phone folder**
  
  ![image-20240124214021079](https://raw.githubusercontent.com/doraemonkeys/picture/master/1/202401242149396.png)

- **Quickly copy folders**

<img src="https://raw.githubusercontent.com/doraemonkeys/picture/master/1/202401242149133.png" alt="image-20240124205814355" style="zoom: 33%;" />



## Cross-platform situation

Since the author only has Android and Windows devices, it is not guaranteed that the software will function normally on other platforms.



The server-side code is available in both Go and Rust, and the main libraries are cross-platform, so additional platform support and optimizations are only a matter of changing the source code slightly.The author's ability is  still shallow, and experts are welcome to PR.



### Flutter

|         | Windows | macOS | Linux | Android | iOS  |
| ------- | ------- | ----- | ----- | ------- | ---- |
| Compile | ✅       | ✅     | ✅     | ✅       | ✅    |
| Run     | ✅       | ❔     | ✅     | ✅       | ❔    |



### Rust

|         | Windows | macOS | Linux | Android | iOS  |
| ------- | ------- | ----- | ----- | ------- | ---- |
| Compile | ✅       | ✅     | ✅     | ❕       | ❕    |
| Run     | ✅       | ❔     | ✅     | ❕       | ❕    |



### Go (End of life)

|         | Windows | macOS | Linux | Android | iOS  |
| ------- | ------- | ----- | ----- | ------- | ---- |
| Compile | ✅       | ❌     | ❌     | ❕       | ❕    |
| Run     | ✅       |       |       | ❕       | ❕    |


## Build

### Flutter

version: channel stable

#### Requirements

[Install Rust](https://www.rust-lang.org/tools/install)

### Rust

#### toolchain

- **windows x86_64**

  stable-x86_64-pc-windows-msvc

- **windows aarch64**

  aarch64-pc-windows-msvc

- **Linux x86_64**

  x86_64-unknown-linux-gnu

- **MacOS x86_64**

  x86_64-apple-darwin

- **MacOS aarch64**

  aarch64-apple-darwin

#### Requirements

[AWS Libcrypto for Rust User Guide](https://aws.github.io/aws-lc-rs/requirements/index.html)

[.github/workflows/rust_build.yml](https://github.com/doraemonkeys/WindSend/blob/main/.github/workflows/rust_build.yml)


**Linux**

```shell
sudo apt install -y libgtk-3-dev libxdo-dev libappindicator3-dev 
sudo apt install -y pkg-config libssl-dev build-essential linux-libc-dev
sudo apt install -y musl-dev musl-tools
```


### Go

version: 1.21+