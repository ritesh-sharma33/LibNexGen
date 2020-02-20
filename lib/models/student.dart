import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Student {
  String id;
  String name;
  String rollNo;
  bool isIn;
  String phoneNo;
  bool isHostelite;
  String city;

  DocumentReference reference;

  Student({ 
    this.id, 
    @required this.name, 
    @required this.rollNo, 
    @required this.city,
    @required this.isHostelite,
    @required this.isIn,
    @required this.phoneNo
  });

  Student.fromMap(Map<String, dynamic> map, {this.reference}) {
    this.id = map["id"];
    this.name = map["name"];
    this.rollNo = map["rollNo"];
    this.phoneNo = map["phoneNo"];
    this.city = map["city"];
    this.isHostelite = map["isHostelite"];
    this.isIn = map["isIn"];
  }

  Student.fromSnapshot(DocumentSnapshot snapshot) 
    : this.fromMap(snapshot.data, reference: snapshot.reference);

  toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'rollNo': this.rollNo,
      'phoneNo': this.phoneNo,
      'isHostelite': this.isHostelite,
      'isIn': this.isIn,
      'city': this.city
    };
  }
}
