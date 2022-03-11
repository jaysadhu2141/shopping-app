import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';
import './products_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData =Provider.of<Product>(context, listen: false);
    final product = showFavs ? productsData.FavoriteItems : productsData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: product.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: product[i],
          child:ProductsItem(
          //product[i].id,
          //product[i].title,
          //product[i].imageUrl,
        ),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      );
  }
}