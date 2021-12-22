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
      this.imageUrl,
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

  Future<void> deleteItem(String ProductId) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final fireId = _items[ProductId].fireId;
    final url = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/cart/$userId/$fireId.json',
    );
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      throw Exception("Couldn't delete product");
    }
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
    final Map<String, CartItem> loadedCartItems = {};
    //print(extractedData);
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((itemId, itemData) {
      loadedCartItems.putIfAbsent(itemId, () {
        print(itemId);
        return CartItem(
          id: itemData['id'],
          fireId: itemId,
          title: itemData['title'],
          imageUrl: itemData['imageUrl'],
          quantity: itemData['quantity'],
          price: itemData['price'],
        );
      });
    });
    loadedCartItems.forEach((key, value) {
      _items.putIfAbsent(
        value.id,
        () => CartItem(
            id: value.id,
            imageUrl: value.imageUrl,
            price: value.price,
            quantity: value.quantity,
            title: value.title,
            fireId: key),
      );
    });
    print(_items);
    notifyListeners();
  }

  Future<void> addItem(
    String ProductID,
    String title,
    double Price,
    String imageUrl,
    int quantity,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    if (_items.containsKey(ProductID)) {
      final fireId = _items[ProductID].fireId;
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

  void clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final url = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/cart/$userId.json',
    );
    await http.delete(url);
    _items = {};
    notifyListeners();
  }
}
