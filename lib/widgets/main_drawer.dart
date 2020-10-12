import 'package:flutter/material.dart';
import '../screens/orders_screen.dart';

class MainDrawer extends StatelessWidget {
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
          ListTile(
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
            leading: Icon(
              Icons.shop_outlined,
              size: 25,
            ),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 20),
            ),
          ),
          ListTile(
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrderScreen.routeName),
            leading: Icon(
              Icons.monetization_on_outlined,
              size: 25,
            ),
            title: Text(
              'My Orders',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
