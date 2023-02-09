// description: 用户页面
// author: WPBKJ
// date: 2023-02-07

import 'package:flutter/material.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:wpbkj_express/db/db.dart';
import 'package:wpbkj_express/main.dart';
import 'package:wpbkj_express/widget/toast.dart';
import 'user/info_collect.dart';
import 'user/info_share.dart';
import 'user/support.dart';
import 'package:wpbkj_express/widget/item_button.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int countDay = 0; // 存储使用应用天数
  int countExpress = 0; // 存储运单总数
  int countQuery = 0; // 存储API查询次数

  // 获取上述各数,初始化页面时调用
  void getCount() async {
    countDay = await countDays();
    List expressList = await selectDBall();
    countExpress = expressList.length;
    Map countNumMap = await selectDBSetting('queryNum');
    countQuery = int.parse(countNumMap['value']);
    // 所有setState都应包含对mounted的检查，若setState时页面不处于显示状态，则会引起异常
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getCount(); // 初始化页面是获取各统计数字
  }

  // 清空运单缓存数据方法
  void cleanDB() async {
    // 弹窗询问,result保存用户操作
    final result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('确认清空'),
            content: const Scrollbar(
                child: SingleChildScrollView(
              child: Text('确认清空运单缓存数据吗？'),
            )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('确认')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('取消')),
            ],
          );
        });
    // 用户确认,执行清空数据表操作
    if (result) {
      bool delResult = await delDBall();
      if (delResult) {
        showToastSuccess('清空运单缓存数据成功！请回到主页刷新查看效果');
      } else {
        showToastError('清空运单缓存数据失败:数据库操作失败');
      }
      getCount();
    }
  }

  // 跳转个人信息收集清单页面方法
  void goInfoCollectPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const InfoCollectPage();
    }));
  }

  // 跳转个人信息共享清单页面方法
  void goInfoSharePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const InfoSharePage();
    }));
  }

  // 跳转个人支持项目页面方法
  void goSupportPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const SupportPage();
    }));
  }

  // 构建统计数字组件方法
  Widget buildCountCard(int number, String classifier, String labelText) {
    Widget countCard = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(TextSpan(children: [
          TextSpan(
              text: number.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 30)),
          TextSpan(
              text: classifier,
              style: const TextStyle(color: Colors.white, fontSize: 10))
        ])),
        Text(labelText,
            style: const TextStyle(color: Colors.white, fontSize: 15))
      ],
    );
    return countCard;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: <Widget>[
            ExtendedSliverAppbar(
                isOpacityFadeWithTitle: false,
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
                    height: 180,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // 返回各统计数字,并添加相关描述
                            buildCountCard(countDay, '天', '已伴您'),
                            buildCountCard(countExpress, '件', '运单数'),
                            buildCountCard(countQuery, '次', '共查询'),
                          ],
                        ),
                        const SizedBox(height: 15),
                      ],
                    ))),
            SliverList(
                delegate: SliverChildListDelegate([
              // 返回条目组件并绑定方法
              buildItemButton('个人信息收集清单', goInfoCollectPage),
              buildItemButton('个人信息共享清单', goInfoSharePage),
              buildItemButton('清空运单缓存', cleanDB),
              buildItemButton('支持本项目', goSupportPage),
            ])),
          ],
        ),
      ),
    );
  }
}
