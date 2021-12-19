import 'package:flutter/material.dart';
import 'package:gulel/Providers/categoryItems.dart';
import 'package:gulel/Providers/products.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  //const WishlistScreen({ Key? key }) : super(key: key);

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<Product> displayedProducts;
  List<Product> availableProducts;

  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<CategoryItems_Provider>(context)
          .fetAndSetFavouriteProducts()
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: Center(
        child: Text('Wishlist'),
      ),
    );
  }
}
