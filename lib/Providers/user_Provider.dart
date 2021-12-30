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
  String Pincode;
  String MobileNumber;
  String city;

  user({
    @required this.FullName,
    @required this.emailId,
    @required this.GstNumber,
    @required this.OrganName,
    @required this.address,
    @required this.Pincode,
    @required this.MobileNumber,
    @required this.city,
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
  user get userss {
    return users;
  }

  Future<void> addUser(
    FullName,
    emailId,
    GstNumber,
    OrganName,
    address,
    Pincode,
    MobileNumber,
    city,
  ) async {
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
            'PinCode': Pincode,
            'MobileNumber': MobileNumber,
            'city': city,
          },
        ));
    final pref1 = await SharedPreferences.getInstance();

    pref1.setString('userIdtoken', json.decode(response.body)['name']);
    // print(json.decode(response.body)['name']);
    users = user(
      FullName: FullName,
      emailId: emailId,
      GstNumber: GstNumber,
      OrganName: OrganName,
      address: address,
      Pincode: Pincode,
      MobileNumber: MobileNumber,
      city: city,
    );

    notifyListeners();
  }

//  Map<String, Object> userdataMap;

  Future<void> fetchandset() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final prefs1 = await SharedPreferences.getInstance();
    final userIdtoken = prefs1.getString('userIdtoken');
    // print(userIdtoken);
    var url = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/users/$userId/$userIdtoken.json',
    );
    final response = await http.get(url);
    var extractedData = json.decode(response.body) as Map<String, dynamic>;
    //if (extractedData == null) return;
    //  print(extracted_data);
    user loadedUsers;
    /*userdata.FullName = extracted_data["FullName"];
    userdata.emailId = extracted_data["emailId"];
    userdata.GstNumber = extracted_data["GstNumber"];
    userdata.OrganName = extracted_data["OrganName"];
    userdata.address = extracted_data["address"];
    userdata.MobileNumber = extracted_data["MobileNumber"];*/
    if (extractedData == null) {
      loadedUsers = user(
        FullName: '',
        emailId: '',
        GstNumber: '',
        OrganName: '',
        Pincode: '',
        address: '',
        MobileNumber: '',
        city: '',
      );
    } else {
      loadedUsers = user(
        FullName: extractedData['FullName'],
        emailId: extractedData['emailId'],
        GstNumber: extractedData['GstNumber'],
        OrganName: extractedData['Organame'],
        Pincode: extractedData['PinCode'],
        address: extractedData['address'],
        MobileNumber: extractedData['MobileNumber'],
        city: extractedData['city'],
      );
    }
    users = loadedUsers;
    notifyListeners();

    // print(json.decode(response.body));*/
  }

  Future<void> getCurrentCity() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final prefs1 = await SharedPreferences.getInstance();
    final userIdtoken = prefs1.getString('userIdtoken');
    // print(userIdtoken);
    var url = Uri.parse(
      'https://gulel-ab427-default-rtdb.firebaseio.com/users/$userId/$userIdtoken.json',
    );
    final response = await http.get(url);
    var extractedData = json.decode(response.body) as Map<String, dynamic>;
    prefs.setString('city', extractedData['city']);
    notifyListeners();
  }

  Future<bool> validateCity(String pinCode, String selectedCity) async {
    final url = Uri.parse(
      'https://api.postalpincode.in/pincode/$pinCode',
    );
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as List<dynamic>;
    //print(extractedData);
    //print(
      //  'district ' + extractedData[0]['PostOffice'][0]['District'].toString());
    if (extractedData[0]['Status'] == 'Error') {
      return false;
    }
    final cityData = extractedData[0]['PostOffice'][0]['District'] as String;
    if (!cityData.contains(selectedCity)) {
      return false;
    }
    

    notifyListeners();
    return true;
  }
}
