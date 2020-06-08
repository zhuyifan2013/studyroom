// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task()
    ..id = json['_id'] as String
    ..content = json['content'] as String
    ..focusTimeList =
        (json['focus_time_list'] as List)?.map((e) => e as String)?.toList()
    ..createdTime = json['created_time'] as String;
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'focus_time_list': instance.focusTimeList,
      'created_time': instance.createdTime,
    };
