//import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:shop_app/models/cart.dart';
import '../widgets/main_drawer.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';
import '../providers/products_provider.dart';
import 'cart_screen.dart';

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
  bool isInit = true;
  bool isLoading = true;

  @override
  void initState() {
    //you can only use like this iff you set listen as false
    //Provider.of<ProductsProvider>(context, listen: false).getProducts();

    //if you want to set listen to true, use the following method
    // Future.delayed(Duration.zero).then((value) {
    //   Provider.of<ProductsProvider>(context).getProducts();
    // });
    super.initState();
  }

  //or you can use like this
  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<ProductsProvider>(context).getProducts().then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      drawer: MainDrawer(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.shopping_bag_outlined),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
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
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(isFavorite),
    );
  }
}
