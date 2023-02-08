// description: 个人信息收集清单页面
// author: WPBKJ
// date: 2023-02-07

import 'package:flutter/material.dart';

class InfoCollectPage extends StatefulWidget {
  const InfoCollectPage({Key? key}) : super(key: key);
  @override
  State<InfoCollectPage> createState() => _InfoCollectPageState();
}

class _InfoCollectPageState extends State<InfoCollectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('个人信息收集清单')),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('为保证本应用正常运行，我们需要收集以下个人信息：'),
              const SizedBox(height: 10),
              Card(
                  child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '信息名称',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('快递运单号'),
                    Divider(),
                    Text(
                      '使用目的',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('获取快递信息'),
                    Divider(),
                    Text(
                      '使用场景',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('首页刷新时；首页查询时；本地数据库存储时。'),
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
