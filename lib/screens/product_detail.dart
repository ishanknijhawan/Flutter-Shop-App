import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  static const routeName = '/product_detail_screen';
  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(id),
      ),
    );
  }
}
