import 'dart:async';
import 'dart:convert';
import 'dart:developer';

//import 'package:app/agora/agora.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:app/model/focus_time.dart';
import 'package:app/model/socket_study_user.dart';
import 'package:app/model/task.dart';
import 'package:app/model/user.dart';
import 'package:app/pages/arguments/study_room_args.dart';
import 'package:app/pages/page_study_room/study_feedback_dialog.dart';
import 'package:app/requests/enter_room_request.dart';
import 'package:app/utils/account_manager.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/focus_time_manager.dart';
import 'package:app/utils/notification.dart';
import 'package:app/utils/socket_manager.dart';
import 'package:app/utils/task_manager.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum RoomState { NotReady, Ready }

class PageStudyRoom extends StatefulWidget {
  final StudyRoomArgs args;

  const PageStudyRoom({Key key, this.args}) : super(key: key);

  static const String defaultRoute = '/study_room';

  @override
  _PageStudyRoomState createState() => _PageStudyRoomState(args);
}

class _PageStudyRoomState extends State<PageStudyRoom> with WidgetsBindingObserver {
  Timer _timer;
  int _countDown = 3;
  int _studyDuration;
  String _studyTopic;
  Task _task;
  FocusTime _currentFocusTime;
  SocketIO _socketIO;
  StudyRoomArgs args;
  String _roomId;
  User _currentUser;
  BuildContext _buildContext;

  List<SocketStudyUser> _studyUsers = [];

  /// Whether this room is ready for starting study
  RoomState _roomState = RoomState.Ready;

  _PageStudyRoomState(this.args);

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_countDown < 1) {
            timer.cancel();
            finishFocusTime();
          } else {
            _countDown = _countDown - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Get arguments
//    _countDown = _studyDuration = this.args.studyDuration;
    _studyTopic = this.args.studyTopic;
    _task = TaskManager().findTaskById(this.args.studyTask);

    _currentFocusTime = createNewFocusTime();
    WidgetsBinding.instance.addObserver(this);
    startTimer();

    var request = EnterRoomRequest();

//    AccountManager().currentUser().then((user){
//      request.post({"topic": _studyTopic},
//              (){})
//
//    });
//    Future.wait({AccountManager().currentUser(), }).then((value) {
//      _currentUser = value[0];
//      http.Response response = value[1];
//      if (response.statusCode == 200) {
//        _roomId = json.decode(response.body)["room_id"];
//
//        SocketManager().createSocket(SocketManager.createSocketOptions()).then((socket) {
//          _socketIO = socket;
//
//          socket.onConnect((data) {
//            socket.emit('study_room/enter', [json.encode(SocketStudyUser(_currentUser, _currentFocusTime, _task, _studyTopic, _roomId).toJson())]);
//          });
//
//          socket.on('study_room/update', (data) {
//            _studyUsers.clear();
//            (data as List).forEach((element) {
//              setState(() {
//                _studyUsers.add(SocketStudyUser.fromJson(json.decode(element)));
//              });
//            });
//          });
//          socket.onConnectError((data) {});
//          socket.connect();
//        });
//      }
//    });
  }

  FocusTime createNewFocusTime() {
    return FocusTime.normal(1, 40 * 60);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer.cancel();
    if (_socketIO != null) {
      SocketManager().disconnect(_socketIO);
    }
    super.dispose();
  }

  AppLifecycleState _currentState = AppLifecycleState.resumed;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
    if (state == AppLifecycleState.paused) {
      _currentState = AppLifecycleState.paused;
      onUserLeave();
    }

    if (_currentState == AppLifecycleState.paused && state == AppLifecycleState.resumed) {
      onUserBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    this._buildContext = context;
    return Scaffold(
        appBar: AppBar(
          title: Text('Study'),
          centerTitle: true,
          elevation: 0,
        ),
        body: () {
          switch (_roomState) {
            case RoomState.NotReady:
              return _buildLoadingView(context);
            case RoomState.Ready:
              return _buildStudyView(context);
          }
          return _buildLoadingView(context);
        }());
  }

  Widget _buildLoadingView(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
      ),
    );
  }

  Widget _buildStudyView(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        ..._buildPartnersView(context),
        Text("剩余学习时间 ${Utils.formatStudyDuration(_countDown)}"),
        FlatButton(
          onPressed: () {},
          child: Text('保存'),
        )
      ],
    );
  }

  List<Widget> _buildPartnersView(BuildContext context) {
    return _studyUsers.map((studyUser) {
      return Card(
        child: ListTile(title: Text(studyUser.user.email)),
      );
    }).toList();
  }

  /// Finish this focus time, show dialog and save it.
  void finishFocusTime() {
    // Show feedback
    FocusTimeManager().addFocusTime(_currentFocusTime);

    showDialog(
        context: this._buildContext,
        builder: (BuildContext context) {
          return StudyFeedbackDialog(pressCallback: () {
            log("Yifan Callback");
            Navigator.of(context).pop();
          });
        });
  }

  int _leaveTime = 0;

  void onUserLeave() {
    _leaveTime = DateTime.now().millisecondsSinceEpoch;
    NotificationManager().showNotification();
  }

  void onUserBack() {
    int leaveDuration = DateTime.now().millisecondsSinceEpoch - _leaveTime;

    if (leaveDuration > Constants.MAX_LEAVE_DURATION) {
      // Show failure dialog
    }

  }
}
