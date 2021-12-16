import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gulel/screens/signup_screen.dart';
import 'package:gulel/screens/tabs_screen.dart';
import 'package:http/http.dart' as http;

class Auth_Provider with ChangeNotifier {
  DateTime expeiryDate;
  final _codeController = TextEditingController();
  String _userId;

  String get userId {
    return _userId;
  }

  Future registerUser(String mobile, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {
          _auth.signInWithCredential(authCredential).then(
            (AuthResult result) {
              _userId = result.user.uid;
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
                            .then((AuthResult result) {
                          _userId = result.user.uid;
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
