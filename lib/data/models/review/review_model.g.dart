// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      id: (json['Id'] as num).toInt(),
      content: json['content'] as String,
      fullName: json['fullName'] as String,
      socialEventDate: DateTime.parse(json['socialEventDate'] as String),
      rating: (json['rating'] as num).toInt(),
      profileId: (json['profileId'] as num).toInt(),
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'content': instance.content,
      'fullName': instance.fullName,
      'socialEventDate': instance.socialEventDate.toIso8601String(),
      'rating': instance.rating,
      'profileId': instance.profileId,
    };
