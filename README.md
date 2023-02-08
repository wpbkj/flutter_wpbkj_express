# 欢迎使用WPBKJ 快递查询助手
<img src="assets/logo.png" width="100">

![flutter_wpbkj_express](https://img.shields.io/badge/flutter-wpbkj__express-blue)![Apache License](https://img.shields.io/badge/license-Apache%202-green)![version](https://img.shields.io/badge/version-v1.0.3-blue)[![Flutter Responsive](https://img.shields.io/badge/flutter-responsive-brightgreen.svg?style=flat-square)](https://github.com/Codelessly/ResponsiveFramework)

[项目官方介绍页面](https://www.wpbkj.com/archives/flutter_wpbkj_express.html)
## 介绍
**WPBKJ 快递查询助手**初衷是做一款Flutter入门软件，源代码注释详细，适合Flutter新手学习参考。
**WPBKJ 快递查询助手**基于Flutter，实现全平台应用，通过调用快递查询API实现快递查询目标：
 
- **功能丰富** ：支持快递查询，添加标签，清空数据等；
- **易于读懂** ：源代码注释丰富，尽量在小的细节都添加注释，使得Flutter初学者可轻松理解；
- **跨平台性** ：支持Android，Windows，Linux，iOS，MacOS等平台。

-------------------

## 使用  
releases发布Android、Windows和Linux版本，其他平台可自行编译使用(后期测试设备允许后全平台release将发布)  
Android、Windows和Linux可直接下载releases最新发行版使用  

[releases](https://github.com/wpbkj/flutter_wpbkj_express/releases)  
 
Android通常根据系统架构选择下载文件  
Android通常架构为``arm64``，下载``arm64``版即可使用  
如您不清楚或不确定系统架构，请下载通用版本(体积稍大)  
``所有架构通用``:``app-release.apk``  
``arm64``:``app-arm64-v8a-release.apk``  
``armeabi``:``app-armeabi-v7a-release.apk``  
``x86_64``:``app-x86_64-release.apk``   

Windows请下载``Linux-bundle.tar.gz``解压后运行``bundle/wpbkj_express``直接使用  

Linux请下载``Windows-Release.zip``解压后运行``Release/wpbkj_express.exe``直接使用  

## 编译流程
如您需要自行编译学习，请遵循以下流程  
Flutter版本：3.7.0  
Dart 版本：2.19.0  
### 1、申请API token(可选)
若您仅学习UI界面可忽略此步骤。

本应用依赖由``ALAPI``提供的API接口实现主要功能，在您自行编译本应用前请先前往[ALAPI用户管理中心](https://admin.alapi.cn/user/login)申请token(免费版每天可有200次调用，学习完全够用)

申请token后请将token填写到：  
``lib/api/config.dart``  
文件中，修改变量``token``的值即可
### 2、开始编译
``` Shell
flutter pub get  
flutter run
```
## 最新更新日志

``1.0.3版本更新``  
``增加开源仓库及官方页面链接常量，并在各页面绑定``  
``修复运单详细信息页面点击运单号无法复制bug``  
``修复支持页面链接错误bug``  
``修复开放源代码许可页面名称错误bug``  
``关于页面添加检查更新按钮``  
``重写全局主题色``  
``添加Linux打包release``

## 联系作者
WPBKJ
``微信`` : ``wpbkj123``
``QQ`` : ``64345171``
``个人博客`` : ``https://www.wpbkj.com/``
``邮箱`` : ``wpbkj123@163.com``
``微信公众号`` : ``WPBKJ小站``

<img src="assets/gzh.jpg" width="200">

## 屏幕截图
### 移动端
<img src="screenshots/1.jpg" width="300"><img src="screenshots/2.jpg" width="300"><img src="screenshots/3.jpg" width="300"><img src="screenshots/4.jpg" width="300"><img src="screenshots/5.jpg" width="300">

### 桌面端
<img src="screenshots/d1.png" width="500"><img src="screenshots/d2.png" width="500"><img src="screenshots/d3.png" width="500">

## 支持本项目
### 开源贡献
您可以提交issues和pr，这是对本项目的最大支持
### 捐助
<img src="assets/wechat.jpg" width="300"><img src="assets/alipay.jpg" width="300"><img src="assets/qqpay.jpg" width="300">

## License
``` License
wpbkj/flutter_wpbkj_express is licensed under the
Apache License 2.0

A permissive license whose main conditions require preservation of copyright and license notices. 
Contributors provide an express grant of patent rights. 
Licensed works, modifications, and larger works may be distributed under different terms and without source code.
```