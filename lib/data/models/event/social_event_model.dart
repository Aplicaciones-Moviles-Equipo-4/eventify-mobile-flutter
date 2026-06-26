import 'package:json_annotation/json_annotation.dart';

part 'social_event_model.g.dart';

@JsonSerializable()
class SocialEventModel {
  final int id;
  final String title;
  final String description;
  final DateTime eventDate;
  final String location;
  final String status;

  SocialEventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.eventDate,
    required this.location,
    required this.status,
  });

  factory SocialEventModel.fromJson(Map<String, dynamic> json) => 
    _$SocialEventModelFromJson(json);
  Map<String, dynamic> toJson() => _$SocialEventModelToJson(this);
}
