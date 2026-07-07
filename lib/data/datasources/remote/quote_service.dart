import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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

  /// Intenta obtener las cotizaciones del Host probando todas las variaciones posibles del backend
  Future<List<QuoteModel>> getQuotesByProfile(int profileId) async {
    // Lista maestra de endpoints probables basada en patrones del Swagger
    final endpoints = [
      '${ApiConstants.quotes}/profile/$profileId', // Siguiendo el patron /reviews/profile/ID
      '${ApiConstants.quotes}?hostId=$profileId',   // Parametro de busqueda estandar
      '${ApiConstants.quotes}/host/$profileId',      // Ruta de recurso dedicada
      '${ApiConstants.customers}/$profileId/quotes', // Ruta por entidad
      '${ApiConstants.organizers}/$profileId/quotes',// Por si el ID es compartido
      ApiConstants.quotes,                           // Listado general (ultimo recurso)
    ];

    for (var url in endpoints) {
      try {
        debugPrint('🔍 Probando endpoint: $url');
        final response = await dio.get(url);
        
        if (response.statusCode == 200 && response.data != null) {
          // Manejamos si la respuesta es una lista directa o un objeto con campo 'content'
          final dynamic rawData = response.data;
          List<dynamic> listData = [];
          
          if (rawData is List) {
            listData = rawData;
          } else if (rawData is Map && rawData.containsKey('content')) {
            listData = rawData['content'];
          }

          if (listData.isNotEmpty) {
            final quotes = listData.map((e) => QuoteModel.fromJson(e)).toList();
            
            // Si es el listado general, filtramos manualmente
            if (url == ApiConstants.quotes) {
              final filtered = quotes.where((q) => q.hostId == profileId).toList();
              if (filtered.isNotEmpty) {
                debugPrint('✅ Datos encontrados en listado general filtrado por ID $profileId');
                return filtered;
              }
            } else {
              debugPrint('✅ ¡Ruta correcta encontrada!: $url');
              return quotes;
            }
          }
        }
      } catch (e) {
        // Log sutil para no llenar la consola si falla
        debugPrint('❌ $url no disponible (${e is DioException ? e.response?.statusCode : e})');
        continue;
      }
    }

    debugPrint('⚠️ Ninguna de las rutas maestras devolvió datos para el ID $profileId');
    return [];
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
