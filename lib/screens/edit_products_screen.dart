import 'package:flutter/material.dart';
import 'package:gulel/Providers/categoryItems.dart';
import 'package:gulel/models/products.dart';
import 'package:gulel/widgets/edit_product.dart';
import 'package:provider/provider.dart';

class EditProductsScreen extends StatefulWidget {
  //const EditProductsScreen({ Key? key }) : super(key: key);

  @override
  _EditProductsScreenState createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  List<Product> displayedProducts;
  List<Product> availableProducts;
  @override
  Widget build(BuildContext context) {
    final availableProducts =
        Provider.of<CategoryItems_Provider>(context).items;
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryy = routeArgs['id'];

    setState(() {
      displayedProducts = availableProducts
          .where(
            (element) => element.category1.contains(categoryy),
          )
          .toList();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) => EditProduct(
          productKey: displayedProducts[index].id,
          title: displayedProducts[index].title,
          imageUrl: displayedProducts[index].imageUrl,
        ),
        itemCount: displayedProducts.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed('/add-product'),
      ),
    );
  }
}
