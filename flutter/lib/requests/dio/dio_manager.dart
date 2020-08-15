import 'package:app/requests/base_request.dart';
import 'package:app/requests/dio/base_response.dart';
import 'package:app/requests/dio/errtor_response.dart';
import 'package:app/utils/constants.dart';
import 'package:dio/dio.dart';

import 'http_method.dart';

class DioManager {
  static final DioManager _shared = DioManager._internal();

  factory DioManager() => _shared;
  Dio _dio;

  DioManager._internal() {
    if (_dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: Constants.API_DOMAIN,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: false,
        connectTimeout: 30000,
        receiveTimeout: 3000,
      );
      _dio = Dio(options);
    }
  }

  // 请求，返回参数为 T
  // method：请求方法，HttpMethod.POST等
  // path：请求地址
  // params：请求参数
  // success：请求成功回调
  // error：请求失败回调
  Future request<T>(HttpMethod method, String path, {data, Map params, Function(T) success, Function(ErrorResponse) error}) async {
    try {
      Response response = await _dio.request(path, data: data, queryParameters: params, options: Options(method: HttpMethodValues[method]));
      if (response != null) {
        BaseResponse entity = BaseResponse<T>.fromJson(response.data);
        if (entity.code == 0) {
          success(entity.data);
        } else {
          error(ErrorResponse(code: entity.code, message: entity.message));
        }
      } else {
        error(ErrorResponse(code: -1, message: "未知错误"));
      }
    } on DioError catch (e) {
      error(createErrorEntity(e));
    }
  }

  // 错误信息
  ErrorResponse createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.CANCEL:
        {
          return ErrorResponse(code: -1, message: "请求取消");
        }
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        {
          return ErrorResponse(code: -1, message: "连接超时");
        }
        break;
      case DioErrorType.SEND_TIMEOUT:
        {
          return ErrorResponse(code: -1, message: "请求超时");
        }
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        {
          return ErrorResponse(code: -1, message: "响应超时");
        }
        break;
      case DioErrorType.RESPONSE:
        {
          try {
            int errCode = error.response.statusCode;
            String errMsg = error.response.statusMessage;
            return ErrorResponse(code: errCode, message: errMsg);
//          switch (errCode) {
//            case 400: {
//              return ErrorEntity(code: errCode, message: "请求语法错误");
//            }
//            break;
//            case 403: {
//              return ErrorEntity(code: errCode, message: "服务器拒绝执行");
//            }
//            break;
//            case 404: {
//              return ErrorEntity(code: errCode, message: "无法连接服务器");
//            }
//            break;
//            case 405: {
//              return ErrorEntity(code: errCode, message: "请求方法被禁止");
//            }
//            break;
//            case 500: {
//              return ErrorEntity(code: errCode, message: "服务器内部错误");
//            }
//            break;
//            case 502: {
//              return ErrorEntity(code: errCode, message: "无效的请求");
//            }
//            break;
//            case 503: {
//              return ErrorEntity(code: errCode, message: "服务器挂了");
//            }
//            break;
//            case 505: {
//              return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
//            }
//            break;
//            default: {
//              return ErrorEntity(code: errCode, message: "未知错误");
//            }
//          }
          } on Exception catch (_) {
            return ErrorResponse(code: -1, message: "未知错误");
          }
        }
        break;
      default:
        {
          return ErrorResponse(code: -1, message: error.message);
        }
    }
  }
}
