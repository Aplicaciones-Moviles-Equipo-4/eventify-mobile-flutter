// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialEventModel _$SocialEventModelFromJson(Map<String, dynamic> json) =>
    SocialEventModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      eventDate: DateTime.parse(json['eventDate'] as String),
      location: json['location'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$SocialEventModelToJson(SocialEventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'eventDate': instance.eventDate.toIso8601String(),
      'location': instance.location,
      'status': instance.status,
    };
