import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.shopping_bag_outlined),
        title: Text('Shop App'),
      ),
      body: ProductsGrid(),
    );
  }
}
