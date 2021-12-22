import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  static const routeName = '\Help_Screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
      ),
      body: Container(
        //height: MediaQuery.of(context).size.height,
        child: Center(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Text("For any Queries or Customer Support Contact Us on:-"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [Icon(Icons.call), Text("+91-8368965099")],
              ),
            ),
            Row(
              children: [Icon(Icons.email), Text("gulelapp@gmail.com")],
            )
          ],
        )),
      ),
    );
  }
}
