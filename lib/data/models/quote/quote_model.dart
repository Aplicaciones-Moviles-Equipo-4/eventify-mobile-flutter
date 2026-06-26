import 'package:json_annotation/json_annotation.dart';
import 'service_item_model.dart';

part 'quote_model.g.dart';

@JsonSerializable()
class QuoteModel {
  final String quoteId;
  final String title;
  final String eventType; // WEDDING, BIRTHDAY, CORPORATE, OTHER
  final int guestQuantity;
  final String location;
  final double totalPrice;
  final String state; // PENDING, ACCEPTED, REJECTED
  final DateTime eventDate;
  final int organizerId;
  final int hostId;
  final List<ServiceItemModel>? serviceItems;

  QuoteModel({
    required this.quoteId,
    required this.title,
    required this.eventType,
    required this.guestQuantity,
    required this.location,
    required this.totalPrice,
    required this.state,
    required this.eventDate,
    required this.organizerId,
    required this.hostId,
    this.serviceItems,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) => 
    _$QuoteModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuoteModelToJson(this);
}
