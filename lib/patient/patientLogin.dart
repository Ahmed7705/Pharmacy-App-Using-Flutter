import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medkit/patient/patientPanel.dart';
import 'package:toast/toast.dart';
import '../Model/DoctorDetails.dart';
import '../PageMain/PageMain.dart';
import '../animations/bottomAnimation.dart';
import '../animations/fadeAnimation.dart';
import '../doctor/Login.dart';
import '../doctor/doctorLogin.dart';
import '../Model/utils.dart';
import '../Model/gloals.dart';


class PatientLogin extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuth _firebaseAuth2 = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  Future<User> _signIn(BuildContext context) async {

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

    User userDetails =  await FirebaseAuth.instance
        .signInWithCredential(credential).
    then((authResult){
      print(authResult.user);

        ProviderDoctorDetails providerInfo = new ProviderDoctorDetails(authResult.user?.uid.toString());
      print(providerInfo.toString());
      List<ProviderDoctorDetails> providerData = <ProviderDoctorDetails>[];

      providerData.add(providerInfo);
    details =  PatientDetails(
          authResult.user?.uid.toString(),
          authResult.user?.displayName,
          authResult.user?.photoURL,
          authResult.user?.email,
          providerData
      );
      print ('#####################################################################################');
      print ('#####################################################################################');

      print(details.userName);
      Navigator.push(
              context,
               new MaterialPageRoute(
                  builder: (context) => MainPage(
                        detailsUser2: details, title: 'Safety',

                  )
              )
           );
    }
    )as User;
    // User userDetails =
    //     await _firebaseAuth.signInWithCredential(credential);
    // ProviderDoctorDetails providerInfo =
    //     new ProviderDoctorDetails(userDetails.uid);
    // print ('#####################################################################################');

    // List<ProviderDoctorDetails> providerData ;
    // providerData.add(providerInfo);
    //
    // PatientDetails details = new PatientDetails(
    //   userDetails.uid,
    //   userDetails.displayName,
    //   userDetails.photoURL,
    //   userDetails.email,
    //   providerData,
    // );
    //
    // Navigator.push(
    //     context,
    //     new MaterialPageRoute(
    //         builder: (context) => PatientPanel(
    //               detailsUser: details,
    //
    //         )
    //     )
    // );

