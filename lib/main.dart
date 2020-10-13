import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

import './screens/user_product_screen.dart';
import './providers/orders_provider.dart';
import './screens/cart_screen.dart';
import './screens/product_detail.dart';
import './screens/product_screen.dart';
import 'providers/products_provider.dart';
import 'models/cart.dart';
import 'providers/orders_provider.dart';
import './screens/orders_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //can also use ChangeNotifierProvider.value here
      //but it is recomemnded that if creating a new instance, use create
      //and if rebuilding is everytime, or in a List/GridView, use .value
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.indigo,
          accentColor: Colors.red,
          fontFamily: 'Lato',
        ),
        debugShowCheckedModeBanner: false,
        title: 'Meals App',
        home: ProductScreen(),
        routes: {
          //'/': (ctx) => ProductScreen(),
          ProductDetail.routeName: (context) => ProductDetail(),
          CartScreen.routeName: (context) => CartScreen(),
          OrderScreen.routeName: (context) => OrderScreen(),
          UserProductScreen.routeName: (context) => UserProductScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen(),
        },
      ),
    );
  }
}
