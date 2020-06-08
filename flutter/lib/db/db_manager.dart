import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  static final DBManager _dbManager = DBManager._internal();
  static const TABLE_TASK = 'task';

  Database _sqldb;

  factory DBManager() {
    return _dbManager;
  }

  DBManager._internal() {
    initDatabase();
  }

  Future<Database> initDatabase() async {
    return openDatabase(join(await getDatabasesPath(), 'study_room.db'), onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE  " + TABLE_TASK + " (id INTEGER PRIMARY KEY, content TEXT, focus_time_list TEXT, created_time TEXT)",
      );
    }, version: 1);
  }

  Future<Database> getDB() async {
    if(_sqldb != null) {
      return _sqldb;
    }
    _sqldb = await initDatabase();
    return _sqldb;
  }
}
