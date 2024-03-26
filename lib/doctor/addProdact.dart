import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

import '../Model/gloals.dart';
import '../animations/bottomAnimation.dart';
import '../otherScreen/backBtnAndImage.dart';
import '../Model/utils.dart';


final controllerDisName = TextEditingController();
final controllerMedName = TextEditingController();
final controllerMedDose = TextEditingController();
final controllerDesc = TextEditingController();
final controllerImage = TextEditingController();

class AddProduct extends StatefulWidget {
  final String doctorName;
  final String doctorEmail;

  AddProduct({ required this.doctorName, required this.doctorEmail});

  @override
  _AddDiseaseState createState() => _AddDiseaseState();
}

class _AddDiseaseState extends State<AddProduct> {
  bool validDisName = false;
  bool validMedName = false;
  bool validMedDose = false;
  bool validDesc = false;

  static late String barcodeScanRes;
  void scanBarcode() async {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#cedc00", "Cancel", true, ScanMode.DEFAULT);
    if (barcodeScanRes != "-1") {
      setState(() => {controllerMedName.text = barcodeScanRes});
    }
  }
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final disNameTF = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: controllerDisName,
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          labelText: 'Prouduct Name',
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final medNameTF = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: controllerMedName,
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
      textInputAction: TextInputAction.next,
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

          labelText: ' Barcode',
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final medTimeTF = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: controllerMedDose,
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          labelText: 'Prodect Dose',
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final medDescTF = TextField(
      keyboardType: TextInputType.multiline,
      autofocus: false,
      controller: controllerDesc,
      maxLines: null,
      decoration: InputDecoration(

          labelText: 'Description',
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final disAmegTF = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: controllerImage,
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          labelText: 'Image url',
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );


    controllerClear() {
      controllerDisName.clear();
      controllerMedName.clear();
      controllerMedDose.clear();
      controllerDesc.clear();
      controllerImage.clear();
    }

    addingDisease () {
      coun1++;

      FirebaseFirestore.instance
          .collection('medi')
          .doc(controllerDisName.text)
          .set({
        'Name': controllerDisName.text,
        'tybe': controllerMedName.text,
        'Dose': controllerMedDose.text,
        'Descrbtion': controllerDesc.text,
        'url': controllerImage.text,
        'favorite':false,
        'Newly':true

      }

      );

      controllerClear();
      Toast.show('Added Successfully!',
          backgroundRadius: 5,backgroundColor: Colors.blue, duration: 3);
      Navigator.pop(context);
    }

    final addBtn = Container(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
              setState(() {
                controllerDisName.text.isEmpty ? validDisName = true : validDisName = false;
                controllerMedName.text.isEmpty ? validMedName = true : validMedName = false;
                controllerMedDose.text.isEmpty ? validMedDose = true : validMedDose = false;
                controllerDesc.text.isEmpty ? validDesc = true : validDesc = false;
              });
              !validDisName & !validMedName & !validMedDose & !validDesc ? addingDisease() :
              Toast.show("Empty Field(s) Found!", backgroundColor: Colors.red, backgroundRadius: 5, duration: 2);
          },
          child: Text(
            'Add',
            style:
            SafeGoogleFont (
              'Kurale',
              fontSize: 30,
              fontWeight: FontWeight.w500,
              height: 1,
              color: Colors.white,
            ),
          ),
        ));

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: width,
              margin: EdgeInsets.fromLTRB(width * 0.025, 0, width * 0.025, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: height * 0.05),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child:
                    Row(
                      children: <Widget>[
                        Text(
                          'Adding',
                          style: SafeGoogleFont (
                            'Kurale',
                            fontSize: 50,
                            fontWeight: FontWeight.w600,
                            height: 1,
                            color: Colors.lightBlue[800],
                          ),                        ),
                        SizedBox(
                            width: height * 0.015
                        ),
                        Text(
                          'Product',
                          style: SafeGoogleFont (
                            'Kurale',
                            fontSize: 50,
                            fontWeight: FontWeight.w600,
                            height: 1,
                            color: Color(0xff302121),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    'Enter the Following Information',
                    style:SafeGoogleFont (
                      'Kurale',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 1,
                      color: Color(0xff302121),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  disNameTF,
                  SizedBox(
                    height: height * 0.015,
                  ),
                  medNameTF,
                  SizedBox(
                    height: height * 0.015,
                  ),
                  medTimeTF,
                  SizedBox(
                    height: height * 0.015,
                  ),
                  medDescTF,
                  SizedBox(
                    height: height * 0.02,
                  ),
                  disAmegTF,
                  SizedBox(
                    height: height * 0.015,
                  ),
                  addBtn,
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
