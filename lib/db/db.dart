// description: 数据库操作
// author: WPBKJ
// date: 2023-02-07

import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wpbkj_express/widget/toast.dart';

var nowDateTime = DateTime.now(); //获取当前时间
int dateTimeStamp = nowDateTime.microsecondsSinceEpoch; //当前时间时间戳

// 打开数据库方法
Future<Database> openDB() async {
  // 不同平台提供不同数据库文件存储路径
  final dbPath = (Platform.isMacOS || Platform.isIOS)
      ? await getApplicationDocumentsDirectory()
      : await getApplicationSupportDirectory();

  final dbFile = p.join(dbPath.path, 'express_info.db');
  Database expressDB = sqlite3.open(dbFile);
  return expressDB;
}

// 初始化数据库检查，每次开启应用都应调用
Future<String> initDB() async {
  try {
    final db = await openDB();

    db.execute('''
    CREATE TABLE express_info (
      id INTEGER NOT NULL PRIMARY KEY,
      number TEXT NOT NULL,
      com TEXT NOT NULL,
      status TEXT NOT NULL,
      info TEXT NOT NULL,
      remark TEXT NULL
    );
  '''); // 运单信息表

    db.execute('''
    CREATE TABLE setting (
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT NOT NULL,
      value TEXT NOT NULL
    );
  '''); // 设置表
    insertDBSetting("createDate", dateTimeStamp.toString()); //初始化使用时间
    insertDBSetting("queryNum", "0"); //初始化查询次数
    db.dispose();
    showToastSuccess('初始化数据库成功');
    return 'success';
  } on SqliteException catch (e) {
    // 根据错误信息判断是否初始化成功
    if (e.message == 'table express_info already exists') {
      showToastSuccess('校验数据库成功');
      return 'initialized';
    } else {
      showToastError('初始化数据库失败');
      return 'error:$e';
    }
  }
}

// 插入设置信息
Future<String> insertDBSetting(String name, String value) async {
  try {
    Map<String, dynamic> trySelect = await selectDBSetting(name);
    if (trySelect.isEmpty) {
      final db = await openDB();
      final stmt =
          db.prepare('INSERT INTO setting (name, value) VALUES (?, ?)');
      stmt.execute([name, value]);
      stmt.dispose();
      db.dispose();
      return 'success';
    } else {
      updateDBSetting(name, value);
      return 'exists';
    }
  } catch (e) {
    return 'error:$e';
  }
}

// 根据名称检索设置信息
Future<Map<String, dynamic>> selectDBSetting(String name) async {
  final db = await openDB();
  Map<String, dynamic> resultMap = {};
  try {
    final ResultSet resultSet =
        db.select('SELECT * FROM setting WHERE name=?', [name]);

    for (final Row row in resultSet) {
      resultMap = {
        'id': row['id'],
        'name': row['name'],
        'value': row['value'],
      };
    }
  } on SqliteException {
    showToastError('数据表丢失，请重启软件');
  }

  db.dispose();
  return resultMap;
}

// 根据名称更新设置信息
Future<bool> updateDBSetting(String name, String value) async {
  try {
    final db = await openDB();
    final stmt = db.prepare('UPDATE setting SET value=? WHERE name=?');
    stmt.execute([value, name]);
    stmt.dispose();
    db.dispose();
    return true;
  } catch (e) {
    return false;
  }
}

// 根据名称删除设置信息
Future<bool> delDBSetting(String name) async {
  try {
    final db = await openDB();
    final stmt = db.prepare('DELETE FROM setting WHERE name=?');
    stmt.execute([name]);
    stmt.dispose();
    db.dispose();
    return true;
  } on SqliteException {
    showToastError('数据表丢失，请重启软件');
    return false;
  }
}

// 更新查询API次数，每次查询API都应调用一次
Future<bool> updateDBqueryNum() async {
  try {
    Map nowNumMap = await selectDBSetting('queryNum');
    int nowNum = int.parse(nowNumMap['value']);
    nowNum++;
    updateDBSetting('queryNum', nowNum.toString());
    return true;
  } catch (e) {
    return false;
  }
}

// 计算软件使用时间（用户页面）
Future<int> countDays() async {
  final db = await openDB();
  int resultInt = 0;
  try {
    Map createDataMap = await selectDBSetting('createDate');
    int createDate = int.parse(createDataMap['value']);
    var createDateTime = DateTime.fromMicrosecondsSinceEpoch(createDate);
    int dDays = nowDateTime.difference(createDateTime).inDays;
    resultInt = dDays;
  } on SqliteException {
    showToastError('数据表丢失，请重启软件');
  }

  db.dispose();
  return resultInt;
}

