import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/home_secreen.dart';

class MySplashSecreen extends StatefulWidget {
  const MySplashSecreen({Key? key}) : super(key: key);

  @override
  State<MySplashSecreen> createState() => _MySplashSecreenState();
}

class _MySplashSecreenState extends State<MySplashSecreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), (){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MyHomeSecreen()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset("assets/splash.jpg"),
    );
  }
}

