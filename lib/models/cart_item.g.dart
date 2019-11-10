// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) {
  return CartItem(
    title: json['title'] as String,
    quantity: json['quantity'] as int,
    price: (json['price'] as num)?.toDouble(),
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'title': instance.title,
      'quantity': instance.quantity,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
    };
