import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  String id;
  String title;
  String imageUrl;
  int stockAvailable;
  String category1;
  String fireId;
  bool isFavourite;
  String favoriteId;
  String description;
  double five;
  double ten;
  double twenty;
  double thirty;
  double fifty;
  double seventyFive;
  double hundred;
  double delhiPrice;
  double hyderabadPrice;
  double varanasiPrice;
  double bikanerPrice;
  double kolkataPrice;
  Product({
    this.id,
    this.title,
    this.imageUrl,
    this.stockAvailable,
    this.category1,
    this.fireId,
    this.isFavourite = false,
    this.favoriteId,
    this.description,
    this.ten = 0,
    this.five = 0,
    this.twenty = 0,
    this.thirty = 0,
    this.fifty = 0,
    this.seventyFive = 0,
    this.hundred = 0,
    this.delhiPrice = 0,
    this.bikanerPrice = 0,
    this.hyderabadPrice = 0,
    this.kolkataPrice = 0,
    this.varanasiPrice = 0,
  });

  List<Product> _items = [];
  List<Product> get items {
    return [..._items];
  }

  Future<void> toggleFavourites(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    isFavourite = !isFavourite;
    final productId = product.id;
    notifyListeners();
    final url2 = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/userFavouritesStatus/$userId/$productId.json',
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
    if (responseData == null) {
      return;
    }
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
                  imageUrl: data[key]['imageUrl'],
                  stockAvailable: data[key]['stockAvailable'],
                  category1: data[key]['category1'],
                  isFavourite: true,
                  five: data[key]['five'],
                  ten: data[key]['ten'],
                  twenty: data[key]['twenty'],
                  thirty: data[key]['thirty'],
                  fifty: data[key]['fifty'],
                  seventyFive: data[key]['seventyFive'],
                  hundred: data[key]['hundred'],
                  delhiPrice: data[key]['DelhiNCR'],
                  hyderabadPrice: data[key]['Hyderabad'],
                  varanasiPrice: data[key]['Varanasi'],
                  kolkataPrice: data[key]['Kolkata'],
                  bikanerPrice: data[key]['Bikaner'],
                  
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
