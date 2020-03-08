import 'package:flutter/material.dart';
import 'package:qr_code/widgets/gradient_appbar.dart';

class CirculationCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          new GradientAppBar('Circulation Center')
        ],
      ),
    );
  }
}