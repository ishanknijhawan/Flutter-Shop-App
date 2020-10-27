import 'package:flutter/material.dart';
import '../models/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<void> addOrder(double amount, List<CartItem> products) async {
    final url = 'https://boycottchina-b2cc6.firebaseio.com/orders.json';
    final timeStamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'id': DateTime.now().toString(),
        'amount': amount,
        'dateTime': timeStamp.toIso8601String(),
        'products': products
            .map((e) => {
                  'id': e.id,
                  'title': e.title,
                  'quantity': e.quantity,
                  'price': e.price,
                })
            .toList(),
      }),
    );
    _items.insert(
      0,
      Order(
        id: json.decode(response.body)['name'],
        amount: amount,
        dateTime: timeStamp,
        products: products,
      ),
    );
    notifyListeners();
  }
}
