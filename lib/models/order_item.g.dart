// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return OrderItem(
    amount: (json['amount'] as num)?.toDouble(),
    products: (json['products'] as List)
        ?.map((e) =>
            e == null ? null : CartItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    dateTime: json['dateTime'] as String,
  );
}

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'amount': instance.amount,
      'products': instance.products?.map((e) => e?.toJson())?.toList(),
      'dateTime': instance.dateTime,
    };
