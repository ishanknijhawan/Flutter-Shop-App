import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../data/product_list.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = ProductList.productList;

  List<Product> get items {
    return [..._items];
  }

  //https://assets.entrepreneur.com/content/3x2/2000/20191219170611-GettyImages-1152794789.jpeg
  Future<void> addProduct(Product product) {
    const url = 'https://boycottchina-b2cc6.firebaseio.com/products';
    return http
        .post(
      url,
      body: json.encode(
        {
          'title': product.title,
          'id': product.id,
          'isFavorite': product.isFavorite,
          'price': product.price,
          'description': product.description,
          'imageUrl': product.imageUrl,
        },
      ),
    )
        .then((value) {
      if (product.id == null) {
        var newProduct = Product(
            id: json.decode(value.body)['name'],
            title: product.title,
            price: product.price,
            description: product.description,
            imageUrl: product.imageUrl,
            isFavorite: false);
        _items.insert(0, newProduct);
      } else {
        final index = _items.indexWhere((element) => element.id == product.id);
        _items[index] = product;
      }
      notifyListeners();
    }).catchError((error) => throw (error));
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  List<Product> get showFavorites {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product getItem(String id) {
    return _items.firstWhere(
      (element) => element.id == id,
    );
  }
}
