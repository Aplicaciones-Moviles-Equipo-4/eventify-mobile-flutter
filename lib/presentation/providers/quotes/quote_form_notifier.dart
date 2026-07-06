import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'quote_form_state.dart';
import '../../../data/datasources/remote/quote_service.dart';

class QuoteFormNotifier extends StateNotifier<QuoteFormState> {
  final QuoteService quoteService;

  QuoteFormNotifier(
    this.quoteService, {
    required int organizerId,
  }) : super(QuoteFormState.initial(organizerId: organizerId));

  void updateTitle(String value) => state = state.copyWith(title: value);
  void updateEventType(String value) => state = state.copyWith(eventType: value);
  void updateGuestQuantity(int value) => state = state.copyWith(guestQuantity: value);
  void updateLocation(String value) => state = state.copyWith(location: value);
  void updateAdditionalDetails(String value) => state = state.copyWith(additionalDetails: value);
  void updateEventDate(DateTime value) => state = state.copyWith(eventDate: value);

  void addServiceItem() {
    final newItems = [...state.serviceItems, const ServiceItemForm(description: '', quantity: 1, unitPrice: 0)];
    state = state.copyWith(serviceItems: newItems);
  }

  void removeServiceItem(int index) {
    if (state.serviceItems.length > 1) {
      final newItems = [...state.serviceItems]..removeAt(index);
      state = state.copyWith(serviceItems: newItems);
    }
  }

  void updateServiceItem(int index, ServiceItemForm item) {
    final newItems = [...state.serviceItems];
    newItems[index] = item;
    state = state.copyWith(serviceItems: newItems);
  }

  Future<void> submitQuote({required int hostId}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      if (state.title.isEmpty) throw Exception('Título es requerido');
      if (state.eventType.isEmpty) throw Exception('Tipo de evento es requerido');
      if (state.location.isEmpty) throw Exception('Ubicación es requerida');

      final quote = await quoteService.createQuote(
        title: state.title,
        eventType: state.eventType,
        guestQuantity: state.guestQuantity,
        location: state.location,
        totalPrice: state.totalBudget,
        eventDate: state.eventDate,
        organizerId: state.organizerId,
        hostId: hostId,
      );

      for (var item in state.serviceItems) {
        if (item.description.isNotEmpty) {
          await quoteService.addServiceItem(
            quoteId: quote.quoteId,
            description: item.description,
            quantity: item.quantity,
            unitPrice: item.unitPrice,
          );
        }
      }

      state = state.copyWith(isLoading: false, createdQuote: quote);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}
