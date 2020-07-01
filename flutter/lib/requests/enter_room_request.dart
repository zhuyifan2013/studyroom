import 'package:app/requests/base_request.dart';

class EnterRoomRequest extends BaseRequest {
  @override
  String path() {
    return "rooms/enter";
  }
}
