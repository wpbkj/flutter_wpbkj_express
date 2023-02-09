// description: 关于页面
// author: WPBKJ
// date: 2023-02-07

import 'package:flutter/material.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wpbkj_express/main.dart';
import 'package:wpbkj_express/request/update.dart';
import 'package:wpbkj_express/widget/item_button.dart';
import 'package:wpbkj_express/widget/toast.dart';
import 'package:wpbkj_express/widget/update_dialog.dart';
import 'info/open_source.dart';
import 'info/author_info.dart';
import 'info/open_license.dart';
import 'info/feedback.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);
  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage>
    with AutomaticKeepAliveClientMixin {
  // 使关于页面保持状态，每次进入不需要重复初始化
  @override
  bool get wantKeepAlive => true;

  // 跳转官方介绍页面方法
  void goOfficialUrl() {
    launchUrlString(officialUrl, mode: LaunchMode.externalApplication);
  }

  // 跳转开源仓库页面方法
  void goOpenSourcePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const OpenSourcePage();
    }));
  }

  // 跳转联系作者页面方法
  void goAuthorInfoPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const AuthorInfoPage();
    }));
  }

  // 分享应用方法
  void shareApp() {
    Clipboard.setData(const ClipboardData(text: officialUrl));
    showToastSuccess('已将链接复制进剪贴板，您可粘贴链接以分享给其他人');
  }

  // 跳转问题反馈页面方法
  void goFeedbackPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const FeedbackPage();
    }));
  }

  // 再添加一层函数，防止出现在异步函数中使用context不规范
  void showUpdateDialogMain(String lastVersion, String msg) {
    showUpdateDialog(context, lastVersion, msg);
  }

  // 检查更新方法
  void checkUpdate() async {
    List<dynamic> updateList = await getUpdate();
    if (updateList[0]) {
      showUpdateDialogMain(updateList[1], updateList[2]);
    } else {
      showToast('软件已是最新版本');
    }
  }

  // 跳转开放源代码许可页面方法
  void goOpenLicensePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const OpenLicensePage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: SafeArea(
            top: false,
            child: CustomScrollView(slivers: <Widget>[
              ExtendedSliverAppbar(
                  onBuild: (
                    BuildContext context,
                    double shrinkOffset,
                    double? minExtent,
                    double maxExtent,
                    bool overlapsContent,
                  ) {},
                  title: const Text(
                    appTitle,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  leading: Container(),
                  background: Container(
                      color: Theme.of(context).primaryColor,
                      child: SafeArea(
                        child: Wrap(
                          runSpacing: 10,
                          runAlignment: WrapAlignment.spaceAround,
                          alignment: WrapAlignment.spaceAround,
                          children: [
                            // 软件信息Card
                            Card(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/logo.png',
                                      height: 50,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          appTitle,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          'v$version',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Built with Responsive Badge图片超链接
                            GestureDetector(
                              child: Image.asset(
                                  'assets/Built_with_Responsive_Badge.png'),
                              onTap: () {
                                launchUrlString(
                                    'https://github.com/Codelessly/ResponsiveFramework',
                                    mode: LaunchMode.externalApplication);
                              },
                            )
                          ],
                        ),
                      ))),
              SliverList(
                  delegate: SliverChildListDelegate(
                [
                  // 返回条目组件并绑定方法
                  buildItemButton('软件官网', goOfficialUrl),
                  buildItemButton('开源仓库', goOpenSourcePage),
                  buildItemButton('联系作者', goAuthorInfoPage),
                  buildItemButton('分享软件', shareApp),
                  buildItemButton('问题反馈', goFeedbackPage),
                  buildItemButton('检查更新', checkUpdate),
                  buildItemButton('开放源代码许可', goOpenLicensePage)
                ],
              )),
            ])));
  }
}
