import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../models/event/social_event_model.dart';

class EventService {
  final Dio dio;

  EventService(this.dio);

  Future<List<SocialEventModel>> getEventsByCustomer(String customerName) async {
    try {
      final response = await dio.get('${ApiConstants.customers}/$customerName/social-events');
      return (response.data as List)
          .map((e) => SocialEventModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception('Get events failed: ${e.response?.data}');
    }
  }

  Future<List<SocialEventModel>> getAllEvents() async {
    try {
      final response = await dio.get(ApiConstants.socialEvents);
      return (response.data as List)
          .map((e) => SocialEventModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception('Get all events failed: ${e.response?.data}');
    }
  }
}
