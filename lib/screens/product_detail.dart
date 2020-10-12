import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetail extends StatelessWidget {
  static const routeName = '/product_detail_screen';

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context).settings.arguments as String;
    //do not listen for data here
    final product = Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).getItem(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Column(
        children: [
          Container(
            height: 350,
            width: double.infinity,
            child: Hero(
              tag: product.id,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            margin: EdgeInsets.all(15),
            child: Text(
              product.description,
              style: TextStyle(
                fontFamily: 'Anton',
                fontSize: 20,
              ),
            ),
          ),
          Text(
            '\$${product.price}',
            style: TextStyle(fontSize: 25),
          ),
        ],
      ),
    );
  }
}
