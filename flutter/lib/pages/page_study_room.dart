import 'dart:async';

//import 'package:app/agora/agora.dart';
import 'package:app/model/focus_time.dart';
import 'package:app/utils/focus_time_manager.dart';
import 'package:flutter/material.dart';

class PageStudyRoom extends StatefulWidget {
  const PageStudyRoom();

  static const String defaultRoute = '/study_room';

  @override
  _PageStudyRoomState createState() => _PageStudyRoomState();
}

class _PageStudyRoomState extends State<PageStudyRoom> with WidgetsBindingObserver {
  Timer _timer;
  int _start = 40*60;
  FocusTime currentFocusTime;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
//    AgoraManager().agoraLogin();
    currentFocusTime = createNewFocusTime();
    WidgetsBinding.instance.addObserver(this);
    startTimer();
  }

  FocusTime createNewFocusTime() {
    return FocusTime.normal(1, 40*60);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer.cancel();
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
          title: Text('Study'),
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            Text("$_start"),
            FlatButton(
              onPressed: () {
                FocusTimeManager().addFocusTime(currentFocusTime);
              },
              child: Text('保存'),
              
            )
          ],
        ));
  }
  
}
