// description: 问题反馈页面
// author: WPBKJ
// date: 2023-02-07

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wpbkj_express/main.dart';
import 'author_info.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);
  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('问题反馈')),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('您可通过以下途径发送问题反馈'),
              const SizedBox(height: 10),
              const Text(
                '提交ISSUES(首选)',
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
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        // 实现超链接效果
                        GestureDetector(
                          child: const Text(
                            '$githubUrl/issues',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                          onTap: () {
                            launchUrlString('$githubUrl/issues',
                                mode: LaunchMode.externalApplication);
                          },
                        ),
                        const Divider(),
                        const Text(
                          'GITEE开源仓库',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        // 实现超链接效果
                        GestureDetector(
                          child: const Text(
                            '$giteeUrl/issues',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                          onTap: () {
                            launchUrlString('$giteeUrl/issues',
                                mode: LaunchMode.externalApplication);
                          },
                        ),
                      ]),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '联系作者',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                  onPressed: () {
                    // 跳转联系作者页面
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const AuthorInfoPage();
                    }));
                  },
                  child: const Text('点击前往作者联系方式页面'))
            ]),
          )
        ],
      ),
    );
  }
}
