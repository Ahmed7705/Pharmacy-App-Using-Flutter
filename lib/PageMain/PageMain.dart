
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../patient/NewlyPge.dart';
import 'rounded_container_widget.dart';
import 'custom_app_bar.dart';

import 'custom_navigation_drawer.dart';
import '../doctor/doctorLogin.dart';
import '../Model/gloals.dart';
import '../patient/Diseases_page.dart';
import '../patient/Favorits.dart';
import '../patient/patientLogin.dart';
import '../patient/patientPanel.dart';
import '../patient/products_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {

  MainPage({Key? key, required this.title,required this.detailsUser2}) : super(key: key);

  final String title;
  final PatientDetails detailsUser2;

  @override
  _MainPageState createState() => _MainPageState();
}
//details.userName='Ahmed';
// details.userEmail='mm770545327@gmail.com';
// details.photoUrl=
// 'https://t4.ftcdn.net/jpg/02/60/04/09/360_F_260040900_oO6YW1sHTnKxby4GcjCvtypUCWjnQRg5.jpg';
// details.providerDetails='Ahmed Mohsen Alhdadi';
class _MainPageState extends State<MainPage> {
  static GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static List<ProviderDoctorDetails> providerData = [];
  // static  PatientDetails detailsUser3=PatientDetails('Ahmed',
  //     'mm770545327@gmail.com',
  //     'https://t4.ftcdn.net/jpg/02/60/04/09/360_F_260040900_oO6YW1sHTnKxby4GcjCvtypUCWjnQRg5.jpg',
  //       'Ahmed Mohsen Alhdadi',
  //     providerData
  //
  // );
  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[
    Padding(
      padding: EdgeInsets.only(top: 15),
      child: ProductsPage(
         detailsUser:details,
      ),
    ),
    DisePage(detailsUser: details, scaffoldKey: _scaffoldKey,),
    Padding(
      padding: EdgeInsets.only(top: 15),
      child:
      FavoritPage(detailsUser: details, scaffoldKey: _scaffoldKey, ),
    ),
    Padding(
      padding: EdgeInsets.only(top: 15),
      child:
      NewProdactPage(detailsUser: details, scaffoldKey: _scaffoldKey, ),
    ),
  ];

  void  onItemTapped(int index) {
    setState(() {

        _selectedIndex = index;

    });
  }
  Icon icon2= const Icon(
      Icons.fiber_new,
          color:Colors.amber,
      size: 30
  );
  @override
  Widget build(BuildContext context) {
    scaffoldKey= _scaffoldKey;
    print("Application Launched");
    return Scaffold(
      backgroundColor:Colors.lightBlue[800] ,
      key: _scaffoldKey,
      appBar: CustomAppBar(
        scafKey: _scaffoldKey,
        barHeight: 80, detailsUser:details,
      ),
      drawer: SafeArea(child: CustomNavigationDrawer()),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.lightBlue[800],
        elevation: 8,
        // items: <BottomNavigationBarItem>[
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.home),
        //     label: "Home",
        //   ),
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.list),
        //     label: "Products",
        //   ),
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.history),
        //     label:"History",
        //   ),
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.add_shopping_cart),
        //     label:"New",
        //   ),
        // ],
        items: [
          const TabItem(icon: Icons.home, title: 'Home'),
          const TabItem(icon: Icons.sick, title: 'Disease'),
          const TabItem(icon: Icons.favorite, title: 'Favorites'),
          TabItem(icon:coun1==0?Icons.fiber_new:icon2, title: ' $coun1 Recently '),
        ],
        initialActiveIndex: _selectedIndex,
        onTap: onItemTapped,
      ),
      body: RoundedContainer(
        roundedChild: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}