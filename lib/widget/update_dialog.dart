// description: 软件更新弹出组件
// author: WPBKJ
// date: 2023-02-07

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

void showUpdateDialog(
    BuildContext context, String lastVersion, String msg) async {
  // result接收弹窗操作返回
  final result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('更新提醒'),
          content: Scrollbar(
              child: SingleChildScrollView(
                  child: Text('软件最新版本:$lastVersion\n更新信息:$msg\n可选择下方更新渠道'))),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop('gitee');
                },
                child: const Text('GITEE')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop('github');
                },
                child: const Text('GITHUB')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('取消')),
          ],
        );
      });
  // 点击actions执行
  if (result == 'gitee') {
    launchUrlString('https://gitee.com/wpbkj/flutter_wpbkj_express/releases/',
        mode: LaunchMode.externalApplication);
  } else if (result == 'github') {
    launchUrlString('https://github.com/wpbkj/flutter_wpbkj_express/releases/',
        mode: LaunchMode.externalApplication);
  }
}
