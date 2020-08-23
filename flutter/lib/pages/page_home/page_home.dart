import 'dart:developer';

import 'package:app/model/task.dart';
import 'package:app/pages/page_home/room_setting.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/task_manager.dart';
import 'package:app/widgets/sr_button.dart';
import 'package:app/widgets/task_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(24),
      children: [
        Container(
          width: 300,
          height: MediaQuery.of(context).size.height * 0.25,
          child: headerButton1(context),
        ),
        SizedBox(height: 32),
        _buildTaskSection(context)
      ],
    );
  }

  Widget headerButton1(BuildContext context) => SRButton(
    child: Text('Study',style: TextStyle(color: Colors.white)),
    onPressed: () {
      log("Click");
      if(TaskManager().getTasks().isNotEmpty) {
//        _showRoomSetting(context);
        Navigator.pushNamed(context, Constants.ROUTE_ROOM_SETTING);
      }
    },
  );

  String _taskContent;

  Widget _buildTaskSection(BuildContext context) => Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    'Today',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _addTask();
                  },
                  icon: Icon(Icons.add_circle, color: Colors.blue),
                )
              ],
            ),
            _buildTaskList(),
          ],
        ),
      );

  void _addTask() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    onChanged: (String value) {
                      _taskContent = value;
                    },
                  ),
                  RaisedButton(
                    onPressed: () {
                      TaskManager().addTask(_taskContent);
                    },
                    child: Text('完成'),
                  )
                ],
              ));
        });
  }

  Widget _buildTaskList() {
    return Consumer<TaskManager>(
      builder: (context, taskList, child) {
        final List<Task> tasks = taskList.getTasks();
        if (tasks.length == 0) {
          return Text('Nothing');
        }
        return Column(
          children: <Widget>[for (Task task in tasks) _buildTaskItem(context, task)],
        );
      },
    );
  }

  Widget _buildTaskItem(BuildContext context, Task task) {
    return TaskItemWidget(
      task: task,
    );
  }

  void _showRoomSetting(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return RoomSettingPage();
        });
  }
}
