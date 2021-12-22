import 'package:flutter/material.dart';
import 'package:gulel/Providers/categoryItems.dart';
import 'package:gulel/Providers/products.dart';
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
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryy = routeArgs['id'];
    //final upperTitle = routeArgs['title'];
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<CategoryItems_Provider>(context)
          .fetchAndSetProducts(categoryy)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final availableProducts =
        Provider.of<CategoryItems_Provider>(context).items;
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryy = routeArgs['id'];
    final categoryName = routeArgs['categoryName'];

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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : availableProducts.length == 0
              ? Center(
                  child: Text('No Products Found!'),
                )
              : ListView.builder(
                  itemBuilder: (ctx, index) => EditProduct(
                    productKey: displayedProducts[index].id,
                    title: displayedProducts[index].title,
                    imageUrl: displayedProducts[index].imageUrl,
                    category1: displayedProducts[index].category1,
                  ),
                  itemCount: displayedProducts.length,
                ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed(
          '/add-product',
          arguments: {
            'categoryId': categoryy,
            'categoryName': categoryName,
          },
        ),
      ),
    );
  }
}
