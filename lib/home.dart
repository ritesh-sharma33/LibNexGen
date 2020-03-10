import 'package:flutter/material.dart';
import 'package:qr_code/widgets/gradient_appbar.dart';
import 'package:qr_code/widgets/home_page_body.dart';

class HomeScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new GradientAppBar('LibNexGen'),
          new HomePageBody()
        ],
      ),
    );
  }
}