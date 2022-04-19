// ignore_for_file: file_names, unused_import, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, deprecated_member_use, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:weather_app/Helpers/constrains.dart';
import 'package:weather_app/Helpers/networkHelper.dart';
import 'package:weather_app/screens/cityscreen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.weatherData);
  final weatherData;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  NetworkHelper networkHelper = NetworkHelper();
  String backgroundImage;
  int temperature;
  String icontext;
  String cityName;
  String messegeText;
  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
  }

  void updateUI(dynamic data) {
    setState(
      () {
        if (data != null) {
          var condition = data['weather'][0]['id'];
          double temp = data['main']['temp'];
          temperature = temp.toInt();
          cityName = data['name'];
          icontext = networkHelper.getWeatherIcon(condition);
          messegeText = networkHelper.getMessage(temperature);
          backgroundImage = networkHelper.getBackgroundImage(condition);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "$backgroundImage",
              ),
              fit: BoxFit.cover,
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton(
                        onPressed: () async {
                          var wData = await networkHelper.getData();
                          updateUI(wData);
                        },
                        child: Icon(
                          Icons.near_me,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      FlatButton(
                        onPressed: () async {
                          var cityData = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CityScreen();
                              },
                            ),
                          );
                          if (cityData != null) {
                            updateUI(cityData);
                          }
                        },
                        child: Icon(
                          Icons.location_city,
                          color: Colors.white,
                          size: 50.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "$temperature°",
                        style: kTempTextStyle,
                      ),
                      Text(
                        "$icontext",
                        style: kIconTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    0.0,
                    0.0,
                    20,
                    20,
                  ),
                  child: Text(
                    "$messegeText in your $cityName",
                    textAlign: TextAlign.right,
                    style: kMessegeTextStyle,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
