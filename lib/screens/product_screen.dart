//import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';

import '../widgets/badge.dart';
import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

enum menuItems {
  ONLY_FAVORITES,
  ALL,
}

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool isFavorite = false;
  var badgeCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.shopping_bag_outlined),
        title: Text('Shop App'),
        actions: [
          Consumer<Cart>(
            builder: (_, cartData, child) {
              return Badge(
                child: child,
                value: cartData.itemCount.toString(),
                color: Colors.red,
              );
            },
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
          ),
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: menuItems.ONLY_FAVORITES,
              ),
              PopupMenuItem(
                child: Text('Show all'),
                value: menuItems.ALL,
              )
            ],
            icon: Icon(Icons.more_vert),
            onSelected: (menuItems value) {
              setState(() {
                if (value == menuItems.ONLY_FAVORITES) {
                  isFavorite = true;
                } else {
                  isFavorite = false;
                }
              });
            },
          ),
        ],
      ),
      body: ProductsGrid(isFavorite),
    );
  }
}
