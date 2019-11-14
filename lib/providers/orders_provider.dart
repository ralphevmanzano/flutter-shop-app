import 'dart:convert';
import 'dart:core';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_shop_app/models/cart_item.dart';
import 'package:flutter_shop_app/models/http_exception.dart';
import 'package:flutter_shop_app/models/order_item.dart';
import 'package:http/http.dart' as http;

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;

  Orders(this.authToken, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = 'https://flutter-recipe-93c67.firebaseio.com/orders.json?auth=$authToken';
    final response = await http.get(url);
    final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
    final List<OrderItem> fetchedOrders = [];

    if (extractedData == null) return;

    extractedData.forEach((orderId, orderData) {
      var order = OrderItem.fromJson(orderData);
      order.id = orderId;
      fetchedOrders.add(order);
    });

    _orders = fetchedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = 'https://flutter-recipe-93c67.firebaseio.com/orders.json?auth=$authToken';
    final order = OrderItem(
      amount: total,
      products: cartProducts,
      dateTime: DateTime.now().toIso8601String(),
    );
    try {
      final response = await http.post(url, body: jsonEncode(order.toJson()));
      order.id = jsonDecode(response.body)['id'];
      _orders.insert(0, order);
      notifyListeners();
    } catch (error) {
      throw HttpException('Error checkout');
    }
  }
}
