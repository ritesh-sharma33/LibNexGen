import 'package:flutter/material.dart';
import './card_row.dart';

class ReadingRoomPageBody extends StatelessWidget {

  String option, description;
  ReadingRoomPageBody(this.option, this.description);

  @override
  Widget build(BuildContext context) {
    return new CardRow(option: this.option, description: this.description);
  }
}