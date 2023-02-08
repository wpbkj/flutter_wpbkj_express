// description: 联系作者页面
// author: WPBKJ
// date: 2023-02-07

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AuthorInfoPage extends StatefulWidget {
  const AuthorInfoPage({Key? key}) : super(key: key);
  @override
  State<AuthorInfoPage> createState() => _AuthorInfoPageState();
}

class _AuthorInfoPageState extends State<AuthorInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('联系作者')),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('您可通过以下方式联系作者'),
              const SizedBox(height: 10),
              const Text(
                '作者联系方式',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Card(
                  child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '作者',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text('WPBKJ'),
                    const Divider(),
                    const Text(
                      '博客',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    // 实现超链接效果
                    GestureDetector(
                      child: const Text(
                        'https://www.wpbkj.com/',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      onTap: () {
                        launchUrlString('https://www.wpbkj.com/',
                            mode: LaunchMode.externalApplication);
                      },
                    ),
                    const Divider(),
                    const Text(
                      '微信',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text('wpbkj123'),
                    const Divider(),
                    const Text(
                      'QQ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text('64345171'),
                    const Divider(),
                    const Text(
                      '邮箱',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    // 实现超链接效果
                    GestureDetector(
                      child: const Text(
                        'wpbkj123@163.com',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      onTap: () {
                        launchUrlString('mailto:wpbkj123@163.com',
                            mode: LaunchMode.externalApplication);
                      },
                    ),
                    const Divider(),
                    const Text(
                      'GITEE',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    // 实现超链接效果
                    GestureDetector(
                      child: const Text(
                        'https://gitee.com/wpbkj/',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      onTap: () {
                        launchUrlString('https://gitee.com/wpbkj/',
                            mode: LaunchMode.externalApplication);
                      },
                    ),
                    const Divider(),
                    const Text(
                      'GITHUB',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    // 实现超链接效果
                    GestureDetector(
                      child: const Text(
                        'https://github.com/wpbkj/',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      onTap: () {
                        launchUrlString('https://github.com/wpbkj/',
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
