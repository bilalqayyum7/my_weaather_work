import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrentForecast extends StatelessWidget {
  final String temprature;
  final IconData icon;
  final String weather;

  const CurrentForecast({
    Key? key,
    required this.temprature,
    required this.icon,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 230,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              temprature,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Icon(
              icon,
              size: 70,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              weather,
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
