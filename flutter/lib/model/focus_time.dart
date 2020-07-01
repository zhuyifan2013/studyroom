import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'focus_time.g.dart';

@JsonSerializable()
class FocusTime {
  FocusTime();

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'duration')
  int duration;

  @JsonKey(name: 'created_time')
  String createdTime;

  @JsonKey(name: 'task_id')
  int taskId;

  FocusTime.normal(this.taskId, this.duration) {
    this.createdTime = DateTime.now().millisecondsSinceEpoch.toString();
  }

  factory FocusTime.fromJson(Map<String, dynamic> json) => _$FocusTimeFromJson(json);

  Map<String, dynamic> toJson() => _$FocusTimeToJson(this);

  Map<String, dynamic> toMap() {
    return {'duration': duration, 'task_id': taskId, 'created_time': createdTime};
  }

  FocusTime.fromDBMap(Map<String, dynamic> map) {
    this.id = map['id'].toString();
    this.duration = map['duration'];
    this.taskId = map['task_id'];
    this.createdTime = map['created_time'];
  }

  String toRawJson() {
    return json.encode({"focus_time" : this.toJson()});
  }

}
