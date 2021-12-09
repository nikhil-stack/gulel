import 'package:flutter/material.dart';

class BottomNavigationBarClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).accentColor,
      selectedItemColor: Theme.of(context).accentColor,
      type: BottomNavigationBarType.shifting,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('home')),
        BottomNavigationBarItem(icon: Icon(Icons.money), title: Text('Orders')),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), title: Text('Cart')),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), title: Text("Settings"))
      ],
    ));
  }
}
