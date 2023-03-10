// description: 支持项目页面
// author: WPBKJ
// date: 2023-02-07

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wpbkj_express/main.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);
  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('支持项目')),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('您可以通过诸多不同途径来支持本项目：'),
              const SizedBox(height: 10),
              const Text(
                '参与开源项目建设',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text('欢迎提交issues和pr，一个小小的star也是对我们的大力支持'),
              Card(
                  child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'GITHUB开源地址',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    // 实现超链接效果
                    GestureDetector(
                      child: const Text(
                        githubUrl,
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      onTap: () {
                        launchUrlString(githubUrl,
                            mode: LaunchMode.externalApplication);
                      },
                    ),
                    const Divider(),
                    const Text(
                      'GITEE开源地址',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    // 实现超链接效果
                    GestureDetector(
                      child: const Text(
                        giteeUrl,
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      onTap: () {
                        launchUrlString(giteeUrl,
                            mode: LaunchMode.externalApplication);
                      },
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 20),
              const Text(
                '赞助',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Card(
                  child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '微信',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Image.asset(
                        'assets/wechat.jpg',
                        fit: BoxFit.fitWidth,
                      ),
                      const Divider(),
                      const Text(
                        '支付宝',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Image.asset('assets/alipay.jpg'),
                      const Divider(),
                      const Text(
                        'QQ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Image.asset('assets/qqpay.jpg'),
                    ]),
              )),
            ]),
          )
        ],
      ),
    );
  }
}
