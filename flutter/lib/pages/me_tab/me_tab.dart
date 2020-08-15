import 'package:app/model/user.dart';
import 'package:app/pages/signup_login/page_signup_login.dart';
import 'package:app/utils/account_manager.dart';
import 'package:flutter/material.dart';

class PageMetab extends StatefulWidget {
  @override
  _PageMetabState createState() => _PageMetabState();
}

class _PageMetabState extends State<PageMetab> {
  User _currentUser;

  void initUserInfo() {
    AccountManager().currentUser().then((user) {
      setState(() {
        _currentUser = user;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[if (_currentUser != null) ...renderUserInfo(context) else
        ...renderNoUserView(context)
      ],
    );
  }

  List<Widget> renderUserInfo(BuildContext context) {
    return [
      Column(
        children: <Widget>[Text("name: ${_currentUser.name}"), Text("email: ${_currentUser.email}"), Text("token: ${_currentUser.token}")],
      )
    ];
  }

  List<Widget> renderNoUserView(BuildContext context) {
    return [
      InkWell(
        child: Row(
          children: <Widget>[
            Text(
              '注册/登录',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline5,
            )
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, SignupLoginPage.defaultRoute).then((value) => initUserInfo());
        },
      )
    ];
  }
}
