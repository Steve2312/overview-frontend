import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity {
  int id;
  String name;
  bool finished;
  String? googleMapsId;
  String date;

  Activity(
    this.id,
    this.name,
    this.finished,
    this.googleMapsId,
    this.date,
  );

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
