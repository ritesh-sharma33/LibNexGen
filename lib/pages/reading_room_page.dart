import 'package:flutter/material.dart';
import 'package:qr_code/widgets/gradient_appbar.dart';
import 'package:qr_code/widgets/reading_room_page_body.dart';

class ReadingRoomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: <Widget>[
          new GradientAppBar("Reading Room"),
          new SizedBox(height: 30,),
          new ReadingRoomPageBody('Student In', 'Click here for check-in the student'),
          new ReadingRoomPageBody('Student Out', 'Click here for check-out the student'),
          new ReadingRoomPageBody('Show Records', 'Click here for student records')
        ],
      ),
    );
  }
}