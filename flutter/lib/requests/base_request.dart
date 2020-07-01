import 'package:app/utils/constants.dart';
import 'package:http/http.dart' as http;

abstract class BaseRequest {
  dynamic _body;
  Map<String, String> _headers;

  BaseRequest() {
    this._headers = {'Content-Type': 'application/json; charset=UTF-8'};
  }

  dynamic body(dynamic body) {
    this._body = body;
  }

  dynamic headers(Map<String, String> headers) {
    this._headers = headers;
  }

  String path();

  Future<http.Response> post() {
    return http.post(
      Constants.API_DOMAIN + path(),
      headers: _headers,
      body: _body,
    );
  }
}
