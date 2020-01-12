import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem({this.id, this.title, this.price, this.quantity});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        child: Dismissible(
          onDismissed: (dir) {
            Provider.of<Cart>(context, listen: false).removeItem(id);
          },
          child: ListTile(
            leading: FittedBox(
              child: CircleAvatar(
                child: FittedBox(child: Text("\$$price")),
              ),
            ),
            title: Text(title),
            subtitle: Text("Total: \$${(price * quantity).toStringAsFixed(2)}"),
            trailing: Text("x $quantity"),
          ),
          key: ValueKey(id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Theme.of(context).errorColor,
            child: Icon(
              Icons.delete,
              size: 40,
              color: Colors.white,
            ),
            alignment: Alignment.centerRight,
          ),
        ),
        padding: EdgeInsets.all(8),
      ),
    );
  }
}
