import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'date.g.dart';

@JsonSerializable()
class Date {
  String date;
  int total;
  int remaining;

  Date(
    this.date,
    this.total,
    this.remaining,
  );

  factory Date.fromJson(Map<String, dynamic> json) => _$DateFromJson(json);

  Map<String, dynamic> toJson() => _$DateToJson(this);

  get formattedDate {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('d MMMM y').format(dateTime);
  }
}
