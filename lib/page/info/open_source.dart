// description: 开源仓库页面
// author: WPBKJ
// date: 2023-02-07

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wpbkj_express/main.dart';

class OpenSourcePage extends StatefulWidget {
  const OpenSourcePage({Key? key}) : super(key: key);
  @override
  State<OpenSourcePage> createState() => _OpenSourcePageState();
}

class _OpenSourcePageState extends State<OpenSourcePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('开源仓库')),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('项目开源仓库欢迎您的issus和pr，如您喜欢也请您点一点star'),
              const SizedBox(height: 10),
              const Text(
                '开源仓库',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Card(
                  child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'GITHUB开源仓库',
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
                      'GITEE开源仓库',
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
            ]),
          )
        ],
      ),
    );
  }
}
