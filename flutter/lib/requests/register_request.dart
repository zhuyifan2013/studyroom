import 'package:app/model/user.dart';
import 'package:app/requests/base_request.dart';

class RegisterRequest extends BaseRequest<User> {
  @override
  String path() {
    return 'users/new';
  }

  static Map<String, Map> buildBody(User user) {
    return {"user": user.toJson()};
  }
}
