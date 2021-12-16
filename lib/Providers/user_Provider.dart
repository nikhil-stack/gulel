import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class user {
  String FullName;
  String emailId;
  String GstNumber;
  String OrganName;
  String address;
  String MobileNumber;

  user({
    @required this.FullName,
    @required this.emailId,
    @required this.GstNumber,
    @required this.OrganName,
    @required this.address,
    @required this.MobileNumber,
  });
}

class user_provider with ChangeNotifier {
  Future<void> addUser(
      FullName, emailId, GstNumber, OrganName, address, MobileNumber) async {
    var url = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/users.json',
    );
    final response = await http.post(
      url,
      body: json.encode(
        {
          'FullName': FullName,
          'emailId': emailId,
          'GstNumber': GstNumber,
          'Organame': OrganName,
          'address': address,
          'MobileNumber': MobileNumber,
        },
      ),
    );
    notifyListeners();
  }
}
