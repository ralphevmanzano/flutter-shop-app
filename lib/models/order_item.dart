import 'package:flutter/cupertino.dart';
import 'package:flutter_shop_app/models/cart_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderItem {
  @JsonKey(ignore: true)
  String id;
  final double amount;
  final List<CartItem> products;
  final String dateTime;

  OrderItem({
    this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });

  DateTime getDateTime() {
    return DateTime.parse(dateTime);
  }
  
  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
