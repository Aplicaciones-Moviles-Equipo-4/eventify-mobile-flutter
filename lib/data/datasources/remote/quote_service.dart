import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../models/quote/quote_model.dart';
import '../../models/quote/service_item_model.dart';

class QuoteService {
  final Dio dio;

  QuoteService(this.dio);

  Future<QuoteModel> createQuote({
    required String title,
    required String eventType,
    required int guestQuantity,
    required String location,
    required double totalPrice,
    required DateTime eventDate,
    required int organizerId,
    required int hostId,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.quotes,
        data: {
          'title': title,
          'eventType': eventType,
          'guestQuantity': guestQuantity,
          'location': location,
          'totalPrice': totalPrice,
          'state': 'PENDING',
          'eventDate': eventDate.toIso8601String(),
          'organizerId': organizerId,
          'hostId': hostId,
        },
      );
      return QuoteModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Create quote failed: ${e.response?.data}');
    }
  }

  Future<QuoteModel> getQuote(String quoteId) async {
    try {
      final response = await dio.get('${ApiConstants.quotes}/$quoteId');
      return QuoteModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Get quote failed: ${e.response?.data}');
    }
  }

  Future<QuoteModel> updateQuote(String quoteId, Map<String, dynamic> data) async {
    try {
      final response = await dio.put('${ApiConstants.quotes}/$quoteId', data: data);
      return QuoteModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Update quote failed: ${e.response?.data}');
    }
  }

  Future<void> deleteQuote(String quoteId) async {
    try {
      await dio.delete('${ApiConstants.quotes}/$quoteId');
    } on DioException catch (e) {
      throw Exception('Delete quote failed: ${e.response?.data}');
    }
  }

  Future<void> acceptQuote(String quoteId) async {
    try {
      await dio.post('${ApiConstants.quotes}/$quoteId/confirmations');
    } on DioException catch (e) {
      throw Exception('Accept quote failed: ${e.response?.data}');
    }
  }

  Future<void> rejectQuote(String quoteId) async {
    try {
      await dio.post('${ApiConstants.quotes}/$quoteId/rejections');
    } on DioException catch (e) {
      throw Exception('Reject quote failed: ${e.response?.data}');
    }
  }

  Future<ServiceItemModel> addServiceItem({
    required String quoteId,
    required String description,
    required int quantity,
    required double unitPrice,
  }) async {
    try {
      final totalPrice = quantity * unitPrice;
      final response = await dio.post(
        '${ApiConstants.quotes}/$quoteId/service-items',
        data: {
          'description': description,
          'quantity': quantity,
          'unitPrice': unitPrice,
          'totalPrice': totalPrice,
          'quoteId': quoteId,
        },
      );
      return ServiceItemModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Add service item failed: ${e.response?.data}');
    }
  }

  Future<List<ServiceItemModel>> getServiceItems(String quoteId) async {
    try {
      final response = await dio.get('${ApiConstants.quotes}/$quoteId/service-items');
      return (response.data as List)
          .map((e) => ServiceItemModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception('Get service items failed: ${e.response?.data}');
    }
  }
}
