import 'dart:developer';

import 'package:app/model/task.dart';
import 'package:app/pages/arguments/study_room_args.dart';
import 'package:app/theme_data.dart';
import 'package:app/utils/task_manager.dart';
import 'package:app/widgets/page_header.dart';
import 'package:app/widgets/sr_button.dart';
import 'package:app/widgets/task_item_widget.dart';
import 'package:flutter/material.dart';

import '../page_study_room/page_study_room.dart';

class RoomSettingPage extends StatefulWidget {
  @override
  _RoomSettingPageState createState() => _RoomSettingPageState();
}

class _RoomSettingPageState extends State<RoomSettingPage> {
  static List<TimeTag> timeTags = List<TimeTag>.generate(3, (index) {
    switch (index) {
      case 0:
        return TimeTag(0, '25 mins', 25 * 60);
      case 1:
        return TimeTag(1, '40 mins', 40 * 60);
      case 2:
        return TimeTag(2, '60 mins', 60 * 60);
    }
    return null;
  });

  TimeTag currentTimeTag = timeTags[0];

  String _topic;
  String _taskId;
  int _duration = 1500;

  Task currentTask;

  TimeTag getTimeTag(index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            PageHeader(
              title: '设置',
              onPress: () {
                log('press');
              },
            ),
            Wrap(
                spacing: 10,
                children: List<Widget>.generate(3, (int index) {
                  TimeTag timeTag = timeTags[index];
                  return ChoiceChip(
                    label: Text(timeTag.label.toString()),
                    selected: currentTimeTag.index == timeTag.index,
                    onSelected: (bool selected) {
                      setState(() {
                        currentTimeTag = timeTags[index];
                      });
                    },
                    backgroundColor: Colors.white,
                    elevation: 1,
                    shadowColor: AppThemeData.color_page_bg,
                  );
                })),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select Task',
                style: Theme
                    .of(context)
                    .textTheme
                    .headline5,
              ),
            ),
            Expanded(
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        ..._buildTaskList(),
                      ],
                    ),
                  ],
                )),
            SRButton(
              onPressed: () {
                Navigator.pushNamed(context, PageStudyRoom.defaultRoute, arguments: StudyRoomArgs(currentTimeTag.duration, currentTask.topic, currentTask.id));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('开始学习', style: AppThemeData.bottomButtonContentStyleGreen),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTaskList() {
    return TaskManager()
        .getTasks()
        .map((e) =>
        InkWell(
          onTap: () {
            setState(() {
              currentTask = e;
            });
          },
          child: TaskItemWidget(
            task: e,
            isSelected: e == currentTask,
          ),
        ))
        .toList();
  }
}

class TimeTag {
  int index;
  String label;
  int duration;

  TimeTag(this.index, this.label, this.duration);
}
