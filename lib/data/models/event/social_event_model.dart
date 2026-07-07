import 'package:json_annotation/json_annotation.dart';

part 'social_event_model.g.dart';

/// Maps the backend `SocialEventResource` (planning context).
/// The API emits: id, title, date (LocalDate), customerName, place, status, organizerId.
@JsonSerializable()
class SocialEventModel {
  final int id;
  final String title;
  final DateTime date;
  final String customerName;
  final String place;
  final String status;
  final int? organizerId;

  SocialEventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.customerName,
    required this.place,
    required this.status,
    this.organizerId,
  });

  factory SocialEventModel.fromJson(Map<String, dynamic> json) =>
      _$SocialEventModelFromJson(json);
  Map<String, dynamic> toJson() => _$SocialEventModelToJson(this);
}
