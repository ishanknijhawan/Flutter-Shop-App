import 'package:flutter/material.dart';

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

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
