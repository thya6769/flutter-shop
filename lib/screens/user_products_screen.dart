import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:flutter_complete_guide/widgets/user_products_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static final String routeName = "/user-products";

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Your products")),
      body: ListView.builder(
          itemCount: products.items.length,
          itemBuilder: (ctx, i) => UserProductsItem(
                title: products.items[i].title,
                imageUrl: products.items[i].imageUrl,
              )),
      drawer: AppDrawer(),
    );
  }
}
