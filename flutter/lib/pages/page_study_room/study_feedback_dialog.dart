import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';



class StudyFeedbackDialog extends StatelessWidget {

  PressCallback pressCallback;

  StudyFeedbackDialog({Key key, @required this.pressCallback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('AlertDialog Title'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('学习结束'),
            Text('恭喜您'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('休息一会'),
          onPressed: pressCallback
        ),
      ],
    );
  }


}