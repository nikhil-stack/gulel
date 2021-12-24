import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:gulel/ClientPart/Providers/Client_Auth_Provider.dart';

class ClientAuthScreen extends StatefulWidget {
  static const routeName = '\Client_login_Screen';
  @override
  _ClientAuthScreenState createState() => _ClientAuthScreenState();
}

class _ClientAuthScreenState extends State<ClientAuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _IsLoading = false;
  void _submitFormData(String emailId, String userId, String password,
      bool IsLogin, BuildContext ctx) async {
    try {
      if (IsLogin) {
        setState(() {
          _IsLoading = true;
        });
        AuthResult authResult;
        authResult = await _auth.signInWithEmailAndPassword(
            email: emailId, password: password);
      } /* else {
        AuthResult authResult;
        authResult = await _auth.createUserWithEmailAndPassword(
            email: emailId, password: password);
      }*/
    } on PlatformException catch (err) {
      var errmessage = "An error Ocurred, Please check your credentials";
      if (err.message != null) {
        errmessage = err.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(errmessage),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        _IsLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitFormData, _IsLoading),
    );
  }
}
