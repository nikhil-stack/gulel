import 'package:flutter/material.dart';
import 'package:gulel/widgets/Bottom_navigation.dart';
import 'package:gulel/widgets/product_grid.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gulel',
          textAlign: TextAlign.center,
        ),
      ),
      body: ProductGrid(),
      bottomNavigationBar: BottomNavigationBarClass(),
    );
  }
}
