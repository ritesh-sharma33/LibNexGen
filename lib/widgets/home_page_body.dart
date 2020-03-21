import 'package:flutter/material.dart';
import 'package:qr_code/pages/circulation_center_page.dart';
import 'package:qr_code/pages/reading_room_page.dart';
import 'package:qr_code/widgets/slide_routing_animation.dart';

class HomePageBody extends StatelessWidget {

  Widget _buildReadingRoomCard(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: deviceHeight * 0.45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReadingRoomPage())
              );
            },
            child: Stack(
              children: <Widget>[
                Container(
                  height: deviceHeight * 0.3,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                          image: AssetImage('assets/images/reading_room.jpg')
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: deviceHeight * 0.125),
                  alignment: Alignment.center,
                  child: Text(
                    'Reading Room',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 29
                    ),
                  ),
                )
              ],
            )
        ),
      ),
    );
  }

  Widget _buildLibraryCard(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: deviceHeight * 0.45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          onTap: () {
            Navigator.push(context, SlideRoutingAnimation(page: CirculationCenterPage()));
          },
          child: Stack(
            children: <Widget>[
              Container(
                height: deviceHeight * 0.3,
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                        image: AssetImage('assets/images/library.jpg')
                    )
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: deviceHeight * 0.125),
                alignment: Alignment.center,
                child: Text(
                  'Circulation Center',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 29
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildLibraryCard(context),
          _buildReadingRoomCard(context)
        ],
      )
    );
  }
}