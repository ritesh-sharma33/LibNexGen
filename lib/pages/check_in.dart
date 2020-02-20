import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../home.dart';
import '../models/student.dart';

class CheckInOut extends StatefulWidget {

  final String barcode;

  CheckInOut({this.barcode});

  @override
  State<StatefulWidget> createState() {
    return _CheckInOutState();
  }
}

class _CheckInOutState extends State<CheckInOut> {
  List<String> _inTakes = List();

  Student student;
  bool isSuccessfullyIn;
  DocumentSnapshot _currentStudent;
  final myController = new TextEditingController();
  bool isLoaded = false;
  bool _isTextFieldRequired = false;

  @override
  void dispose() {
    myController.dispose();
    this.isSuccessfullyIn = false;
    super.dispose();
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
      resizeToAvoidBottomPadding: false,
      body: Container(
      color: Colors.white,
      alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05, vertical: deviceHeight * 0.2),
        child: Card(
          elevation: 10,
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    this._currentStudent = snapshot.data.documents[0];
                    if (snapshot.hasData) {
                      return Center(
                      child: Column(
                      children: <Widget>[
                        Text('Student Details', style: headerTextStyle,),
                        Text("Name: ${this.student.name}", style: regularTextStyle,),
                        Text("Roll No: ${this.student.rollNo}", style: regularTextStyle,),
                        Text("Phone No: ${this.student.phoneNo}", style: regularTextStyle,),
                        Text("isHostelite: ${this.student.isHostelite == true ? 'yes' : 'No'}", style: regularTextStyle,),
                        Text("isInside: ${this.student.isIn == true ? 'yes' : 'No'}", style: regularTextStyle,),
                        SizedBox(height: 40,),
                        this.student.isIn == true
                        ?  Text("The user is already inside, please checkout", style: subHeaderTextStyle,)
                          : Column(
                            children: <Widget>[
                              DropdownButton(
                                items: [
                                  DropdownMenuItem(
                                    value: "Laptop",
                                    child: Text('Laptop'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Copy',
                                    child: Text('Copy'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Book',
                                    child: Text('Book'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Others',
                                    child: Text('Others'),
                                  )
                                ],
                                onChanged: (value) {
                                  if (value == 'Others') {
                                    setState(() {
                                      this._isTextFieldRequired = true;
                                    });
                                  } else {
                                    _inTakes.add(value.toString());
                                  }
                                },
                              ),
                              this._isTextFieldRequired == true
                                ? TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Enter other intakes'
                                  ),
                                  controller: this.myController,
                                )
                                : SizedBox(),
                              RaisedButton(
                                color: Colors.orangeAccent,
                                child: Text('Submit'),
                                onPressed: () {
                                  this.myController.value;
                                  Firestore.instance.collection('checkinout').add({
                                    'inTime': DateTime.now(),
                                    'outTime': null,
                                    'intakes': _inTakes.join(', ') + ', ' +(this._isTextFieldRequired == true ? myController.text : ''),
                                    'student': '/students/${this._currentStudent.documentID}'
                                  }).then((c) {
                                    this.isSuccessfullyIn = true;
                                    Firestore.instance
                                      .collection('students')
                                      .document(this._currentStudent.documentID)
                                      .updateData({
                                        'isIn': true
                                      });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen()
                                      )
                                    );
                                  })
                                  .catchError((e) {
                                    setState(() {
                                      this.isSuccessfullyIn = false;
                                    });
                                  });
                                },
                              ),
                            ]
                          )
                      ]),
                    );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('No student found...', style: TextStyle(color: Colors.red),),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                ),
                this.isSuccessfullyIn == false
                  ? Text('Unsuccessful! Please try again', style: TextStyle(color: Colors.red),)
                  : SizedBox()
            ],
          ),
        ),
    )
    );
  }
}