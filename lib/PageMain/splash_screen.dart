import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    return Timer(Duration(seconds: 3), navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/WelcomeScreen');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Safety",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,
                fontSize: 50),
              ),
              Loading(
                indicator: BallPulseIndicator(),
                size: 50,
                color: Colors.white,
              ),
            ],
          ),
      ),
    );
  }
}
