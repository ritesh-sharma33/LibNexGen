import 'package:flutter/material.dart';
import 'package:qr_code/pages/show_records.dart';
import '../pages/student_sign_in.dart';
import '../pages/student_sign_out.dart';

class CardRow extends StatelessWidget {

  String option, description;
  CardRow({this.option, this.description});

  AssetImage _buildCardImage() {
    if (this.option == 'Student In') {
      return new AssetImage('assets/images/profile-icon.png');
    } else if (this.option == 'Student Out') {
      return new AssetImage('assets/images/profile-icon.png');
    } else if (option == 'Show Records') {
      return new AssetImage('assets/images/pie-chart.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    final optionThumbnail = new Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0)
      ),
      margin: new EdgeInsets.symmetric(
        vertical: 16.0
      ),
      alignment: FractionalOffset.centerLeft,
      child: new Image(
        image: _buildCardImage(),
        height: 92.0,
        width: 92.0,
      ),
    );
    final baseTextStyle = const TextStyle(
      fontFamily: 'Poppins'
    );

    final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 22.50,
      fontWeight: FontWeight.w600
    );

    final regularTextStyle = baseTextStyle.copyWith(
      color: const Color(0xff4d4d4d),
      fontSize: 9.0,
      fontWeight: FontWeight.w400
    );

    final subHeaderTextStyle = regularTextStyle.copyWith(
      fontSize: 12.0,
    );

    final optionCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        children: <Widget>[
          new Container(height: 4.0,),
          new Text(
            option, 
            style: headerTextStyle,
          ),
          new Container(height: 10.0,),
          new Text(
            description,
            style: subHeaderTextStyle,
          )
        ],
      ),
    );

    final optionCard = new Container(
      height: 124.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: Colors.green,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(10.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0)
          )
        ]
      ),
      child: optionCardContent,
    );

    return new GestureDetector(
      onTap: () {
        if (option == 'Student In') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentSignInPage()
            )
          );
        } else if (option == 'Student Out') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentSignOutPage()
            )
          );
        } else if (option == 'Show Records') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowRecordsPage()
            )
          );
        }
      },
      child: new Container(
        margin: const EdgeInsets.only(
          top: 16.0,
          bottom: 16.0,
          left: 24.0,
          right: 24.0
        ),
        child: new Stack(
          children: <Widget>[
            optionCard,
            optionThumbnail,
          ],
        ),
      ),
    );
  }
}