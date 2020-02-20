import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  String name, empId, phoneNo;
  String age;
  DocumentReference reference;

  User({
    @required this.name, 
    @required this.empId, 
    @required this.age, 
    @required this.phoneNo
  });

  User.fromMap(Map<String, dynamic> map, {this.reference}) {
    name = map['name'];
    empId = map['empId'];
    age = map['age'];
    phoneNo = map['phoneNo'];
  }

  User.fromSnapshot(DocumentSnapshot snapshot) 
    : this.fromMap(snapshot.data, reference: snapshot.reference);
  
  toJson() {
    return {
      'name': name,
      'age': age,
      'empId': empId,
      'phoneNo': phoneNo
    };
  }
}