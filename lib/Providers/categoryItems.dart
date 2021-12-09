import 'package:flutter/material.dart';
import 'package:gulel/models/category.dart';
import 'package:gulel/models/products.dart';

class CategoryItems_Provider with ChangeNotifier {
  List<Category> _categories = [
    Category(
      id: '1',
      title: 'Cardamom',
      imageUrl:
          'https://images.pexels.com/photos/3040873/pexels-photo-3040873.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    ),
    Category(
        id: '2',
        title: 'Black pepper',
        imageUrl:
            'https://images.pexels.com/photos/5741507/pexels-photo-5741507.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
    Category(
        id: '3',
        title: 'Almond',
        imageUrl:
            'https://images.pexels.com/photos/57042/pexels-photo-57042.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
    Category(
        id: '4',
        title: 'Cashew',
        imageUrl:
            'https://images.pexels.com/photos/4663476/pexels-photo-4663476.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
  ];
  List<Product> _items = [
    Product(
        id: "it1",
        category: "Almond",
        price: 800.0,
        imageUrl: "https://the.ismaili/sites/ismaili/files/5277.jpg",
        stockAvailable: 100,
        title: "Clifornian Non pareil"),
    Product(
        id: "it2",
        category: "Almond",
        price: 700.0,
        imageUrl: "https://the.ismaili/sites/ismaili/files/5277.jpg",
        stockAvailable: 100,
        title: "Australian Almonds"),
    Product(
        id: "it3",
        category: "Cashew",
        price: 700.0,
        imageUrl:
            "https://th.bing.com/th/id/OIP.O1DjnYjOjx_ef412DSfDSwHaEd?pid=ImgDet&rs=1",
        stockAvailable: 100,
        title: "Cashew K"),
    Product(
        id: "it4",
        category: "Cashew",
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
}
