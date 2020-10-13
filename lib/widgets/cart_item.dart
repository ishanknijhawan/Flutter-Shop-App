import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/providers/products_provider.dart';

class CartItem extends StatelessWidget {
  final id;
  final int quantity;
  final double price;
  final title;
  final String productId;

  CartItem(this.id, this.quantity, this.title, this.price, this.productId);
  @override
  Widget build(BuildContext context) {
    final double totalQ = quantity * price;
    final cart = Provider.of<Cart>(context);
    final product = Provider.of<ProductsProvider>(context);
    return Dismissible(
      onDismissed: (direction) {
        cart.deleteItem(id);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Delete dish'),
                content: Text('Do you want to delete this dish temporarily ?'),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(false);
                    },
                    child: Text('No'),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(true);
                      cart.deleteItem(id);
                    },
                    child: Text('Yes'),
                  ),
                ],
              );
            },
            barrierDismissible: false);
      },
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
        ),
      ),
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
          subtitle: Text('\$${totalQ.toStringAsFixed(2)}'),
          trailing: Text('${quantity}x'),
        ),
      ),
    );
  }
}
