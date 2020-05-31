import 'package:flutter/services.dart';

class AgoraManager {
  static const platform_agora = const MethodChannel('studyroom.yifan.com/agora');

  static final AgoraManager _agoraManager = AgoraManager._internal();

  factory AgoraManager() {
    return _agoraManager;
  }

  AgoraManager._internal() {
    platform_agora.setMethodCallHandler(_methodCallHandler);
  }

  Future<void> agoraInit() async {
    await platform_agora.invokeMethod("agoraInit");
  }

  Future<void> agoraLogin() async {
    await platform_agora.invokeMethod("agoraLogin");
  }

  Future<void> _methodCallHandler(MethodCall call) async {
    if (call.method == "agoraOnConnectionStateChanged") {
      print("agoraOnConnectionStateChanged : ${call.arguments}");
    } else if (call.method == "agoraOnMessageReceived") {
      print("agoraOnMessageReceived : ${call.arguments}");
    } else if (call.method == "agoraOnLoginSuccess") {
      print("agoraOnLoginSuccess : ${ call.arguments}");
    } else if ('agoraOnLoginError' == call.method) {
      print("agoraOnLoginError, code: ${call.arguments["errorCode"]}, msg: ${call.arguments["errorMsg"]}");
    }
  }
}
