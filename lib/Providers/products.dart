import 'dart:convert';
import 'dart:ffi';

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
  String favoriteId;
  String description;
  Product({
    this.id,
    this.title,
    this.price,
    this.imageUrl,
    this.stockAvailable,
    this.category1,
    this.fireId,
    this.isFavourite = false,
    this.favoriteId,
    this.description
  });

  List<Product> _items = [];
  List<Product> get items {
    return [..._items];
  }

  Future<void> toggleFavourites(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    isFavourite = !isFavourite;
    notifyListeners();
    final url2 = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/userFavouritesStatus/$userId/$id.json',
    );
    await http.put(url2, body: json.encode(isFavourite));
    notifyListeners();
  }

  Future<void> fetchAndSetWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final url = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/userFavouritesStatus/$userId.json',
    );
    final response = await http.get(url);
    final responseData = json.decode(response.body) as Map<String, dynamic>;
    final url2 = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/products.json',
    );
    final response2 = await http.get(url2);
    final responseData2 = json.decode(response2.body) as Map<String, dynamic>;
    final responseData3 = responseData2.values;
    final List<Product> loadedProducts = [];
    responseData.forEach((key, value) {
      //print(value);
      if (value.toString().contains('true')) {
        //print('Hereeeeeeeee');
        responseData3.forEach((prodId) {
          final data = prodId as Map<String, dynamic>;
          //print(data.values);
          data.keys.forEach((element) {
            if (element == key) {
              print(data[key]['imageUrl']);
              loadedProducts.add(
                Product(
                  title: data[key]['title'],
                  id: key,
                  price: data[key]['price'],
                  imageUrl: data[key]['imageUrl'],
                  stockAvailable: data[key]['stockAvailable'],
                  category1: data[key]['category1'],
                  isFavourite: true,
                ),
              );
            }
          });
        });
      }
    });
    _items = loadedProducts;
    notifyListeners();
  }
}
