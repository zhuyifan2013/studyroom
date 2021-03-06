import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  Task();

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'focus_time_list')
  List<String> focusTimeList;

  @JsonKey(name: 'created_time')
  String createdTime;

  @JsonKey(name: 'finished', defaultValue: false)
  bool finished;

  @JsonKey(name: 'topic')
  String topic;

  Task.fromContent(String content) {
    this.content = content;
    this.focusTimeList = [];
    this.createdTime = DateTime.now().millisecondsSinceEpoch.toString();
  }

  Task.fromDBMap(Map<String, dynamic> map) {
    this.id = map['id'].toString();
    this.content = map['content'];
    this.focusTimeList = (jsonDecode(map['focus_time_list']) as List<dynamic>).cast<String>();
    this.createdTime = map['created_time'];
    this.finished = map['finished'];
    this.topic = map['topic'];
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'focus_time_list': json.encode(focusTimeList),
      'created_time': createdTime,
      'finished': finished,
      'topic': topic
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
