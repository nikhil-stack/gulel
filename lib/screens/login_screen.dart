import 'package:flutter/material.dart';
import 'package:gulel/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gulel/screens/tabs_screen.dart';

class LoginScreen extends StatefulWidget {
  // const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _codeController = TextEditingController();

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          var result = await _auth.signInWithCredential(credential);

          var user = result.user;

          if (user != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TabsScreen(),
                ));
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (var exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Give the code?"),
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
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId, smsCode: code);

                        var result =
                            await _auth.signInWithCredential(credential);

                        var user = result.user;

                        if (user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TabsScreen(),
                              ));
                        } else {
                          print("Error");
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(
            "https://images.pexels.com/photos/7412065/pexels-photo-7412065.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          ),
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.4), BlendMode.dstATop),
          fit: BoxFit.cover,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text("Gulel",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
            SizedBox(
              height: 20,
            ),
            Text(
              "Welcome",
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 4,
            ),
            Text("Please Login to Continue"),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'MobileNo'),
                      keyboardType: TextInputType.text,
                      controller: _phoneController,
                    ),
                    /* TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      // keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                    )*/
                  ],
                )),
            SizedBox(
              height: 4,
            ),
            Center(
              child: FlatButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    final phone = _phoneController.text.trim();

                    loginUser(phone, context);
                  },
                  child: Text("Login",
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text("Don't have an account?"),
                SizedBox(
                  width: 2,
                ),
                FlatButton(
                  child: Text("SignUp"),
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignUp.routeName);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
