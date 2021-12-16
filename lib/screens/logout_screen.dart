import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gulel/screens/login_screen.dart';

class LogoutScreen extends StatefulWidget {
  //const LogoutScreen({ Key? key }) : super(key: key);
  static const routeName = '\Logout-Screen';
  @override
  _LogoutScreenState createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  void initState() {
    FirebaseAuth.instance.signOut();
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
