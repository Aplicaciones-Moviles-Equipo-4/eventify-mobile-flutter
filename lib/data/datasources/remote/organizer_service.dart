import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../models/profile/profile_model.dart';
import '../../models/quote/quote_model.dart';

class OrganizerService {
  final Dio dio;

  OrganizerService(this.dio);

  Future<List<ProfileModel>> getOrganizers() async {
    try {
      final response = await dio.get(ApiConstants.profiles);
      final profiles = (response.data as List)
          .map((e) => ProfileModel.fromJson(e))
          .toList();
      return profiles.where((p) => p.type == 'ORGANIZER').toList();
    } on DioException catch (e) {
      throw Exception('Get organizers failed: ${e.response?.data}');
    }
  }

  Future<List<QuoteModel>> getOrganizerQuotes(int organizerId) async {
    try {
      final response = await dio.get('${ApiConstants.organizers}/$organizerId/quotes');
      return (response.data as List)
          .map((e) => QuoteModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception('Get organizer quotes failed: ${e.response?.data}');
    }
  }
}
