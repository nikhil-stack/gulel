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
  double discount;

  CartItem({
    @required this.id,
    @required this.title,
    this.imageUrl,
    @required this.quantity,
    @required this.price,
    this.fireId,
    this.discount,
  });
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

  double get totalDiscount {
    var total = 0.0;
    _items.forEach((key, CartItem) {
      total += CartItem.discount;
    });
    return total;
  }

  double get DeliveryAmount {
    var DeliveryCharge = 0.0;
    _items.forEach((key, CartItem) {
      DeliveryCharge += 10 * CartItem.quantity;
    });
    return DeliveryCharge;
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
    print('idddddd ' + userId.toString());
    final url = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/cart/$userId.json',
    );
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final Map<String, CartItem> loadedCartItems = {};
    print('data     ' + extractedData.toString());
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
          discount: itemData['discount'],
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
          fireId: key,
          discount: value.discount,
        ),
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
    Map<String, double> discount,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    var discount1 = 0.0;
    if (_items.containsKey(ProductID)) {
      final fireId = _items[ProductID].fireId;
      final url = Uri.parse(
        'https://gulel-ab427-default-rtdb.firebaseio.com/cart/$userId/$fireId.json',
      );
      int newQuantity;
      _items.update(
        ProductID,
        (exCartItem) {
          newQuantity = exCartItem.quantity + quantity;

          if (newQuantity >= 5 && newQuantity < 10) {
            discount1 = discount['five'];
          } else if (newQuantity >= 10 && newQuantity < 20) {
            discount1 = discount['ten'];
          } else if (newQuantity >= 20 && newQuantity < 30) {
            discount1 = discount['twenty'];
          } else if (newQuantity >= 30 && newQuantity < 50) {
            discount1 = discount['thirty'];
          } else if (newQuantity >= 50 && newQuantity < 75) {
            discount1 = discount['fifty'];
          } else if (newQuantity >= 75 && newQuantity < 100) {
            discount1 = discount['seventyFive'];
          } else if (newQuantity >= 100) {
            discount1 = discount['hundred'];
          }
          print(discount1.toString() + '%%');
          print('Discount' +
              ((exCartItem.price * newQuantity * discount1) / 100).toString());
          return CartItem(
            id: exCartItem.id,
            imageUrl: exCartItem.imageUrl,
            price: exCartItem.price,
            title: exCartItem.title,
            quantity: quantity + exCartItem.quantity,
            fireId: exCartItem.fireId,
            discount: (exCartItem.price * newQuantity * discount1) / 100,
          );
        },
      );

      await http.patch(
        url,
        body: json.encode(
          {
            'title': title,
            'price': Price,
            'quantity': newQuantity,
            'imageUrl': imageUrl,
            'id': ProductID,
            'discount': (discount1 * newQuantity * Price) / 100,
          },
        ),
      );
    } else {
      final url = Uri.parse(
        'https://gulel-ab427-default-rtdb.firebaseio.com/cart/$userId.json',
      );
      if (quantity >= 5 && quantity < 10) {
        discount1 = discount['five'];
      } else if (quantity >= 10 && quantity < 20) {
        discount1 = discount['ten'];
      } else if (quantity >= 20 && quantity < 30) {
        discount1 = discount['twenty'];
      } else if (quantity >= 20 && quantity < 30) {
        discount1 = discount['twenty'];
      } else if (quantity >= 30 && quantity < 50) {
        discount1 = discount['thirty'];
      } else if (quantity >= 50 && quantity < 75) {
        discount1 = discount['fifty'];
      } else if (quantity >= 75 && quantity < 100) {
        discount1 = discount['seventyFive'];
      } else if (quantity >= 100) {
        discount1 = discount['hundred'];
      }
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': title,
            'price': Price,
            'quantity': quantity,
            'imageUrl': imageUrl,
            'id': ProductID,
            'discount': (Price * quantity * discount1) / 100,
          },
        ),
      );
      print('Doscount' + ((Price * quantity * discount1) / 100).toString());
      _items.putIfAbsent(
        ProductID,
        () => CartItem(
          id: ProductID,
          imageUrl: imageUrl,
          price: Price,
          quantity: quantity,
          title: title,
          fireId: json.decode(response.body)['name'],
          discount: (Price * quantity * discount1) / 100,
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

  String _productTitle;
  int _productQuantity;
  bool _validateKey;

  String get productTitle {
    return _productTitle;
  }

  int get productQuantity {
    return _productQuantity;
  }

  bool get validateKey {
    return _validateKey;
  }

  Future<void> validateCartProducts() async {
    _validateKey = true;
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    // print('idddddd ' + userId.toString());
    final url = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/cart/$userId.json',
    );
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final url2 = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/products.json',
    );
    final response2 = await http.get(url2);
    final responseData2 = json.decode(response2.body) as Map<String, dynamic>;
    final responseData3 = responseData2.values;
    extractedData.forEach((keycart, valuecart) async {
      final value = valuecart as Map<String, dynamic>;
      var productkey = value['id'];
      _productQuantity = value['quantity'];
      _productTitle = value['title'];
      print("KeyCart" + productkey.toString());

      responseData3.forEach((element) {
        var element2 = element as Map<String, dynamic>;
        element2.forEach((key, value) {
          var element3 = value as Map<String, dynamic>;
          print(key);
          if (key == productkey) {
            print("Your Stock:----" + element3['stock'].toString());
            print("Your Quantity is :---" + _productQuantity.toString());
            if (int.tryParse(element3['stock'].toString()) <
                int.tryParse(_productQuantity.toString())) {
              print('hereeeeeeeeee');
              _validateKey = false;
              notifyListeners();
              return;
            }
          }
        });
      });
      print("The 1st Loop!!------");
    });
    print('Keyyyyyyy' + validateKey.toString());
    notifyListeners();
  }
}
