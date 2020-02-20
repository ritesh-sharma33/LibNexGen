import 'package:flutter/material.dart';
import 'package:qr_code/widgets/gradient_appbar.dart';
import './widgets/home_page_body.dart';

class HomeScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new GradientAppBar('KIIT Library'),
          new HomePageBody('Student In', 'Click here for check-in the student'),
          new HomePageBody('Student Out', 'Click here for check-out the student'),
          new HomePageBody('Show Records', 'Click here for student records'),
        ],
      ),
    );
  }
}