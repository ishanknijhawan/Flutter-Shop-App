import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/product_list.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = ProductList.productList;

  List<Product> get items {
    return [..._items];
  }

  void addProduct() {
    notifyListeners();
  }

  List<Product> get showFavorites {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product getItem(String id) =>
      _items.firstWhere((element) => element.id == id);
}
