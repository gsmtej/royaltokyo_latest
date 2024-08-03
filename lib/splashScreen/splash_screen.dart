import 'dart:async';

import 'package:buyer_app/authentication/auth_screen.dart';
import 'package:buyer_app/authentication/login.dart';
import 'package:buyer_app/global/AppImages.dart';
import 'package:buyer_app/global/AppStrings.dart';
import 'package:buyer_app/global/global.dart';
import 'package:buyer_app/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../providers/DashboardProvider.dart';





class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {


  startTimer() {
     Timer(const Duration(seconds: 5), () async
    {
      //if seller is loggedin already
      // if(firebaseAuth.currentUser != null)
      // {
      //   Navigator.push(context, MaterialPageRoute(builder: (c)=>  AuthScreen()));
        Navigator.push(context, MaterialPageRoute(builder: (c)=>  HomeScreen()));


      // }
      //if user is NOT loggedin already
      // else
      // {
      //   Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
      // }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }



  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.orange,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Image.asset(AppImages.ic_splashscreen),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(
                "${AppString.user_app} - ${AppString.restaurunt_hub}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontFamily: "Poppins",
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
