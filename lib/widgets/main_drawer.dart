import 'package:flutter/material.dart';
import 'package:shop_app/screens/user_product_screen.dart';
import '../screens/orders_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(
      BuildContext context, String routeName, IconData icon, String content) {
    return ListTile(
      onTap: () => Navigator.of(context).pushReplacementNamed(routeName),
      leading: Icon(
        icon,
        size: 25,
      ),
      title: Text(
        content,
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Text(
              'Hola!',
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.headline6.color,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          buildListTile(context, '/', Icons.shop_outlined, 'Home'),
          Divider(),
          buildListTile(context, OrderScreen.routeName,
              Icons.monetization_on_outlined, 'My Orders'),
          Divider(),
          buildListTile(context, UserProductScreen.routeName,
              Icons.edit_outlined, 'Manage Products'),
        ],
      ),
    );
  }
}
