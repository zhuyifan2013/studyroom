import 'package:app/pages/debug_page.dart';
import 'package:app/pages/page_home/page_home.dart';
import 'package:app/routes.dart';
import 'package:app/utils/task_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
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
        primarySwatch: Colors.teal,
//        primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.black)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: initialRoute,
      onGenerateRoute: RouteConfiguration.onGenerateRoute,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final TaskManager _taskManager = TaskManager();

  @override
  void initState() {
    super.initState();
    [Permission.storage].request().then((value) {
      print(value[Permission.storage]);
    });
    // Init Agora SDK
//    AgoraManager().agoraInit();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
    ));
    return Scaffold(
            appBar: AppBar(
              brightness: Brightness.light,
              backgroundColor: Colors.transparent,
              title: Text(
                  'Study Room',
                  style: TextStyle(
                    color: Colors.black87
                  ),
              ),
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
