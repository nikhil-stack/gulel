import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  String id;
  String title;
  String imageUrl;
  int quantity;
  double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.imageUrl,
      @required this.quantity,
      @required this.price});
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

  void addItem(String ProductID, String title, double Price, String imageUrl,
      int quantity) {
    if (_items.containsKey(ProductID)) {
      _items.update(
          ProductID,
          (exCartItem) => CartItem(
              id: exCartItem.id,
              imageUrl: exCartItem.imageUrl,
              price: exCartItem.price,
              title: exCartItem.title,
              quantity: exCartItem.quantity + quantity));
    } else {
      _items.putIfAbsent(
          ProductID,
          () => CartItem(
              id: DateTime.now().toString(),
              imageUrl: imageUrl,
              price: Price,
              quantity: quantity,
              title: title));
    }
    ;

    notifyListeners();
  }
}
