import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/quote/quote_model.dart';

part 'quote_form_state.freezed.dart';

@freezed
class ServiceItemForm with _$ServiceItemForm {
  const factory ServiceItemForm({
    required String description,
    required int quantity,
    required double unitPrice,
  }) = _ServiceItemForm;
}

extension ServiceItemFormX on ServiceItemForm {
  double get total => quantity * unitPrice;
}

@freezed
class QuoteFormState with _$QuoteFormState {
  const factory QuoteFormState({
    required String title,
    required String eventType,
    required int guestQuantity,
    required String location,
    required DateTime eventDate,
    required int organizerId,
    required List<ServiceItemForm> serviceItems,
    required bool isLoading,
    @Default('') String additionalDetails,
    String? errorMessage,
    QuoteModel? createdQuote,
  }) = _QuoteFormState;

  factory QuoteFormState.initial({required int organizerId}) => QuoteFormState(
    title: '',
    eventType: '',
    guestQuantity: 1,
    location: '',
    additionalDetails: '',
    eventDate: DateTime.now(),
    organizerId: organizerId,
    serviceItems: [
      const ServiceItemForm(
        description: '',
        quantity: 1,
        unitPrice: 0,
      ),
    ],
    isLoading: false,
  );
}

extension QuoteFormStateX on QuoteFormState {
  double get totalBudget => 
    serviceItems.fold(0, (sum, item) => sum + item.total);
}
