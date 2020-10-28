import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import '../providers/orders_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future _ordersFuture;
  Future obtainOrders() {
    return Provider.of<OrderProvider>(context, listen: false).getOrders();
  }

  @override
  void initState() {
    _ordersFuture = obtainOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('building orders');
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('My orders'),
      ),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text('Error!'),
              );
            } else {
              return Consumer<OrderProvider>(
                builder: (context, order, child) => ListView.builder(
                  itemCount: order.items.length,
                  itemBuilder: (_, i) => OrderItem(
                    order.items[i],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
