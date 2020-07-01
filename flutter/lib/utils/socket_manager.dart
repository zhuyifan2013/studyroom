import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:app/utils/constants.dart';

class SocketManager {



  static final SocketManager _socketManager = SocketManager._internal();

  SocketIOManager _socketIOManager;

  factory SocketManager() {
    return _socketManager;
  }

  SocketManager._internal() {
    _socketIOManager = SocketIOManager();
  }

  Future<SocketIO> createSocket(SocketOptions options) {
    return _socketIOManager.createInstance(options);
  }

  static SocketOptions createSocketOptions() {
    return SocketOptions(
        Constants.SOCKET_URI,
    );
  }

  void disconnect(SocketIO instance) {
    _socketIOManager.clearInstance(instance);
  }

}
