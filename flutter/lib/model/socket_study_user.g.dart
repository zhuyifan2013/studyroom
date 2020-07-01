// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'socket_study_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocketStudyUser _$SocketStudyUserFromJson(Map<String, dynamic> json) {
  return SocketStudyUser(
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    json['focus_time'] == null
        ? null
        : FocusTime.fromJson(json['focus_time'] as Map<String, dynamic>),
    json['task'] == null
        ? null
        : Task.fromJson(json['task'] as Map<String, dynamic>),
    json['topic'] as String,
    json['room_id'] as String,
  );
}

Map<String, dynamic> _$SocketStudyUserToJson(SocketStudyUser instance) =>
    <String, dynamic>{
      'user': instance.user,
      'focus_time': instance.focusTime,
      'task': instance.task,
      'topic': instance.topic,
      'room_id': instance.roomId,
    };
