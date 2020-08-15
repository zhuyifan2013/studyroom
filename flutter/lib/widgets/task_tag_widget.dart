import 'package:flutter/material.dart';

import '../theme_data.dart';

class TaskTag extends StatefulWidget {
  final String taskText;

  const TaskTag({Key key, @required this.taskText}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskTagState();
}

class _TaskTagState extends State<TaskTag> {
  String get taskText => widget.taskText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: AppThemeData.tag_color_green_bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(taskText, style: AppThemeData.taskTagStyleGreen),
        ),
      ),
    );
  }
}
