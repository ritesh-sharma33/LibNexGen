import 'package:flutter/material.dart';
import './reading_room_card_rows.dart';

class ReadingRoomPageBody extends StatelessWidget {

  String option, description;
  ReadingRoomPageBody(this.option, this.description);

  @override
  Widget build(BuildContext context) {
    return new CardRow(option: this.option, description: this.description);
  }
}