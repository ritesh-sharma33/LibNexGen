import 'package:flutter/material.dart';
import './card_row.dart';

class HomePageBody extends StatelessWidget {

  String option, description;
  HomePageBody(this.option, this.description);

  @override
  Widget build(BuildContext context) {
    return new CardRow(option: this.option, description: this.description);
  }
}