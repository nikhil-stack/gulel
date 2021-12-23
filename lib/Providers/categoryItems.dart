import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gulel/models/category.dart';
import 'package:gulel/Providers/products.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CategoryItems_Provider with ChangeNotifier {
  List<Category> _categories = [];
  List<Product> _items = [];
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
      'https://gulel-ab427-default-rtdb.firebaseio.com/categories.json',
    );
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

  Future<void> addProduct(Product product) async {
    final categoryId = product.category1;
    var url = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/products/$categoryId.json',
    );
    print(product.description);
    final response = await http.post(
      url,
      body: json.encode(
        {
          'title': product.title,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'stock': product.stockAvailable,
          'category1': product.category1,
          'description': product.description,
          'five': product.five,
          'ten': product.ten,
          'twenty': product.twenty,
          'thirty': product.thirty,
          'fifty': product.fifty,
          'seventyFive': product.seventyFive,
          'hundred': product.hundred,
        },
      ),
    );
    final newProduct = Product(
      id: json.decode(response.body)['name'],
      title: product.title,
      price: product.price,
      imageUrl: product.imageUrl,
      stockAvailable: product.stockAvailable,
      category1: product.category1,
      isFavourite: product.isFavourite,
      description: product.description,
      five: product.five,
      ten: product.ten,
      twenty: product.twenty,
      thirty: product.thirty,
      fifty: product.fifty,
      seventyFive: product.seventyFive,
      hundred: product.hundred,
    );
    _items.add(newProduct);
    notifyListeners();
  }

  Future<void> fetchAndSetProducts(String categoryId) async {
    var url = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/products/$categoryId.json',
    );

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    url = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/userFavouritesStatus/$userId.json',
    );
    final favouriteResponse = await http.get(url);
    final favoriteData = json.decode(favouriteResponse.body);
    final List<Product> loadedProducts = [];
    print(extractedData);
    if (extractedData != null) {
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
            title: prodData['title'],
            id: prodId,
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            stockAvailable: prodData['stock'],
            category1: prodData['category1'],
            isFavourite:
                favoriteData == null ? false : favoriteData[prodId] ?? false,
            description: prodData['description'],
            five: prodData['five'],
            ten: prodData['ten'],
            twenty: prodData['twenty'],
            thirty: prodData['thirty'],
            fifty: prodData['fifty'],
            seventyFive: prodData['seventyFive'],
            hundred: prodData['hundred'],
          ),
        );
      });
    }
    _items = loadedProducts;

    notifyListeners();
  }

  Future<void> fetAndSetFavouriteProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    var url = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/userFavourites/$userId.json',
    );
    final favouriteResponse = await http.get(url);
    final favoriteData = json.decode(favouriteResponse.body);
    url = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/products.json',
    );
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    print(favoriteData);
    print(extractedData);
    final Map<String, Map<String, dynamic>> loadedCategories = {};
    final List<Product> loadedProducts = [];
    /* extractedData.forEach(
      (catId, catData) => loadedCategories.putIfAbsent(catId,() =>
        Category(
          id: catId,
          title: catData['title'],
          imageUrl: catData['imageUrl'],
        ),
      ),
    );*/
    //print(loadedCategories);

    notifyListeners();
  }

  Product findById(String productId) {
    return _items.firstWhere((element) => element.id == productId);
  }

  Future<void> updateProduct(
    String id,
    Product newProduct,
  ) async {
    final categoryId = newProduct.category1;
    final prodIndex = _items.indexWhere((element) => element.id == id);
    print('INdex' + prodIndex.toString());
    print('categoryId ' + categoryId.toString());
    if (prodIndex >= 0) {
      final url = Uri.parse(
        'https://gulel-ab427-default-rtdb.firebaseio.com/products/$categoryId/$id.json',
      );
      await http.patch(
        url,
        body: json.encode(
          {
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
            'stock': newProduct.stockAvailable,
            'category1': newProduct.category1,
            'five': newProduct.five,
            'ten': newProduct.ten,
            'twenty': newProduct.twenty,
            'thirty': newProduct.thirty,
            'fifty': newProduct.fifty,
            'seventyFive': newProduct.seventyFive,
            'hundred': newProduct.hundred,
          },
        ),
      );
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }
}
