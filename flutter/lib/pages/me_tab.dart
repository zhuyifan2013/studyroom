import 'package:app/model/user.dart';
import 'package:app/utils/account_manager.dart';
import 'package:flutter/material.dart';

class PageMetab extends StatefulWidget {
  @override
  _PageMetabState createState() => _PageMetabState();
}

class _PageMetabState extends State<PageMetab> {
  String _email, _password;
  User _currentUser;

  @override
  void initState() {
    super.initState();
    AccountManager().currentUser().then((user) {
      setState(() {
        _currentUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser != null) {
      return Text(_currentUser.token);
    }
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          TextField(
            onChanged: (String value) {
              setState(() {
                print('email:' + value);
                _email = value;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 16),
          TextField(
            onChanged: (String value) {
              setState(() {
                print('pwd:' + value);
                _password = value;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          SizedBox(height: 16),
          FlatButton(
            child: Text('Login'),
            onPressed: () async {
              if (_email.isNotEmpty && _password.isNotEmpty) {
                await AccountManager().login(_email, _password);
                AccountManager().currentUser().then((user) {
                  print('Login user : $user');
                  setState(() {
                    _currentUser = user;
                  });
                });
              }
            },
          )
        ],
      ),
    ));
  }
}
