// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      json['id'] as int?,
      json['name'] as String,
      json['description'] as String?,
      json['finished'] as bool,
      json['googleMapsUrl'] as String?,
      json['date'] as String,
      json['lastEdited'] as String,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'finished': instance.finished,
      'googleMapsUrl': instance.googleMapsUrl,
      'date': instance.date,
      'lastEdited': instance.lastEdited,
    };
