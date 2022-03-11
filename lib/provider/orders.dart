import 'dart:convert';

import 'package:flutter/foundation.dart';
import './cart.dart';
import 'package:http/http.dart'as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier{
  List<OrderItem> _orders = [];



  List<OrderItem> get orders{
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = 'https://flutter-recipe-93c67.firebaseio.com/order.json';
    final response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
  }


  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url = 'https://flutter-recipe-93c67.firebaseio.com/order.json';
    final timestamp = DateTime.now();
    final response = await http.post(Uri.parse(url), body: json.encode({
      'amount': total,
      'datetime': DateTime.now().toIso8601String(),
      'product': cartProducts.map((cp) => {
        'id': cp.id,
        'title': cp.title,
        'quantity': cp.quantity,
        'price': cp.price,

      }).toList(),

    }),);
    _orders.insert(0, OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now()),
    );
  notifyListeners();
  }



}
