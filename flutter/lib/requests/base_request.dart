import 'package:app/requests/dio/dio_manager.dart';
import 'package:app/requests/dio/http_method.dart';

import 'dio/errtor_response.dart';

abstract class BaseRequest<T> {
  String path();

  void post(Map body, Function(T) success, Function(ErrorResponse) error) {
    DioManager().request(HttpMethod.POST, path(), data: body, success: success, error: error);
  }
}
