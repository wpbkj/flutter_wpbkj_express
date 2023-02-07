// 开放源代码许可页面

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wpbkj_express/main.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OpenLicensePage extends StatefulWidget {
  const OpenLicensePage({Key? key}) : super(key: key);
  @override
  State<OpenLicensePage> createState() => _OpenLicensePageState();
}

class _OpenLicensePageState extends State<OpenLicensePage> {
  String osLicense = '';

  void getOsLicense() async {
    // 这里读取assets中的oslicense.txt文件来显示开放源代码信息
    osLicense = await rootBundle.loadString('assets/oslicense.txt');
    // 所有setState都应包含对mounted的检查，若setState时页面不处于显示状态，则会引起异常
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getOsLicense();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('开放源代码许可'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              Card(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/logo.png',
                            height: 50,
                          ),
                          const Text(
                            'WPBKJ 工具集',
                            style: TextStyle(fontSize: 20),
                          ),
                          const Text(
                            'v$version',
                          ),
                          const SizedBox(height: 10),
                          // 实现超链接效果
                          GestureDetector(
                            child: const Text(
                              'https://github.com/wpbkj/flutter_wpbkj_express',
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                            onTap: () {
                              launchUrlString(
                                  'https://github.com/wpbkj/flutter_wpbkj_express',
                                  mode: LaunchMode.externalApplication);
                            },
                          ),
                          // 实现超链接效果
                          GestureDetector(
                            child: const Text(
                              'https://gitee.com/wpbkj/flutter_wpbkj_express',
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                            onTap: () {
                              launchUrlString(
                                  'https://gitee.com/wpbkj/flutter_wpbkj_express',
                                  mode: LaunchMode.externalApplication);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '开发源代码许可',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Card(
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      child: SelectableText(osLicense))),
            ]),
          )
        ],
      ),
    );
  }
}
