import 'package:app/model/task.dart';
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
      children: [
        Container(
          padding: EdgeInsets.all(16),
          height: MediaQuery
              .of(context)
              .size
              .height * 0.3,
          child: headerButton(context),
        ),
        _buildTaskSection(context)
      ],
    );
  }

  Widget headerButton(BuildContext context) =>
      Material(
        color: Colors.indigo,
        child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                child: new SimpleDialog(
                  contentPadding: EdgeInsets.all(16),
                  title: Text('设置'),
                  children: <Widget>[
                    Text('这里会设置一些其他的东西，暂时先不管11'),
                    FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/study_room');
                      },
                      child: Text('开始！'),
                    )
                  ],
                ));
          },
          child: Center(child: Text('Go to room111')),
        ),
      );

  String _taskContent;

  Widget _buildTaskSection(BuildContext context) =>
      Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('我的任务'),
                FlatButton(
                  onPressed: () {
                    _addTask();
                  },
                  child: Text('Add'),
                )
              ],
            ),
            TextField(
              onChanged: (String value) {
                _taskContent = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '任务内容',
              ),
            ),
            _buildTaskList(),
          ],
        ),
      );

  void _addTask() {
    TaskManager().addTask(_taskContent);
  }

  Widget _buildTaskList() {
    return Consumer<TaskManager>(
      builder: (context, taskList, child) {
        final List<Task> tasks = taskList.getTasks();
        print('Yifan : ' + tasks.length.toString());
        if (tasks.length == 0) {
          return Text('Nothing');
        }
        return Column(
          children: <Widget>[for (Task task in tasks) Text(task.content)],
        );
//        return Expanded(child: ListView.builder(
//            itemCount: tasks.length,
//            itemBuilder: (BuildContext context, int index) {
//          return );
//        })
//        );
      },
    );
  }
}
