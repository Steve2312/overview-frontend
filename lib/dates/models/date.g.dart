// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Date _$DateFromJson(Map<String, dynamic> json) => Date(
      json['date'] as String,
      json['total'] as int,
      json['remaining'] as int,
    );

Map<String, dynamic> _$DateToJson(Date instance) => <String, dynamic>{
      'date': instance.date,
      'total': instance.total,
      'remaining': instance.remaining,
    };
