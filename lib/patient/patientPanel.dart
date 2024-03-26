import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medkit/patient/patientLogin.dart';
import 'package:medkit/patient/patientProfile.dart';
import '../animations/bottomAnimation.dart';
import '../animations/fadeAnimation.dart';
import '../Model/gloals.dart';
import '../otherScreen/customListTiles.dart';

class PatientPanel extends StatefulWidget {
  PatientDetails  detailsUser=details;

  PatientPanel({Key? key}) : super(key: key);


  @override
  _PatientPanelState createState() => _PatientPanelState();
}
String? disName;
String ?docEmail;
String ?medDesc;
String ?medName;
String ?medTime;
String ?post;
class _PatientPanelState extends State<PatientPanel> {

  Future SerDiseaseInfo() async {

    var firestore = FirebaseFirestore.instance;

    QuerySnapshot qn = await firestore.collection("Diseases").get();


    return qn.docs;
  }
  Future getDiseaseInfo() async {
    CollectionReference cool= FirebaseFirestore.instance.collection("Diseases");
    QuerySnapshot qn = await cool.where("disName",isGreaterThanOrEqualTo: Sername).get();
    var mmm=qn.docs;


    return qn.docs;

  }


  final GoogleSignIn _gSignIn = GoogleSignIn();



  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
        ),
        title: const Text(
          "Are You Sure?",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text("You are about to Log Out!"),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,

            ),
            child: const Text(
              "Close",
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            child: const Text(
              "Log Out",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              _gSignIn.signOut();
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);
            },
          ),
        ],
      ),
    )) ??
        false;
  }
  final searchController = TextEditingController();

  static late String barcodeScanRes;
  static late bool barcodeScanStatus;
  static  bool Status=false;
  static String ?Sername ;

  void scanBarcode() async {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#cedc00", "Cancel", true, ScanMode.DEFAULT);
    if (barcodeScanRes != "-1") {
      setState(() => {searchController.text = barcodeScanRes});
    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                width: width,
                margin: EdgeInsets.fromLTRB(0, height * 0.03, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GestureDetector(onTap: () => Navigator.of(context).pop(true),
                        child: Icon(Icons.arrow_back, size: height * 0.04,)),
                    SizedBox(width: width * 0.02,),
                    Container(
                      width: width * 0.7,
                      height: height * 0.052,
                      child: WidgetAnimator(
                        TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          onChanged:(value) {
                                setState(() {
                                  Status=true;
                               Sername=value.toString();
                                });
                          },
                          onEditingComplete: (){
                            setState(() {
                              Status=false;
                            });
                          },
                          controller: searchController,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: scanBarcode,
                                icon: Image(
                                  image: AssetImage(
                                      'images/001-barcode-scanner.png'),
                                  color: Colors.grey,
                                ),
                                focusColor: Colors.grey,
                                iconSize: 25,
                                hoverColor: Colors.grey,
                              ),
                              focusColor: Colors.grey[700],
                              hoverColor: Colors.grey[700],
                              labelText: 'Disease/Medicine',
                              prefixIcon: WidgetAnimator(Icon(
                                Icons.search,
                                size: height * 0.03,
                              )),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.02,),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  PatientProfile(
                                doctorDetails: widget.detailsUser,
                              )
                          )
                      ),
                      child: Hero(
                        tag: 'patPic',
                        child: CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.2),
                            backgroundImage:
                            NetworkImage(widget.detailsUser.photoUrl.toString())),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: height * 0.1,
                width: width * 0.35,
                  margin: EdgeInsets.fromLTRB(
                      width * 0.21, height * 0.15, 0, 0),
                  child: FadeAnimation(
                    0.3,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Patient's",
                          style: GoogleFonts.abel(
                              fontSize: height * 0.04,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Panel',
                          style: TextStyle(
                              fontSize: height * 0.025),
                        )
                      ],
                    ),
                  )),
              FutureBuilder(
                future: Status?getDiseaseInfo():SerDiseaseInfo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: WidgetAnimator(
                        CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      margin: EdgeInsets.fromLTRB(
                          0, height * 0.32, 0, 0),
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10),
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.transparent,
                        ),
                        itemCount:snapshot.data.length ,//length
                        itemBuilder: (context, index) {
                          return WidgetAnimator(
                            CustomTile(
                              delBtn: false,
                              snapshot: snapshot.data[index],
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
              Positioned(
                  top: height * 0.087,
                  left: width - 180,
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(1.0),
                          Colors.black.withOpacity(1.0),
                          Colors.black.withOpacity(0.5),
                        ],
                      ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image(
                        height: height * 0.24,
                        image: AssetImage('assets/bigPat.png')),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
