import 'package:shared_preferences/shared_preferences.dart';

class SPManager {
  static const String SP_KEY_CURRENT_USER = "current_user";

  static final SPManager _spManager = SPManager._internal();
  SharedPreferences _sp;

  factory SPManager() {
    return _spManager;
  }

  SPManager._internal();

  static void set(String key, String value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }

  static Future<String> get(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }
}
