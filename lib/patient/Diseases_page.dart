import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../animations/bottomAnimation.dart';
import '../otherScreen/customListTiles.dart';
import '../patient/patientLogin.dart';

class DisePage extends StatefulWidget {
  GlobalKey<ScaffoldState> ?scaffoldKey;
  final PatientDetails detailsUser;

  DisePage({Key? key,this.scaffoldKey ,required this.detailsUser}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<DisePage> {

  QuerySnapshot? qn ;
  bool Status=true;
  late String Sername ;
  Future SerDiseaseInfo() async {

    var firestore = FirebaseFirestore.instance.collection('Diseases');

    qn = await firestore.where("disName",isGreaterThanOrEqualTo: Sername).get();

    print(qn?.docs.length);
    return qn?.docs;
  }

  Future getDiseaseInfo() async {
    CollectionReference cool= FirebaseFirestore.instance.collection("Diseases");
     qn = await cool.get();


    return qn?.docs;

  }

  Future  gebtnndata() async{
    var collection = FirebaseFirestore.instance.collection('Diseases');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();

    }
return querySnapshot.docs;
  }


  bool editPanel = false;
  bool remove = false;

   GlobalKey? _searchTextField;
  static late String barcodeScanRes;
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

  void scanBarcode() async {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#cedc00", "Cancel", true, ScanMode.DEFAULT);
    if (barcodeScanRes != "-1") {
      setState(() => {searchController.text = barcodeScanRes});
    }
  }



  @override
  Widget build(BuildContext context) {

    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
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


                ),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(
                    left: 0,
                    right: 0,
                    top: 0,
                  ),
                  child: Stack(
                    children: <Widget>[
                  FutureBuilder(
                    future:Status?getDiseaseInfo():SerDiseaseInfo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.transparent,
                        ),

                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return WidgetAnimator(
                            CustomTile(
                              delBtn: remove,
                              snapshot: qn?.docs[index] as  DocumentSnapshot,
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

  // void showSortDialog() async {
  //   await showDialog(
  //       context: context,
  //       builder: (context) {
  //         return SortDialog(
  //             listCategoriesName: listCategoriesName,
  //             listCategoriesVal: listCategoriesVal);
  //       }).then(
  //     (val) {
  //       setState(
  //         () {
  //           listCategoriesName.forEach(
  //             (v) {
  //               int index = listCategoriesName.indexOf(v);
  //               bool checkboxVal = listCategoriesVal[index];
  //               String label = "$v " + checkboxVal.toString();
  //               listChipLabel.add(label);
  //               listChipWidget.add(
  //                 Chip(
  //                   label: Text(label),
  //                   deleteIcon: Icon(Icons.close),
  //                   onDeleted: () {
  //                     setState(
  //                       () {
  //                         String lblChip = label;
  //                         int index = listChipLabel.indexOf(lblChip);
  //                         listChipWidget.removeAt(index);
  //                         listChipLabel.remove(lblChip);
  //                       },
  //                     );
  //                   },
  //                 ),
  //               );
  //             },
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
  //
  // void showSortBottomSheet() async {
  //   await showModalBottomSheet(
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(20), topRight: Radius.circular(20)),
  //     ),
  //     builder: (context) {
  //       return SortBottomSheet(listCategoriesName, listCategoriesVal);
  //     },
  //   ).then(
  //     (value) {
  //       // Scaffold.of(context).showSnackBar(SnackBar(
  //       //   content: Text("data"),
  //       // ));
  //       listChipLabel.clear();
  //       listChipWidget.clear();
  //       setState(
  //         () {
  //           listCategoriesName.forEach(
  //             (v) {
  //               int index = listCategoriesName.indexOf(v);
  //               bool checkboxVal = listCategoriesVal[index];
  //               String label = "$v " + checkboxVal.toString();
  //               listChipLabel.add(label);
  //               listChipWidget.add(
  //                 Chip(
  //                   label: Text(label),
  //                   deleteIcon: Icon(Icons.close),
  //                   onDeleted: () {
  //                     setState(
  //                       () {
  //                         String lblChip = label;
  //                         int index = listChipLabel.indexOf(lblChip);
  //                         listChipWidget.removeAt(index);
  //                         listChipLabel.remove(lblChip);
  //                       },
  //                     );
  //                   },
  //                 ),
  //               );
  //             },
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
}
