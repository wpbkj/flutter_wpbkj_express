// description: splash闪屏页
// author: WPBKJ
// date: 2023-02-07

import 'package:flutter/material.dart';
import 'package:wpbkj_express/main.dart';
import 'package:wpbkj_express/db/db.dart';
import 'package:wpbkj_express/request/api_post.dart';
import 'package:wpbkj_express/widget/easy_splash_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<List<dynamic>> futureCall() async {
    bool connectStatus = await checkAPIconnect();
    String initDBresult = await initDB();
    if (connectStatus) {
      if (initDBresult != 'initialized' && initDBresult != 'success') {
        // 当数据库初始化出问题时跳转数据库错误页面并传递问题描述参数
        // 已修改easy_splash_screen,使其可以传递参数,具体见widget/easy_splash_screen.dart
        return [
          "/db_error",
          {"message": initDBresult}
        ];
      } else {
        // 所有检查都没问题跳转主页
        return ["/home"];
      }
    } else {
      // 当网络连接检查出问题时(无网络连接或API服务器终端)跳转网络连接错误页面
      return ["/connect_error"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/logo.png'),
      title: const Text(
        appTitle,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      showLoader: true,
      loadingText: const Text("正在进行必备检查"),
      futureNavigator: futureCall(),
    );
  }
}
