import 'package:flutter/material.dart';
import 'package:gulel/models/products.dart';

class CategoryItems_Provider with ChangeNotifier {
  List<Product> _items = [
    Product(
        id: "it1",
        category: "Almonds",
        price: 800.0,
        imageUrl: "https://the.ismaili/sites/ismaili/files/5277.jpg",
        stockAvailable: 100,
        title: "Clifornian Non pareil")
  ];
}
