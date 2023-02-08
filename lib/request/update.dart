// description: 检查更新
// author: WPBKJ
// date: 2023-02-07

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:wpbkj_express/main.dart';

Future<List<dynamic>> getUpdate() async {
  List<dynamic> resultList = [];
  try {
    var response =
        await Dio().get('', options: Options(responseType: ResponseType.plain));
    String responseData = response.data.toString();
    Map<String, dynamic> updateMap = jsonDecode(responseData);
    if (updateMap['lasted_version'] != version) {
      resultList = [true, updateMap['lasted_version'], updateMap['update_msg']];
    } else {
      resultList = [false];
    }
  } catch (e) {
    resultList = [false];
  }
  return resultList;
}
