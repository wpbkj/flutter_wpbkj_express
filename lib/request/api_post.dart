// description: API调用
// author: WPBKJ
// date: 2023-02-07

import 'dart:convert';

import '../api/config.dart';
import 'package:dio/dio.dart';
import 'package:wpbkj_express/db/db.dart';

// 根据运单号通过API获取运单信息方法
Future<String> postAPI(String number) async {
  Response response;
  String responseData = '';
  var dio = Dio();
  Map<String, dynamic> postNameMap = {"number": number, "token": token};
  var formData = FormData.fromMap(postNameMap);
  try {
    response = await dio.post(apiUrl,
        data: formData, options: Options(responseType: ResponseType.plain));
    responseData = response.data.toString();
    updateDBqueryNum();
  } on DioError {
    Map<String, String> errorMap = {'code': '404', 'message': '请检查网络连接或稍后再试'};
    responseData = jsonEncode(errorMap);
  }

  return responseData;
}
