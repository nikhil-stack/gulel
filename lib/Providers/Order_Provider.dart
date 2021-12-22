import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:gulel/Providers/Cart_Provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OrderItem {
  String Name;
  String GSTNo;
  String OrgName;
  String Id;
  double Amount;
  List<CartItem> Products;
  final DateTime time1;
  String address;
  String Pincode;
  String paymentStatus;
  String MobileNumber;
  OrderItem({
    this.Name,
    this.GSTNo,
    this.OrgName,
    this.Id,
    this.Amount,
    this.Products,
    this.time1,
    this.address,
    this.Pincode,
    this.paymentStatus,
    this.MobileNumber,
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
          'FullName': extractedData['FullName'],
          'GstNumber': extractedData['GstNumber'],
          'Organame': extractedData['Organame'],
          'amount': total,
          'address': extractedData['address'],
          'PinCode': extractedData['PinCode'],
          'MobileNumber': extractedData['MobileNumber'],
          'time': timestamp.toIso8601String(),
          'PaymentStatus': PaymentStatus,
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
          Name: extractedData['FullName'],
          GSTNo: extractedData['GstNumber'],
          OrgName: extractedData['Organame'],
          Id: json.decode(response.body)['name'],
          Amount: total,
          time1: timestamp,
          Products: cartProduct,
          address: extractedData['address'],
          Pincode: extractedData['PinCode'],
          paymentStatus: PaymentStatus,
          MobileNumber: extractedData['MobileNumber'],
        ));
    notifyListeners();
  }

  Future<void> getandset() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final url = Uri.parse(
        'https://gulel-ab427-default-rtdb.firebaseio.com/Orders/$userId.json');
    final response = await http.get(url);
    final List<OrderItem> loadedOrder = [];
    final extracted_Data = json.decode(response.body) as Map<String, dynamic>;
    if (extracted_Data == null) {
      return;
    }
    extracted_Data.forEach((OrderId, OrderData) {
      loadedOrder.add(OrderItem(
          Name: OrderData['FullName'],
          GSTNo: OrderData['GstNumber'],
          OrgName: OrderData['Organame'],
          Id: OrderId,
          address: OrderData['address'],
          Amount: OrderData['amount'],
          Pincode: OrderData['PinCode'],
          paymentStatus: OrderData['PaymentStatus'],
          MobileNumber: OrderData['MobileNumber'],
          Products: (OrderData['Products'] as List<dynamic>)
              .map((items) => CartItem(
                    id: items['id'],
                    price: items['price'],
                    quantity: items['quantity'],
                    title: items['title'],
                  ))
              .toList(),
          time1: DateTime.parse(OrderData['time'])));
    });
    print(json.decode(response.body));
    _Order = loadedOrder.reversed.toList();
    notifyListeners();
  }
}