import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductsItem extends StatelessWidget {
  final String id;

  UserProductsItem({this.id});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    final product = products.findById(id);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.title),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName,
                    arguments: product.id);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {
                products.deleteById(id);
              },
            )
          ],
        ),
      ),
    );
  }
}
