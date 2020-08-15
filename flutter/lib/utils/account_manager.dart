import 'dart:convert';

import 'package:app/model/user.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/sp_manager.dart';
import 'package:http/http.dart' as http;

class AccountManager {
  static final AccountManager _accountManager = AccountManager._internal();

  factory AccountManager() {
    return _accountManager;
  }

  AccountManager._internal();

  Future<User> currentUser() async {
    String userJson = await SPManager.get(SPManager.SP_KEY_CURRENT_USER) ?? null;
    if(userJson == null) {
      return null;
    }
    User user = User.fromJson(json.decode(userJson));
    return user;
  }

  void saveUser(User user) {
    SPManager.set(SPManager.SP_KEY_CURRENT_USER, json.encode(user.toJson()));
  }

  void clearUser() {
    SPManager.set(SPManager.SP_KEY_CURRENT_USER, null);
  }


}
