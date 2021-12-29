import 'package:flutter/material.dart';
import 'package:gulel/Providers/categoryItems.dart';
import 'package:gulel/Providers/products.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductItem extends StatefulWidget {
  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  String currentCity;
  double productPrice;
  Product product;
  @override
  void didChangeDependencies() async {
    final prefs = await SharedPreferences.getInstance();
    currentCity = prefs.getString('city');
    product = Provider.of<Product>(context, listen: false);
    if (currentCity == 'Delhi NCR') {
      setState(() {
        productPrice = product.delhiPrice;
      });
    } else if (currentCity == 'Bikaner') {
      setState(() {
        
      productPrice = product.bikanerPrice;
            });

    } else if (currentCity == 'Varanasi') {
      setState(() {
        
      productPrice = product.varanasiPrice;
            });

    } else if (currentCity == 'Hyderabad') {
      setState(() {
        
      productPrice = product.hyderabadPrice;
            });

    } else if (currentCity == 'Kolkata') {
      setState(() {
        
     
      productPrice = product.kolkataPrice;
       });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return product == null ? Center(child: CircularProgressIndicator(),) : Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 1),
            borderRadius: BorderRadius.circular(15)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/product-details', arguments: {
                'id': product.id,
                'category': product.category1,
              });
            },
            child: GridTile(
              child: Hero(
                  tag: product.id,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  )),
              footer: Container(
                color: Theme.of(context).accentColor,
                //decoration: BoxDecoration(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Consumer<Product>(
                            builder: (ctx, product, child) => IconButton(
                              onPressed: () {
                                product.toggleFavourites(product);
                              },
                              icon: Icon(
                                product.isFavourite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Price',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          'Rs. ' + productPrice.toString(),
                          style: TextStyle(color: Theme.of(context).cardColor),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
