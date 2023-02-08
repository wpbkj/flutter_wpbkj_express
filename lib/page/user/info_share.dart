// description: 个人信息共享清单页面
// author: WPBKJ
// date: 2023-02-07

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InfoSharePage extends StatefulWidget {
  const InfoSharePage({Key? key}) : super(key: key);
  @override
  State<InfoSharePage> createState() => _InfoSharePageState();
}

class _InfoSharePageState extends State<InfoSharePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('个人信息共享清单')),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                  '为保证本应用正常运行和实现相关功能，我们需要接入由第三方提供的接口服务，向第三方共享信息以实现前述目的。'),
              const SizedBox(height: 10),
              const Text(
                '共享第三方',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Card(
                  child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '共享第三方名称',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text('ALAPI'),
                    const Divider(),
                    const Text(
                      '共享第三方产品',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text('快递查询'),
                    const Divider(),
                    const Text(
                      '个人信息种类',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text('快递运单号'),
                    const Divider(),
                    const Text(
                      '使用目的',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text('用于获得快递运输信息，实现查件追踪功能'),
                    const Divider(),
                    const Text(
                      '使用场景',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text('用户使用本应用进行运单查询'),
                    const Divider(),
                    const Text(
                      '共享方式',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text('接口传输'),
                    const Divider(),
                    const Text(
                      '共享第三方隐私政策或官网',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    // 实现超链接效果
                    GestureDetector(
                      child: const Text(
                        'http://www.alapi.cn/',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      onTap: () {
                        launchUrlString('http://www.alapi.cn/',
                            mode: LaunchMode.externalApplication);
                      },
                    ),
                  ],
                ),
              )),
            ]),
          )
        ],
      ),
    );
  }
}
