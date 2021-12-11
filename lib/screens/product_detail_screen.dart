import 'package:flutter/material.dart';
import 'package:gulel/Providers/categoryItems.dart';
import 'package:gulel/models/products.dart';
import 'package:gulel/models/quantity.dart';
import 'package:gulel/widgets/Bottom_navigation.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Product displayedProduct;
    List<Product> availableProducts;
    availableProducts = Provider.of<CategoryItems_Provider>(context).items;
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    final title = routeArgs['id'];
    displayedProduct =
        availableProducts.firstWhere((element) => element.title == title);
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
                    tag: title,
                    child: Image.network(
                      displayedProduct.imageUrl,
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
                        displayedProduct.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: SelectQuantity(
                                        displayedProduct.id,
                                        displayedProduct.title,
                                        displayedProduct.price,
                                        displayedProduct.imageUrl),
                                    behavior: HitTestBehavior.opaque,
                                  );
                                });
                          },
                          child: Text("Add To Cart")),
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
                              Text("Rs. " + displayedProduct.price.toString())
                            ],
                          ),
                          Text("Offers"),
                        ],
                      ),
                      Text("Qty. Available " +
                          displayedProduct.stockAvailable.toString()),
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
