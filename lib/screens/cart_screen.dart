import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';
import '../widgets/cart_item.dart' as ci;
import '../providers/orders_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '\cart_screen';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final order = Provider.of<OrderProvider>(context, listen: false);
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 5,
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.itemTotal.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlineButton(
                    onPressed: () async {
                      await order.addOrder(
                        cart.itemTotal,
                        cart.items.values.toList(),
                      );
                      cart.clear();
                    },
                    child: Text('Place Order'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (context, i) => ci.CartItem(
                cart.items.values.toList()[i].id,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].title,
                cart.items.values.toList()[i].price,
                cart.items.keys.toList()[i],
              ),
            ),
          )
        ],
      ),
    );
  }
}
