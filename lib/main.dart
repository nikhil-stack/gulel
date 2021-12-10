import 'package:flutter/material.dart';
import 'package:gulel/Providers/categoryItems.dart';
import 'package:gulel/models/products.dart';
import 'package:gulel/screens/Products_screen.dart';
import 'package:gulel/screens/categories_screen.dart';
import 'package:gulel/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    /*List<Product> _availableProducts =
        Provider.of<CategoryItems_Provider>(context).items;*/
    return ChangeNotifierProvider.value(
      value: CategoryItems_Provider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gulel',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.blue.shade200,
        ),
        home: CategoriesScreen(), //CategoriesScreen(),
        routes: {
          '/products-screen': (ctx) => ProductScreen(),
          '/product-details': (ctx) => ProductDetail(),
        },
      ),
    );
  }
}
