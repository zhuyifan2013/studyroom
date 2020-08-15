import 'package:app/model/user.dart';
import 'package:app/requests/base_request.dart';

class LoginRequest extends BaseRequest<User> {
  @override
  String path() {
    return 'users/login';
  }

  Map body(String email, String password ) {

  }
}
