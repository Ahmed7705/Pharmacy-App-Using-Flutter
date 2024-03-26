import 'package:flutter/material.dart';

//This is the back button being used on almost every screen
class BackBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      margin: EdgeInsets.fromLTRB(
          0, MediaQuery.of(context).size.height * 0.05, 0, 0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            backgroundColor: Colors.lightBlue[800]
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: MediaQuery.of(context).size.height * 0.045,
          )),
    );
  }
}

//this is the big image at patient and doctor login screen
class ImageAvatar extends StatelessWidget {
  final String assetImage;

  ImageAvatar({required this.assetImage});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Positioned(
          top: height * 0.02,
          left: width - 350,
          child: Opacity(
            opacity: 0.80,
            child: CircleAvatar(
              radius: height * 0.18,
              backgroundColor: Colors.cyan[200],
              child: Image(
                image: AssetImage(assetImage),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
