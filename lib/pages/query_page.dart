import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student.dart';
import './profile_page.dart';

class QueryPage extends StatefulWidget {

  String query;
  QueryPage(this.query);

  @override
  State<StatefulWidget> createState() {
    return _QueryPageState();
  }
}

class _QueryPageState extends State<QueryPage> {

  TextEditingController _textEditingController = TextEditingController();
  List _listViewData = [];
  List _newData = [];


  @override
  void initState() {

    Firestore.instance.collection('students').getDocuments().then((data) {
      _listViewData += data.documents;
    });

    super.initState();
  }
  
  search(String value) {
    setState(() {
      _newData = _listViewData
        .where((string) => string.toLowerCase().contains(value.toLowerCase()))
        .toList();
    });
  }

  Container _buildBody() {
    if (widget.query == 'all-students-in') {
      return Container(
        child: StreamBuilder(
          stream: Firestore
            .instance
            .collection('students')
            .where('isIn', isEqualTo: true)
            .getDocuments()
            .asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return new ListTile(
                    leading: Icon(Icons.insert_emoticon),
                    trailing: Text(snapshot.data.documents[index]['rollNo']),
                    title: FlatButton(
                      child: Text(snapshot.data.documents[index]['name']),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage()
                          )
                        );
                      },
                    )
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error');
            } else {
              return Center(child: CircularProgressIndicator(),); 
            }
          },
        ),
      );
    } else if (widget.query == 'search-student') {
      return Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 15.0,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: 'Enter text here'
                ),
              ),
            ),
            SizedBox(height: 20.0),
            _newData != null && _newData.length != 0
              ? Expanded(
                child: ListView(
                  padding: EdgeInsets.all(10.0),
                  children: _newData.map((data) {
                    return ListTile(title: Text(data['name'].toString()),);
                  }).toList()
                ),
              )
              : SizedBox()
          ],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.query}"),),
      body: _buildBody()
    );
  }
}