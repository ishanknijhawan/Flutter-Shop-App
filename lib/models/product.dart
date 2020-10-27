import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  @required
  final String id;
  @required
  final double price;
  @required
  final String description;
  @required
  final String title;
  @required
  final String imageUrl;
  bool isFavorite;

  Product(
      {this.id,
      this.price,
      this.description,
      this.imageUrl,
      this.title,
      this.isFavorite = false});

  Future<void> toggleFavorite() async {
    final url = 'https://boycottchina-b2cc6.firebaseio.com/products/$id.json';
    isFavorite = !isFavorite;
    await http.patch(
      url,
      body: json.encode(
        {
          'title': title,
          'id': id,
          'isFavorite': isFavorite,
          'price': price,
          'description': description,
          'imageUrl': imageUrl,
        },
      ),
    );
    notifyListeners();
  }
}
