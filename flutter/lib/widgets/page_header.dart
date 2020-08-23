import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({Key key, @required String title, @required VoidCallback onPress}) : super(key: key);

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
              child: Text('测试Title'),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.black,), onPressed: () {  },
              ),
            ),
          )
        ],
      ),
    );
  }
}
