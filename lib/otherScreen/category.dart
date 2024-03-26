import 'dart:io';
import 'package:flutter/material.dart';
import '../animations/bottomAnimation.dart';
import '../animations/fadeAnimation.dart';
import '../Model/utils.dart';


class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: new Text(
                "Exit Application",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: new Text("Are You Sure?"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: StadiumBorder(),
                  ),
                  child: new Text(
                    "No",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: StadiumBorder(),
                  ),
                  child: new Text(
                    "Yes",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    exit(0);
                  },
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            FadeAnimation(
              0.3,
              Container(
                height: 320.0,
                decoration: const BoxDecoration(
                  color: Color(0xff0277bd),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0)
                  )
                ),
                child: Container(
                  margin: EdgeInsets.fromLTRB(12,0, 12, 0) ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Category',
                        style:  SafeGoogleFont (
                          'Kurale',
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          height: 1,
                          color: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white70,
                          shape: StadiumBorder(),
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/AboutUs'),
                        child: Icon(
                          Icons.info,
                          size: height * 0.04,
                          color: Colors.lightBlue[800],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.12),
            Column(
              children: [
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.cyan.withOpacity(0.2),
                            radius: height * 0.075,
                            child: Image(
                              image: AssetImage("assets/doctor.png"),
                              height: height * 0.2,
                            ),
                          ),
                          WidgetAnimator(patDocBtn('Doctor', context)),
                        ],
                      ),
                    ),

                    SizedBox(
                      width: 40),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.cyan.withOpacity(0.2),
                          radius: height * 0.075,
                          child: Image(
                            image: AssetImage("assets/patient.png"),
                            height: height * 0.2,
                          ),
                        ),
                        WidgetAnimator(patDocBtn('Patient', context)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 150,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Version',
                      style:  SafeGoogleFont (
                        'Kurale',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1,
                        color: Colors.lightBlue[800],
                      ),
                      //TextStyle(fontWeight: FontWeight.bold,color: Colors.lightBlue[800]),
                    ),
                    Text(
                      'V 0.1',
                      style: SafeGoogleFont (
                        'Kurale',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 2,
                        color: Colors.lightBlue[900],
                      ),
                     // TextStyle(fontSize: 12 ,color: Colors.lightBlue[800]),
                    )
                  ],
                ),
                SizedBox(
                  height: 2,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget patDocBtn(String categoryText, context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05+2,
      width: MediaQuery.of(context).size.width * 0.4-15,
      child: ElevatedButton(
        onPressed: () {
          if (categoryText == 'Doctor') {
            Navigator.pushNamed(context, '/DoctorLogin');
          } else {
            Navigator.pushNamed(context, '/PatientLogin');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:  Colors.lightBlue[800],
          shape: StadiumBorder(),
        ),
        child: Text("I am " + categoryText,
        style: SafeGoogleFont (
          'Kurale',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1,
          color: Colors.white,
        ),
        ),
      ),
    );
  }
}