// 向数据库插入运单信息
Future<String> insertDB(
    String number, String com, String status, String info) async {
  try {
    Map<String, dynamic> trySelect = await selectDB(number);
    if (trySelect.isEmpty) {
      final db = await openDB();
      final stmt = db.prepare(
          'INSERT INTO express_info (number, com, status, info) VALUES (?, ?, ?, ?)');
      stmt.execute([number, com, status, info]);
      stmt.dispose();
      db.dispose();
      return 'success';
    } else {
      updateDB(number, status, info);
      return 'exists';
    }
  } catch (e) {
    return 'error:$e';
  }
}

// 根据运单号更新运单信息
Future<bool> updateDB(String number, String status, String info) async {
  try {
    final db = await openDB();
    final stmt =
        db.prepare('UPDATE express_info SET info=?, status=? WHERE number=?');
    stmt.execute([info, status, number]);
    stmt.dispose();
    db.dispose();
    return true;
  } catch (e) {
    return false;
  }
}

// 根据运单号更新运单标签
Future<bool> updateDBRemark(String number, String remark) async {
  try {
    final db = await openDB();
    final stmt = db.prepare('UPDATE express_info SET remark=? WHERE number=?');
    stmt.execute([remark, number]);
    stmt.dispose();
    db.dispose();
    return true;
  } catch (e) {
    return false;
  }
}

// 根据运单号检索运单信息，供运单详细信息页面使用
Future<Map<String, dynamic>> selectDB(String number) async {
  final db = await openDB();
  Map<String, dynamic> resultMap = {};
  try {
    final ResultSet resultSet =
        db.select('SELECT * FROM express_info WHERE number=?', [number]);

    for (final Row row in resultSet) {
      resultMap = {
        'id': row['id'],
        'number': row['number'],
        'com': row['com'],
        'status': row['status'],
        'info': row['info'],
        'remark': row['remark']
      };
    }
  } on SqliteException {
    showToastError('数据表丢失，请重启软件');
  }

  db.dispose();
  return resultMap;
}

// 检索出全部运单信息，供首页提供运单列表使用
Future<List<Map<String, dynamic>>> selectDBall() async {
  final db = await openDB();
  List<Map<String, dynamic>> resultAll = [];
  try {
    final ResultSet resultSet =
        db.select('SELECT * FROM express_info ORDER BY id DESC');
    for (final Row row in resultSet) {
      Map<String, dynamic> resultMap = {};
      resultMap = {
        'id': row['id'],
        'number': row['number'],
        'com': row['com'],
        'status': row['status'],
        'info': row['info'],
        'remark': row['remark']
      };
      resultAll.add(resultMap);
    }
  } on SqliteException {
    showToastError('数据表丢失，请重启软件');
  }
  db.dispose();
  return resultAll;
}

// 检索出未签收运单号，供刷新状态使用，已签收运单默认不参与刷新
Future<List<String>> selectDBallNoSign() async {
  final db = await openDB();
  List<String> resultAll = [];
  try {
    final ResultSet resultSet = db.select(
        'SELECT * FROM express_info WHERE status != ? ORDER BY id DESC',
        ['SIGN']);
    for (final Row row in resultSet) {
      String resultNumber = row['number'];
      resultAll.add(resultNumber);
    }
  } on SqliteException {
    showToastError('数据表丢失，请重启软件');
  }
  db.dispose();
  return resultAll;
}

// 删除单行数据方法
Future<bool> delDB(String number) async {
  try {
    final db = await openDB();
    final stmt = db.prepare('DELETE FROM express_info WHERE number=?');
    stmt.execute([number]);
    stmt.dispose();
    db.dispose();
    return true;
  } on SqliteException {
    showToastError('数据表丢失，请重启软件');
    return false;
  }
}

// 清空数据表方法，DROP后重构比逐行删除效率更高
Future<bool> delDBall() async {
  try {
    final db = await openDB();
    db.execute('DROP TABLE express_info');
    db.execute('''
    CREATE TABLE express_info (
      id INTEGER NOT NULL PRIMARY KEY,
      number TEXT NOT NULL,
      com TEXT NOT NULL,
      status TEXT NOT NULL,
      info TEXT NOT NULL,
      remark TEXT NULL
    );
  ''');
    db.dispose();
    return true;
  } on SqliteException {
    showToastError('数据表丢失，请重启软件');
    return false;
  }
}
