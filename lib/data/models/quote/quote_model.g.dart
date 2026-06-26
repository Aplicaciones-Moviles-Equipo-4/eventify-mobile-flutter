// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteModel _$QuoteModelFromJson(Map<String, dynamic> json) => QuoteModel(
      quoteId: json['quoteId'] as String,
      title: json['title'] as String,
      eventType: json['eventType'] as String,
      guestQuantity: (json['guestQuantity'] as num).toInt(),
      location: json['location'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      state: json['state'] as String,
      eventDate: DateTime.parse(json['eventDate'] as String),
      organizerId: (json['organizerId'] as num).toInt(),
      hostId: (json['hostId'] as num).toInt(),
      serviceItems: (json['serviceItems'] as List<dynamic>?)
          ?.map((e) => ServiceItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuoteModelToJson(QuoteModel instance) =>
    <String, dynamic>{
      'quoteId': instance.quoteId,
      'title': instance.title,
      'eventType': instance.eventType,
      'guestQuantity': instance.guestQuantity,
      'location': instance.location,
      'totalPrice': instance.totalPrice,
      'state': instance.state,
      'eventDate': instance.eventDate.toIso8601String(),
      'organizerId': instance.organizerId,
      'hostId': instance.hostId,
      'serviceItems': instance.serviceItems,
    };
