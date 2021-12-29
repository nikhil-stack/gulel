import 'package:flutter/material.dart';
import 'package:gulel/Providers/categoryItems.dart';
import 'package:gulel/Providers/products.dart';
import 'package:gulel/models/quantity.dart';
import 'package:gulel/screens/cart_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetail extends StatefulWidget {
  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool _isInit = true;
  bool _isLoading = false;
  Product displayedProduct;
  List<Product> availableProducts;
  String currentCity;
  double productPrice;
  @override
  void didChangeDependencies() async {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryy = routeArgs['category'];
    final prefs = await SharedPreferences.getInstance();
    currentCity = prefs.getString('city');
    //final upperTitle = routeArgs['title'];
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<CategoryItems_Provider>(context)
          .fetchAndSetProducts(categoryy)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    setState(() {
      availableProducts = Provider.of<CategoryItems_Provider>(context).items;
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;

      final id = routeArgs['id'];
      displayedProduct = availableProducts
          .firstWhere((element) => element.id == id, orElse: () => null);
    });
    if (currentCity == 'Delhi NCR') {
      setState(() {
        productPrice = displayedProduct.delhiPrice;
      });
    } else if (currentCity == 'Bikaner') {
      setState(() {
        productPrice = displayedProduct.bikanerPrice;
      });
    } else if (currentCity == 'Varanasi') {
      setState(() {
        productPrice = displayedProduct.varanasiPrice;
      });
    } else if (currentCity == 'Hyderabad') {
      setState(() {
        productPrice = displayedProduct.hyderabadPrice;
      });
    } else if (currentCity == 'Kolkata') {
      setState(() {
        productPrice = displayedProduct.kolkataPrice;
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : availableProducts == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding: EdgeInsets.all(10),
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Theme.of(context).primaryColor,
                        expandedHeight: 300,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Hero(
                              tag: displayedProduct.title,
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
                                      if (displayedProduct.stockAvailable <=
                                          0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Sorry, this product is currently out of stock',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (_) {
                                            return GestureDetector(
                                              onTap: () {},
                                              child: SelectQuantity(
                                                displayedProduct.id,
                                                displayedProduct.title,
                                                productPrice,
                                                displayedProduct.stockAvailable,
                                                displayedProduct.imageUrl,
                                                displayedProduct.five,
                                                displayedProduct.ten,
                                                displayedProduct.twenty,
                                                displayedProduct.thirty,
                                                displayedProduct.fifty,
                                                displayedProduct.seventyFive,
                                                displayedProduct.hundred,
                                              ),
                                              behavior: HitTestBehavior.opaque,
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: Text("Add To Cart")),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Price"),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Rs. " +
                                            productPrice
                                                .toString())
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Offers:-",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (displayedProduct.five > 0)
                                          Row(
                                            children: [
                                              Text('On 5kg'),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text("flat "),
                                              Text(
                                                displayedProduct.five
                                                        .toString() +
                                                    '% off',
                                              ),
                                            ],
                                          ),
                                        if (displayedProduct.ten > 0)
                                          Row(
                                            children: [
                                              Text('On 10kg'),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text("flat "),
                                              Text(
                                                displayedProduct.ten
                                                        .toString() +
                                                    '% off',
                                              ),
                                            ],
                                          ),
                                        if (displayedProduct.twenty > 0)
                                          Row(
                                            children: [
                                              Text('On 20kg'),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text("flat "),
                                              Text(
                                                displayedProduct.twenty
                                                        .toString() +
                                                    '% off',
                                              ),
                                            ],
                                          ),
                                        if (displayedProduct.thirty > 0)
                                          Row(
                                            children: [
                                              Text('On 30kg'),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text("flat "),
                                              Text(
                                                displayedProduct.thirty
                                                        .toString() +
                                                    '% off',
                                              ),
                                            ],
                                          ),
                                        if (displayedProduct.fifty > 0)
                                          Row(
                                            children: [
                                              Text('On 50kg'),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text("flat "),
                                              Text(
                                                displayedProduct.fifty
                                                        .toString() +
                                                    '% off',
                                              ),
                                            ],
                                          ),
                                        if (displayedProduct.seventyFive > 0)
                                          Row(
                                            children: [
                                              Text('On 75kg'),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text("flat "),
                                              Text(
                                                displayedProduct.seventyFive
                                                        .toString() +
                                                    '% off',
                                              ),
                                            ],
                                          ),
                                        if (displayedProduct.hundred > 0)
                                          Row(
                                            children: [
                                              Text('On 100kg'),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text("flat "),
                                              Text(
                                                displayedProduct.hundred
                                                        .toString() +
                                                    '% off',
                                              ),
                                            ],
                                          )
                                      ],
                                    )
                                  ],
                                ),
                                // Text("Qty. Available " +
                                //   displayedProduct.stockAvailable.toString()),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    color: Theme.of(context).accentColor,
                                  ),
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: FlatButton(
                                    onPressed: () async {
                                      if (displayedProduct.stockAvailable <=
                                          0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Sorry, this product is currently out of stock',
                                            ),
                                          ),
                                        );
                                      } else {
                                        await showModalBottomSheet(
                                            context: context,
                                            builder: (_) {
                                              return GestureDetector(
                                                onTap: () {},
                                                child: SelectQuantity(
                                                  displayedProduct.id,
                                                  displayedProduct.title,
                                                  productPrice,
                                                  displayedProduct
                                                      .stockAvailable,
                                                  displayedProduct.imageUrl,
                                                  displayedProduct.five,
                                                  displayedProduct.ten,
                                                  displayedProduct.twenty,
                                                  displayedProduct.thirty,
                                                  displayedProduct.fifty,
                                                  displayedProduct.seventyFive,
                                                  displayedProduct.hundred,
                                                ),
                                                behavior:
                                                    HitTestBehavior.opaque,
                                              );
                                            });
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CartScreen(),
                                          ),
                                        );
                                      }
                                    },
                                    child: Text(
                                      "BUY NOW",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                    ),
                                    child: FlatButton(
                                      onPressed: () {
                                        Provider.of<Product>(context,
                                                listen: false)
                                            .toggleFavourites(
                                          displayedProduct,
                                        );
                                      },
                                      child: Text(
                                        "Wishlist",
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
                            Text(displayedProduct.description),
                            SizedBox(
                              height: 300,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}