    return userDetails;
  }
  void checkInternt() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
      else{
        Toast.show(
            "وين النت",
            backgroundColor: Colors.red,
            backgroundRadius: 6,
            duration: Toast.lengthLong);
      }
    } on SocketException catch (_) {

    }
  }
  initState(){
    checkInternt();
  }
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360.5;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(

      body: Stack(
        children: <Widget>[
          FadeAnimation(
            1,
             Container(
                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0.5*fem, 1.5*fem+96),
                decoration: BoxDecoration (
                  image: DecorationImage (
                    fit: BoxFit.contain,
                    image: AssetImage (
                      'images/vector-3-i4v.png',

                    ),
                  ),
                )),
          ),
          FadeAnimation(
            1,
             Container(
              width: width,
              height: height,
              margin: EdgeInsets.fromLTRB(
                  width * 0.05, 0, width * 0.05, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        width * 0.08+120, height*0.2, width * 0.05,0),
                    child: Column(
                      children: [
                        Text(
                          'Sign-In',
                          textAlign: TextAlign.center,
                          style: SafeGoogleFont (
                            'Kurale',
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                            height: 1,
                            color: Color(0xffffffff),
                          ),

                        ),
                        Center(
                          child: Align(
                            child: SizedBox(
                              width: 190*fem,
                              height: 50*fem,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: SafeGoogleFont (
                                    'Kurale',
                                    fontSize: 40*ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.4780000051*ffem/fem,
                                    color: Color(0xffffffff),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Pati',
                                      style: SafeGoogleFont (
                                        'Kurale',
                                        fontSize: 40*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.4775*ffem/fem,
                                        color:  Colors.white70,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'ent',
                                      style: SafeGoogleFont (
                                        'Kurale',
                                        fontSize: 48*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.4775*ffem/fem,
                                        color: Color(0xff302121),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0, 70, width * 0.05,0),
                    child: Text(
                      'Features',
                      style: SafeGoogleFont (
                        'Kurale',
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        height: 3,
                        color: Colors.lightBlue[800],
                      ),
                    ),
                  ),
                  Text(
                    '1. Details about different Diseases/Medicines'
                        '\n2. Add your favorite Doctors'
                        '\n3. Request to add Disease/Medicine'
                        '\n4. Report incorrect Disease/Medicine'
                        '\n5. Search for Nearest Pharmacy'
                        '\n6. Feeback/Complains',
                     style:  SafeGoogleFont (
                       'Kurale',
                       fontSize: 15,
                       fontWeight: FontWeight.w600,
                       height: 1.5,
                       color: Colors.lightBlue[800]?.withOpacity(0.7),
                     ),
                    //   (
                  //       color: Colors.black.withOpacity(0.5),
                  //       height: height * 0.002),
                  // )
                  ),
                  SizedBox(
                    height: height * 0.02+150,
                  ),

                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: height * 0.0),
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.white,
                  //       shape: StadiumBorder(),
                  //     ),
                  //
                  //     onPressed: () {
                  //       _signIn(context);
                  //     },
                  //
                  // ),
                  // )
                ]

              ),
            ),
          ),
          WidgetAnimator(

            Stack(
              children: [
                Positioned(
                  // group2nq4 (1:54)
                  left: width*0.51,
                  top: height*0.85,
                  child: WidgetAnimator(
                    Container(
                      width: width*0.4,
                      height: 55*fem,
                      decoration: BoxDecoration (
                        borderRadius: BorderRadius.circular(15*fem),
                      ),
                      child: Center(
                        // rectangle67cS (1:48)
                        child: SizedBox(
                          width: double.infinity,
                          height: 55*fem,
                          child: Container(
                            decoration: BoxDecoration (
                              borderRadius: BorderRadius.circular(15*fem),
                              color: Color(0xff0b65b8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  // group3Ewx (1:55)
                  left: width*0.03,
                  top: height*0.85,
                  child: Container(
                    width: 300*fem,
                    height: 55*fem,
                    decoration: BoxDecoration (
                      borderRadius: BorderRadius.circular(15*fem),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        WidgetAnimator(
                          Container(
                            // autogrouptfkmkfQ (2W5GgZJhQC249QFUK3TfKm)
                            margin: EdgeInsets.fromLTRB(0*fem+5, 0*fem, 54*fem, 0*fem),
                            width: 148*fem,
                            height: double.infinity,
                            decoration: BoxDecoration (
                              color: Color(0xff302121),
                              borderRadius: BorderRadius.circular(15*fem),
                            ),
                            child: Center(
                              child: Center(
                                child: TextButton(

                                  child: Text(  'Back',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont (
                                      'Kurale',
                                      fontSize: 20*ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.4775*ffem/fem,
                                      color: Color(0xffffffff),
                                    ), ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(

                          child: Container(
                            margin: EdgeInsets.fromLTRB(0*fem, 0, 0*fem, 0*fem),
                            child: TextButton(
                              child: Text(
                                'Sign-Up',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont (
                                  'Kurale',
                                  fontSize: height*0.03,
                                  fontWeight: FontWeight.w400,
                                  height: 1,
                                  color: Color(0xffffffff),
                                ),),
                              onPressed: () {
                                checkInternt();
                                _signIn(context);


                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: height * 0.15 -120),
              width: width,
              height: height * 0.06,
              child: WidgetAnimator(
                Text(
                  '"The Job You are Struggling for will replace \nYou within a week if you found dead.'
                  '\nTake care of yourself!"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: height * 0.014,
                      color: Colors.black.withOpacity(0.3),
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PatientDetails {
  final String ?providerDetails;
  final String ?userName;
  final String? photoUrl;
  final String? userEmail;
  final List<ProviderDoctorDetails> ?providerData;

  PatientDetails(this.providerDetails, this.userName, this.photoUrl,
      this.userEmail, this.providerData);
}

class ProviderPatientDetails {
  ProviderPatientDetails(this.providerDetails);

  final String providerDetails;
}
