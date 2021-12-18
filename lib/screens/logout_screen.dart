import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gulel/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutScreen extends StatefulWidget {
  //const LogoutScreen({ Key? key }) : super(key: key);
  static const routeName = '\Logout-Screen';
  @override
  _LogoutScreenState createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  Future<void> didChangeDependencies() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    FirebaseAuth.instance.signOut();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
