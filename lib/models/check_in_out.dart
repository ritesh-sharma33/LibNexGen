
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/models/student.dart';

class CheckInOut {
  Student student;
  String intakes;
  DateTime inTime;
  DateTime outTime;

  DocumentReference reference;

  CheckInOut({
    @required this.student,
    @required this.intakes,
    @required this.inTime,
    @required this.outTime
  });

  CheckInOut.fromMap(Map<String, dynamic> map, {this.reference}) {
    this.student = map['reference'];
    this.intakes = map['intakes'];
    this.inTime = map['inTime'];
    this.outTime = map['outTime'];
  }
  
  CheckInOut.fromSnapshot(DocumentSnapshot snapshot) 
    : this.fromMap(snapshot.data, reference: snapshot.reference);

  toJson() {
    return {
      'student': this.student,
      'intakes': this.intakes,
      'inTime': this.inTime,
      'outTime': this.outTime
    };
  }

}