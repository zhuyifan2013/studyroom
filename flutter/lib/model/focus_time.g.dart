// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FocusTime _$FocusTimeFromJson(Map<String, dynamic> json) {
  return FocusTime()
    ..id = json['_id'] as String
    ..duration = json['duration'] as int
    ..createdTime = json['created_time'] as String
    ..taskId = json['task_id'] as int;
}

Map<String, dynamic> _$FocusTimeToJson(FocusTime instance) => <String, dynamic>{
      '_id': instance.id,
      'duration': instance.duration,
      'created_time': instance.createdTime,
      'task_id': instance.taskId,
    };
