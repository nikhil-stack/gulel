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

  Future registerUser(String mobile, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {
          _auth.signInWithCredential(authCredential).then((AuthResult result) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TabsScreen(result.user),
              ),
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TabsScreen(result.user),
                            ),
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
                      keyboardType: TextInputType.number,
                      controller: _phoneController,
                    ),
                  ],
                )),
            SizedBox(
              height: 4,
            ),
            Center(
              child: FlatButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    final mobile = "+91" + _phoneController.text.trim();

                    registerUser(mobile, context);
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
