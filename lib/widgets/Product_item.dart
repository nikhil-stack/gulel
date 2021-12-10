import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  String id;
  String name;
  double price;
  int quantity;
  String imageUrl;
  String category;
  ProductItem({this.id, this.name, this.price, this.quantity, this.imageUrl, this.category});
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
            onTap: () {},
            child: GridTile(
              child: Hero(
                  tag: 1,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  )),
              footer: Container(
                color: Theme.of(context).accentColor,
                //decoration: BoxDecoration(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.favorite_border))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Price'),
                        Text(price.toString()),
                        Text(quantity.toString())
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
