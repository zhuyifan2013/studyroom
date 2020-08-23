import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {

  String title;
  VoidCallback onPress;

  PageHeader({Key key, @required this.title, @required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(this.title),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.black,), onPressed: this.onPress,
              ),
            ),
          )
        ],
      ),
    );
  }
}
