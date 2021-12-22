import 'package:flutter/material.dart';
import 'package:gulel/Providers/categoryItems.dart';
import 'package:gulel/Providers/products.dart';
import 'package:gulel/widgets/Product_item.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  //const WishlistScreen({ Key? key }) : super(key: key);

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<Product> displayedProducts;

  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Product>(context, listen: false)
          .fetchAndSetWishlist()
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
    displayedProducts = Provider.of<Product>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : displayedProducts.length == 0
              ? Center(
                  child: Text('No products found'),
                )
              : RefreshIndicator(
                  onRefresh: () => Provider.of<Product>(context, listen: false)
                      .fetchAndSetWishlist(),
                  child: Padding(
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
                ),
    );
  }
}
