import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gulel/Providers/Cart_Provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final _addressController = TextEditingController();
  final _Pincodecontroller = TextEditingController();
  Future<void> submitdata() async {
    final enteredAddress = _addressController.text;
    final enteredPinCode = _Pincodecontroller.text;
    if ((enteredPinCode.isNotEmpty) && (enteredAddress.isNotEmpty)) {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      final prefs1 = await SharedPreferences.getInstance();
      final userIdtoken = prefs1.getString('userIdtoken');
      var url = Uri.parse(
          'https://gulel-ab427-default-rtdb.firebaseio.com/users/$userId/$userIdtoken.json');
      await http.patch(
        url,
        body: json.encode(
          {
            'address': enteredAddress,
            'PinCode': enteredPinCode,
          },
        ),
      );
    }
    Navigator.of(context).pop();
    Provider.of<Cart_Provider>(context, listen: false).fetchAndSetCart();
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
                decoration: InputDecoration(labelText: "Address"),
                controller: _addressController,
                onSubmitted: (_) {},
              ),
              TextField(
                decoration: InputDecoration(labelText: "Pin Code"),
                controller: _Pincodecontroller,
                onSubmitted: (_) {},
              ),
              FlatButton(
                color: Theme.of(context).accentColor,
                child: Text(
                  "Add Address",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => submitdata(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
