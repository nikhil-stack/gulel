import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:gulel/Providers/Cart_Provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OrderItem {
  String Id;
  double Amount;
  List<CartItem> Products;
  final DateTime time1;
  String address;
  String paymentStatus;

  OrderItem({
    this.Id,
    this.Amount,
    this.Products,
    this.time1,
    this.address,
    this.paymentStatus,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _Order = [];
  List<OrderItem> get Order {
    return [..._Order];
  }

  Future<void> addItem(
      List<CartItem> cartProduct, double total, String PaymentStatus) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final prefs1 = await SharedPreferences.getInstance();
    final userIdtoken = prefs1.getString('userIdtoken');
    var urluser = Uri.parse(
        'https://gulel-ab427-default-rtdb.firebaseio.com/users/$userId/$userIdtoken.json');
    final responseuser = await http.get(urluser);
    var extractedData = json.decode(responseuser.body) as Map<String, dynamic>;
    final url = Uri.parse(
        'https://gulel-ab427-default-rtdb.firebaseio.com/Orders/$userId.json');
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'address': extractedData['address'],
          'time': timestamp.toIso8601String(),
          'Products': cartProduct
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'price': cp.price,
                    'quantity': cp.quantity,
                  })
              .toList(),
        }));
    _Order.insert(
        0,
        OrderItem(
          Id: json.decode(response.body)['name'],
          Amount: total,
          time1: timestamp,
          Products: cartProduct,
          address: extractedData['address'],
          paymentStatus: PaymentStatus,
        ));
    notifyListeners();
  }
}
