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

  Future<void> getOrders() async {
    const url = 'https://boycottchina-b2cc6.firebaseio.com/orders.json';
    final response = await http.get(url);
    List<Order> loadedOrders = [];
    final extractedOrders = json.decode(response.body) as Map<String, dynamic>;

    if (extractedOrders == null) {
      return;
    }

    extractedOrders.forEach((orderId, order) {
      loadedOrders.add(
        Order(
          id: orderId,
          amount: order['amount'],
          dateTime: DateTime.parse(order['dateTime']),
          products: (order['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                ),
              )
              .toList(),
        ),
      );
    });
    _items = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(double amount, List<CartItem> products) async {
    const url = 'https://boycottchina-b2cc6.firebaseio.com/orders.json';
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
