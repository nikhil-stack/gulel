import 'package:flutter/material.dart';
import 'package:gulel/models/products.dart';
import 'package:gulel/widgets/Bottom_navigation.dart';
import 'package:gulel/widgets/product_grid.dart';

class ProductScreen extends StatefulWidget {
  final List<Product> availableProducts;
  ProductScreen(this.availableProducts);
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> displayedProducts;
  @override
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryy = routeArgs['title'];
    displayedProducts = widget.availableProducts
        .where((product) => product.category.contains(categoryy));
    super.didChangeDependencies();
  }

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
