import 'package:flutter/material.dart';
import 'package:gulel/Providers/Cart_Provider.dart';
import 'package:gulel/Providers/categoryItems.dart';
import 'package:gulel/screens/Products_screen.dart';
import 'package:gulel/screens/add_category_screen.dart';
import 'package:gulel/screens/add_product_screen.dart';
import 'package:gulel/screens/cart_screen.dart';
import 'package:gulel/screens/edit_categories_screen.dart';
import 'package:gulel/screens/edit_products_screen.dart';
import 'package:gulel/screens/login_screen.dart';
import 'package:gulel/screens/product_detail_screen.dart';
import 'package:gulel/screens/tabs_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => CategoryItems_Provider()),
        ChangeNotifierProvider.value(value: Cart_Provider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gulel',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.blue.shade200,
        ),
        home: LoginScreen(), //TabsScreen(), //CategoriesScreen(),
        routes: {
          '/products-screen': (ctx) => ProductScreen(),
          '/product-details': (ctx) => ProductDetail(),
          '/add-category': (ctx) => AddCategoryScreen(),
          '/edit-category': (ctx) => EditCategoriesScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          '/edit-products': (ctx) => EditProductsScreen(),
          '/add-product': (ctx) => AddProductScreen(),
        },
      ),
    );
  }
}
