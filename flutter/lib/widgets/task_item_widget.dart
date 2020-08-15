import 'package:app/model/task.dart';
import 'package:app/theme_data.dart';
import 'package:app/widgets/task_tag_widget.dart';
import 'package:flutter/material.dart';

class TaskItemWidget extends StatefulWidget {
  final Task task;

  const TaskItemWidget({Key key, @required this.task}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  Task get task => widget.task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: new BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [
        BoxShadow(
          color: const Color(0xfff2f2f2),
          blurRadius: 10,
          offset: Offset(0, 0), // changes position of shadow
        ),
      ]),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(task.content, style: AppThemeData.taskContentStyleGreen),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    TaskTag(
                      taskText: 'English',
                    )
                  ],
                )
              ],
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: Colors.green),
          )
        ],
      ),
    );
  }
}
