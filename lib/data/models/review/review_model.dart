import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel {
  @JsonKey(name: 'Id')
  final int id;
  final String content;
  final String fullName;
  final DateTime socialEventDate;
  final int rating; // 1-5
  final int profileId;

  ReviewModel({
    required this.id,
    required this.content,
    required this.fullName,
    required this.socialEventDate,
    required this.rating,
    required this.profileId,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => 
    _$ReviewModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
