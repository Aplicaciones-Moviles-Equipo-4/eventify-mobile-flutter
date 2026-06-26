// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceItemModel _$ServiceItemModelFromJson(Map<String, dynamic> json) =>
    ServiceItemModel(
      id: json['id'] as String,
      description: json['description'] as String,
      quantity: (json['quantity'] as num).toInt(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      quoteId: json['quoteId'] as String,
    );

Map<String, dynamic> _$ServiceItemModelToJson(ServiceItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice,
      'totalPrice': instance.totalPrice,
      'quoteId': instance.quoteId,
    };
