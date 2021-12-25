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
  String DeliveryStatus;
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
    this.DeliveryStatus,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _Order = [];
  List<OrderItem> get Order {
    return [..._Order];
  }

  Future<void> addItem(
    List<CartItem> cartProduct,
    double total,
    String PaymentStatus,
  ) async {
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

    final response = await http.post(
      url,
      body: json.encode(
        {
          'FullName': extractedData['FullName'],
          'GstNumber': extractedData['GstNumber'],
          'Organame': extractedData['Organame'],
          'amount': total,
          'address': extractedData['address'],
          'PinCode': extractedData['PinCode'],
          'MobileNumber': extractedData['MobileNumber'],
          'time': timestamp.toIso8601String(),
          'PaymentStatus': PaymentStatus,
          'DeliveryStatus': "Delivery in 10 working days!!",
          'Products': cartProduct
              .map(
                (cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'price': cp.price,
                  'quantity': cp.quantity,
                },
              )
              .toList(),
        },
      ),
    );

    List<String> ids = [];
    cartProduct.forEach((element) {
      ids.add(element.id);
    });

    final url1 = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/products.json',
    );
    final response1 = await http.get(url1);
    final respnseData1 = json.decode(response1.body) as Map<String, dynamic>;
    //print(respnseData1.values);
    respnseData1.values.forEach((element) {
      final element1 = element as Map<String, dynamic>;
      element1.keys.forEach((element2) {
        ids.forEach((element3) {
          if (element2 == element3) {
            final quantityOrdered = cartProduct
                .firstWhere((element4) => element4.id == element2)
                .quantity;
            final elementDetails = element1[element2];
            //print('category ' + category);
            final category = elementDetails['category1'];
            print('category ' + category.toString());
            print('product ' + element2);
            final url2 = Uri.parse(
              'https://gulel-ab427-default-rtdb.firebaseio.com/products/$category/$element2.json',
            );
            http.patch(
              url2,
              body: json.encode(
                {
                  'stock': int.tryParse(
                        elementDetails['stock'].toString(),
                      ) -
                      quantityOrdered,
                },
              ),
            );
          }
        });
      });
    });
    final orId = json.decode(response.body)['name'];
    final url2 = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/Orders/admin/$orId.json',
    );
    await http.put(
      url2,
      body: json.encode(
        {
          'FullName': extractedData['FullName'],
          'GstNumber': extractedData['GstNumber'],
          'Organame': extractedData['Organame'],
          'amount': total,
          'address': extractedData['address'],
          'PinCode': extractedData['PinCode'],
          'MobileNumber': extractedData['MobileNumber'],
          'time': timestamp.toIso8601String(),
          'PaymentStatus': PaymentStatus,
          'DeliveryStatus': "Delivery in 10 working days!!",
          'Products': cartProduct
              .map(
                (cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'price': cp.price,
                  'quantity': cp.quantity,
                },
              )
              .toList(),
          'userId': userId,
        },
      ),
    );
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
        DeliveryStatus: extractedData['DeliveryStatus'],
      ),
    );
    notifyListeners();
  }

  Future<void> getandset() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final List<OrderItem> loadedOrder = [];
    if (userId == 'admin') {
      final url = Uri.parse(
        'https://gulel-ab427-default-rtdb.firebaseio.com/Orders/admin.json',
      );
      final response = await http.get(url);

      final extracted_Data = json.decode(response.body) as Map<String, dynamic>;
      if (extracted_Data == null) {
        return;
      }
      extracted_Data.forEach(
        (OrderId, OrderData) {
          loadedOrder.add(
            OrderItem(
              Name: OrderData['FullName'],
              GSTNo: OrderData['GstNumber'],
              OrgName: OrderData['Organame'],
              Id: OrderId,
              address: OrderData['address'],
              Amount: OrderData['amount'],
              Pincode: OrderData['PinCode'],
              paymentStatus: OrderData['PaymentStatus'],
              MobileNumber: OrderData['MobileNumber'],
              DeliveryStatus: OrderData['DeliveryStatus'],
              Products: (OrderData['Products'] as List<dynamic>)
                  .map((items) => CartItem(
                        id: items['id'],
                        price: items['price'],
                        quantity: items['quantity'],
                        title: items['title'],
                      ))
                  .toList(),
              time1: DateTime.parse(
                OrderData['time'],
              ),
            ),
          );
        },
      );
    } else {
      final url = Uri.parse(
          'https://gulel-ab427-default-rtdb.firebaseio.com/Orders/$userId.json');
      final response = await http.get(url);

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
            DeliveryStatus: OrderData['DeliveryStatus'],
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
    }
    //print(json.decode(response.body));
    _Order = loadedOrder.reversed.toList();
    notifyListeners();
  }

  Future<void> UpdateDeliveryStatus(String Status, String OrderId) async {
    // print(OrderId);
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    // print(userId);
    var url;
    if (userId == 'admin') {
      url = Uri.parse(
        'https://gulel-ab427-default-rtdb.firebaseio.com/Orders/admin/$OrderId.json',
      );
      await http.patch(
        url,
        body: json.encode(
          {
            'DeliveryStatus': Status,
          },
        ),
      );
      final response = await http.get(url);
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      final uid = responseData['userId'];
      final url2 = Uri.parse(
        'https://gulel-ab427-default-rtdb.firebaseio.com/Orders/$uid/$OrderId.json',
      );
      await http.patch(
        url2,
        body: json.encode(
          {
            'DeliveryStatus': Status,
          },
        ),
      );
    } else {
      url = Uri.parse(
        'https://gulel-ab427-default-rtdb.firebaseio.com/Orders/$userId/$OrderId.json',
      );
      await http.patch(
        url,
        body: json.encode(
          {
            'DeliveryStatus': Status,
          },
        ),
      );
      final url2 = Uri.parse(
        'https://gulel-ab427-default-rtdb.firebaseio.com/Orders/admin/$OrderId.json',
      );
      await http.patch(
        url2,
        body: json.encode(
          {
            'DeliveryStatus': Status,
          },
        ),
      );
    }
    final order = _Order.firstWhere((element) => element.Id == OrderId);
    order.DeliveryStatus = Status;
    notifyListeners();
  }
}
