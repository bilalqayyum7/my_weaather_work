import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/utalites/add_info.dart';
import 'package:my_weather_app/utalites/current_forecast.dart';
import 'package:http/http.dart' as http;
import 'package:my_weather_app/utalites/hourly_forecast.dart';
import 'package:my_weather_app/utalites/weather_api.dart';

class MyHomeSecreen extends StatefulWidget {
  const MyHomeSecreen({Key? key}) : super(key: key);

  @override
  State<MyHomeSecreen> createState() => _MyHomeSecreenState();
}

class _MyHomeSecreenState extends State<MyHomeSecreen> {
  double temp = 0;
  @override
  void initState() {
    super.initState();
    getCurrentForecast();
  }

  Future<Map<String, dynamic>> getCurrentForecast() async {
    try {
      const String cityName = "London";
      final res = await http.get(
        Uri.parse(
            'http://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$weatherApiKey'),
      );
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'Some Unexpected error';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("WEATHER APP"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(Icons.refresh_outlined)),
            const SizedBox(
              width: 30,
            ),
          ],
        ),
        body: FutureBuilder(
          future: getCurrentForecast(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            // some code
            final data = snapshot.data!;
            final currentTemp = (data['list'][0]['main']['temp']);
            final currentSky = (data['list'][0]['weather'][0]['main']);
            final currenPressure = (data['list'][0]['main']['pressure']);
            final currentSpeed = (data['list'][0]['wind']['speed']);
            final currentHumidity = (data['list'][0]['main']['humidity']);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CurrentForecast(
                      icon: (currentSky == "Clouds" || currentSky == "Rain"
                          ? Icons.cloud_sharp
                          : Icons.sunny),
                      weather: currentSky,
                      temprature: "$currentTemp K ",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Weather Forecast',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: [
                        for (int i = 0; i < 39; i++)
                          HourlyForecast(
                            icon: data['list'][i + 1]['weather'][0]['main'] ==
                                        'Cloud' ||
                                    data['list'][i + 1]['weather'][0]['main'] ==
                                        'Rain'
                                ? Icons.cloud_sharp
                                : Icons.sunny,
                            temprature:
                                data['list'][i + 1]['main']['temp'].toString(),
                            time: data['list'][i + 1]['dt_txt'].toString(),
                          ),
                        const SizedBox(
                          width: 10,
                        ),
                      ]),
                    ),
                    const Text(
                      'Additional Information',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                AddInfo(
                                    icon: Icons.water_drop,
                                    condition: 'Humidity',
                                    value: currentHumidity.toString()),
                                AddInfo(
                                    icon: Icons.air_outlined,
                                    condition: 'Wind Speed',
                                    value: currentSpeed.toString()),
                                AddInfo(
                                    icon: Icons.beach_access,
                                    condition: 'Pressure',
                                    value: currenPressure.toString()),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
