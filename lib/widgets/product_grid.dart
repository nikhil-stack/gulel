import 'package:flutter/material.dart';
import 'package:gulel/widgets/Product_item.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 3,
        itemBuilder: (context, index) => ProductItem(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            mainAxisSpacing: 5,
            crossAxisSpacing: 3));
  }
}
