import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var login = 0;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            () {
      if(login == 0) {
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                LoginScreen()
              )
          );
         }
      else{
        MaterialPageRoute(builder:
            (context) =>
            MyHomePage()
        );
      }
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
        color: Colors.white,
        child:FlutterLogo(size:MediaQuery.of(context).size.height)
    );
  }
}
