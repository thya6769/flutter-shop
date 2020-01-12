import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/orders.dart' as ord;
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text(
                '\$${widget.order.amount}',
              ),
              subtitle: Text(
                  DateFormat('dd/MM/yyyy HH:mm').format(widget.order.dateTime)),
              trailing: IconButton(
                icon: Icon(Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ),
            if (_isExpanded)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                height: min(widget.order.items.length * 20.0 + 10, 100),
                child: ListView(
                    children: widget.order.items
                        .map((item) =>
                        Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                item.title,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${item.quantity}x \$${item.price}',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey),
                              )
                            ]))
                        .toList()),
              )
          ],
        ),
      ),
    );
  }
}
