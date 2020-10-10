import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/product_list.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = ProductList.productList;

  List<Product> get items {
    return [..._items];
  }

  void addProduct() {
    notifyListeners();
  }

  Product getItem(String id) =>
      _items.firstWhere((element) => element.id == id);
}
