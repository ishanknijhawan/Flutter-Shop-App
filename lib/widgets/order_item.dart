import 'package:flutter/material.dart';
import '../providers/orders_provider.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class OrderItem extends StatefulWidget {
  final Order order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isExpanded = false;
  var container_height = 0.0;
  var color = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text('\$${widget.order.amount.toString()}'),
          subtitle: Text(
            DateFormat('dd MM yyyy hh:mm').format(widget.order.dateTime),
          ),
          trailing: IconButton(
            icon:
                _isExpanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
                container_height = _isExpanded
                    ? min(widget.order.products.length * 30.0 + 20, 200)
                    : 0;
              });
            },
          ),
        ),
        AnimatedContainer(
          padding: EdgeInsets.all(15),
          height: container_height,
          duration: Duration(milliseconds: 200),
          child: ListView(
            children: widget.order.products
                .map((e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('\$${e.price}x${e.quantity}'),
                      ],
                    ))
                .toList(),
          ),
        ),
      ]),
    );
  }
}
