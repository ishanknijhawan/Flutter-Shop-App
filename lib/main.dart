import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/product_detail.dart';
import './screens/product_screen.dart';
import 'providers/products_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductsProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.indigo,
          accentColor: Colors.red,
          fontFamily: 'Lato',
        ),
        debugShowCheckedModeBanner: false,
        title: 'Meals App',
        home: ProductScreen(),
        routes: {ProductDetail.routeName: (context) => ProductDetail()},
      ),
    );
  }
}
