import 'package:json_annotation/json_annotation.dart';

part 'focus_time.g.dart';

@JsonSerializable()
class FocusTime {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'duration')
  int duration;

  @JsonKey(name: 'created_time')
  int createdTime;

  @JsonKey(name: 'task_id')
  int taskId;

  FocusTime.normal(this.taskId, this.duration) {
    this.createdTime = DateTime.now().millisecondsSinceEpoch;
  }

  factory FocusTime.fromMapJson(Map<String, dynamic> json) => _$FocusTimeFromJson(json);

  Map<String, dynamic> toMapJson() => _$FocusTimeToJson(this);
}
