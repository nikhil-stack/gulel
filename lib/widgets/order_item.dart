import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gulel/Providers/Order_Provider.dart';
import 'package:gulel/screens/Help_Screen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderItem1 extends StatefulWidget {
  final OrderItem order;
  OrderItem1(this.order);

  @override
  _OrderItem1State createState() => _OrderItem1State();
}

class _OrderItem1State extends State<OrderItem1> {
  final ScrollController _controllerOne = ScrollController();
  var expand = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
      height:
          expand ? min((widget.order.Products.length) * 20.0 + 400, 1500) : 450,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('\Rs.${widget.order.Amount}'),
              subtitle: Text(
                  DateFormat('dd/MM/yyyy hh:mm').format(widget.order.time1)),
              trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      expand = !expand;
                    });
                  },
                  icon: Icon(expand ? Icons.expand_less : Icons.more)),
            ),
            Expanded(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                height: expand
                    ? min(widget.order.Products.length * 20.0 + 250, 1500)
                    : 0,
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.4),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                                  children: widget.order.Products
                                      .map((pro) => Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(pro.title),
                                                  Text(
                                                      '${pro.quantity}x${pro.price}')
                                                ],
                                              ),
                                            ],
                                          ))
                                      .toList()),
                          
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Text(
                            "Name:-",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.order.Name)
                        ],
                      ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Address:-",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Flexible(
                              child: Text(
                                widget.order.address,
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            "Pin Code:-",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.order.Pincode),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            "GST No:-",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.order.GSTNo)
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Text(
                            "Organization Name:-",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.order.OrgName)
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            "Contact No:-",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.order.MobileNumber),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            "Payment Status:-",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.order.paymentStatus)
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Payment Status:-",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.order.DeliveryStatus),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: FlatButton(
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(HelpScreen.routeName);
                                },
                                child: Text("Help")),
                            width: MediaQuery.of(context).size.width / 2.2,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Expanded(
                              child: FlatButton(
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    var timedifference = DateTime.now()
                                        .difference(widget.order.time1)
                                        .inHours;
                                    print(timedifference);
                                    if (timedifference >= 1) {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return AlertDialog(
                                              title: Text("Sorry!"),
                                              content: Text(
                                                  "your Order Cant be cancelled"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("Ok"))
                                              ],
                                            );
                                          });
                                    }
                                  },
                                  child: Text("Cancel")))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
