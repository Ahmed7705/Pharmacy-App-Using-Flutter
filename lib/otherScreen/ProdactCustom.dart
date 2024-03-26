import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

import '../PageMain/PageMain.dart';
import '../doctor/doctorLogin.dart';
import '../Model/gloals.dart';
import '../patient/products_page.dart';
import 'ProdactDetails.dart';
import 'medDetails.dart';

class CustomTileProdact extends StatefulWidget {
  final bool delBtn;
  final bool fa;
  late final DocumentSnapshot snapshot;


  CustomTileProdact({required this.delBtn, required this.snapshot, required this.fa});

  @override
  _CustomTileState createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTileProdact> {
  late String currentUser;
  QuerySnapshot? qn ;
  late Map<String, dynamic> data;
  late Map<String, dynamic>favo={};
  bool vi=fa;

  Future getDiseaseInfo() async {
    vi=fa;
    var firestore = FirebaseFirestore.instance.collection('medi');
    qn = await firestore.get();
    var mmm=qn?.docs;
    for (var queryDocumentSnapshot in mmm!) {
      Object? data = queryDocumentSnapshot.data();

    }


    return qn?.docs;
  }


  FavoitUpdate(String id ,bool state) {

    FirebaseFirestore.instance
        .collection('medi')
        .doc(id)
        .set(
        {'Name':data['Name'],
          'Descrbtion':data['Descrbtion'],
          'Dose':data['Dose'],
          'tybe':data['tybe'],
          'url':data['url'],
          'favorite':state,
          'Newly':false


        });
  //  Toast.show('$state', backgroundColor: Colors.blue, backgroundRadius: 5,duration: 2);
    getDiseaseInfo();
    setState(() {
//      super.build(widget.context2);
      initState();
    });

  }
void initState(){


  getDisease();
}
  getDisease(){
 data=this.widget.snapshot.data()as Map<String, dynamic>;

  }

  ProductsPage xx=ProductsPage(detailsUser: details);
Key key1=UniqueKey();
  var ic=Icons.star_border;
  var col=Colors.brown;
  void Rest1(){
    setState(() {
      key1=UniqueKey();
    });
  }
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    double height = MediaQuery.of(context).size.height;
    return KeyedSubtree(
      key:key1 ,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProdactDetails2(
                        snapshot: widget.snapshot, doctorName: 'Ahmed',
                      )
              )
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          height: height * 0.13,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            gradient: LinearGradient(colors: [
              Colors.white.withOpacity(0.3),
                   Colors.blueGrey.withOpacity(0.3)
            ]),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Positioned(
                left:0 ,
                  child:
                  Image(image: NetworkImage(data['url']),width:80)),

              Text(
                data['Name'],
                style: GoogleFonts.lato(fontSize: height * 0.03, letterSpacing: 2),
              ),

              Row(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        shape: CircleBorder(),
                      ),
                    onPressed: () {
                      setState(() {
                        fa=!fa;
                        FavoitUpdate(data['Name'],fa);

                        Rest1();

                      });

                      // Navigator.push(

                    },

                    child: Icon(
                      fa?Icons.favorite:Icons.favorite_border,
                      color: Colors.lightBlue[800],
                      size: height * 0.032,

                  )
                  ),
                ],
              ),




            ],
          ),
        ),
      ),
    );
  }

}

class DeletingWait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
      Toast.show("Deleted Successfully!", backgroundRadius: 5, backgroundColor: Colors.red, duration: 3);
    });
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.1,
                ),
                Text(
                  'Deleting Please Wait...',
                  style: TextStyle(color: Colors.red, fontSize: 17),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class CustomTileFavorits extends StatefulWidget {
  final bool delBtn;
  final bool fa;
  late final DocumentSnapshot snapshot;


  CustomTileFavorits({required this.delBtn, required this.snapshot, required this.fa});

  @override
  _CustomTileFavoritsState createState() => _CustomTileFavoritsState();
}

class _CustomTileFavoritsState extends State<CustomTileFavorits> {
  late String currentUser;
  QuerySnapshot? qn ;
  late Map<String, dynamic> data;
  late Map<String, dynamic>favo={};
  bool vi=fa;

  Future getDiseaseInfo() async {
    vi=fa;
    var firestore = FirebaseFirestore.instance.collection('medi');
    qn = await firestore.get();
    var mmm=qn?.docs;
    for (var queryDocumentSnapshot in mmm!) {
      Object? data = queryDocumentSnapshot.data();

    }


    return qn?.docs;
  }


  FavoitUpdate(String id ,bool state) {

    FirebaseFirestore.instance
        .collection('medi')
        .doc(id)
        .set(
        {'Name':data['Name'],
          'Descrbtion':data['Descrbtion'],
          'Dose':data['Dose'],
          'tybe':data['tybe'],
          'url':data['url'],
          'favorite':state,
          'Newly':false
        });
    //  Toast.show('$state', backgroundColor: Colors.blue, backgroundRadius: 5,duration: 2);
    getDiseaseInfo();
    setState(() {
//      super.build(widget.context2);
      initState();
    });

  }
  void initState(){


    getDisease();
  }
  getDisease(){
    data=this.widget.snapshot.data()as Map<String, dynamic>;

  }
// -------------- create this method to get the current user
//   Future<Null> _getCurrentUser() async {
//     var result = await firebaseHelper().getCurrentUser();
//
// //we notified that there was a change and that the UI should be rendered
//     setState(() {
//       currentUser = result;
//     });
//   }
  _deleteDisease(BuildContext context) {
    FirebaseFirestore.instance
        .collection('medi')
    //.doc('disName')
        .doc(data['Name'])
        .delete().then((value)
    {

    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DeletingWait()));
    setState(() {

    });
  }
  ProductsPage xx=ProductsPage(detailsUser: details);
  Key key1=UniqueKey();
  var ic=Icons.star_border;
  var col=Colors.brown;
  void Rest1(){
    setState(() {
      key1=UniqueKey();
    });
  }
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    double height = MediaQuery.of(context).size.height;
    return KeyedSubtree(
      key:key1 ,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProdactDetails2(
                        snapshot: widget.snapshot, doctorName: 'Ahmed',
                      )
              )
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          height: height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            gradient: LinearGradient(colors: [
              Colors.white.withOpacity(0.5),
              Colors.blueGrey.withOpacity(0.3)

            ]),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image(image: NetworkImage(data['url']),width:90),

              Text(
                data['Name'],
                style: GoogleFonts.lato(fontSize: height * 0.03, letterSpacing: 2),
              ),

              Row(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        shape: CircleBorder(),
                      ),
                      onPressed: () {
                        setState(() {
                          fa=!fa;
                          FavoitUpdate(data['Name'],fa);


                          Rest1();

                        });

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             MainPage(title: 'ali', detailsUser2: details,
                        //             )
                        //     )
                        // );
                      },

                      child: Icon(
                        fa?Icons.favorite:Icons.favorite_border,
                        color: Colors.lightBlue[800],
                        size: height * 0.032,

                      )
                  ),
                ],
              ),




            ],
          ),
        ),
      ),
    );
  }

}

