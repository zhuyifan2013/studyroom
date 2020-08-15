import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  static final NotificationManager _notification = NotificationManager._internal();
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  factory NotificationManager() {
    return _notification;
  }

  NotificationManager._internal();

  void init() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid = AndroidInitializationSettings('launch_background');
    var initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: (int id, String title, String body, String payload) async {
    });
    var initializationSettings = InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String payload) async {
      if (payload != null) {
        log('notification payload: ' + payload);
      }
    });
  }


  void showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '111', 'yifan-push', 'Start!!',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
        0, 'Start!', 'Begin', platformChannelSpecifics,
        payload: 'item yifan111');
  }
}
