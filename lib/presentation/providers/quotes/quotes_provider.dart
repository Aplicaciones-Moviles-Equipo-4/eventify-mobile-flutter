import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'quote_form_notifier.dart';
import 'quote_form_state.dart';
import '../auth/auth_provider.dart';
import '../../../data/datasources/remote/quote_service.dart';
import '../../../data/datasources/remote/api_client.dart';
import '../../../data/models/quote/quote_model.dart';
import '../../../data/models/quote/service_item_model.dart';

final quoteServiceProvider = Provider<QuoteService>((ref) {
  final dio = ref.watch(dioProvider);
  return QuoteService(dio);
});

final quotesListProvider = FutureProvider<List<QuoteModel>>((ref) async {
  final quoteService = ref.watch(quoteServiceProvider);
  try {
    return await quoteService.getQuotes();
  } catch (e) {
    // Si el endpoint falla (por ejemplo, GET no soportado o no hay datos), 
    // retornamos una lista vacía para mostrar el estado "No hay cotizaciones"
    return [];
  }
});

final myQuotesProvider = Provider<AsyncValue<List<QuoteModel>>>((ref) {
  final quotesAsync = ref.watch(quotesListProvider);
  final user = ref.watch(currentUserProvider);

  return quotesAsync.whenData((quotes) {
    if (user == null) return [];
    return quotes.where((q) => q.hostId == user.id).toList();
  });
});

final quoteDetailProvider = 
  FutureProvider.family<QuoteModel, String>((ref, quoteId) async {
  final quoteService = ref.watch(quoteServiceProvider);
  return quoteService.getQuote(quoteId);
});

final quoteServiceItemsProvider = 
  FutureProvider.family<List<ServiceItemModel>, String>((ref, quoteId) async {
  final quoteService = ref.watch(quoteServiceProvider);
  return quoteService.getServiceItems(quoteId);
});

final quoteFormProvider = 
  StateNotifierProvider.family<QuoteFormNotifier, QuoteFormState, int>(
    (ref, organizerId) {
      final quoteService = ref.watch(quoteServiceProvider);
      return QuoteFormNotifier(quoteService, organizerId: organizerId);
    },
  );
