// description: 数据库出错页面，一般在splash进行数据库初始化出错时显示，无法使用数据库禁止进入软件
// author: WPBKJ
// date: 2023-02-07

import 'package:flutter/material.dart';
import 'package:wpbkj_express/main.dart';
import 'package:wpbkj_express/page/info/feedback.dart';

class DBErrorPage extends StatefulWidget {
  const DBErrorPage({Key? key}) : super(key: key);
  @override
  State<DBErrorPage> createState() => _DBErrorPageState();
}

class _DBErrorPageState extends State<DBErrorPage> {
  @override
  Widget build(BuildContext context) {
    dynamic argMap = ModalRoute.of(context)?.settings.arguments;
    String initDBresult = '';
    Map argument = {};
    if (argMap != null && (argMap as Map).isNotEmpty) {
      argument = argMap;
      initDBresult = argument['message'];
    }

    return Scaffold(
        body: Center(
            child: Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(appTitle),
          const SizedBox(height: 30),
          const Icon(
            Icons.code_off_outlined,
            color: Colors.red,
            size: 100,
          ),
          const SizedBox(height: 30),
          const Text(
            '数据库服务出错,您将无法使用本应用,请点击下方链接,向开发者反馈您的机型',
            style: TextStyle(color: Colors.red, fontSize: 17),
          ),
          const SizedBox(height: 10),
          Text(
            '错误信息：$initDBresult',
            style: const TextStyle(fontSize: 17),
          ),
          TextButton(
            onPressed: () {
              // 跳转到问题反馈页面
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const FeedbackPage();
              }));
            },
            child: const Text(
              '点击向开发者反馈',
              style: TextStyle(fontSize: 17),
            ),
          ),
          ElevatedButton(
              // 重新进入splash,此处应删除路由历史防止使用返回键回到该页面
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  "/", (Route<dynamic> route) => false),
              child: const Text('重试')),
        ],
      ),
    )));
  }
}
