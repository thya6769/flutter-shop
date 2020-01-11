import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/screens/product_detail.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
//  final String id;
//  final String title;
//  final String imageUrl;

//  ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    // if not listen then set listen to false
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return GridTile(
      child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProductDetailScreen.routeName,
                arguments: product.id);
//            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ProductDetailScreen()));
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.fill,
          )),
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        leading: Consumer<Product>(
          builder: (ctx, product, child) => IconButton(
            icon: Icon(
                product.isFavourite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).accentColor),
            color: Colors.white,
            onPressed: () => product.fav(),
          ),
        ),
        title: Text(product.title),
        trailing: IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            cart.addItem(product.id, product.title, product.price);
          },
        ),
      ),
    );
  }
}
