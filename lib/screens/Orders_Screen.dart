import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '\Order_Screen';
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Orders_Screen"),
      ),
    );
  }
}
