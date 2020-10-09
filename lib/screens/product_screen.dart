import 'package:flutter/material.dart';
import '../widgets/product_item.dart';
import '../models/product.dart';
import '../models/product_list.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> productList = ProductList.productList;

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.shopping_bag_outlined),
        title: Text('Shop App'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: productList.length,
        itemBuilder: (context, i) => ProductItem(
          productList[i].id,
          productList[i].imageUrl,
          productList[i].description,
          productList[i].title,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3 / 2,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
      ),
    );
  }
}
