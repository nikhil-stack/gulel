import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
//import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  user users;
  /*user userdata = user(
      FullName: null,
      emailId: null,
      GstNumber: null,
      OrganName: null,
      address: null,
      MobileNumber: null);*/
  Future<void> addUser(
      FullName, emailId, GstNumber, OrganName, address, MobileNumber) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    var url = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/users/$userId.json',
    );
    final response = await http.post(url,
        body: json.encode(
          {
            'FullName': FullName,
            'emailId': emailId,
            'GstNumber': GstNumber,
            'Organame': OrganName,
            'address': address,
            'MobileNumber': MobileNumber,
          },
        ));
    final pref1 = await SharedPreferences.getInstance();

    pref1.setString('userIdtoken', json.decode(response.body)['name']);
    // print(json.decode(response.body)['name']);

    notifyListeners();
  }

//  Map<String, Object> userdataMap;

  Future<void> fetchandset() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final prefs1 = await SharedPreferences.getInstance();
    final userIdtoken = prefs1.getString('userIdtoken');
    print(userIdtoken);
    var url = Uri.parse(
        'https://gulel-ab427-default-rtdb.firebaseio.com/users/$userId/$userIdtoken.json');
    final response = await http.get(url);
    var extracted_data = json.decode(response.body) as Map<String, dynamic>;
    print(extracted_data);
    user loadedUsers;
    /*userdata.FullName = extracted_data["FullName"];
    userdata.emailId = extracted_data["emailId"];
    userdata.GstNumber = extracted_data["GstNumber"];
    userdata.OrganName = extracted_data["OrganName"];
    userdata.address = extracted_data["address"];
    userdata.MobileNumber = extracted_data["MobileNumber"];*/
    loadedUsers = user(
        FullName: extracted_data['FullName'],
        emailId: extracted_data['emailId'],
        GstNumber: extracted_data['GstNumber'],
        OrganName: extracted_data['Organame'],
        address: extracted_data['address'],
        MobileNumber: extracted_data['MobileNumber']);
    users = loadedUsers;
    // print(json.decode(response.body));*/
  }
}
