import 'dart:developer';

import 'package:app/model/user.dart';
import 'package:app/requests/base_request.dart';
import 'package:app/requests/login_request.dart';
import 'package:app/requests/register_request.dart';
import 'package:app/utils/account_manager.dart';
import 'package:app/utils/ui_utils.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';

class SignupLoginPage extends StatefulWidget {
  static const String defaultRoute = '/signup_login';

  @override
  _SignupLoginPageState createState() => _SignupLoginPageState();
}

class _SignupLoginPageState extends State<SignupLoginPage> {
  final globalKey = GlobalKey<ScaffoldState>();

  String _email, _password, _name;
  bool _toRegister = false;
  BuildContext _context;
  User _currentUser = User();

  bool validationForInout() {
//    if (!Utils.isValidEmail(_email)) {
//      UIUtils.showSimpleSnackBar(_context, "邮箱格式不正确");
//      return false;
//    }
//
//    if (!Utils.isValidEmail(_password)) {
//      UIUtils.showSimpleSnackBar(_context, "密码格式不正确");
//      return false;
//    }

    if (_email == null || _email.isEmpty) {
      UIUtils.showSimpleSnackBar(globalKey.currentContext, "邮箱格式不正确");
      return false;
    }

    if (_password == null || _password.isEmpty) {
      UIUtils.showSimpleSnackBar(globalKey.currentContext, "密码格式不正确");
      return false;
    }

    if (_toRegister && (_name == null || _name.isEmpty)) {
      UIUtils.showSimpleSnackBar(globalKey.currentContext, "名字不能为空");
      return false;
    }

    _currentUser.email = _email;
    _currentUser.password = _password;
    if (_toRegister) {
      _currentUser.name = _name;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
        key: globalKey,
        appBar: AppBar(
          title: Text("欢迎"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(36),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("欢迎回来", style: Theme.of(context).textTheme.headline4),
                ],
              ),
              Spacer(flex: 2),
              _toRegister
                  ? TextField(
                      onChanged: (String value) {
                        setState(() {
                          _name = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: '姓名',
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: 32),
              TextField(
                onChanged: (String value) {
                  setState(() {
                    _email = value;
                  });
                },
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: '邮箱',
                ),
              ),
              SizedBox(height: 32),
              TextField(
                onChanged: (String value) {
                  setState(() {
                    _password = value;
                  });
                },
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: '密码',
                ),
              ),
              SizedBox(height: 64),
              Row(
                children: <Widget>[
                  Spacer(flex: 2),
                  Expanded(
                    flex: 1,
                    child: Text('登录', style: Theme.of(context).textTheme.headline5),
                  ),
                  Spacer(),
                  Container(
                    decoration: const ShapeDecoration(
                      color: Colors.blueGrey,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward),
                      color: Colors.white,
                      onPressed: () async {
                        if (validationForInout()) {
                          BaseRequest request;
                          if (_toRegister) {
                            request = RegisterRequest();
                          } else {
                            request = LoginRequest();
                          }
                          Map body = RegisterRequest.buildBody(_currentUser);
                          request.post(body, (user) {
                            AccountManager().saveUser(user);
                            AccountManager().currentUser().then((value) => Navigator.pop(context));
                          }, (e) => log(e.toString()));
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 36,
              ),
              Row(
                children: <Widget>[
                  Spacer(),
                  InkWell(
                    child: Text(
                      '用户注册',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                    onTap: () {
                      setState(() {
                        _toRegister = _toRegister ? false : true;
                      });
                    },
                  )
                ],
              ),
              Spacer(flex: 1),
            ],
          ),
        ));
  }
}
