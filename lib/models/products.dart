import 'dart:convert';
import '../models/http_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;


  Products({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });




  Future<void> toggleFavoriteStatus() async {
    final url = 'https://flutter-recipe-93c67.firebaseio.com/product/$id.json';
    isFavorite = !isFavorite;
    notifyListeners();
    final response =
    await http.patch(Uri.parse(url), body: jsonEncode({'isFavorite': isFavorite}));
    if (response.statusCode >= 400) {
      isFavorite = !isFavorite;
      notifyListeners();

      throw HttpException('Error favoriting item!');
    }
  }
}