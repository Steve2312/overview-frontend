import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity {
  int? id;
  String name;
  String? description;
  bool finished;
  String? googleMapsUrl;
  String date;
  String lastEdited;

  Activity(
    this.id,
    this.name,
    this.description,
    this.finished,
    this.googleMapsUrl,
    this.date,
    this.lastEdited,
  );

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);

  get formattedDate {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('d MMMM y').format(dateTime);
  }
}
