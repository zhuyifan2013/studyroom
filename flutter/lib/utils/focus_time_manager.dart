import 'package:app/db/db_manager.dart';
import 'package:app/model/focus_time.dart';

class FocusTimeManager {
  static final FocusTimeManager _focusTimeManager = FocusTimeManager._internal();

  factory FocusTimeManager() {
    return _focusTimeManager;
  }

  FocusTimeManager._internal();

  void addFocusTime(FocusTime focusTime) async {
    final db = await DBManager().getDB();
    db.insert(DBManager.TABLE_FOCUS_TIME, focusTime.toMap());
  }

  Future<List<FocusTime>> fetchFocusTimeFromDb() async {
    final db = await DBManager().getDB();
    final List<Map<String, dynamic>> maps = await db.query(DBManager.TABLE_FOCUS_TIME);
    return List.generate(maps.length, (index) => FocusTime.fromDBMap(maps[index]));
  }
}
