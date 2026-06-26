import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int id;
  final String username;
  final List<String> roles;
  final String? token;

  UserModel({
    required this.id,
    required this.username,
    List<String>? roles,
    this.token,
  }) : roles = roles ?? [];

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
