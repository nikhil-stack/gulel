import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SelectCity extends StatefulWidget {
  @override
  _SelectCityState createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  List<String> _locations = [
    'Delhi NCR',
    'Hyderabad',
    'Varanasi',
    'Bikaner',
    'Kolkata'
  ];
  void didChangeDependencies() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLocation = prefs.getString('city');
    });
    super.didChangeDependencies();
  }

  String _selectedLocation;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton(
        value: null,
        hint: Text(
          _selectedLocation == null
              ? 'Please choose a location'
              : _selectedLocation,
          style: TextStyle(color: Colors.black),
        ), // Not necessary for Option 1
        //  value: _selectedLocation,
        onChanged: (newValue) async {
          setState(() {
            _selectedLocation = newValue;
          });
          final prefs = await SharedPreferences.getInstance();
          final userId = prefs.getString('userId');
          final userIdtoken = prefs.getString('userIdtoken');
          var url = Uri.parse(
            'https://gulel-ab427-default-rtdb.firebaseio.com/users/$userId/$userIdtoken.json',
          );
          final prefs3 = await SharedPreferences.getInstance();
          prefs3.setString('city', newValue);
          await http.patch(
            url,
            body: json.encode(
              {
                'city': newValue,
              },
            ),
          );
        },
        items: _locations.map((location) {
          return DropdownMenuItem(
            child: new Text(location),
            value: location,
          );
        }).toList(),
      ),
    );
  }
}
