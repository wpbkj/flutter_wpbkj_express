// description: 返回条目按钮方法,用户和关于页面使用
// author: WPBKJ
// date: 2023-02-07

import 'package:flutter/material.dart';

// 接收描述文本和绑定方法,返回组件
Widget buildItemButton(String itemText, Function onTapFunction) {
  Widget card = GestureDetector(
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(
              color: Colors.black12,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      itemText,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const Icon(Icons.keyboard_arrow_right),
                  ],
                ),
              )
            ],
          )),
      onTap: () => onTapFunction());
  return card;
}
