import 'package:flutter/material.dart';
import '../models/cart.dart';

class Order {
  final String id;
  final double amount;
  final DateTime dateTime;
  final List<CartItem> products;

  Order({this.id, this.amount, this.dateTime, this.products});
}

class OrderProvider with ChangeNotifier {
  List<Order> _items = [];
  List<Order> get items {
    return [..._items];
  }

  void addOrder(double amount, List<CartItem> products) {
    _items.insert(
      0,
      Order(
        id: DateTime.now().toString(),
        amount: amount,
        dateTime: DateTime.now(),
        products: products,
      ),
    );
    notifyListeners();
  }
}
