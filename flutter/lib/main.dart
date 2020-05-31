import 'dart:developer';

import 'package:app/routes.dart';
import 'package:flutter/material.dart';

import 'agora/agora.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, this.initialRoute}) : super(key: key);

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: initialRoute,
      onGenerateRoute: RouteConfiguration.onGenerateRoute,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // Init Agora SDK
    AgoraManager().agoraInit();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Study Room'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: headerButton(context),
                    )),
              ],
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Me'),
          ),
        ]));
  }

  Widget headerButton(BuildContext context) => Material(
        color: Colors.yellow,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/study_room');
          },
          child: Center(child: Text('Go to room111')),
        ),
      );
}
