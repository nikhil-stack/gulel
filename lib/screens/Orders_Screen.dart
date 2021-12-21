import 'package:flutter/material.dart';
import 'package:gulel/Providers/Order_Provider.dart';
import 'package:gulel/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '\Order_Screen';
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _Isloading = false;
  @override
  void initState() {
    _Isloading = true;

    Provider.of<Orders>(context, listen: false).getandset().then((_) {
      setState(() {
        _Isloading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Order1 = Provider.of<Orders>(context);
    return Scaffold(
      body: _Isloading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (ctx, index) => OrderItem1(Order1.Order[index]),
              itemCount: Order1.Order.length,
            ),
    );
  }
}
