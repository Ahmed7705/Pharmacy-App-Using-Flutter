import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toast/toast.dart';
import '../animations/bottomAnimation.dart';
import '../otherScreen/backBtnAndImage.dart';
import '../Model/utils.dart';
import 'doctorPanel.dart';

class DoctorLogin extends StatefulWidget {
  @override
  _DoctorLoginState createState() => _DoctorLoginState();
}

final _controllerName = TextEditingController();
final _controllerPhone = TextEditingController();
final _controllerCNIC = TextEditingController();

class _DoctorLoginState extends State<DoctorLogin> {
  //bool validatePhoneVar = false;
  bool validateCNICVar = false;
  bool validateName = false;


  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  Future<User> _signIn(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

    User userDetails = await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((authResult) {
      ProviderDoctorDetails providerInfo =
      ProviderDoctorDetails(authResult.user?.uid);
      List<ProviderDoctorDetails> providerData =
      <ProviderDoctorDetails>[];
      providerData.add(providerInfo);
      DoctorDetails details = DoctorDetails(
          authResult.user?.uid,
          authResult.user?.displayName,
          authResult.user?.photoURL,
          authResult.user?.email,
          providerData);
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => DoctorPanel( detailsUser: details,
              )));
    })as User;

    // (await _firebaseAuth.signInWithCredential(credential)) as User;
    ProviderDoctorDetails providerInfo =
    new ProviderDoctorDetails(userDetails.uid);

    List<ProviderDoctorDetails> providerData = [];
    providerData.add(providerInfo);

    //DoctorDetails details =  DoctorDetails(
    //       userDetails.uid,
    //       userDetails.displayName,
    //       userDetails.photoURL,
    //       userDetails.email,
    //       providerData,
    //     );
    // details.userName='Ahmed';
    // details.userEmail='mm770545327@gmail.com';
    // details.photoUrl=
    // 'https://t4.ftcdn.net/jpg/02/60/04/09/360_F_260040900_oO6YW1sHTnKxby4GcjCvtypUCWjnQRg5.jpg';
    // details.providerDetails='Ahmed Mohsen Alhdadi';
    print('#####################################################################################');
    print('#####################################################################################');
    print('#####################################################################################');
    print('#####################################################################################');
    print('#####################################################################################');
    print('#####################################################################################');
    // Navigator.push(
    //     context,
    //     new MaterialPageRoute(
    //         builder: (context) => DoctorPanel(
    //           detailsUser: details,
    //             )));

    return userDetails;
  }

  // Future<User> currentUser() async {
  //   final GoogleSignInAccount account = await _googleSignIn.signIn();
  //   final GoogleSignInAuthentication authentication =
  //   await account.authentication;
  //
  //   final GoogleAuthCredential credential = GoogleAuthProvider.credential(
  //       idToken: authentication.idToken,
  //       accessToken: authentication.accessToken);
  //
  //   final UserCredential authResult =
  //   await _auth.signInWithCredential(credential);
  //   final User user = authResult.user;
  //
  //   return user;
  // }
  controllerClear() {
    _controllerName.clear();
    _controllerPhone.clear();
    _controllerCNIC.clear();

    // details.userName='Ahmed';
    // details.userEmail='mm770545327@gmail.com';
    // details.photoUrl=
    // 'https://t4.ftcdn.net/jpg/02/60/04/09/360_F_260040900_oO6YW1sHTnKxby4GcjCvtypUCWjnQRg5.jpg';
    // details.providerDetails='Ahmed Mohsen Alhdadi';
  }

  validatePhone(String phone) {
    if (!(phone.length == 11) && phone.isNotEmpty) {
      return "Invalid Phone Number length";
    }
    return null;
  }

  validateCNIC(String idNumber) {
    if (!(idNumber.length == 13) && idNumber.isNotEmpty) {
      return "CNIC must be of 13-Digits";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final nameTextField = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      maxLength: 30,
      textInputAction: TextInputAction.next,
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: _controllerName,
      decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.08),

          filled: true,
          labelText: 'Enter Name',
          prefixIcon: WidgetAnimator(Icon(
              Icons.person,
              color: Colors.lightBlue[800]
          )),
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(20)))),
    );

    final cnicTextField = TextField(
      keyboardType: TextInputType.number,
      autofocus: false,
      maxLength: 13,
      controller: _controllerCNIC,
      onSubmitted: (_) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
          filled: true,
          errorText: validateCNIC(_controllerCNIC.text),
          fillColor: Colors.white.withOpacity(0.08),
          labelText: 'NIC Number',
          prefixIcon:
          WidgetAnimator(Icon(Icons.credit_card, color: Colors.lightBlue[800])),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
//###############
    getInfoAndLogin() {
      FirebaseFirestore.instance
          .collection('doctorInfo')
          .doc(_controllerName.text)
          .set({
        'cnic': _controllerCNIC.text,
      });

      _signIn(context)
          .then((User user) => print('Gmail Logged In'))
          .catchError((e) => print(e));
      controllerClear();
    }
    double baseWidth = 360.5;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: width,
            height: height,
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: _HeaderWavesPainter(),
                  ),
                ),
                Container(
                  width: width,
                  height: height,
                  margin:
                  EdgeInsets.fromLTRB(width * 0.03, 0, width * 0.03, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      Center(
                        // signinVfc (1:53)
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 10*fem+70),
                          width: double.infinity,
                          child: Text(
                            'Sign-In',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont (
                              'Kurale',
                              fontSize: 64*ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.4775*ffem/fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                      WidgetAnimator(
                        Center(
                          child: Align(
                            child: SizedBox(
                              width: 190*fem,
                              height: 71*fem,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: SafeGoogleFont (
                                    'Kurale',
                                    fontSize: 48*ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.4780000051*ffem/fem,
                                    color: Color(0xffffffff),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Welco',
                                      style: SafeGoogleFont (
                                        'Kurale',
                                        fontSize: 48*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.4775*ffem/fem,
                                        color:  Colors.lightBlue[800],
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'me',
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
                        ),),
                      Container(

                        child:  nameTextField,
                        //phoneTextField,
                      ),
                      //phoneTextField,
                      Container(
                        margin: EdgeInsets.fromLTRB(0*fem, 10, 0*fem, 50),

                        child:   cnicTextField,

                      ),

                      SizedBox(
                        width: width,
                        height: height * 0.25,
                        child:  Container(
                          // group4g1L (1:56)
                          margin: EdgeInsets.fromLTRB(1.5*fem, 0*fem, 18*fem, 0*fem),
                          width: double.infinity,
                          height: 55*fem,
                          decoration: BoxDecoration (
                            borderRadius: BorderRadius.circular(15*fem),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                // group2nq4 (1:54)
                                left: 171*fem,
                                top: 0*fem+10,
                                child: WidgetAnimator(
                                  Container(
                                    width: 148*fem,
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
                                left: 0*fem+4,
                                top: 0*fem+10,
                                child: Container(
                                  width: 303*fem,
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

                                                child: Text(
                                                  'Back',
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
                                        // signupEqU (1:52)
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(0*fem, 1*fem, 0*fem, 0*fem),
                                          child: TextButton(
                                            child: Text(
                                              'Sign-Up',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'Kurale',
                                                fontSize: 20*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.4775*ffem/fem,
                                                color: Color(0xffffffff),
                                              ),),
                                            onPressed: () {
                                              setState(() {
                                                _controllerCNIC.text.isEmpty
                                                    ? validateCNICVar = true
                                                    : validateCNICVar = false;
                                                _controllerName.text.isEmpty
                                                    ? validateName = true
                                                    : validateName = false;
                                              });
                                              !validateName & !validateCNICVar
                                                  ? getInfoAndLogin()
                                                  : Toast.show(
                                                  "Empty Field(s) Found!",
                                                  backgroundColor: Colors.red,
                                                  backgroundRadius: 5,
                                                  duration: Toast.lengthLong);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Center(
                                // doyouforgotyourpasswordNmL (1:44)
                                child: Container(
                                  margin:  EdgeInsets.fromLTRB(0, 30, 0,0),
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Text(   'Do you forgot your Nic ?',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont (
                                      'Kurale',
                                      fontSize: 15*ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.4775*ffem/fem,
                                      color: Color(0xff000000),
                                    )), onPressed: () {
                                    Toast.show(
                                        " حاول تتذكر",
                                        backgroundColor: Colors.red,
                                        backgroundRadius: 6,
                                        duration: Toast.lengthLong);

                                  },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height:10,
                      ),
                      SizedBox(
                        height: height * 0.2-160,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}


class _HeaderWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = Colors.lightBlue[800]!;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    final path = Path();

    path.lineTo(0, size.height * 0.35);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.40,
        size.width * 0.5, size.height * 0.30);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.20, size.width, size.height * 0.30);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DoctorDetails {

  String? providerDetails;
  String ?userName;
  String ?photoUrl;
  String ?userEmail;
  List<ProviderDoctorDetails>? providerData;

  DoctorDetails(this.providerDetails, this.userName, this.photoUrl,
      this.userEmail, this.providerData);
// DoctorDetails.fromJson(Map<String, dynamic> json) {
//   providerDetails = json['providerDetails'];
//   userName = json['userName'];
//   photoUrl = json['photoUrl'];
//   userEmail = json['userEmail'];
// }
// Map<String, dynamic> tomap() {
//   return {
//     providerDetails: 'providerDetails',
//     userName: 'userName',
//     photoUrl: 'photoUrl',
//     userEmail: 'userEmail',
//   };
// }
}

class ProviderDoctorDetails {
  ProviderDoctorDetails(this.providerDetails);

  final String? providerDetails;
}
