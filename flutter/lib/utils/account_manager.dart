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
    print(json.decode(userJson));
    User user = User.fromMapJson(json.decode(userJson));
    return user;
  }

  Future<User> login(email, password) async {
    User user = User();
    user.email = email;
    user.password = password;
    print('User : ' + user.toRawJson());
    final http.Response response = await http.post(
      Constants.API_DOMAIN + 'users/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: user.toRawJson(),
    );

    if (response.statusCode == 200) {
      User user = User.fromMapJson(json.decode(response.body)["user"]);
      SPManager.set(SPManager.SP_KEY_CURRENT_USER, json.encode(user.toMapJson()));
      return user;
    } else {
      throw Exception('Failed to login' + response.statusCode.toString() + response.body);
    }
  }
}
