import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gulel/Providers/Cart_Provider.dart';
import 'package:gulel/models/address.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CartScreen extends StatefulWidget {
  static const routeName = '\Cart-Screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  String address;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }
      Provider.of<Cart_Provider>(context).fetchAndSetCart().then((_) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
    _isInit = false;
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final prefs1 = await SharedPreferences.getInstance();
    final userIdtoken = prefs1.getString('userIdtoken');
    var url = Uri.parse(
        'https://gulel-ab427-default-rtdb.firebaseio.com/users/$userId/$userIdtoken.json');
    final response = await http.get(url);
    var extracted_data = json.decode(response.body) as Map<String, dynamic>;
    setState(() {
      address = extracted_data['Address'];
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var cartitems = Provider.of<Cart_Provider>(context).items;
    var cart = Provider.of<Cart_Provider>(context);
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Your Cart"),
      ),*/
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : cartitems.isEmpty
              ? Center(child: Text("No items added yet"))
              : Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.2)),
                      height: MediaQuery.of(context).size.height / 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Address:-",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(address),
                            ],
                          ),
                          TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (_) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Address(),
                                        behavior: HitTestBehavior.opaque,
                                      );
                                    });
                              },
                              child: Text("Change"))
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: cartitems.length,
                          itemBuilder: (ctx, index) {
                            return Dismissible(
                              key: ValueKey(cartitems.keys.toList()[index]),
                              background: Container(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 35,
                                ),
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 20),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 4),
                                color: Theme.of(context).accentColor,
                              ),
                              direction: DismissDirection.endToStart,
                              // onDismissed: (){},
                              onDismissed: (direction) {
                                Provider.of<Cart_Provider>(context,
                                        listen: false)
                                    .deleteItem(cartitems.keys.toList()[index]);
                              },
                              confirmDismiss: (direction) {
                                return showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text('Are you Sure?'),
                                          content: Text(
                                              'You want to remove item from Cart'),
                                          actions: [
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: Text('No')),
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                },
                                                child: Text('Yes'))
                                          ],
                                        ));
                              },
                              child: Card(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 8),
                                  elevation: 7,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 130,
                                        child: Image.network(
                                          cartitems.values
                                              .toList()[index]
                                              .imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cartitems.values
                                                  .toList()[index]
                                                  .title,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                                "\$${cartitems.values.toList()[index].price * cartitems.values.toList()[index].quantity}"),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            );
                          }),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                      elevation: 7,
                      child: Column(
                        children: [
                          Text(
                            "Price Details",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text('Total MRP'),
                              Text('\$${cart.totalAmount.toStringAsFixed(2)}')
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          Row(
                            children: [
                              Text('Discount on MRP'),
                              Text('\$-Y',
                                  style: TextStyle(color: Colors.green))
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Amount",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text('\$Z',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            child: Card(
                              child: FlatButton(
                                onPressed: () {},
                                child: Text("Place Order"),
                                color: Theme.of(context).accentColor,
                              ),
                              elevation: 4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
