import 'package:flutter/material.dart';
import 'package:gulel/Providers/categoryItems.dart';
import 'package:gulel/models/products.dart';
import 'package:gulel/widgets/Product_item.dart';
import 'package:gulel/widgets/product_grid.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  /*final List<Product> availableProducts;
  ProductScreen(this.availableProducts);*/
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> displayedProducts;
  List<Product> availableProducts;

  @override
  Widget build(BuildContext context) {
    availableProducts = Provider.of<CategoryItems_Provider>(context).items;
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryy = routeArgs['id'];
    final upperTitle = routeArgs['title'];

    setState(() {
      /*displayedProducts = availableProducts.firstWhere((product) {
        print(categoryy);
        print(product.category1);
        return product.category1 == categoryy;
      });*/
      displayedProducts = availableProducts
          .where((element) => element.category1.contains(categoryy))
          .toList();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          upperTitle,
          textAlign: TextAlign.center,
        ),
      ),
      body: GridView.builder(
          itemCount: displayedProducts.length,
          itemBuilder: (context, index) => ProductItem(
                id: displayedProducts[index].id,
                name: displayedProducts[index].title,
                price: displayedProducts[index].price,
                quantity: displayedProducts[index].stockAvailable,
                imageUrl: displayedProducts[index].imageUrl,
                category: displayedProducts[index].category1,
              ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.9,
              mainAxisSpacing: 5,
              crossAxisSpacing: 3)),
    );
  }
}
