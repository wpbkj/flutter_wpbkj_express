// description: API解析
// author: WPBKJ
// date: 2023-02-07

import 'dart:convert';

// 解析API接口返回参数方法
Map<String, dynamic> parseAPI(String data) {
  Map<String, dynamic> returnDate = {};
  Map<String, dynamic> dataMap = jsonDecode(data);
  // 当API返回code为200(查询成功)时返回运单详细信息,否则返回错误代码和错误信息
  if (dataMap['code'] == 200) {
    returnDate['code'] = 200;
    returnDate['number'] = dataMap['data']['nu'];
    returnDate['com'] = dataMap['data']['com'];
    returnDate['status'] = dataMap['data']['status'];
    returnDate['info'] = dataMap['data']['info'];
  } else {
    returnDate['code'] = dataMap['code'];
    returnDate['error'] = dataMap['msg'];
  }
  return returnDate;
}
