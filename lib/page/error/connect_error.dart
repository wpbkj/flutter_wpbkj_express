// description: 网络链接出错页面，一般在splash进行网络检查出错时显示，无网络禁止进入应用
// author: WPBKJ
// date: 2023-02-07

import 'package:flutter/material.dart';
import 'package:wpbkj_express/main.dart';
import 'package:wpbkj_express/page/info/feedback.dart';

class ConnectErrorPage extends StatefulWidget {
  const ConnectErrorPage({Key? key}) : super(key: key);
  @override
  State<ConnectErrorPage> createState() => _ConnectErrorPageState();
}

class _ConnectErrorPageState extends State<ConnectErrorPage> {
  @override
  Widget build(BuildContext context) {
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
            Icons.cloud_off,
            color: Colors.red,
            size: 100,
          ),
          const SizedBox(height: 30),
          const Text(
            'API服务器连接失败，请检查网络连接或稍后重试',
            style: TextStyle(color: Colors.red, fontSize: 17),
          ),
          TextButton(
            onPressed: () {
              // 跳转到问题反馈页面
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const FeedbackPage();
              }));
            },
            child: const Text(
              '一直显示API连接失败？点击向开发者反馈！',
              style: TextStyle(fontSize: 17),
            ),
          ),
          ElevatedButton(
              // 重新进入splash,此处应删除路由历史防止使用返回键回到该页面
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  "/", (Route<dynamic> route) => false),
              child: const Text('重试'))
        ],
      ),
    )));
  }
}
