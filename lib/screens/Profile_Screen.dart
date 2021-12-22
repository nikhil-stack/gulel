import 'package:flutter/material.dart';
import 'package:gulel/screens/Help_Screen.dart';
//import 'package:gulel/screens/Edit_Profile.dart';
import 'package:gulel/screens/Orders_Screen.dart';
import 'package:gulel/screens/Edit_Profile.dart';
import 'package:gulel/screens/logout_screen.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.05)),
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text("Manage Profile"),
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(EditProfilePage.routeName);
            },
          ),
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.05)),
              child: ListTile(
                leading: Icon(Icons.money),
                title: Text("Orders"),
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(OrderScreen.routeName);
            },
          ),
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.05)),
              child: ListTile(
                leading: Icon(Icons.favorite_border),
                title: Text("Wishlist"),
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/wishlist');
            },
          ),
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.05)),
              child: ListTile(
                leading: Icon(Icons.help),
                title: Text("Help"),
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(HelpScreen.routeName);
            },
          ),
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.05)),
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(LogoutScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
