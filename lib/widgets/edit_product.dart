import 'package:flutter/material.dart';

class EditProduct extends StatelessWidget {
  //const EditProduct({ Key? key }) : super(key: key);
  final String productKey;
  final String title;
  final double price;
  final String imageUrl;
  final int stockAvailable;
  final String category1;

  EditProduct({
    this.category1,
    this.imageUrl,
    this.price,
    this.productKey,
    this.stockAvailable,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(productKey),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      onTap: () => Navigator.of(context).pushNamed('/add-product', arguments: {
        'productId': productKey,
        'categoryId': category1,
      }),
    );
  }
}
