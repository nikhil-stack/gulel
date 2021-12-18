import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  String id;
  String title;
  double price;
  String imageUrl;
  int stockAvailable;
  String category1;
  String fireId;
  bool isFavourite;
  Product({
    this.id,
    this.title,
    this.price,
    this.imageUrl,
    this.stockAvailable,
    this.category1,
    this.fireId,
    this.isFavourite = false,
  });

  Future<void> toggleFavouriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/userFavourites/$userId/$id.json',
    );
    try {
      final response = await http.put(url, body: json.encode(isFavourite));
      if (response.statusCode >= 400) {
        isFavourite = oldStatus;
        notifyListeners();
      }
    } catch (e) {
      isFavourite = oldStatus;
      notifyListeners();
    }
  }
}
