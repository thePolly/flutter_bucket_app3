import 'dart:async';

import 'package:flutterbucketapp/bucket.dart';
import 'package:flutterbucketapp/user.dart';
import 'package:sqflite/sqflite.dart';

abstract class DB {
  static Database _db;
  static int get _version => 1;

  static Future<void> init() async {


    if (_db != null) {
return;
    }

    try {
      String _path = await getDatabasesPath() + 'example';
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);


    } catch (ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async => await db.execute(
      'CREATE TABLE bucket_items (user_name STRING, name STRING, description STRING, priority STRING)');


  static void drop(Database db) async => await db.execute(
      'DROP TABLE bucket_items');


  static Future<List<Map<String, dynamic>>> query(String table,  userName) async =>
      _db.query(table, where: 'user_name = ?', whereArgs: [userName]);


  static Future<int> insert(String table, Bucket model) async =>

      await _db.insert(table, model.toJson());

  static Future<int> update(String table, Bucket model) async => await _db
      .update(table, model.toJson(), where: 'name = ?', whereArgs: [model.name]);

  static Future<int> delete(String table, Bucket model) async =>
      await _db.delete(table, where: 'name = ?', whereArgs: [model.name]);

}
