import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
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
                    "https://media.gettyimages.com/photos/almonds-picture-id153711056",
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
                          "Pistachios",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.favorite_border))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Text('Price'), Text('Rs.xxx'), Text("Qty.__")],
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
