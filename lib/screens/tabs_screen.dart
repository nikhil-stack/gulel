import 'package:flutter/material.dart';
import 'package:gulel/Providers/Cart_Provider.dart';
import 'package:gulel/screens/Orders_Screen.dart';
import 'package:gulel/screens/Profile_Screen.dart';
import 'package:gulel/screens/cart_screen.dart';
import 'package:gulel/screens/categories_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gulel/screens/logout_screen.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  //const TabsScreen({ Key? key }) : super(key: key);
  //final FirebaseUser user;
  //TabsScreen(this.user);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Widget> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      CategoriesScreen(),
      OrderScreen(),
      CartScreen(),
      Profile(),
    ];
    Provider.of<Cart_Provider>(context, listen: false).fetchAndSetCart();
    super.initState();
  }

  void _selectPage(int index) {
    setState(
      () {
        _selectedPageIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Gulel'),
        ),
        /*actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: Icon(Icons.shopping_cart))
        ],*/
      ),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.black,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
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
            icon: Icon(Icons.account_box),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
