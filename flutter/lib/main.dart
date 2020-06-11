
import 'package:app/pages/debug_page.dart';
import 'package:app/pages/page_home.dart';
import 'package:app/routes.dart';
import 'package:app/utils/task_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import 'agora/agora.dart';
import 'pages/me_tab.dart';

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

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{
  int _selectedIndex = 0;
  final TaskManager _taskManager = TaskManager();

  @override
  void initState() {
    super.initState();
    // Init Agora SDK
//    AgoraManager().agoraInit();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Study Room'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          child: _getChild(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Me'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.android),
              title: Text('Debug'),
            ),
          ],
          onTap: _onItemTapped,
        ));
  }

  Widget _getChild() {
    switch (_selectedIndex) {
      case 0:
        return ChangeNotifierProvider.value(
          value: _taskManager,
          child: PageHome(),
        );
      case 1:
        return PageMetab();
      case 2:
        return PageDebug();
    }
    return PageHome();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
