

// description: API调用
// author: WPBKJ
// date: 2023-02-07

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
  } on DioError catch (e) {
    responseData = e.message;
  }

  return responseData;
}

// 检查API服务器连接，每次开启应用都应调用
Future<bool> checkAPIconnect() async {
  bool? status;
  var dio = Dio();
  try {
    await dio.post(apiUrl);
    status = true;
  } on DioError {
    status = false;
  }
  return status;
}
