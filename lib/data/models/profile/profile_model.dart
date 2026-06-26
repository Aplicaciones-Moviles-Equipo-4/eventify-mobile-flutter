import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  final int id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final String street;
  final String number;
  final String city;
  final String postalCode;
  final String country;
  final String fullAddress;
  final String type; // HOST, ORGANIZER

  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.street,
    required this.number,
    required this.city,
    required this.postalCode,
    required this.country,
    required this.fullAddress,
    required this.type,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => 
    _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
