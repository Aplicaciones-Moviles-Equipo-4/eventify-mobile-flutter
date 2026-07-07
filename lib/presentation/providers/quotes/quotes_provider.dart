import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'quote_form_notifier.dart';
import 'quote_form_state.dart';
import '../profile/profile_provider.dart';
import '../auth/auth_provider.dart';
import '../../../data/datasources/remote/quote_service.dart';
import '../../../data/datasources/local/local_quote_service.dart';
import '../../../data/datasources/remote/api_client.dart';
import '../../../data/models/quote/quote_model.dart';
import '../../../data/models/quote/service_item_model.dart';

final quoteServiceProvider = Provider<QuoteService>((ref) {
  final dio = ref.watch(dioProvider);
  return QuoteService(dio);
});

final localQuoteServiceProvider = Provider<LocalQuoteService>((ref) {
  return LocalQuoteService();
});

final quotesListProvider = FutureProvider<List<QuoteModel>>((ref) async {
  final quoteService = ref.watch(quoteServiceProvider);
  final localService = ref.watch(localQuoteServiceProvider);
  final profile = await ref.watch(currentProfileProvider.future);
  final user = ref.watch(currentUserProvider);

  if (profile == null || user == null) return [];

  // 1. Intentamos obtener del servidor (Master Search)
  final remoteQuotes = await quoteService.getQuotesByProfile(profile.id);
  
  // 2. Obtenemos las guardadas localmente
  final localQuotes = await localService.getQuotes(user.id);

  // 3. Combinamos ambas listas evitando duplicados por ID
  final Map<String, QuoteModel> mergedMap = {};
  
  for (var q in localQuotes) { mergedMap[q.quoteId] = q; }
  for (var q in remoteQuotes) { mergedMap[q.quoteId] = q; }

  return mergedMap.values.toList()
    ..sort((a, b) => b.eventDate.compareTo(a.eventDate));
});

final myQuotesProvider = Provider<AsyncValue<List<QuoteModel>>>((ref) {
  return ref.watch(quotesListProvider);
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
      final localService = ref.watch(localQuoteServiceProvider);
      final user = ref.watch(currentUserProvider);
      return QuoteFormNotifier(quoteService, localService, user?.id, organizerId: organizerId);
    },
  );
