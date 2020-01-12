import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/orders.dart' as ord;
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text(
                '${order.amount}',
              ),
              subtitle:
                  Text(DateFormat('dd/MM/yyyy HH:mm').format(order.dateTime)),
              trailing: IconButton(
                icon: Icon(Icons.expand_more),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
