import 'package:app/agora/agora.dart';
import 'package:flutter/material.dart';

class PageStudyRoom extends StatefulWidget {
  const PageStudyRoom();

  static const String defaultRoute = '/study_room';

  @override
  _PageStudyRoomState createState() => _PageStudyRoomState();
}

class _PageStudyRoomState extends State<PageStudyRoom> {

  @override
  void initState() {
    super.initState();
    AgoraManager().agoraLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                      padding: EdgeInsets.all(16),
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.5,
                      child: _buildStudyArea())),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStudyArea() {}
}
