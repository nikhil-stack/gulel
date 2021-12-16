import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CartItem {
  String id;
  String title;
  String imageUrl;
  int quantity;
  double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.quantity,
    @required this.price,
  });
}

class Cart_Provider with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  final String userId;
  Cart_Provider(this.userId, this._items);

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, CartItem) {
      total += CartItem.price * CartItem.quantity;
    });
    return total;
  }

  void deleteItem(String ProductId) {
    _items.remove(ProductId);
    notifyListeners();
  }

  Future<void> addItem(String ProductID, String title, double Price,
      String imageUrl, int quantity) async {
    if (_items.containsKey(ProductID)) {
      final url = Uri.parse(
        'https://gulel-ab427-default-rtdb.firebaseio.com/cart/$userId/$ProductID.json',
      );
      int newQuantity;

      _items.update(
        ProductID,
        (exCartItem) {
          newQuantity = exCartItem.quantity + quantity;
          return CartItem(
            id: exCartItem.id,
            imageUrl: exCartItem.imageUrl,
            price: exCartItem.price,
            title: exCartItem.title,
            quantity: quantity + exCartItem.quantity,
          );
        },
      );
      await http.patch(url,
          body: json.encode({
            'title': title,
            'price': Price,
            'quantity': newQuantity,
            'imageUrl': imageUrl,
          }));
    } else {
      final url = Uri.parse(
        'https://gulel-ab427-default-rtdb.firebaseio.com/cart/$userId.json',
      );
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': title,
            'price': Price,
            'quantity': quantity,
            'imageUrl': imageUrl,
          },
        ),
      );
      print(json.decode(response.body)['name']);
      _items.putIfAbsent(
        ProductID,
        () => CartItem(
          id: json.decode(response.body)['name'],
          imageUrl: imageUrl,
          price: Price,
          quantity: quantity,
          title: title,
        ),
      );
    }

    notifyListeners();
  }
}
