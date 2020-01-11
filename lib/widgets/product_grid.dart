import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:provider/provider.dart';

import 'pruduct_item.dart';

class ProductGrid extends StatelessWidget {
  final showFavs;

  const ProductGrid({
    Key key,
    this.showFavs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = showFavs ? productData.favourites : productData.items;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: products[i],
          child: ProductItem(
//          products[i].id,
//              products[i].title,
//              products[i].imageUrl
              )),
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
    );
  }
}
