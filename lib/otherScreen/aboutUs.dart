import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Model/utils.dart';
import '../animations/bottomAnimation.dart';
import '../animations/fadeAnimation.dart';
import 'backBtnAndImage.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Container(
        height: 130.0,
        decoration: const BoxDecoration(
            color: Color(0xff0277bd),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0)
            )

        ),
          child:  Row(
            children: [
              BackBtn(),
              SizedBox(
                width: 20,
              ),
              Center(
                child: Text(
                'About Us',
                style: SafeGoogleFont (
                    'Kurale',
                    fontSize: 60,
                    fontWeight: FontWeight.w600,
                    height: 2.6,
                    color:  Colors.white
                )),
              ),
            ],
          ),  ),
          SizedBox(
            height: height * 0.08,
          ),
          Center(
            child: Column(
              children: <Widget>[

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      'assets/dscn.png',
                      height: height * 0.15,
                    ),
                    FadeAnimation(
                      1, Text(
                        'Developer Student Club',
                        textAlign: TextAlign.center,
                        style: SafeGoogleFont (
                            'Kurale',
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            height: 1,
                            color:  Colors.lightBlue[800]
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.05,),
                    FadeAnimation(
                      2, Text('Developed By: ', style: SafeGoogleFont (
                          'Kurale',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          height: 1,
                          color:  Colors.brown
                      ) ,),
                    ),
                    const SizedBox(
                      height: 12,
                    ),

                    FadeAnimation(
                     3, Text('Ahmed Alhadadi'
                          , textAlign: TextAlign.center,
                        style: SafeGoogleFont (
                            'Kurale',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1,
                            color:  Colors.lightBlue[800]
                        ),),
                    ),
                    FadeAnimation(
                     4, Text(
                          'Gobran Hakim'
                          , textAlign: TextAlign.center,
                        style: SafeGoogleFont (
                            'Kurale',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1,
                            color:  Colors.lightBlue[800]
                        ),),
                    ),
                    FadeAnimation(
                     5, Text(
                          'Al-motasem Al-rashdi'

                          , textAlign: TextAlign.center,
                        style: SafeGoogleFont (
                            'Kurale',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1,
                            color:  Colors.lightBlue[800]
                        ),),
                    ),
                    FadeAnimation(
                     6, Text('Hashem Al-taweel'
                          , textAlign: TextAlign.center,
                        style: SafeGoogleFont (
                            'Kurale',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1,
                            color:  Colors.lightBlue[800]
                        ),),
                    ),
                    SizedBox(height: height * 0.05,),
                    WidgetAnimator(
                        Text('Doctor : ', style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.brown),)),
                    SizedBox(height: height * 0.008,),

                    WidgetAnimator(
                       Text('Amal Aziz' ,style: SafeGoogleFont (
                        'Kurale',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                        color:Colors.lightBlue[800]
                      ),),
                    ),
                    SizedBox(height: height * 0.15-50,),
                    WidgetAnimator(
                       Image.asset(
                        'assets/cui.png',
                        height: height * 0.1,
                      ),
                    ),
                    WidgetAnimator(
                       Text('Dhamar University, Dhamar',
                          style: SafeGoogleFont (
                              'Kurale',
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                              color:Colors.black
                          ),),
                    ),
                    WidgetAnimator(
                       Text('@Copyrights All Rights Reserved, 2023',
                          style: SafeGoogleFont (
                              'Kurale',
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              height: 1.3,
                              color:Colors.black
                          ),),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
