import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartItem {
  String id;
  String title;
  String imageUrl;
  int quantity;
  double price;
  String fireId;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.imageUrl,
      @required this.quantity,
      @required this.price,
      this.fireId});
}

class Cart_Provider with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

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

  Future<void> fetchAndSetCart() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final url = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/cart/$userId.json',
    );
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final Map<String, dynamic> loadedCartItems = {};
    print(extractedData);
    extractedData.forEach((itemId, itemData) {
      loadedCartItems.putIfAbsent(
          itemId,
          () => CartItem(
              id: itemData['id'],
              fireId: itemId,
              title: itemData['title'],
              imageUrl: itemData['imageUrl'],
              quantity: itemData['quantity'],
              price: itemData['price']));
    });
    _items = loadedCartItems;
    notifyListeners();
  }

  Future<void> addItem(
    String ProductID,
    String title,
    double Price,
    String imageUrl,
    int quantity,
    String fireId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    if (_items.containsKey(ProductID)) {
      print(fireId);
      final url = Uri.parse(
        'https://gulel-ab427-default-rtdb.firebaseio.com/cart/$userId/$fireId.json',
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
            fireId: exCartItem.fireId,
          );
        },
      );
      await http.patch(url,
          body: json.encode({
            'title': title,
            'price': Price,
            'quantity': newQuantity,
            'imageUrl': imageUrl,
            'id': ProductID,
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
            'id': ProductID,
          },
        ),
      );
      _items.putIfAbsent(
        ProductID,
        () => CartItem(
          id: ProductID,
          imageUrl: imageUrl,
          price: Price,
          quantity: quantity,
          title: title,
          fireId: json.decode(response.body)['name'],
        ),
      );
    }
    print(_items);

    notifyListeners();
  }
}
