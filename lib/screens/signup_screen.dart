import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  static const routeName = '\SignUp-Screen';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _form = GlobalKey<FormState>();
  final NameFocusNode = FocusNode();
  final EmailFocusNode = FocusNode();
  final OrgNameFocusNode = FocusNode();
  final AddressFocusNode = FocusNode();
  final GstFocusNode = FocusNode();
  final MObileNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp"),
      ),
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
        child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'Full Name'),
                  // onFieldSubmitted: (){},
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.text,
                  focusNode: EmailFocusNode,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                    // return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'GstNumber'),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'Organization name'),
                  keyboardType: TextInputType.text,
                  focusNode: OrgNameFocusNode,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'Address'),
                  keyboardType: TextInputType.text,
                  focusNode: AddressFocusNode,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'Mobile Number'),
                  keyboardType: TextInputType.number,
                  focusNode: MObileNode,
                  //focusNode: priceFocusNode,
                ),
                SizedBox(
                  height: 6,
                ),
                Center(
                  child: Container(
                    child: FlatButton(
                      onPressed: () {},
                      child: Text("Submit"),
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
