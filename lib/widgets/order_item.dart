import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gulel/Providers/Order_Provider.dart';
import 'package:intl/intl.dart';

class OrderItem1 extends StatefulWidget {
  final OrderItem order;
  OrderItem1(this.order);

  @override
  _OrderItem1State createState() => _OrderItem1State();
}

class _OrderItem1State extends State<OrderItem1> {
  var expand = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
      height:
          expand ? min(widget.order.Products.length * 20.0 + 300, 1000) : 95,
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
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: expand
                  ? min(widget.order.Products.length * 20.0 + 150, 1000)
                  : 0,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                        children: widget.order.Products
                            .map((pro) => Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(pro.title),
                                        Text('${pro.quantity}x${pro.price}')
                                      ],
                                    ),
                                  ],
                                ))
                            .toList()),
                  ),
                  SizedBox(
                    height: 6,
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
