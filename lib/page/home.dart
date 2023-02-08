// description: 应用首页,通过splash检查后显示
// author: WPBKJ
// date: 2023-02-07

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home/details.dart';
import 'package:wpbkj_express/request/update.dart';
import 'package:wpbkj_express/widget/update_dialog.dart';
import 'package:wpbkj_express/api/api_code.dart';
import 'package:wpbkj_express/api/parse.dart';
import 'package:wpbkj_express/request/api_post.dart';
import 'package:wpbkj_express/db/db.dart';
import 'package:wpbkj_express/main.dart';
import 'package:wpbkj_express/widget/toast.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String queryNumber = ''; // 存储输入框中的运单号
  List<Map<String, dynamic>> expressList = []; // 存储所有运单
  double maxDragOffset = 100; // 下拉刷新距离
  var expressQueryController = TextEditingController(); // 运单号输入框controller
  var remarkTextController = TextEditingController(); // 修改标签输入框controller
  final GlobalKey<PullToRefreshNotificationState> refreshKey =
      GlobalKey<PullToRefreshNotificationState>(); // 下拉刷新组件Key
  StreamController<void> onBuildController =
      StreamController<void>.broadcast(); //ExtendedSliverAppbar

  // 刷新数据方法
  Future<bool> _refreshExpress() async {
    // 添加震动反馈
    HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 500));
    HapticFeedback.mediumImpact();
    List<String> noSignNumberList = await selectDBallNoSign();
    // 仅当没有签收的快递单号存在时执行刷新
    if (noSignNumberList.isNotEmpty) {
      showToast('正在刷新，请稍候');
      for (String noSignNumber in noSignNumberList) {
        // 因API要求不可频繁刷新，则固定停止1秒后执行刷新
        await Future.delayed(const Duration(seconds: 1));

        String apiData = await postAPI(noSignNumber); // post调用API
        Map<String, dynamic> apiDataMap = parseAPI(apiData); // 解析API

        // 仅当API返回code为200(查询成功)时执行数据库操作
        if (apiDataMap['code'] == 200) {
          bool result = await updateDB(noSignNumber, apiDataMap['status'],
              jsonEncode(apiDataMap['info']));
          // 根据更新数据库方法返回的bool值判断是否更新成功
          if (!result) {
            showToastError('$noSignNumber运单刷新更新数据库失败');
          } else {
            showToastSuccess('$noSignNumber运单刷新完成');
          }
        } else {
          showToastWarning(
              '$noSignNumber运单刷新失败:${apiDataMap['code']}:${apiDataMap['error']},请稍后再试');
        }
      }
      selectDBallMain();
    } else {
      // 当实际不执行刷新时显示
      showToast('无处于运输状态运单');
    }
    return true;
  }

  // 根据输入查询数据方法
  void queryNumberAPI() async {
    if (queryNumber.isNotEmpty) {
      showToast('开始查询');
      String apiData = await postAPI(queryNumber);
      Map<String, dynamic> apiDataMap = parseAPI(apiData);
      if (apiDataMap['code'] == 200) {
        await insertDB(queryNumber, apiDataMap['com'], apiDataMap['status'],
            jsonEncode(apiDataMap['info']));
        selectDBallMain();
        showToastSuccess('查询成功');
      } else {
        showToastWarning(
            '失败:${apiDataMap['code']}:${apiDataMap['error']},请稍后再试,有些快递接口不稳定,或该运单未在运输过程中');
      }
    } else {
      showToastWarning('失败:运单号不可为空');
    }
  }

  // 修改标签方法
  void changeRemark(String number) async {
    String remark = '';
    remarkTextController.addListener(() {
      remark = remarkTextController.text;
    }); // 将弹窗中输入的内容赋给remark，以便插入数据库使用

    // result接收弹窗操作返回
    final result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('添加标签'),
            content: Scrollbar(
                child: SingleChildScrollView(
              child: TextField(
                maxLines: 1, // 最多允许一行(单行输入)
                textAlign: TextAlign.center, // 文字输入在中间
                autofocus: true, // 弹出弹框自动获得焦点(处于待输入状态)
                controller: remarkTextController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(8)
                ], // 最多允许8个字符
                decoration: const InputDecoration(
                  hintText: '输入标签(最多8个字)',
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0), // 缩小输入框
                ),
              ),
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
    // 点击确认时执行
    if (result) {
      bool updateResult = await updateDBRemark(number, remark); // 更新标签
      remarkTextController.clear(); // 清空标签输入框
      if (updateResult) {
        showToastSuccess('修改标签成功');
      } else {
        showToastError('修改标签失败:数据库操作失败');
      }
      selectDBallMain(); // 更新数据库后调用一次，刷新页面
    }
  }

  // 删除某运单方法
  void delExpress(String number) async {
    // 弹出弹框确认,result接收用户操作
    final result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('确认删除'),
            content: Scrollbar(
                child: SingleChildScrollView(
              child: Text('确认删除运单 $number 吗？'),
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
    // 用户确认执行删除数据库数据操作
    if (result) {
      bool delResult = await delDB(number);
      if (delResult) {
        showToastSuccess('删除运单 $number 成功！');
      } else {
        showToastError('删除运单 $number 失败:数据库操作失败');
      }
      selectDBallMain();
    }
  }

  // 从数据库调取数据并且刷新页面，每次刷新数据都应调用一次
  void selectDBallMain() async {
    expressList = await selectDBall();
    // 所有setState都应包含对mounted的检查，若setState时页面不处于显示状态，则会引起异常
    if (mounted) {
      setState(() {});
    }
  }

  // 再添加一层函数，防止出现在异步函数中使用context不规范
  void showUpdateDialogMain(String lastVersion, String msg) {
    showUpdateDialog(context, lastVersion, msg);
  }

  // 检查更新
  void checkUpdate() async {
    List<dynamic> updateList = await getUpdate();
    if (updateList[0]) {
      showUpdateDialogMain(updateList[1], updateList[2]);
    }
  }

  @override
  void initState() {
    super.initState();
    checkUpdate(); // 检查更新
    // 加载页面时先从数据库中显示出所有运单信息,再刷新运单状态
    selectDBallMain();
    _refreshExpress();
  }

  // 首页快递信息卡片构建方法
  Widget buildCard(String number, String com, String status,
      Map<String, dynamic> lastInfo, String remark) {
    com = codeExpress.containsKey(com) ? codeExpress[com]! : '未知公司';
    status = statusCode.containsKey(status) ? statusCode[status]! : '未知状态';
    Widget card = GestureDetector(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey), // 边框颜色
            borderRadius: const BorderRadius.all(Radius.circular(15)) // 边框圆角
            ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // 通过判断remark是否为空来决定显示
                      // 要加这么多不同或判断是因为sqlite3数据库在不同平台可能会对空值返回不同结果
                      // 如Android平台返回就是空的(不是null),Windows则返回null
                      Text(remark.isEmpty ||
                              remark == 'null' ||
                              remark == 'Null' ||
                              remark == 'NULL'
                          ? number
                          : remark),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(com),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        status,
                        style: TextStyle(
                            color: status == '已签收' ? Colors.greenAccent : null,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        child: const Text(
                          '标签',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        onTap: () {
                          changeRemark(number);
                        },
                      ),
                      const Text('/'),
                      GestureDetector(
                        child: const Text(
                          '删除',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        onTap: () {
                          delExpress(number);
                        },
                      )
                    ],
                  )
                ],
              ),
              const Divider(),
              Text(
                lastInfo['time']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Stack(
                alignment: Alignment.center,
                children: [
                  const Text('\n\n\n'), // 配合maxLines使用，使得所有buildCard返回组件高度相同
                  Text(
                    lastInfo['content']!,
                    maxLines: 3, // 最多运行3行
                    overflow: TextOverflow.ellipsis, // 大于3行内容使用...代替
                  )
                ],
              ),
            ]),
      ),
      onTap: () {
        // 点击卡片跳转到详细信息页面
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailsPage(number: number);
        })).then((value) {
          // 这里每次从详细信息页面返回主页面都应刷新页面
          // 获取用户在详细信息页面的刷新或修改标签操作
          selectDBallMain();
        });
      },
    );
    return card;
  }

  @override
  Widget build(BuildContext context) {
    expressQueryController.addListener(() {
      queryNumber = expressQueryController.text;
    });
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: PullToRefreshNotification(
          // 下拉刷新，配合extended_sliver
          pullBackOnRefresh: true,
          onRefresh: _refreshExpress,
          key: refreshKey,
          maxDragOffset: maxDragOffset,
          child: CustomScrollView(
            physics: const AlwaysScrollableClampingScrollPhysics(),
            slivers: <Widget>[
              PullToRefreshContainer(
                  (PullToRefreshScrollNotificationInfo? info) {
                final double offset = info?.dragOffset ?? 0.0;
                Widget actions = Container();
                // 当存在下拉刷新动作时改变actions
                if (info?.refreshWidget != null) {
                  // 下拉刷新时提示组件
                  actions = SizedBox(
                      height: 20,
                      width: 85,
                      child: isDesktop // 桌面端不使用下拉刷新
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text('松手刷新',
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(width: 5),
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.transparent,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                    strokeWidth: 3,
                                  ),
                                )
                              ],
                            ));
                }

                return ExtendedSliverAppbar(
                  isOpacityFadeWithTitle: false,
                  onBuild: (
                    BuildContext context,
                    double shrinkOffset,
                    double? minExtent,
                    double maxExtent,
                    bool overlapsContent,
                  ) {
                    if (shrinkOffset > 0) {
                      onBuildController.sink.add(null);
                    }
                  },
                  title: const Text(
                    appTitle,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ), // AppBar标题
                  leading: Container(), // 左侧返回按钮禁用
                  background: DefaultTextStyle(
                    style: const TextStyle(color: Colors.white),
                    child: Stack(
                      children: <Widget>[
                        // banner背景图片
                        Positioned.fill(
                            child: Image.asset(
                          'assets/banner.jpg',
                          fit: BoxFit.cover,
                        )),
                        Padding(
                          padding: EdgeInsets.only(
                            top: kToolbarHeight + statusBarHeight,
                            bottom: 20,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                actions,
                                SizedBox(
                                  height: offset,
                                ),
                                // 中央logo
                                Image.asset(
                                  'assets/logo.png',
                                  height: 100,
                                  width: 100,
                                ),
                                const SizedBox(height: 10),
                                // 中央描述
                                Text('快捷管理快递运输状态工具',
                                    style: const TextStyle(fontSize: 16)
                                        .useSystemChineseFont()),
                                Text(
                                    // 桌面端不使用下拉刷新
                                    isDesktop
                                        ? '点击右下角悬浮按钮刷新'
                                        : '下拉或点击右下角悬浮按钮刷新',
                                    style: const TextStyle(fontSize: 16)
                                        .useSystemChineseFont())
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              // 子组件(真正body)
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(height: 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          // 运单号查询输入框
                          child: TextField(
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            controller: expressQueryController,
                            onSubmitted: (value) {
                              queryNumberAPI();
                            },
                            decoration: InputDecoration(
                              hintText: '输入运单号查询',
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(color: Colors.blue),
                              ), // 普通状态
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(color: Colors.blue),
                              ), // 获取到焦点时状态,使普通状态和获取到焦点状态相同
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.search,
                                    color: Colors.blue),
                                onPressed: () {
                                  queryNumberAPI();
                                  FocusScope.of(context).requestFocus(
                                      FocusNode()); // 点击右侧按钮后输入框应失去焦点
                                },
                              ), // 右侧检索按钮
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                            ), // 缩小输入框高度
                          ),
                        ),
                        const SizedBox(height: 20),
                        // 使用List.generate来遍历显示所有数据库内的运单
                        ...List.generate(expressList.length, (index) {
                          String number =
                              expressList[index]['number'].toString();
                          String com = expressList[index]['com'].toString();
                          String status =
                              expressList[index]['status'].toString();
                          List<dynamic> infoList =
                              jsonDecode(expressList[index]['info']);
                          Map<String, dynamic> lastInfo = infoList.isEmpty
                              ? {'time': 'no time', 'content': '该运单暂无消息'}
                              : infoList[0];
                          String remark =
                              expressList[index]['remark'].toString();
                          return buildCard(
                              number, com, status, lastInfo, remark);
                        })
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // 右下角悬浮刷新按钮
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshExpress,
        tooltip: '刷新',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
