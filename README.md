<div align="center">
<h1>WPBKJ 快递查询助手</h1>
<img src="assets/logo.png" width="100">

![flutter_wpbkj_express](https://img.shields.io/badge/flutter-wpbkj__express-blue)![License](https://img.shields.io/github/license/wpbkj/flutter_wpbkj_express)![version](https://img.shields.io/badge/version-v1.0.5-blue)[![Flutter Responsive](https://img.shields.io/badge/flutter-responsive-brightgreen.svg?style=flat-square)](https://github.com/Codelessly/ResponsiveFramework)![Language Count](https://img.shields.io/github/languages/count/wpbkj/flutter_wpbkj_express)![Top Language](https://img.shields.io/github/languages/top/wpbkj/flutter_wpbkj_express)![Code Size](https://img.shields.io/github/languages/code-size/wpbkj/flutter_wpbkj_express)![repo Size](https://img.shields.io/github/repo-size/wpbkj/flutter_wpbkj_express)![Platform](https://img.shields.io/badge/platform-Android%20%7C%20Windows%20%7C%20Linux%20%7C%20iOS%20%7C%20MacOS-brightgreen)

简体中文 | [English](README.en.md)

[项目官方介绍页面](https://www.wpbkj.com/archives/flutter_wpbkj_express.html)
</div>

## 介绍
**WPBKJ 快递查询助手**初衷是做一款Flutter入门软件，源代码注释详细，适合Flutter新手学习参考。
**WPBKJ 快递查询助手**基于Flutter，实现全平台应用，通过调用快递查询API实现快递查询目标：
 
- **功能丰富** ：支持快递查询，添加标签，清空数据等；
- **易于读懂** ：源代码注释丰富，尽量在小的细节都添加注释，使得Flutter初学者可轻松理解；
- **跨平台性** ：支持Android，Windows，Linux，iOS，MacOS等平台。

若国内图片无法加载可访问[GITEE同名仓库](https://gitee.com/wpbkj/flutter_wpbkj_express)

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

Linux请下载``Linux-bundle.tar.gz``解压后运行``bundle/wpbkj_express``直接使用  

Windows请下载``Windows-Release.zip``解压后运行``Release/wpbkj_express.exe``直接使用  

## 项目衍生文章

<table>
	<tr>
		<th colspan ="6">【Flutter】如何自定义Flutter MaterialApp主题色(primarySwatch)？</th>
	</tr>
	<tr>
		<td>微信公众号</td>
		<td>掘金</td>
		<td>CSDN</td>
		<td>知乎</td>
		<td>百家号</td>
		<td>博客</td>
	</tr>
	<tr>
		<td><a href="https://mp.weixin.qq.com/s/j5YE_2Tr03OCbI5BSbFxvw" target="_blank">点我</a></td>
		<td><a href="https://juejin.cn/post/7197955458963324989/" target="_blank">点我</a></td>
		<td><a href="https://blog.csdn.net/wpb1047199265/article/details/128948152" target="_blank">点我</a></td>
		<td><a href="https://zhuanlan.zhihu.com/p/604744176" target="_blank">点我</a></td>
		<td><a href="https://baijiahao.baidu.com/builder/preview/s?id=1757319432010231624" target="_blank">点我</a></td>
		<td><a href="https://www.wpbkj.com/archives/flutter-diy-primarySwatch.html" target="_blank">点我</a></td>
	</tr>
</table>

## 编译流程
如您需要自行编译学习，请遵循以下流程  

> 请先确保您的Flutter版本为``3.7``

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
## 最新版本更新日志

``1.0.5版本更新``  
``适配更多快递公司``  
``取消无网络禁止进入``  

## 联系作者
**WPBKJ**  
``微信`` : ``wpbkj123``  
``QQ`` : ``64345171``  
``个人博客`` : ``https://www.wpbkj.com/``  
``邮箱`` : ``wpbkj123@163.com``  
``微信公众号`` : ``WPBKJ小站``  

<img src="assets/gzh.jpg" width="200">

## 屏幕截图
### 移动端
<img src="screenshots/1.jpg" width="300"><img src="screenshots/2.jpg" width="300"><img src="screenshots/3.jpg" width="300"><img src="screenshots/4.jpg" width="300">

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