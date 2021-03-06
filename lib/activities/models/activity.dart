import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity {
  int id;
  String name;
  String? description;
  bool finished;
  String? googleMapsUrl;
  String date;

  Activity(
    this.id,
    this.name,
    this.description,
    this.finished,
    this.googleMapsUrl,
    this.date,
  );

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
