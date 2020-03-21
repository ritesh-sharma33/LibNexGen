import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import '../pages/check_in.dart';

class StudentSignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentSignInPageState();  
  }
}

class _StudentSignInPageState extends State<StudentSignInPage> {

  String barcode = '';
  bool isScanned = false;

  Future scanForIn() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        this.barcode = barcode;
        this.isScanned = true;
      });
    } on PlatformException catch(e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() {
          this.barcode = 'Unknown error: $e';
        });
      }
    } on FormatException {
      setState(() {
        this.barcode = 'null (User returned using the "back"-button before scanning anything, Result)';

      });
    } catch (e) {
      setState(() {
        this.barcode = 'Unknown error: $e';
      });
    }
  }


  Container _getBackground() {
    return new Container(
      child: new Image.asset(
        'assets/images/kiit-library.jpeg',
        fit: BoxFit.cover,
        height: 300.0,
      ),
      constraints: new BoxConstraints.expand(height: 300.0),
    );
  }

  Container _getToolbar(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(
        top: MediaQuery.of(context).padding.top
      ),
      child: new BackButton(color: Colors.white,),
    );
  }

  Widget _getActionsWidgets(BuildContext context) {

    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;


    final baseTextStyle = const TextStyle(
      fontFamily: 'Poppins'
    );

    final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w600
    );

    final regularTextStyle = baseTextStyle.copyWith(
      color: const Color(0xff4d4d4d),
      fontSize: 12.0,
      fontWeight: FontWeight.w400
    );


    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)
        ),
        width: deviceWidth * 0.8,
        margin: EdgeInsets.only(top: deviceHeight * 0.575, left: deviceHeight * 0.05),
        child: Column(
          children: <Widget>[
            InkWell(
              child: RaisedButton(
                elevation: 5,
                color: Colors.green,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.scanner, size: 50,),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Start Camera Scan', style: headerTextStyle,),
                        Text('Click here to scan barcode', style: regularTextStyle,),
                      ],
                    ),
                  ],
                ),
                onPressed: scanForIn
              ),
              onTap: scanForIn
            ),
            SizedBox(height: 50,),
            isScanned == true ? RaisedButton(
              color: Colors.orangeAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Next', style: TextStyle(color: Colors.purple),),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckInOut(barcode: this.barcode,)
                  )
                );
              },
            ) : SizedBox(),
            SizedBox(height: deviceHeight * 0.175,),
            Text("© Copyright-2020 LibNexGen")
          ]
        )
      );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final double deviceWidth = MediaQuery.of(context).size.width;

    final baseTextStyle = const TextStyle(
      fontFamily: 'Poppins'
    );

    final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.w600
    );

    final regularTextStyle = baseTextStyle.copyWith(
      color: const Color(0xffbabfbc),
      fontSize: 15.0,
      fontWeight: FontWeight.w400
    );

    final subHeaderTextStyle = regularTextStyle.copyWith(
      fontSize: 14.0
    );
    final optionCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(16.0, 42.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0,),
          new Text('Student In', style: headerTextStyle,),
          new Container(height: 10.0,),
          new Text('Click here to check-in student', style: subHeaderTextStyle,)
        ],
      ),
    );

    final optionCard = new Container(
      child: optionCardContent,
      constraints: BoxConstraints(maxWidth: deviceWidth * 0.85),
      height: 154.0,
      margin: new EdgeInsets.only(top: 200, left: 30),
      decoration: new BoxDecoration(
        color: Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 20.0)
          )
        ]
      ),
    );

    return Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        color: new Color(0xffffff),
        child: new Stack(
          children: <Widget>[
            _getBackground(),
            optionCard,
            _getActionsWidgets(context),
            _getToolbar(context)
          ]
        ),
      ),
    );
  }
}