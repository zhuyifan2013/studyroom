import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
/// flutter pub run build_runner build --delete-conflicting-outputs for one time.
/// flutter pub run build_runner watch for generating code continuously.
@JsonSerializable()
class User {
  User();

  @JsonKey(defaultValue: "Yifan")
  String name;

  @JsonKey(name: 'email', required: true)
  String email;

  @JsonKey(name: 'token')
  String token;

  @JsonKey(name: '_id', required: true)
  String id;

  String password;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory User.fromMapJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toMapJson() => _$UserToJson(this);

  String toRawJson() {
    return json.encode({"user" : this.toMapJson()});
  }
}
