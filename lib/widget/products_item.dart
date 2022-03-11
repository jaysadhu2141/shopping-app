import 'package:flutter/material.dart';
import 'package:myshop/models/products.dart';
import 'package:provider/provider.dart';
import '../screen/product_detail_screen.dart';
import '../provider/cart.dart';



class ProductsItem extends StatelessWidget {
  //final String id;
  //final String title;
  //final String imageUrl;

  //ProductsItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context);
    final cart = Provider.of<Cart>(context, listen: false,);
    return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                      ProductDetailScreen.routeName,
                      arguments: product.id,
                  );
                  },
      child: Image.network(product.imageUrl, fit: BoxFit.cover,
      ),
            ),
    footer: GridTileBar(
      backgroundColor: Colors.black87,
      leading: IconButton(
        icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
        color: Theme.of(context).accentColor,
        onPressed: () {
          product.toggleFavoriteStatus();
        },
      ),
      title: Text(product.title,
      textAlign: TextAlign.center,),
      trailing: IconButton(
        icon: Icon(
          Icons.shopping_cart,
        ),
        onPressed: (){
          cart.addItem(product.id, product.title, product.price);
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('added item to cart'),
          duration: Duration(seconds: 2),
          action: SnackBarAction(label: 'undo',onPressed: () {
            cart.removeSingleItemQuantity(product.id);
          },),
          ));
        },
        color: Theme.of(context).accentColor,
      ),
    ),
    ),
    );
  }
}
