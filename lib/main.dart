//   Copyright 2023 WPBKJ(www.wpbkj.com)
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.

// description: WPBKJ快递查询助手入口文件
// author: WPBKJ
// date: 2023-02-07

import 'package:flutter/material.dart';
import 'package:wpbkj_express/app.dart';
import 'package:flutter/foundation.dart';
import 'package:window_manager/window_manager.dart';

const String appTitle = "WPBKJ快递查询助手"; // 应用标题
const String version = "1.0.3"; // 应用版本号
const String githubUrl =
    "https://github.com/wpbkj/flutter_wpbkj_express"; // GITHUB开源仓库地址
const String giteeUrl =
    "https://gitee.com/wpbkj/flutter_wpbkj_express"; // GITEE开源仓库地址
const String officialUrl =
    "https://www.wpbkj.com/archives/flutter_wpbkj_express.html"; // 官方介绍页面地址

// 判断是否为桌面端方法
bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

// 入口main()函数
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 是桌面端时使用windowManager进行窗口设置
  if (isDesktop) {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      title: appTitle, // 窗口标题
      size: Size(800, 600), // 窗口默认大小
      minimumSize: Size(800, 600), // 允许最新窗口大小
      center: true, // 窗口居中
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(const MyApp());
}
