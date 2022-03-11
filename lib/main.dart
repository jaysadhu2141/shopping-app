import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screen/products_overview_screen.dart';
import './screen/product_detail_screen.dart';
import './provider/product.dart';
import './provider/cart.dart';
import './screen/cart_screen.dart';
import './provider/orders.dart';
import './screen/order_screen.dart';
import './screen/user_product_screen.dart';
import './screen/edit_product_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider.value(value: Product(),
        ),

        ChangeNotifierProvider.value(value: Cart(),
        ),

          ChangeNotifierProvider.value(value: Orders(),
          ),

    ],
    child:MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          primaryColorLight: Colors.deepOrange,
),
      home: ProductsOverviewScreen(),
      routes: {
        ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        CartScreen.routeName: (ctx) => CartScreen(),
        OrdersScreen.routeName: (ctx) => OrdersScreen(),
        UserProductScreen.routeName: (ctx) => UserProductScreen(),
        EditProductScreen.routeName: (ctx) => EditProductScreen(),
      },
    ),
    );

  }
}

