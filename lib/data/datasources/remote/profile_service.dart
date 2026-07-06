import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../models/profile/profile_model.dart';

class ProfileService {
  final Dio dio;

  ProfileService(this.dio);

  Future<ProfileModel> createProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String street,
    required String number,
    required String city,
    required String postalCode,
    required String country,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.profiles,
        data: {
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'street': street,
          'number': number,
          'city': city,
          'postalCode': postalCode,
          'country': country,
          'type': 'HOSTER',
        },
      );
      return ProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Create profile failed: ${e.response?.data}');
    }
  }

  Future<ProfileModel> getProfile(int profileId) async {
    try {
      final response = await dio.get('${ApiConstants.profiles}/$profileId');
      return ProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Get profile failed: ${e.response?.data}');
    }
  }

  Future<ProfileModel> getProfileByEmail(String email) async {
    try {
      final response = await dio.get('${ApiConstants.profiles}/email/$email');
      return ProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Get profile by email failed: ${e.response?.data}');
    }
  }

  Future<List<ProfileModel>> getAllProfiles() async {
    try {
      final response = await dio.get(ApiConstants.profiles);
      return (response.data as List)
          .map((e) => ProfileModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception('Get all profiles failed: ${e.response?.data}');
    }
  }
}
