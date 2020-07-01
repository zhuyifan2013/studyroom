import 'package:app/model/task.dart';
import 'package:app/pages/page_home/room_setting.dart';
import 'package:app/utils/task_manager.dart';
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
      padding: EdgeInsets.all(16),
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: headerButton(context),
        ),
        SizedBox(height: 16),
        _buildTaskSection(context)
      ],
    );
  }

  Widget headerButton(BuildContext context) => Ink(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: AssetImage("assets/images/go_room.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: InkWell(
          splashColor: Colors.white.withOpacity(0.2),
          onTap: () {
            if(TaskManager().getTasks().isNotEmpty) {
              _showRoomSetting(context);
            }
          },
          child: Container(
//            decoration:
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "开始学习",
                  style: TextStyle(fontSize: 36, color: Colors.white, shadows: [
                    Shadow(
                      blurRadius: 20.0,
                      color: Colors.black,
                      offset: Offset(-5.0, 5.0),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
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
                    '我的任务',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _addTask();
                  },
                  icon: Icon(Icons.add_circle),
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
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(task.content != null ? task.content : "Null", style: Theme.of(context).textTheme.subtitle1),
        )
      ],
    );
  }

  void _showRoomSetting(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return RoomSetting();
        });
  }
}
