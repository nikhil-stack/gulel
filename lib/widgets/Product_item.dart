import 'package:flutter/material.dart';
import 'package:gulel/Providers/categoryItems.dart';
import 'package:gulel/Providers/products.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  /*final String id;
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;
  final String category;
  ProductItem({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.imageUrl,
    this.category,
  });*/
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    return Padding(
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
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                        Text('Price'),
                        Text(product.price.toString()),
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
