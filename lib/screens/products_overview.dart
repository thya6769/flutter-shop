import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:flutter_complete_guide/widgets/badge.dart';
import 'package:flutter_complete_guide/widgets/product_grid.dart';
import 'package:provider/provider.dart';

enum MenuOptions { Favourite, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          Consumer<Products>(
            builder: (ctx, products, child) => PopupMenuButton(
              onSelected: (MenuOptions option) {
                // setState is required for the changes to propagate
                setState(() {
                  if (option == MenuOptions.Favourite) {
                    _showFavOnly = true;
                  } else {
                    _showFavOnly = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                    value: MenuOptions.Favourite, child: Text('Favourite')),
                PopupMenuItem(value: MenuOptions.All, child: Text('All')),
              ],
            ),
          ),
          Consumer<Cart>(
            builder: (ctx, cart, child) => Badge(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.routeName);
                },
              ),
              value: cart.numberOfItems.toString(),
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductGrid(
        showFavs: _showFavOnly,
      ),
    );
  }
}
