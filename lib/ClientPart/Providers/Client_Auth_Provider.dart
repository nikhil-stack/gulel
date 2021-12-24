import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitfn, this._IsLoading);

  final void Function(String emailId, String userId, String password,
      bool IsLogin, BuildContext context) submitfn;
  final bool _IsLoading;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  var _IsLogin = true;
  String emailId = '';
  String userId = '';
  String password = '';

  void _submit() async {
    final isValid = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formkey.currentState.save();
      widget.submitfn(
        emailId.trim(),
        userId.trim(),
        password.trim(),
        _IsLogin,
        context,
      );

      Navigator.of(context).pushNamedAndRemoveUntil(
        '/tabs-screen',
        (Route<dynamic> route) => false,
      );
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', 'admin');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.orange.shade100,
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: ValueKey("Email"),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return "Please Enter a valid Email Address";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(label: Text("Email address")),
                    onSaved: (value) {
                      emailId = value;
                    },
                  ),
                  /* if (!_IsLogin)
                    TextFormField(
                      key: ValueKey('userId'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return "User Name must Contains 4 characters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "User Name"),
                      onSaved: (value) {
                        userId = value;
                      },
                    ),*/
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 6) {
                        return "Password Must atleast 6 characters Long";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                    onSaved: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget._IsLoading) CircularProgressIndicator(),
                  if (!widget._IsLoading)
                    RaisedButton(
                      onPressed: _submit,
                      child: Text("Login"),
                    ),
                ],
              )),
        )),
      ),
    );
  }
}
