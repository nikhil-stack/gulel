import 'package:flutter/material.dart';
import 'package:gulel/Providers/Auth_Provider.dart';
import 'package:gulel/Providers/user_Provider.dart';
import 'package:gulel/models/CityChose.dart';
import 'package:gulel/models/signUpcontainer.dart';
import 'package:gulel/screens/login_screen.dart';
import 'package:gulel/screens/tabs_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  static const routeName = '\SignUp-Screen';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // final _form = GlobalKey<FormState>();
  final NameFocusNode = FocusNode();
  final EmailFocusNode = FocusNode();
  //final OrgNameFocusNode = FocusNode();
  final AddressFocusNode = FocusNode();
  // final GstFocusNode = FocusNode();
  final MObileNode = FocusNode();
  final _NameController = TextEditingController();
  final _EmailController = TextEditingController();
  // final _GstController = TextEditingController();
  // final _OrgnameController = TextEditingController();
  final _AddressController = TextEditingController();
  final _MobileController = TextEditingController();
  final _PincodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(
          '/login-screen',
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 20, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  String city;
  void didChangeDependencies() async {
    final prefs = await SharedPreferences.getInstance();
    city = prefs.getString('city') == null ? '' : prefs.getString('city');

    super.didChangeDependencies();
  }

  Widget _nameWidget() {
    return Stack(
      children: [
        TextFormField(
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          controller: _NameController,
          validator: (value) {
            if (value.trim().isEmpty) return "Please Enter Name";
            return null;
          },
          decoration: InputDecoration(
            // hintText: 'Enter your full name',
            labelText: 'Name',
            labelStyle: TextStyle(
                color: Color.fromRGBO(226, 222, 211, 1),
                fontWeight: FontWeight.w500,
                fontSize: 13),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(226, 222, 211, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _emailWidget() {
    return Stack(
      children: [
        TextFormField(
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          controller: _EmailController,
          validator: (value) {
            if (value.trim().isEmpty || !value.trim().contains('@')) {
              return "Invalid Email";
            }
            return null;
          },
          decoration: InputDecoration(
            // hintText: 'Enter your full name',
            labelText: 'Email',
            labelStyle: TextStyle(
                color: Color.fromRGBO(226, 222, 211, 1),
                fontWeight: FontWeight.w500,
                fontSize: 13),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(226, 222, 211, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /* Widget _GstNumberWidget() {
    return Stack(
      children: [
        TextFormField(
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          controller: _GstController,
          validator: (value) {
            if (value.length != 15) return "Invalid GST Number";
            return null;
          },
          decoration: InputDecoration(
            labelText: 'GstNumber/Udhyog Adhaar number',
            labelStyle: TextStyle(
                color: Color.fromRGBO(226, 222, 211, 1),
                fontWeight: FontWeight.w500,
                fontSize: 13),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(226, 222, 211, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }*/

  /* Widget _OrganizationnameWidget() {
    return Stack(
      children: [
        TextFormField(
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          controller: _OrgnameController,
          validator: (value) {
            if (value.trim().isEmpty) return "Please Enter Organization Name";
            return null;
          },
          decoration: InputDecoration(
            labelText: 'Organization name',
            labelStyle: TextStyle(
                color: Color.fromRGBO(226, 222, 211, 1),
                fontWeight: FontWeight.w500,
                fontSize: 13),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(226, 222, 211, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }*/

  Widget _AddressWidget() {
    return Stack(
      children: [
        TextFormField(
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          controller: _AddressController,
          validator: (value) {
            if (value.trim().isEmpty) return "Please Provide Address";
            return null;
          },
          decoration: InputDecoration(
            labelText: 'Address',
            labelStyle: TextStyle(
                color: Color.fromRGBO(226, 222, 211, 1),
                fontWeight: FontWeight.w500,
                fontSize: 13),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(226, 222, 211, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _PincodeWidget() {
    return Stack(
      children: [
        TextFormField(
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          controller: _PincodeController,
          validator: (value) {
            if (value.trim().length != 6) return "Invalid Pin Code!";

            return null;
          },
          decoration: InputDecoration(
            labelText: 'Pin Code',
            labelStyle: TextStyle(
                color: Color.fromRGBO(226, 222, 211, 1),
                fontWeight: FontWeight.w500,
                fontSize: 13),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(226, 222, 211, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _MobileNumberWidget() {
    return Stack(
      children: [
        TextFormField(
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          controller: _MobileController,
          validator: (value) {
            if (value.trim().length < 10) return "Invalid Mobile Number";
            return null;
          },
          decoration: InputDecoration(
            labelText: 'mobileNumber',
            labelStyle: TextStyle(
                color: Color.fromRGBO(226, 222, 211, 1),
                fontWeight: FontWeight.w500,
                fontSize: 13),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(226, 222, 211, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _submitButton() {
    // if (!_formKey.currentState.validate()) {
    // return Text("hi");
    // }

    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () async {
          if (!_formKey.currentState.validate()) {
            return; //Text("hi");
          }
          final response = await Provider.of<user_provider>(
            context,
            listen: false,
          ).validateCity(
            _PincodeController.text.trim(),
            city,
          );
          if (!response) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please Enter a valid pin code in your region!'),
              ),
            );
            return;
          }
          Provider.of<user_provider>(context, listen: false).addUser(
            _NameController.text,
            _EmailController.text,
            // _GstController.text,
            // _OrgnameController.text,
            _AddressController.text,
            _PincodeController.text,
            "+91" + _MobileController.text,
            city,
          );
          final mobile = "+91" + _MobileController.text.trim();

          // Provider.of<Auth_Provider>(context, listen: false)
          //   .registerUser(mobile, context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => TabsScreen(),
            ),
            (route) => false,
          );
        },
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            'Sign up',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w500,
                height: 1.6),
          ),
          SizedBox.fromSize(
            size: Size.square(70.0), // button width and height
            child: ClipOval(
              child: Material(
                color: Color.fromRGBO(76, 81, 93, 1),
                child: Icon(Icons.arrow_forward,
                    color: Colors.white), // button color
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _createLoginLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomLeft,
      child: InkWell(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen())),
        child: Text(
          'Login',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            decoration: TextDecoration.underline,
            decorationThickness: 2,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () => showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Warning',
          ),
          content: Text(
            'Do you really want to go back?',
          ),
          actions: [
            FlatButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(ctx, '/login-screen'),
              child: Text(
                'Yes',
              ),
            ),
            FlatButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('No'),
            )
          ],
        ),
      ),
      child: Scaffold(
        body: SizedBox(
          height: height,
          child: Stack(
            children: [
              Positioned(
                height: MediaQuery.of(context).size.height * 1,
                child: SignUpContainer(),
              ),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      //margin: EdgeInsets.symmetric(vertical: 60),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height * .4),
                            _nameWidget(),
                            SizedBox(height: 20),
                            _emailWidget(),
                            // SizedBox(height: 20),
                            //_GstNumberWidget(),
                            // SizedBox(height: 20),
                            // _OrganizationnameWidget(),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "City:-",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SelectCity(),
                              ],
                            ),
                            SizedBox(height: 20),
                            _AddressWidget(),
                            SizedBox(height: 20),
                            _PincodeWidget(),
                            SizedBox(height: 20),
                            _MobileNumberWidget(),
                            SizedBox(height: 80),
                            _submitButton(),
                            SizedBox(height: height * .030),
                            TextButton(
                              onPressed: () async {
                                await showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Please Select Your City"),
                                      content: StatefulBuilder(
                                        builder: (BuildContext context,
                                            StateSetter setState) {
                                          return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                SelectCity(),
                                              ]);
                                        },
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TabsScreen()),
                                                  (route) => false);
                                            },
                                            child: Text('Ok'))
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                'Skip for now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            //  _createLoginLabel(),
                            //SizedBox(
                            //height: 20,
                            //),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(top: 30, left: 0, child: _backButton()),
            ],
          ),
        ),
      ),
    );
  }
}