class CustomNew extends StatefulWidget {
  final bool delBtn;
  final bool fa;
  late final DocumentSnapshot snapshot;


  CustomNew({required this.delBtn, required this.snapshot, required this.fa});

  @override
  _CustomTileNewitsState createState() => _CustomTileNewitsState();
}

class _CustomTileNewitsState extends State<CustomNew> {
  late String currentUser;
  QuerySnapshot? qn ;
  late Map<String, dynamic> data;
  late Map<String, dynamic>favo={};
  bool vi=fa;

  Future getDiseaseInfo() async {
    vi=fa;
    var firestore = FirebaseFirestore.instance.collection('medi');
    qn = await firestore.get();
    var mmm=qn?.docs;
    for (var queryDocumentSnapshot in mmm!) {
      Object? data = queryDocumentSnapshot.data();

    }


    return qn?.docs;
  }

  FavoitUpdate(String id ,bool state) {
coun1=0;
    FirebaseFirestore.instance
        .collection('medi')
        .doc(id)
        .set(
        {'Name':data['Name'],
          'Descrbtion':data['Descrbtion'],
          'Dose':data['Dose'],
          'tybe':data['tybe'],
          'url':data['url'],
          'favorite':state,
          'Newly':false

        });
    //  Toast.show('$state', backgroundColor: Colors.blue, backgroundRadius: 5,duration: 2);
    getDiseaseInfo();
    setState(() {
//      super.build(widget.context2);
      initState();
    });

  }

  NewUpdate(String id ) {

    FirebaseFirestore.instance
        .collection('medi')
        .doc(id)
        .set(
        {'Name':data['Name'],
          'Descrbtion':data['Descrbtion'],
          'Dose':data['Dose'],
          'tybe':data['tybe'],
          'url':data['url'],
          'favorite':data['favorite'],
          'Newly':false

        });
    //  Toast.show('$state', backgroundColor: Colors.blue, backgroundRadius: 5,duration: 2);
    getDiseaseInfo();
    setState(() {
//      super.build(widget.context2);
      initState();
    });

  }
  void initState(){

    getDisease();
  }
  getDisease(){
    data=this.widget.snapshot.data()as Map<String, dynamic>;

  }
// -------------- create this method to get the current user
//   Future<Null> _getCurrentUser() async {
//     var result = await firebaseHelper().getCurrentUser();
//
// //we notified that there was a change and that the UI should be rendered
//     setState(() {
//       currentUser = result;
//     });
//   }
  _deleteDisease(BuildContext context) {
    FirebaseFirestore.instance
        .collection('medi')
    //.doc('disName')
        .doc(data['Name'])
        .delete().then((value)
    {

    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DeletingWait()));
    setState(() {

    });
  }
  Key key1=UniqueKey();
  var ic=Icons.star_border;
  var col=Colors.brown;
  void Rest1(){
    setState(() {
      key1=UniqueKey();
    });
  }
  @override
  Widget build(BuildContext context) {
    NewUpdate( data['Name']);
    coun1=0;
    ToastContext().init(context);
    double height = MediaQuery.of(context).size.height;
    return KeyedSubtree(

      key:key1 ,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProdactDetails2(
                        snapshot: widget.snapshot, doctorName: 'Ahmed',
                      )
              )
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          height: height * 0.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            gradient: new LinearGradient(colors: [
              Colors.blueAccent.withOpacity(0.1),
              !widget.delBtn
                  ? Colors.blueGrey.withOpacity(0.2)
                  : Colors.redAccent.withOpacity(0.2),
            ]),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image(image: NetworkImage(data['url'])),

              Text(
                data['Name'],
                style: GoogleFonts.lato(fontSize: height * 0.03, letterSpacing: 2),
              ),

              Row(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        shape: CircleBorder(),
                      ),
                      onPressed: () {
                        setState(() {
                          fa=!fa;
                          FavoitUpdate(data['Name'],fa);
                          Rest1();

                        });
                      },

                      child: Icon(
                        fa?Icons.favorite:Icons.favorite_border,
                        color: Colors.lightBlue[800],
                        size: height * 0.032,

                      )
                  ),
                  Icon(Icons.fiber_new_outlined,
                      color:Colors.blue[800],
                    size: height * 0.062,
                  ),

                ],
              ),




            ],
          ),
        ),
      ),
    );
  }

}