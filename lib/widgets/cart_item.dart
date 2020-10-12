import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/providers/products_provider.dart';

class CartItem extends StatelessWidget {
  final id;
  final quantity;
  final price;
  final title;
  final String productId;

  CartItem(this.id, this.quantity, this.title, this.price, this.productId);
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final product = Provider.of<ProductsProvider>(context);
    return Dismissible(
      onDismissed: (direction) => cart.deleteItem(id),
      direction: DismissDirection.startToEnd,
      key: ValueKey(id),
      background: Container(
          color: Colors.red,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            color: Theme.of(context).errorColor,
            child: Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 30,
            ),
          )),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 0,
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(product.getItem(productId).imageUrl),
          ),
          title: Text(title),
          subtitle: Text('\$${quantity * price}'),
          trailing: Text('${quantity}x'),
        ),
      ),
    );
  }
}
