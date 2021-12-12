import 'package:flutter/material.dart';
import 'package:gulel/screens/Orders_Screen.dart';
import 'package:gulel/screens/cart_screen.dart';
import 'package:gulel/screens/categories_screen.dart';

class BottomNavigationBarClass extends StatefulWidget {
  @override
  State<BottomNavigationBarClass> createState() =>
      _BottomNavigationBarClassState();
}

class _BottomNavigationBarClassState extends State<BottomNavigationBarClass> {
  List<Map<String, Object>> Pages;
  int selectedPageIndex = 0;
  @override
  void initState() {
    Pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': OrderScreen(), 'title': 'Your Orders'},
      {'page': CartScreen(), 'title': "Your Cart"}
    ];
    super.initState();
  }

  void selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return //Scaffold(
        //appBar: AppBar(
        //title: Text("Gulel"),
        //),
        //  body: Pages[selectedPageIndex]['page'] as Widget,
        // bottomNavigationBar:
        BottomNavigationBar(
      onTap: selectPage,
      backgroundColor: Theme.of(context).primaryColor,
      currentIndex: selectedPageIndex,
      unselectedItemColor: Theme.of(context).accentColor,
      selectedItemColor: Theme.of(context).primaryColor,
      type: BottomNavigationBarType.shifting,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.money),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings",
        ),
      ],
    );
    //  );
  }
}
