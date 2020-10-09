import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_detail.dart';
import 'package:shop_app/screens/product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.red,
        fontFamily: 'Lato',
      ),
      debugShowCheckedModeBanner: false,
      title: 'Meals App',
      home: ProductScreen(),
      routes: {ProductDetail.routeName: (context) => ProductDetail()},
    );
  }
}
