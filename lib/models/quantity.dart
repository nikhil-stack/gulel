import 'package:flutter/material.dart';
import 'package:gulel/Providers/Cart_Provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class SelectQuantity extends StatefulWidget {
  String ProductID;
  String title;
  double Price;
  String imageUrl;
  double five;
  double ten;
  double twenty;
  double thirty;
  double fifty;
  double seventyFive;
  double hundred;
  SelectQuantity(
    this.ProductID,
    this.title,
    this.Price,
    this.imageUrl,
    this.five,
    this.ten,
    this.twenty,
    this.thirty,
    this.fifty,
    this.seventyFive,
    this.hundred,
  );
  @override
  _SelectQuantityState createState() => _SelectQuantityState();
}

class _SelectQuantityState extends State<SelectQuantity> {
  final Quantitycontroller = TextEditingController();
  void SubmitData() {
    final enteredQuantity = Quantitycontroller.text.trim();
    //final enteredamount = double.parse(amountcontroller.text);
    if (enteredQuantity.isEmpty || int.tryParse(enteredQuantity) <= 0) {
      return;
    }
    double discount = 0;
    if (double.tryParse(enteredQuantity) >= 5 &&
        double.tryParse(enteredQuantity) < 10) {
      discount = widget.five;
    }
    Provider.of<Cart_Provider>(context, listen: false).addItem(
        widget.ProductID,
        widget.title,
        widget.Price,
        widget.imageUrl,
        int.tryParse(enteredQuantity), {
      'five': widget.five,
      'ten': widget.ten,
      'twenty': widget.twenty,
      'thirty': widget.thirty,
      'fifty': widget.fifty,
      'seventyFive': widget.seventyFive,
      'hundred': widget.hundred,
    });
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
                decoration:
                    InputDecoration(labelText: "Quantity", hintText: "In Kg"),
                controller: Quantitycontroller,
                keyboardType: TextInputType.number,
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
