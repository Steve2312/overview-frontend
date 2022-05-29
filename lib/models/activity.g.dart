// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      json['id'] as int,
      json['name'] as String,
      json['finished'] as bool,
      json['googleMapsId'] as String?,
      json['date'] as String,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'finished': instance.finished,
      'googleMapsId': instance.googleMapsId,
      'date': instance.date,
    };
