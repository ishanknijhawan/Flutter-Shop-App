import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool isFavorite;

  ProductsGrid(this.isFavorite);
  @override
  Widget build(BuildContext context) {
    //important to give this <> to specify which class to look for
    final productList = Provider.of<ProductsProvider>(context);
    final products = isFavorite ? productList.showFavorites : productList.items;

    return products.length > 0
        ? GridView.builder(
            padding: EdgeInsets.all(10),
            itemCount: products.length,
            // you can also use ChangeNotifierProvider.value
            //that won't take any create/builder method
            itemBuilder: (context, i) => ChangeNotifierProvider.value(
              value: products[i],
              child: ProductItem(
                  // products[i].id,
                  // products[i].imageUrl,
                  // products[i].description,
                  // products[i].title,
                  ),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3 / 2,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
          )
        : Center(
            child: Text('You don\'t have any favorites'),
          );
  }
}
