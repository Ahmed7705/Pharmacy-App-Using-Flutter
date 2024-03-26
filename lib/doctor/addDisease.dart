import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

import '../Model/gloals.dart';
import '../animations/bottomAnimation.dart';
import '../otherScreen/backBtnAndImage.dart';
import '../Model/utils.dart';
import 'addProdact.dart';
class TabsExample extends StatelessWidget {
  final String doctorName;
  final String doctorEmail;
  const TabsExample({Key? key, required this.doctorName, required this.doctorEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final kTabPages = <Widget>[
      AddDisease(doctorName: doctorName, doctorEmail: doctorEmail,),
      AddProduct(doctorName: doctorName, doctorEmail: doctorEmail),
    ];
    final kTabs = <Tab>[
      const Tab(icon: Icon(Icons.production_quantity_limits), text: ' Add Disease'),
      const Tab(icon: Icon(Icons.medical_information), text: 'Add Product'),
    ];
    return DefaultTabController(
      length: kTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add More'),
          backgroundColor: Colors.lightBlue[800],
          bottom: TabBar(
            tabs: kTabs,
          ),
        ),
        body: TabBarView(
          children: kTabPages,
        ),
      ),
    );
  }
}


final controllerDisName = TextEditingController();
final controllerMedName = TextEditingController();
final controllerMedDose = TextEditingController();
final controllerDesc = TextEditingController();

class AddDisease extends StatefulWidget {
  final String doctorName;
  final String doctorEmail;
  AddDisease({ required this.doctorName, required this.doctorEmail});

  @override
  _AddDiseaseState createState() => _AddDiseaseState();
}

class _AddDiseaseState extends State<AddDisease> {
  bool validDisName = false;
  bool validMedName = false;
  bool validMedDose = false;
  bool validDesc = false;

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
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: WidgetAnimator(
              Image(
                image: AssetImage('assets/injection.png'),
                height: height * 0.04
              ),
            ),
          ),
          labelText: 'Disease Name',
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
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: WidgetAnimator(
              Image(
                image: AssetImage('assets/tablets.png'),
                height: height * 0.04,
              ),
            ),
          ),
          labelText: 'Medicine Name',
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
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: WidgetAnimator(
              Image(
                image: AssetImage('assets/pill.png'),
                height: height * 0.04,
              ),
            ),
          ),
          labelText: 'Medicine Dose',
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
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: WidgetAnimator(
              Image(
                image: AssetImage('assets/steth.png'),
                height: height * 0.04,
              ),
            ),
          ),
          labelText: 'Description',
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    controllerClear() {
      controllerDisName.clear();
      controllerMedName.clear();
      controllerMedDose.clear();
      controllerDesc.clear();
    }

    addingDisease () {
      coun1++;

      FirebaseFirestore.instance
          .collection('Diseases')
          .doc(controllerDisName.text)
          .set({
        'disName': controllerDisName.text,
        'medName': controllerMedName.text,
        'medTime': controllerMedDose.text,
        'medDesc': controllerDesc.text,
        'post' : widget.doctorName,
        'docEmail' : widget.doctorEmail,
        'favorite' : false,
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
              Toast.show("Empty Field(s) Found!",
                  backgroundColor: Colors.red,
                  backgroundRadius: 5, duration: 2);
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
            ),          ),
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
                          'Disease',
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
                    height: height * 0.04,
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
