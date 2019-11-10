import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_shop_app/models/http_exception.dart';
import 'package:flutter_shop_app/models/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Future<void> fetchAndSetProducts() async {
    const url = 'https://flutter-recipe-93c67.firebaseio.com/products.json';

    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      final List<Product> fetchedProducts = [];
      
      if (extractedData == null) return;
      
      extractedData.forEach((prodId, prodData) {
        var prod = Product.fromMappedJson(prodData);
        prod.id = prodId;
        fetchedProducts.add(prod);
      });
      _items = fetchedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://flutter-recipe-93c67.firebaseio.com/products.json';
    try {
      final response = await http.post(
        url,
        body: jsonEncode(product.toJson()),
      );

      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://flutter-recipe-93c67.firebaseio.com/products/$id.json';
      try {
        await http.patch(url, body: jsonEncode(newProduct.toJson()));
      } catch (error) {
        print('Update error $error');
      }
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://flutter-recipe-93c67.firebaseio.com/products/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];

    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();

      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
