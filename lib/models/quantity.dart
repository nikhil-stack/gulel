import 'package:flutter/material.dart';
import 'package:gulel/Providers/Cart_Provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class SelectQuantity extends StatefulWidget {
  String ProductID;
  String title;
  double Price;
  String imageUrl;
  SelectQuantity(
      {@required this.ProductID,
      @required this.title,
      @required this.Price,
      @required this.imageUrl});
  @override
  _SelectQuantityState createState() => _SelectQuantityState();
}

class _SelectQuantityState extends State<SelectQuantity> {
  final Quantitycontroller = TextEditingController();
  void SubmitData() {
    final enteredQuantity = Quantitycontroller.text;
    //final enteredamount = double.parse(amountcontroller.text);
    if (enteredQuantity.isEmpty) {
      return;
    }
    Provider.of<Cart_Provider>(context, listen: false).addItem(
        widget.ProductID,
        widget.title,
        widget.Price,
        widget.imageUrl,
        int.tryParse(enteredQuantity));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Quantity"),
                controller: Quantitycontroller,
                onSubmitted: (_) => SubmitData(),
              ),
              FlatButton(
                color: Theme.of(context).accentColor,
                child: Text(
                  "Add Product",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => SubmitData(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
