import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gulel/screens/tabs_screen.dart';

class Auth_Provider with ChangeNotifier {
  String _token;
  String _userId;
  DateTime expeiryDate;
  var _authTimer;
  final _codeController = TextEditingController();

  Future registerUser(String mobile, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {
          _auth.signInWithCredential(authCredential).then((AuthResult result) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => TabsScreen(result.user),
              ),
              (route) => false,
            );
          }).catchError((e) {
            print(e);
          });

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
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TabsScreen(result.user),
                            ),
                            (route) => false,
                          );
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
          print(verificationId);
          print('TimeOut');
        });
  }

  Future<bool> autologin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString("userData")) as Map<String, dynamic>;
    final expieryUserDate = DateTime.parse(extractedUserData['expiery']);
    if (expieryUserDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData["token"];
    _userId = extractedUserData["userId"];
    expeiryDate = expieryUserDate;
    notifyListeners();
    autologout();
    return true;
  }

  Future<void> logout() async {
    _userId = null;
    _token = null;
    expeiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  void autologout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timetoexpire = expeiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timetoexpire), logout);
  }
}
