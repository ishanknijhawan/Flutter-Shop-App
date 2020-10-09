import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_detail.dart';

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String id;
  final String title;
  final String description;

  ProductItem(this.id, this.imageUrl, this.description, this.title);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ProductDetail.routeName, arguments: id);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: GridTile(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black.withOpacity(0.54),
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            leading: Icon(Icons.favorite_border),
            trailing: Icon(Icons.shopping_cart_outlined),
          ),
        ),
      ),
    );
  }
}
