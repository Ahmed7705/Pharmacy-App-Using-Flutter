import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'medDetails.dart';

class CustomTile extends StatefulWidget {
  final bool delBtn;
  final DocumentSnapshot snapshot;

  CustomTile({required this.delBtn, required this.snapshot});

  @override
  _CustomTileState createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  late String currentUser;
  late Map<String, dynamic> data;
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
        .collection('Diseases')
    //.doc('disName')
     .doc(data['disName'])
        .delete().then((value)
    {
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DeletingWait()));
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    getDisease();
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MedDetails(
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
// image
            Text(
       data['disName'],
              style: GoogleFonts.lato(fontSize: height * 0.03, letterSpacing: 2),
            ),

            ElevatedButton(
              onPressed: () {
                widget.delBtn
                    ? _deleteDisease(context)
                    : Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            MedDetails(
                              snapshot: widget.snapshot, doctorName: 'Ahmed',
                            )));
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
              ),
              child: widget.delBtn
                  ? Icon(
                Icons.delete,
                color: Colors.red,
                size: height * 0.032,
              )
                  : Icon(
                Icons.arrow_forward_ios,
                color: Colors.black54,
                size: height * 0.032,
              ),
            )
          ],
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
