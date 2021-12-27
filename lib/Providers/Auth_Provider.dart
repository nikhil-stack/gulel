import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gulel/screens/signup_screen.dart';
import 'package:gulel/screens/tabs_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth_Provider with ChangeNotifier {
  DateTime expeiryDate;
  final _codeController = TextEditingController();

  Future registerUser(String mobile, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {
          _auth.signInWithCredential(authCredential).then(
            (AuthResult result) async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setString('userId', result.user.uid);
              if (result.additionalUserInfo.isNewUser) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUp(),
                  ),
                  (route) => false,
                );
              } else {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TabsScreen(),
                  ),
                  (route) => false,
                );
              }
            },
          ).catchError(
            (e) {
              print(e);
            },
          );

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException authException) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(authException.message),
            ),
          );
          print(authException.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Please Enter OTP"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        var smsCode = _codeController.text.trim();
                        var _credential = PhoneAuthProvider.getCredential(
                          verificationId: verificationId,
                          smsCode: smsCode,
                        );
                        auth
                            .signInWithCredential(_credential)
                            .then((AuthResult result) async {
                          final prefs = await SharedPreferences.getInstance();

                          prefs.setString('userId', result.user.uid);
                          if (result.additionalUserInfo.isNewUser) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(),
                              ),
                              (route) => false,
                            );
                          } else {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TabsScreen(),
                              ),
                              (route) => false,
                            );
                          }
                          /*final url = Uri.parse(
                            'https://gulel-ab427-default-rtdb.firebaseio.com/users.json',
                          );
                          final response = await http.post(
                            url,
                            body: json.encode(
                              {
                                'UserId': result.user.phoneNumber,
                              },
                            ),
                          );*/
                        }).catchError((e) {
                          if (e
                              .toString()
                              .contains('ERROR_INVALID_VERIFICATION_CODE')) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Invalid OTP!"),
                            ));
                          }
                          print(e);
                        });
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
        });
  }
}
