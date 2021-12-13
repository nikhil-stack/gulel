import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  String id;
  String name;
  double price;
  int quantity;
  String imageUrl;
  String category;
  ProductItem(
      {this.id,
      this.name,
      this.price,
      this.quantity,
      this.imageUrl,
      this.category});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 1),
            borderRadius: BorderRadius.circular(15)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            onTap: () => Navigator.of(context)
                .pushNamed('/product-details', arguments: {'id': name}),
            child: GridTile(
              child: Hero(
                  tag: id,
                  child: Image.network(
                    imageUrl,
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
                            name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.favorite_border))
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Price'),
                        Text(price.toString()),
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
