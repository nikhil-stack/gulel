import 'package:flutter/material.dart';
import 'package:gulel/screens/Products_screen.dart';
import 'package:gulel/screens/categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gulel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blue.shade200,
      ),
      home: CategoriesScreen(),
<<<<<<< HEAD
=======
      routes: {
        '/products-screen': (ctx) => ProductScreen(),
      },
>>>>>>> eb61102c4a8aa8478992bb22f0ae7441f2e75098
    );
  }
}
