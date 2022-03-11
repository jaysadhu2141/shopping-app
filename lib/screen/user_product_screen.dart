import 'package:flutter/material.dart';
import 'package:myshop/screen/edit_product_screen.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';
import '../widget/user_product_item.dart';
import '../provider/product.dart' show Product;
import '../widget/app_drawer.dart';
import '../screen/edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-product';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Product>(context, listen: false).fetchAndSetProducts();
  }
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product>(context);
    return Scaffold(
        appBar: AppBar(
        title: const Text('Your Products'),
    actions: <Widget>[
    IconButton(
      icon: Icon(Icons.add),
    onPressed: () {
      Navigator.of(context).pushReplacementNamed(EditProductScreen.routeName);
    },

    ),
    ],
    ),
    drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: ListView.builder( shrinkWrap: true, itemCount: productData.items.length, itemBuilder: (_, i) => UserProductItem(
        productData.items[i].id,
        productData.items[i].title,
        productData.items[i].imageUrl,),
          ),
      ),
    );
  }
}