import 'package:flutter/material.dart';

class CartItem {
  @required
  final String id;
  @required
  final int quantity;
  @required
  final String title;
  @required
  final double price;

  CartItem({this.id, this.quantity, this.title, this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get itemTotal {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void deleteItem(String id) {
    _items.removeWhere((key, value) => value.id == id);
    notifyListeners();
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      //increase quantity by 1
      _items.update(
          productId,
          (existingValue) => CartItem(
                id: existingValue.id,
                title: existingValue.title,
                price: existingValue.price,
                quantity: existingValue.quantity + 1,
              ));
      notifyListeners();
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
      notifyListeners();
    }
  }
}
