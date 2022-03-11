import 'package:flutter/material.dart';
import 'package:myshop/screen/cart_screen.dart';
import 'package:myshop/widget/app_drawer.dart';
import '../widget/products_grid.dart';
import '../widget/badge.dart';
import '../provider/cart.dart';
import 'package:provider/provider.dart';
import '../screen/cart_screen.dart';
import '../widget/app_drawer.dart';
import '../provider/product.dart';

enum FillterOption{
  Favorites,
  All,
}


class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState(){
    //Provider.of<Product>(context).fetchAndSetProducts();
    //Future.delayed(Duration.zero).then((_) {
     // Provider.of<Product>(context).fetchAndSetProducts();
   // });
    super.initState();
  }
  @override
  void didChangeDependencies() {
    if(_isInit){
      setState(() {
        _isLoading = true;
      });
      Provider.of<Product>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('MyShop'),
      actions: <Widget>[
        PopupMenuButton(
          onSelected: (FillterOption selectedValue){
            setState(() {
              if(selectedValue == FillterOption.Favorites){
                _showOnlyFavorites = true;
              }
              else
              {
                _showOnlyFavorites = false;
              }

            });

    },
          icon: Icon(Icons.more_vert,),
          itemBuilder: (_) => [
            PopupMenuItem(child: Text('Only Favorites'), value: FillterOption.Favorites),
            PopupMenuItem(child: Text('Show All'), value: FillterOption.All),
          ],
        ),
        Consumer<Cart>(
          builder: (_, cart, ch) => Badge(
            child: Center(child: ch),
            value: cart.ItemCount.toString(),
            color: Colors.deepOrange,
          ),
          child: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
              }
              ),)
      ],
    ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
