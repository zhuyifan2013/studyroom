
import 'package:app/model/task.dart';
import 'package:app/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

import 'focus_time.dart';

part 'socket_study_user.g.dart';

@JsonSerializable()
class SocketStudyUser{

  @JsonKey(name: 'user')
  User user;

  @JsonKey(name: 'focus_time')
  FocusTime focusTime;

  @JsonKey(name: 'task')
  Task task;

  @JsonKey(name: 'topic')
  String topic;

  @JsonKey(name: 'room_id')
  String roomId;

  SocketStudyUser(this.user, this.focusTime, this.task, this.topic, this.roomId);

  factory SocketStudyUser.fromJson(Map<String, dynamic> json) => _$SocketStudyUserFromJson(json);

  Map<String, dynamic> toJson() => _$SocketStudyUserToJson(this);

}