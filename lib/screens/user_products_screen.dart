import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:flutter_complete_guide/widgets/user_products_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static final String routeName = "/user-products";

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your products"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: products.items.length,
        itemBuilder: (ctx, i) =>
            Column(children: <Widget>[
              UserProductsItem(
                id: products.items[i].id,
              ),
              Divider(),
            ]),
      ),
      drawer: AppDrawer(),
    );
  }
}
