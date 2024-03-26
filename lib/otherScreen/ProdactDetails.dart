import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';
import '../animations/bottomAnimation.dart';
import 'backBtnAndImage.dart';
import 'doctorAbout.dart';

class ProdactDetails {
  ProdactDetails._();

  static Future<void> openMap(String location) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$location';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}

class ProdactDetails2 extends StatefulWidget {
  final DocumentSnapshot snapshot;
  final String doctorName;

  ProdactDetails2({required this.snapshot, required this.doctorName});

  @override
  _MedDetailsState createState() => _MedDetailsState();
}

class _MedDetailsState extends State<ProdactDetails2> {
  var location = new Location();
  var currentLocation = LocationData;
  late Map<String, dynamic> data;
  mmh(){
    data=this.widget.snapshot.data() as Map<String, dynamic>;
 }
  @override
  Widget build(BuildContext context) {
    mmh();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top: height * 0.02),
                width: width * 0.75,
                child: Opacity(
                    opacity: 0.3,
                    child: Row(
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/pill.png'),
                          height: height * 0.1,
                        ),
                        Image(
                          image: AssetImage('assets/syrup.png'),
                          height: height * 0.1,
                        ),
                        Image(
                          image: AssetImage('assets/tablets.png'),
                          height: height * 0.07,
                        ),
                        Image(
                          image: AssetImage('assets/injection.png'),
                          height: height * 0.07,
                        )
                      ],
                    )),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BackBtn(),
                Container(
                    width: width,
                    margin:
                    EdgeInsets.fromLTRB(width * 0.025, 40, width * 0.025, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                             Text(
                             data['Name'],
                               style: GoogleFonts.abel(fontSize: height * 0.06),
                             ),
                          ],
                        ),


                        Container(
                          width: width,
                          height: height * 0.3,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(8)),
                          child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(width * 0.025, 10, width * 0.025, 0),
                                child: Image(image:
                                NetworkImage( data['url'])
                                  ,height: 230.0,),
                              )
                               // data['Dose'],
                              
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Medicine: ',
                              style: TextStyle(fontSize: height * 0.03),
                            ),
                            WidgetAnimator(
                              Text(
                                data['Name'],
                                style: GoogleFonts.averageSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 0.03),
                              ),
                            ),
                          ],
                        ),


                        SizedBox(
                          height: height * 0.01,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              'Descrbtion: ',
                              style: TextStyle(fontSize: height * 0.02),
                            ),
                            WidgetAnimator(
                              Container(
                                margin: EdgeInsets.fromLTRB(5.0,8,2.0,0),
                                width: 550
                                ,child: Text(
                                data['Descrbtion'],
                                style: GoogleFonts.averageSans(
                                    fontWeight: FontWeight.w100,
                                    fontSize: height * 0.02),
                                overflow: TextOverflow.ellipsis,
                              ),

                              ),

                            ),

                          ],
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        WidgetAnimator(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.warning,
                                size: height * 0.02,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Text(
                                'See a Doctor if condition gets Worse!',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                          child: SizedBox(
                            width: width,
                            height: height * 0.075,
                            child: ElevatedButton(
                              onPressed: () {
                                ProdactDetails.openMap('Pharmacy near me');
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    WidgetAnimator(Image.asset(
                                      'assets/mapicon.png',
                                      height: height * 0.045,
                                    )),
                                    SizedBox(width: width * 0.01),
                                    Text(
                                      'Search Nearest Pharmacy',
                                      style: TextStyle(
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.bold,
                                          fontSize: height * 0.021),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
