import 'package:flutter/material.dart';
import 'package:gulel/Providers/categoryItems.dart';
import 'package:gulel/Providers/products.dart';
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
      body: availableProducts.length == 0
          ? Center(
              child: Text('No products found'),
            )
          : _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: displayedProducts.length,
                    itemBuilder: (context, index) =>
                        ChangeNotifierProvider.value(
                      value: displayedProducts[index],
                      child: ProductItem(),
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 3,
                    ),
                  ),
                ),
    );
  }
}
