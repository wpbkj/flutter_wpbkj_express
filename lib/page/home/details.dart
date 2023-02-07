// description: 运单详细信息页面
// author: WPBKJ
// date: 2023-02-07

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:wpbkj_express/api/api_code.dart';
import 'package:wpbkj_express/api/parse.dart';
import 'package:wpbkj_express/request/api_post.dart';
import 'package:wpbkj_express/db/db.dart';
import 'package:wpbkj_express/widget/toast.dart';

class DetailsPage extends StatefulWidget {
  // 设置为必须传入运单号(number)参数，无此参数该页面无效
  const DetailsPage({Key? key, required this.number}) : super(key: key);
  final String number;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var remarkTextController = TextEditingController(); // 修改标签弹出输入框的controller
  List<dynamic> infoList = []; // 存储运单状态信息
  String com = ''; // 存储快递公司
  String status = ''; // 存储快递状态
  String remark = ''; // 存储快递标签

  // 通过数据库检索出运单详细信息并相应赋值，应在页面初始化时调用
  void selectDetailsFromDB() async {
    Map<String, dynamic> expressDetailsMap = await selectDB(widget.number);
    infoList = jsonDecode(expressDetailsMap['info']);
    com = codeExpress.containsKey(expressDetailsMap['com'])
        ? codeExpress[expressDetailsMap['com']]!
        : '未知公司';
    status = statusCode.containsKey(expressDetailsMap['status'])
        ? statusCode[expressDetailsMap['status']]!
        : '未知状态';
    remark = expressDetailsMap['remark'].toString();
    // 所有setState都应包含对mounted的检查，若setState时页面不处于显示状态，则会引起异常
    if (mounted) {
      setState(() {});
    }
  }

  // 刷新运单信息方法
  void _refreshExpress() async {
    // 因API要求不可频繁刷新，则固定停止1秒后执行刷新
    await Future.delayed(const Duration(seconds: 1));
    showToast('正在刷新，请稍候');

    String apiData = await postAPI(widget.number.toString()); // post调用API
    Map<String, dynamic> apiDataMap = parseAPI(apiData); // 解析API

    // 仅当API返回code为200(查询成功)时执行数据库操作
    if (apiDataMap['code'] == 200) {
      bool result = await updateDB(
          widget.number, apiDataMap['status'], jsonEncode(apiDataMap['info']));
      // 根据更新数据库方法返回的bool值判断是否更新成功
      if (!result) {
        showToastError('运单刷新插入数据库失败');
      }
      showToastSuccess('运单刷新完成');
    } else {
      showToastWarning(
          '运单刷新失败:${apiDataMap['code']}:${apiDataMap['error']},请稍后再试');
    }

    selectDetailsFromDB();
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
      selectDetailsFromDB(); // 更新数据库后调用一次，刷新页面
    }
  }

  @override
  void initState() {
    super.initState();
    selectDetailsFromDB(); // 在页面初始化时查询数据库
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.number}的详细信息'), // 根据传递的运单号构建title
      ),
      body: ListView(children: [
        Container(
            padding: const EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // 这里运行点击快递单号直接复制进剪贴板，也可以自行选择
              GestureDetector(
                child: SelectableText.rich(TextSpan(children: [
                  const TextSpan(
                    text: '快递单号：',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextSpan(
                    text: widget.number,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ])),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: widget.number));
                  showToast('快递单号已复制进剪贴板');
                },
              ),
              const Divider(),
              Text.rich(TextSpan(children: [
                const TextSpan(
                  text: '快递公司：',
                  style: TextStyle(fontSize: 18),
                ),
                TextSpan(
                  text: com,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ])),
              const Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text.rich(TextSpan(children: [
                  const TextSpan(
                    text: '快递标签：',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextSpan(
                    // 通过判断remark是否为空来决定显示
                    // 要加这么多不同或判断是因为sqlite3数据库在不同平台可能会对空值返回不同结果
                    // 如Android平台返回就是空的(不是null),Windows则返回null
                    text: remark.isEmpty ||
                            remark == 'null' ||
                            remark == 'Null' ||
                            remark == 'NULL'
                        ? '无'
                        : remark,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ])),
                GestureDetector(
                  child: const Text(
                    '修改标签',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  onTap: () {
                    changeRemark(widget.number);
                  },
                ),
              ]),
              const Divider(),
              Text.rich(TextSpan(children: [
                const TextSpan(
                  text: '快递状态：',
                  style: TextStyle(fontSize: 18),
                ),
                TextSpan(
                  text: status,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: status == '已签收' ? Colors.greenAccent : null),
                )
              ])),
              const Divider(),
              // 使用List.generate来遍历显示运单信息
              ...List.generate(infoList.length, (index) {
                Widget textInfo = SelectableText.rich(TextSpan(children: [
                  TextSpan(
                    text: "${infoList[index]['time']}\n",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: index == 0 ? Colors.blueAccent : null),
                  ),
                  TextSpan(
                    text: "${infoList[index]['content']}\n",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: index == 0 ? FontWeight.bold : null,
                        color: index == 0 ? Colors.blueAccent : null),
                  )
                ]));
                return textInfo;
              })
            ]))
      ]),
      // 右下角悬浮刷新按钮
      floatingActionButton: status != '已签收'
          ? FloatingActionButton(
              onPressed: _refreshExpress,
              tooltip: '刷新',
              child: const Icon(Icons.refresh),
            )
          : null,
    );
  }
}
