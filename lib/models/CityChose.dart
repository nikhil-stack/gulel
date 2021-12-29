import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String _selectedLocation;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton(
        hint: Text(
          'Please choose a location',
          style: TextStyle(color: Colors.white),
        ), // Not necessary for Option 1
        value: _selectedLocation,
        onChanged: (newValue) async {
          setState(() {
            _selectedLocation = newValue;
          });
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('city', newValue);
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
