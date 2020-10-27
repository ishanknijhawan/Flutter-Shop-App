import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/edit_product_screen.dart';

import '../widgets/main_drawer.dart';
import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/UserProductScreen';

  Future<void> _rebuild(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('User Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _rebuild(context),
        child: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (_, i) {
            return UserProductItem(
              productData.items[i].id,
              productData.items[i].title,
              productData.items[i].imageUrl,
            );
          },
        ),
      ),
    );
  }
}
