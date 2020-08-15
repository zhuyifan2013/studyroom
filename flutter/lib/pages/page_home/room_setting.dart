import 'package:app/pages/arguments/study_room_args.dart';
import 'package:app/utils/task_manager.dart';
import 'package:flutter/material.dart';

import '../page_study_room/page_study_room.dart';

class RoomSetting extends StatefulWidget {
  @override
  _RoomSettingState createState() => _RoomSettingState();

}

class _RoomSettingState extends State<RoomSetting> {

  String _topic;
  String _taskId;
  int _duration = 1500;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text('房间设置'),
            TextField(
              onChanged: (value) => _topic = value,
            ),
            DropdownButton<String>(
              onChanged: (String value) {
                _taskId = value;
              },
              items: TaskManager().getTasks().map((value){
                return DropdownMenuItem<String>(
                value: value.id,
                child: Text(value.content),
              );
            }).toList(),

            ),
            DropdownButton<int>(
              value: _duration,
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              onChanged: (int newValue) {
                setState(() {
                  _duration = newValue;
                });
              },
              items: <String>['25分钟', '40分钟', '60分钟'].asMap().entries.map<DropdownMenuItem<int>>((entry) {
                int realValue = 1500;
                switch(entry.key) {
                  case 0:
                    realValue = 1500;
                    break;
                  case 1:
                    realValue = 2400;
                    break;
                  case 2:
                    realValue = 3600;
                    break;
                }
                return DropdownMenuItem<int>(
                  value: realValue,
                  child: Text(entry.value),
                );
              }).toList(),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, PageStudyRoom.defaultRoute,
                    arguments: StudyRoomArgs(_duration, _topic, _taskId));
              },
              child: Text('开始学习'),
            )
          ],
        ));
  }

}