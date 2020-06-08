// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['email', '_id']);
  return User()
    ..name = json['name'] as String ?? 'Yifan'
    ..email = json['email'] as String
    ..token = json['token'] as String
    ..id = json['_id'] as String
    ..password = json['password'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'token': instance.token,
      '_id': instance.id,
      'password': instance.password,
    };
