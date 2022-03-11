
import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/http_exception.dart';
import '../models/products.dart';
import 'package:http/http.dart' as http;


class Product with ChangeNotifier {
  List<Products> _item = [
    //Products(
   //  id: 'p1',
  //  title: 'Red shirt',
  //  description: 'pretty shirt',
  //  price: 43.88,
  //  imageUrl: 'data:image/jpeg;base64,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',
    //),
  //  Products(
  //    id: 'p2',
  //    title: 'blue jeans',
  //    description: 'pretty jeans',
  //    price: 83.88,
  //    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNYGbaShqlZfl5HZ9Zs6DKtRRt_psUWYqheA&usqp=CAU',
    //  ),
  //  Products(
  //    id: 'p3',
  //    title: 'black tshirt',
  //    description: 'pretty tshirt',
  //    price: 23.88,
  //    imageUrl: 'data:image/jpeg;base64,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',
    //  ),
  //  Products(
  //    id: 'p4',
  //    title: 'track',
  //    description: 'pretty track',
  //    price: 63.88,
  //    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHFmHfQQmoIkC4xRCBO8NLPGQ3EfTU8kLp6g&usqp=CAU',
    //  ),
  ];

  // var _ShowFavoritesOnly = false;

  List<Products> get items {
    // if(_ShowFavoritesOnly)
    //   {
    //    return items.where((prodItem) => prodItem.isFavorite).toList();
    //   }
    return [..._item];
  }

  List<Products> get FavoriteItems {
    return _item.where((prodItem) => prodItem.isFavorite).toList();
  }

  Products findById(String id) {
    return _item.firstWhere((prod) => prod.id == id);
  }

  // void showFavoriteOnly(){
  //   _ShowFavoritesOnly = true;
  //   notifyListeners();
  // }
  //void showAll()
  //{
  //  _ShowFavoritesOnly = false;
  //  notifyListeners();
  //}
  Future<void> fetchAndSetProducts() async {
    const url = 'https://shopping-app-b582b-default-rtdb.firebaseio.com/product.json';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      final List<Products> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Products(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite: prodData['isFavourite'],
          imageUrl: prodData['imageUrl'],
        ));
      });
      _item = loadedProducts;
      notifyListeners();
    }
    catch(error){
      throw(error);
    }
  }

  Future<void> addProduct(Products products) async {
    const url = 'https://shopping-app-b582b-default-rtdb.firebaseio.com/product.json';
    try {
      final response = await http.post(Uri.parse(url), body: json.encode({
        'title': products.title,
        'description': products.description,
        'imageUrl': products.imageUrl,
        'price': products.price,
        'isFavourite': products.isFavorite,
      }),);
      final newProduct = Products(
          id: json.decode(response.body)['name'],
          title: products.title,
          description: products.description,
          price: products.price,
          imageUrl: products.imageUrl
      );
      _item.add(newProduct);

      notifyListeners();
    }catch (error) {
      print(error);
      throw error;
    }



  }

  Future<void> updateProduct(String id, Products newProduct) async
  {
    final prodIndex = _item.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0){
      final url = 'https://shopping-app-b582b-default-rtdb.firebaseio.com/product/$id.json';
      await http.patch(Uri.parse(url), body: json.encode({
        'title': newProduct.title,
        'description': newProduct.description,
        'imageUrl': newProduct.imageUrl,
        'price': newProduct.price,


      }),);

      _item[prodIndex] = newProduct;
      notifyListeners();
    }
    else{
      print('...');
    }
  }

  Future <void> deleteProduct(String id) async{
    final url = 'https://shopping-app-b582b-default-rtdb.firebaseio.com/product/$id.json';
    final existingProductIndex = _item.indexWhere((prod) => prod.id == id);
    var existingProduct = _item[existingProductIndex];
    _item.removeAt(existingProductIndex);
    notifyListeners();


    final response = await http.delete(Uri.parse(url));
      if (response.statusCode >= 400) {
        _item.insert(existingProductIndex, existingProduct);
        notifyListeners();
        throw HttpException('Could not delete product.');
      }



      existingProduct = 'NUll' as Products;

  }

}