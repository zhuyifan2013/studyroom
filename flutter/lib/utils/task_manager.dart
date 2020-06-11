import 'package:app/db/db_manager.dart';
import 'package:app/model/task.dart';
import 'package:flutter/foundation.dart';

class TaskManager extends ChangeNotifier {
  final List<Task> _tasks = [];
  static final TaskManager _taskManager = TaskManager._internal();

  factory TaskManager() {
    return _taskManager;
  }

  TaskManager._internal() {
    this.fetchTasksFromDb();
  }

  void addTask(String content) async {
    Task task = Task.fromContent(content);
    final db = await DBManager().getDB();
    db.insert(DBManager.TABLE_TASK, task.toMap());
    this.fetchTasksFromDb();
  }

  Future<List<Task>> fetchTasksFromDb() async {
    final db = await DBManager().getDB();
    final List<Map<String, dynamic>> maps = await db.query(DBManager.TABLE_TASK);
    this._tasks.clear();
    this._tasks.addAll(List.generate(maps.length, (i) {
          return Task.fromDBMap(maps[i]);
        }));
    notifyListeners();
    return this._tasks;
  }

  List<Task> getTasks() {
    return _tasks;
  }
}
