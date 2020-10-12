import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import '../providers/orders_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrderProvider>(context);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('My orders'),
      ),
      body: ListView.builder(
        itemCount: orderData.items.length,
        itemBuilder: (_, i) => OrderItem(
          orderData.items[i],
        ),
      ),
    );
  }
}
