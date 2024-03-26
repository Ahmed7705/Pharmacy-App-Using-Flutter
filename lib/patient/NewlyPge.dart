import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../animations/bottomAnimation.dart';
import '../Model/gloals.dart';
import '../otherScreen/ProdactCustom.dart';
import '../patient/patientLogin.dart';

class NewProdactPage extends StatefulWidget {
  GlobalKey<ScaffoldState>? scaffoldKey;
  final PatientDetails detailsUser;

  NewProdactPage({Key? key, this.scaffoldKey ,required this.detailsUser}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<NewProdactPage> {

  QuerySnapshot? qn;

  Future SerDiseaseInfo() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot qn = await firestore.collection("medi").
    where("favorite", isEqualTo: Sername).get();
    print(qn.docs.length);
    return qn.docs;
  }

  Future getDiseaseInfo() async {
    var firestore = FirebaseFirestore.instance.collection('medi');
    qn = await firestore.where('Newly',isNotEqualTo:false).get();
    var mmm = qn?.docs;
    for (var queryDocumentSnapshot in mmm!) {
      Object? data = queryDocumentSnapshot.data();
    }
    return qn?.docs;
  }

  getmmdata() async {
    var collection = FirebaseFirestore.instance.collection('medi');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
    }
  }


  bool editPanel = false;
  bool remove = false;

  GlobalKey? _searchTextField;
  static late String barcodeScanRes;
  static late bool barcodeScanStatus;
  final searchController = TextEditingController();

  bool searchEnable = false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fillList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  static bool Status = false;
  static String ?Sername;

  void scanBarcode() async {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#cedc00", "Cancel", true, ScanMode.DEFAULT);
    if (barcodeScanRes != "-1") {
      setState(() => {searchController.text = barcodeScanRes});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                left: 10,
                right: 10,
                bottom: 5,
              ),
              child: Container(
                // margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: searchController,
                  key: _searchTextField,
                  textAlign: TextAlign.left,
                  cursorColor: Colors.grey[300],
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[700],
                  ),
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
                    prefixIcon: Icon(
                      Icons.search,
                      color: const Color(0xffF3F2F7),
                      size: 30,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10, vertical: 17),
                    hintText: "Search product",
                    hintStyle:
                    TextStyle(color: const Color(0xffF3F2F7)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: const Color(0xffF3F2F7), width: 2.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          width: 2.5, color: const Color(0xffF3F2F7)),
                    ),
                  ),
                  autofocus: false,
                  // onSubmitted: (String key) {
                  //
                  //     setState(() {
                  //       searchEnable = true;
                  //       Status=true;
                  //       Sername=key.toString();
                  //     });
                  //
                  // },

                  onChanged: (value) {
                    setState(() {
                      Status = false;
                      Sername = value.toString();
                    });
                  },
                  onEditingComplete: () {
                    setState(() {
                      Status = true;
                    });
                  },


                ),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(
                    left: 0,
                    right: 0,
                    top: 0,
                  ),
                  child: Stack(
                    children: <Widget>[
                      FutureBuilder(
                        future: !(Status) ? getDiseaseInfo() : SerDiseaseInfo(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.blue),
                              ),
                            );
                          } else {
                            return Container(
                              child: ListView.separated(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12),
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                      color: Colors.transparent,
                                    ),

                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  fa=snapshot.data[index]['favorite'];

                                  return WidgetAnimator(
                                    CustomNew(
                                      delBtn: remove,
                                      snapshot: qn?.docs[index] as DocumentSnapshot, fa:snapshot.data[index]['favorite'] as bool ,

                                    ),);
                                },
                              ),
                            );
                          }
                        },

                      ),


                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

}