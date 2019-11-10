import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item.g.dart';

@JsonSerializable()
class CartItem {
  @JsonKey(ignore: true)
  String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  CartItem({
    this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.imageUrl,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
