import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/product_list.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = ProductList.productList;

  List<Product> get items {
    return [..._items];
  }

  void addProduct(Product product) {
    if (product.id == null) {
      var newProduct = Product(
          id: DateTime.now().toString(),
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
