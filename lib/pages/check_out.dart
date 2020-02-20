import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student.dart';
import '../home.dart';

class CheckOut extends StatefulWidget {
  String barcode = '';

  CheckOut({this.barcode});
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {

  String _currentStudentId;
  Student student;
  bool isSuccessfullyOut, isStudentInside;
  String studentPath, idOfCurrentCheckOut;

  @override
  void initState() {
    Firestore
      .instance
      .collection('students')
      .where('rollNo', isEqualTo: widget.barcode)
      .getDocuments()
      .then((docs) {
        this._currentStudentId = docs.documents[0].documentID;
        this.isStudentInside = docs.documents[0]['isIn'];
        this.studentPath = "/students/${docs.documents[0].documentID}";
      })
      .catchError((error) {
        print(error);
      });
    Firestore.instance
      .collection('checkinout')
      .where('outTime', isEqualTo: null)
      .where('student', isEqualTo: this.studentPath)
      .getDocuments()
      .then((docs) {
        this.idOfCurrentCheckOut = docs.documents[0].documentID;
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    final baseTextStyle = const TextStyle(
      fontFamily: 'Poppins'
    );

    final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.w600
    );

    final regularTextStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 15.0,
      fontWeight: FontWeight.w400
    );

    final subHeaderTextStyle = regularTextStyle.copyWith(
      fontSize: 12.0
    );

    return Scaffold(
      body: Container(
      color: Colors.white,
      alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05, vertical: deviceHeight * 0.25),
        child: Card(
          elevation: 10,
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                stream: Firestore
                  .instance
                  .collection('students')
                  .where('rollNo', isEqualTo: widget.barcode)
                  .snapshots(),
                  builder: (context, snapshot) {
                    student = new Student(
                      name: snapshot.data.documents[0]['name'],
                      rollNo: snapshot.data.documents[0]['rollNo'],
                      phoneNo: snapshot.data.documents[0]['phoneNo'],
                      isHostelite: snapshot.data.documents[0]['isHostelite'],
                      isIn: snapshot.data.documents[0]['isIn'],
                      city: snapshot.data.documents[0]['city']
                    );
                    return Center(
                      child: Column(
                        children: <Widget>[
                          Text('Student Details', style: headerTextStyle,),
                          Text("Name: ${snapshot.data.documents[0]['name']}", style: regularTextStyle,),
                          Text("Roll No: ${snapshot.data.documents[0]['rollNo']}", style: regularTextStyle,),
                          Text("Phone No: ${snapshot.data.documents[0]['phoneNo']}", style: regularTextStyle,),
                          Text("isHostelite: ${snapshot.data.documents[0]['isHostelite'] == true ? 'yes' : 'No'}", style: regularTextStyle,),
                          Text("isInside: ${snapshot.data.documents[0]['isIn'] == true ? 'yes' : 'No'}", style: regularTextStyle,),
                          SizedBox(height: 40,),
                          snapshot.data.documents[0]['isIn'] == false
                            ? Text("Student is not present in library, please check")
                            : RaisedButton(
                              child: Text("Submit"),
                              color: Colors.purple,
                              onPressed: () {
                                Firestore.instance
                                  .collection('checkinout')
                                  .document(this.idOfCurrentCheckOut)
                                  .updateData({
                                    'outTime': DateTime.now()
                                  })
                                  .then((c) {
                                    this.isSuccessfullyOut = true;
                                    Firestore.instance
                                      .collection('students')
                                      .document(this._currentStudentId)
                                      .updateData({
                                        'isIn': false
                                      })
                                      .then((c) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomeScreen()
                                          )
                                        );
                                      })
                                      .catchError((error) {

                                      });
                                  });
                              },
                            )
                        ]
                      )
                    );
                  }
                ),
            ],
          ),
        ),
    )
    );
  }
}