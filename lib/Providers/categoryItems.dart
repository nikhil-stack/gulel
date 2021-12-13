import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gulel/models/category.dart';
import 'package:gulel/models/products.dart';
import 'package:http/http.dart' as http;

class CategoryItems_Provider with ChangeNotifier {
  List<Category> _categories = [
    
  ];
  List<Product> _items = [
    Product(
        id: "it1",
        category1: "Almond",
        price: 800.0,
        imageUrl: "https://the.ismaili/sites/ismaili/files/5277.jpg",
        stockAvailable: 100,
        title: "Clifornian Non pareil"),
    Product(
        id: "it2",
        category1: "Almond",
        price: 700.0,
        imageUrl: "https://the.ismaili/sites/ismaili/files/5277.jpg",
        stockAvailable: 100,
        title: "Australian Almonds"),
    Product(
        id: "it3",
        category1: "Cashew",
        price: 700.0,
        imageUrl:
            "https://th.bing.com/th/id/OIP.O1DjnYjOjx_ef412DSfDSwHaEd?pid=ImgDet&rs=1",
        stockAvailable: 100,
        title: "Cashew K"),
    Product(
        id: "it4",
        category1: "Cashew",
        price: 750.0,
        imageUrl:
            "https://th.bing.com/th/id/OIP.O1DjnYjOjx_ef412DSfDSwHaEd?pid=ImgDet&rs=1",
        stockAvailable: 100,
        title: "Cashew LWP"),
  ];
  List<Category> get categories {
    return [..._categories];
  }

  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchAndSetCategories() async {
    var url = Uri.parse(
        'https://gulel-ab427-default-rtdb.firebaseio.com/categories.json');
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Category> loadedCategories = [];
    extractedData.forEach((catId, catData) {
      loadedCategories.add(
        Category(
          id: catId,
          imageUrl: catData['imageUrl'],
          title: catData['title'],
        ),
      );
    });
    _categories = loadedCategories;
    notifyListeners();
  }

  Future<void> addCategories(Category category) async {
    var url = Uri.parse(
        'https://gulel-ab427-default-rtdb.firebaseio.com/categories.json');
    final response = await http.post(
      url,
      body: json.encode(
        {
          'title': category.title,
          'imageUrl': category.imageUrl,
        },
      ),
    );
    final newCategory = Category(
      id: json.decode(response.body)['name'],
      title: category.title,
      imageUrl: category.imageUrl,
    );
    _categories.add(newCategory);
    notifyListeners();
  }
}
