import 'dart:convert';

import 'dart:developer';

import 'package:app/model/model_factory.dart';

class BaseResponse<T> {
  int code;
  String message;
  T data;

  BaseResponse(this.code, this.message, this.data);

  factory BaseResponse.fromJson(res) {
    return BaseResponse(res['code'], res['message'], ModelFactory.generateObj<T>(json.decode(res['data'])));
  }
}
