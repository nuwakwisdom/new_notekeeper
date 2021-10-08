import 'package:flutter/material.dart';
import 'package:notekeeper/home.dart';
import 'package:notekeeper/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 1),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Center(
          child: Text(
            'MYnotekeeper',
            style: TextStyle(
              decoration: TextDecoration.none,
              fontFamily: 'Pacifico',
              color: Colors.white,
              letterSpacing: 5,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        decoration: BoxDecoration(color: Colors.black),
      ),
    );
  }
}
