import 'package:flutter/material.dart';
import 'package:gulel/widgets/Bottom_navigation.dart';

class ProductDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).primaryColor,
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                    tag: 2,
                    child: Image.network(
                      "https://th.bing.com/th/id/OIP.XcVxjhsnZYGM-pkgiDiruQHaE6?pid=ImgDet&rs=1",
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Row(
                    children: [
                      Text(
                        "Dates(Khajoor)",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.shopping_cart)),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text("Price"),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Rs.xxx")
                            ],
                          ),
                          Text("Offers"),
                        ],
                      ),
                      Text("Qty. ___"),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          color: Theme.of(context).accentColor,
                        ),
                        width: MediaQuery.of(context).size.width / 2,
                        child: FlatButton(
                          onPressed: () {},
                          child: Text(
                            "BUY NOW",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              "WISHLIST",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Product Details:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "The almond is the edible kernel of the fruit of the sweet almond tree. It is a bright white fruit wrapped in a reddish brown cover. It is consumed as dry fruit, fried and/or salted."),
                  SizedBox(
                    height: 300,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarClass(),
    );
  }
}
