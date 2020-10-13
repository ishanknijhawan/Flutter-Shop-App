import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import '../screens/product_detail.dart';

import 'package:provider/provider.dart';
import '../models/cart.dart';

class ProductItem extends StatelessWidget {
  // final String imageUrl;
  // final String id;
  // final String title;
  // final String description;

  // ProductItem(this.id, this.imageUrl, this.description, this.title);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetail.routeName, arguments: product.id);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: GridTile(
          child: Hero(
            tag: product.id,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black.withOpacity(0.54),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            //we have the set the above listener to false and
            //the consumer widget always listens.
            //So only the heart button is listening to changes
            leading: Consumer<Product>(
              builder: (context, product, child) {
                return IconButton(
                  icon: Icon(product.isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border),
                  onPressed: product.toggleFavorite,
                );
              },
            ),
            trailing: IconButton(
                icon: Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  cart.addItem(product.id, product.price, product.title);
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                      content: Row(
                        children: [
                          Icon(Icons.shopping_cart_outlined),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Item added to cart'),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
