import 'package:json_annotation/json_annotation.dart';

part 'service_item_model.g.dart';

@JsonSerializable()
class ServiceItemModel {
  final String id;
  final String description;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final String quoteId;

  ServiceItemModel({
    required this.id,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.quoteId,
  });

  factory ServiceItemModel.fromJson(Map<String, dynamic> json) => 
    _$ServiceItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceItemModelToJson(this);
}
