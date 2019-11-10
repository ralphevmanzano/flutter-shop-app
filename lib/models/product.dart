import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/http_exception.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'product.g.dart';

@JsonSerializable()
class Product with ChangeNotifier {
  @JsonKey(ignore: true)
  String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  factory Product.fromMappedJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  String toString() {
    return '[Product $id: title $title, description $description, price $price, imageUrl $imageUrl, isFavorite $isFavorite]';
  }

  Future<void> toggleFavoriteStatus() async {
    final url = 'https://flutter-recipe-93c67.firebaseio.com/products/$id';
    isFavorite = !isFavorite;
    notifyListeners();
    final response =
        await http.patch(url, body: jsonEncode({'isFavorite': isFavorite}));
    if (response.statusCode >= 400) {
      isFavorite = !isFavorite;
      notifyListeners();

      throw HttpException('Error favoriting item!');
    }
  }
}
