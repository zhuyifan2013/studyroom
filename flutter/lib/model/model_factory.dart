import 'package:app/model/user.dart';

class ModelFactory {
  static T generateObj<T>(Map json) {
    if (json == null) {
      return null;
    }
    switch (T) {
      case User:
        return User.fromJson(json['user']) as T;
    }
  }
}
