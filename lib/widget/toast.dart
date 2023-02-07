// description: 显示toast方法
// author: WPBKJ
// date: 2023-02-07

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

// 显示普通toast
void showToast(String msg) {
  BotToast.showText(text: msg, onlyOne: false);
}

// 显示成功toast
void showToastSuccess(String msg) {
  BotToast.showText(
      text: msg, onlyOne: false, contentColor: Colors.greenAccent);
}

// 显示警告toast,时间持续5秒
void showToastWarning(String msg) {
  BotToast.showText(
      text: msg,
      onlyOne: false,
      contentColor: Colors.brown,
      duration: const Duration(seconds: 5));
}

// 显示错误toast,时间持续5秒
void showToastError(String msg) {
  BotToast.showText(
      text: msg,
      onlyOne: false,
      contentColor: Colors.redAccent,
      duration: const Duration(seconds: 5));
}
