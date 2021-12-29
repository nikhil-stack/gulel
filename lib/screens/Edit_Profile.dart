import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gulel/Providers/user_Provider.dart';
import 'package:gulel/models/CityChose.dart';
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
  bool _isInit = true;
  bool _isLoading = false;
  final _NameController = TextEditingController();
  final _emailController = TextEditingController();
  final _AddressController = TextEditingController();
  final _MobileController = TextEditingController();
  final _PincodeController = TextEditingController();
  final _GstController = TextEditingController();
  final _OrganController = TextEditingController();
  String UpdatedCity;
  @override
  void didChangeDependencies() async {
    if (_isInit) {
      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }
      Provider.of<user_provider>(context, listen: false)
          .fetchandset()
          .then((_) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
    _isInit = false;

    super.didChangeDependencies();
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Consumer<user_provider>(
                builder: (ctx, userdata, _) => Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Expanded(
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _NameController,
                                    //onChanged: (value) async {},
                                    obscureText: false ? showPassword : false,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 3),
                                        labelText: "Full Name",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintText: userdata.users.FullName,
                                        hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    //onSubmitted: (value) async {},
                                    controller: _emailController,
                                    obscureText: false ? showPassword : false,
                                    decoration: InputDecoration(
                                        suffixIcon: false
                                            ? IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    showPassword =
                                                        !showPassword;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.remove_red_eye,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            : null,
                                        contentPadding:
                                            EdgeInsets.only(bottom: 3),
                                        labelText: "E-Mail",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintText: userdata.users.emailId,
                                        hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Your City:-"),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      SelectCity(),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _AddressController,
                                    //  onSubmitted: (value) async {},
                                    obscureText: false ? showPassword : false,
                                    decoration: InputDecoration(
                                        suffixIcon: false
                                            ? IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    showPassword =
                                                        !showPassword;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.remove_red_eye,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            : null,
                                        contentPadding:
                                            EdgeInsets.only(bottom: 3),
                                        labelText: "Address",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintText: userdata.users.address,
                                        hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _PincodeController,
                                    //  onSubmitted: (value) async {},
                                    obscureText: false ? showPassword : false,
                                    decoration: InputDecoration(
                                        suffixIcon: false
                                            ? IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    showPassword =
                                                        !showPassword;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.remove_red_eye,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            : null,
                                        contentPadding:
                                            EdgeInsets.only(bottom: 3),
                                        labelText: "Pincode",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintText: userdata.users.Pincode,
                                        hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _OrganController,
                                    // onSubmitted: (value) async {},
                                    obscureText: false ? showPassword : false,
                                    decoration: InputDecoration(
                                        suffixIcon: false
                                            ? IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    showPassword =
                                                        !showPassword;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.remove_red_eye,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            : null,
                                        contentPadding:
                                            EdgeInsets.only(bottom: 3),
                                        labelText: "Organization Name",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintText: userdata.users.OrganName,
                                        hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _GstController,
                                    // onSubmitted: (value) async {},
                                    obscureText: false ? showPassword : false,
                                    decoration: InputDecoration(
                                        suffixIcon: false
                                            ? IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    showPassword =
                                                        !showPassword;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.remove_red_eye,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            : null,
                                        contentPadding:
                                            EdgeInsets.only(bottom: 3),
                                        labelText: "GST Number",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintText: userdata.users.GstNumber,
                                        hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _MobileController,
                                    //  onSubmitted: (value) async {},
                                    obscureText: false ? showPassword : false,
                                    decoration: InputDecoration(
                                        suffixIcon: false
                                            ? IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    showPassword =
                                                        !showPassword;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.remove_red_eye,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            : null,
                                        contentPadding:
                                            EdgeInsets.only(bottom: 3),
                                        labelText: "Mobile Number",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintText: userdata.users.MobileNumber,
                                        hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    OutlineButton(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 50),
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
                                      onPressed: () async {
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        final userId =
                                            prefs.getString('userId');
                                        final prefs1 = await SharedPreferences
                                            .getInstance();
                                        final userIdtoken =
                                            prefs1.getString('userIdtoken');
                                        final prefs3 = await SharedPreferences
                                            .getInstance();
                                        UpdatedCity = prefs3.getString('city');
                                        var url = Uri.parse(
                                            'https://gulel-ab427-default-rtdb.firebaseio.com/users/$userId/$userIdtoken.json');
                                        await http.patch(url,
                                            body: json.encode({
                                              if (_NameController.text.trim() !=
                                                  "")
                                                "FullName":
                                                    _NameController.text,
                                              if (_emailController.text
                                                      .trim() !=
                                                  "")
                                                'emailId':
                                                    _emailController.text,
                                              if (_GstController.text.trim() !=
                                                      "" &&
                                                  _GstController.text
                                                          .trim()
                                                          .length ==
                                                      15)
                                                "GstNumber":
                                                    _GstController.text.trim(),
                                              if (_OrganController.text
                                                      .trim() !=
                                                  "")
                                                "Organame": _OrganController
                                                    .text
                                                    .trim(),
                                              if (_AddressController.text
                                                      .trim() !=
                                                  "")
                                                'address':
                                                    _AddressController.text,
                                              if (_MobileController.text
                                                      .trim()
                                                      .length ==
                                                  10)
                                                'MobileNumber':
                                                    _MobileController.text
                                                        .trim(),
                                              if (_PincodeController.text
                                                      .trim() !=
                                                  "")
                                                'PinCode':
                                                    _PincodeController.text,
                                              'city': UpdatedCity,
                                            }));
                                        Navigator.of(context).pop();
                                      },
                                      color: Theme.of(context).accentColor,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 50),
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
                    ],
                  ),
                ),
              ),
            ),
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
        onSubmitted: (value) async {},
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
