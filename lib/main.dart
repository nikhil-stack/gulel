import 'package:flutter/material.dart';
import 'package:gulel/ClientPart/ClientLogin.dart';
import 'package:gulel/ClientPart/Providers/Client_Auth_Provider.dart';
import 'package:gulel/Providers/Auth_Provider.dart';
import 'package:gulel/Providers/Cart_Provider.dart';
import 'package:gulel/Providers/Order_Provider.dart';
import 'package:gulel/Providers/categoryItems.dart';
import 'package:gulel/Providers/products.dart';
import 'package:gulel/Providers/user_Provider.dart';
import 'package:gulel/screens/Help_Screen.dart';
//import 'package:gulel/screens/Edit_Profile.dart';
import 'package:gulel/screens/Orders_Screen.dart';
import 'package:gulel/screens/Products_screen.dart';
import 'package:gulel/screens/add_category_screen.dart';
import 'package:gulel/screens/add_product_screen.dart';
import 'package:gulel/screens/cart_screen.dart';
import 'package:gulel/screens/Edit_Profile.dart';
import 'package:gulel/screens/edit_categories_screen.dart';
import 'package:gulel/screens/edit_products_screen.dart';
import 'package:gulel/screens/login_screen.dart';
import 'package:gulel/screens/logout_screen.dart';
import 'package:gulel/screens/product_detail_screen.dart';
import 'package:gulel/screens/signup_screen.dart';
import 'package:gulel/screens/tabs_screen.dart';
import 'package:gulel/screens/wishlist_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => CategoryItems_Provider()),
        /*ChangeNotifierProvider.value(
          value: Cart_Provider(),
        ),*/
        ChangeNotifierProvider.value(
          value: Auth_Provider(),
        ),
        ChangeNotifierProvider.value(
          value: user_provider(),
        ),
        ChangeNotifierProvider.value(
          value: Cart_Provider(),
        ),
        ChangeNotifierProvider.value(
          value: Product(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gulel',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.orangeAccent,
          cardColor: Colors.black,
        ),
        //home: LoginScreen(),
        //TabsScreen(), //CategoriesScreen(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              print("SnapShotEmail" + snapshot.data.toString());
              return TabsScreen();
            }
            return LoginScreen();
          },
        ),
        routes: {
          '/tabs-screen': (ctx) => TabsScreen(),
          '/products-screen': (ctx) => ProductScreen(),
          '/product-details': (ctx) => ProductDetail(),
          '/add-category': (ctx) => AddCategoryScreen(),
          '/edit-category': (ctx) => EditCategoriesScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          '/edit-products': (ctx) => EditProductsScreen(),
          '/add-product': (ctx) => AddProductScreen(),
          SignUp.routeName: (ctx) => SignUp(),
          LogoutScreen.routeName: (ctx) => LogoutScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          EditProfilePage.routeName: (ctx) => EditProfilePage(),
          '/wishlist': (ctx) => WishlistScreen(),
          HelpScreen.routeName: (ctx) => HelpScreen(),
          ClientAuthScreen.routeName: (ctx) => ClientAuthScreen(),
        },
      ),
    );
  }
}
