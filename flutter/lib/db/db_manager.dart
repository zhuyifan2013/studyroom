import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  static final DBManager _dbManager = DBManager._internal();

  static const TABLE_TASK = 'task';
  static const TABLE_FOCUS_TIME = 'focus_time';

  Database _sqlDB;

  factory DBManager() {
    return _dbManager;
  }

  DBManager._internal() {
    initDatabase();
  }

  Future<Database> initDatabase() async {
    return openDatabase(join(await getDatabasesPath(), 'study_room.db'), onCreate: (db, version) {
      db.execute(_CREATE_TABLE_TASK);
      db.execute(_CREATE_TABLE_FOCUS_TIME);
    }, version: 1);
  }

  Future<Database> getDB() async {
    if (_sqlDB != null) {
      return _sqlDB;
    }
    _sqlDB = await initDatabase();
    return _sqlDB;
  }

  static const _CREATE_TABLE_TASK = "CREATE TABLE  " + TABLE_TASK + "(id INTEGER PRIMARY KEY, content TEXT, focus_time_list TEXT, created_time TEXT, finished TEXT, topic TEXT)";
  static const _CREATE_TABLE_FOCUS_TIME = "CREATE TABLE  " +
      TABLE_FOCUS_TIME +
      "("
          "id INTEGER PRIMARY KEY, "
          "duration INTEGER, "
          "task_id INTEGER, "
          "created_time TEXT" +
      ")";
}
