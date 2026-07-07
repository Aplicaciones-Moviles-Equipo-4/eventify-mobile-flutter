// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialEventModel _$SocialEventModelFromJson(Map<String, dynamic> json) =>
    SocialEventModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      customerName: json['customerName'] as String,
      place: json['place'] as String,
      status: json['status'] as String,
      organizerId: (json['organizerId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SocialEventModelToJson(SocialEventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date.toIso8601String(),
      'customerName': instance.customerName,
      'place': instance.place,
      'status': instance.status,
      'organizerId': instance.organizerId,
    };
