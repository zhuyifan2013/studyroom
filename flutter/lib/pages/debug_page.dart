import 'package:app/model/focus_time.dart';
import 'package:app/utils/account_manager.dart';
import 'package:app/utils/focus_time_manager.dart';
import 'package:app/utils/task_manager.dart';
import 'package:flutter/material.dart';

class PageDebug extends StatefulWidget {
  @override
  _PageDebugState createState() => _PageDebugState();
}

class _PageDebugState extends State<PageDebug> {
  String _data = "Nothing";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(_data),
        FlatButton(
          onPressed: () async {
            await TaskManager().fetchTasksFromDb();
            setState(() {
              _data = TaskManager().getTasks().toString();
            });
          },
          child: Text('获取 Task List'),
        ),
        FlatButton(
          onPressed: ()  async {
            List<FocusTime> list = await FocusTimeManager().fetchFocusTimeFromDb();
            String printData = "";
            List.generate(list.length, (index) {printData += list[index].toJson().toString() + "\n";});
            setState(()  {
              _data = printData;
            });
          },
          child: Text('获取 Focus Time List'),
        ),
        FlatButton(
          onPressed: ()  async {
            AccountManager().clearUser();
          },
          child: Text('Clear User Info'),
        ),
      ],
    );
  }
}
