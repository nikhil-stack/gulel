import 'package:flutter/material.dart';
import 'package:gulel/Providers/Cart_Provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '\Cart-Screen';
  @override
  Widget build(BuildContext context) {
    var cartitems = Provider.of<Cart_Provider>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: ListView.builder(
          itemCount: cartitems.length,
          itemBuilder: (ctx, index) {
            return Card(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                elevation: 7,
                child: Row(
                  children: [
                    Container(
                      height: 150,
                      child: Image.network(
                        cartitems.values.toList()[index].imageUrl,
                        fit: BoxFit.cover,
                      ),
                      width: MediaQuery.of(context).size.width / 4,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cartitems.values.toList()[index].title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                              "\$${cartitems.values.toList()[index].price * cartitems.values.toList()[index].quantity}"),
                        ],
                      ),
                    )
                  ],
                ));
          }),
    );
  }
}
