import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gulel/Providers/user_Provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
//import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  static const routeName = '\Edit-Profile';
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  Future<void> refreshProduct(BuildContext context) async {
    await Provider.of<user_provider>(context, listen: false).fetchandset();
  }

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder(
          future: refreshProduct(context),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () => refreshProduct(context),
                  child: Container(
                    child: Consumer<user_provider>(
                      builder: (ctx, userdata, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: Expanded(
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 16, top: 25, right: 16),
                            child: GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                              },
                              child: ListView(
                                children: [
                                  Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  /*  Center(
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 130,
                                          height: 130,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 4,
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor),
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 2,
                                                    blurRadius: 10,
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    offset: Offset(0, 10))
                                              ],
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                                  ))),
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  width: 4,
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                ),
                                                color: Colors.green,
                                              ),
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),*/
                                  SizedBox(
                                    height: 35,
                                  ),
                                  buildTextField("Full Name",
                                      userdata.users.FullName, false),
                                  buildTextField(
                                      "E-mail", userdata.users.emailId, false),
                                  buildTextField(
                                      "Address", userdata.users.address, false),
                                  buildTextField(
                                      "PinCode", userdata.users.Pincode, false),
                                  buildTextField("Organization name",
                                      userdata.users.OrganName, false),
                                  buildTextField("GST Number",
                                      userdata.users.GstNumber, false),
                                  buildTextField("Mobile Number",
                                      userdata.users.MobileNumber, false),
                                  SizedBox(
                                    height: 35,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      OutlineButton(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("CANCEL",
                                            style: TextStyle(
                                                fontSize: 14,
                                                letterSpacing: 2.2,
                                                color: Colors.black)),
                                      ),
                                      RaisedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        color: Colors.green,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 50),
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text(
                                          "SAVE",
                                          style: TextStyle(
                                              fontSize: 14,
                                              letterSpacing: 2.2,
                                              color: Colors.white),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    var key;
    if (labelText == 'Full Name') key = 'FullName';
    if (labelText == 'E-mail') key = 'emailId';
    if (labelText == 'Address') key = 'address';
    if (labelText == 'PinCode') key = 'PinCode';
    if (labelText == 'Mobile Number') key = 'MobileNumber';
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        onChanged: (value) async {
          if (value != Null) {
            final prefs = await SharedPreferences.getInstance();
            final userId = prefs.getString('userId');
            final prefs1 = await SharedPreferences.getInstance();
            final userIdtoken = prefs1.getString('userIdtoken');
            var url = Uri.parse(
                'https://gulel-ab427-default-rtdb.firebaseio.com/users/$userId/$userIdtoken.json');
            await http.patch(url,
                body: json.encode({
                  "$key": value,
                }));
          }
        },
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
