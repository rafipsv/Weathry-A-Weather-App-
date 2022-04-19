// ignore_for_file: avoid_print, unused_import, file_names, missing_return

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apikey = '5850db9eec40eb6c4534c982bded9f4d';

class NetworkHelper {
  double latitude;
  double longitude;
  Future<dynamic> getData() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude;
    longitude = position.longitude;
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikey&units=metric';
    final response = await http.get(
      Uri.parse(url),
    );
    var data = response.body;
    var weatherData = jsonDecode(data);
    return weatherData;
  }

  Future<dynamic> getCityData(String name) async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$name&appid=$apikey&units=metric";
    final response = await http.get(
      Uri.parse(url),
    );
    var data = response.body;
    var weatherData = jsonDecode(data);
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  String getBackgroundImage(int cond) {
    if (cond < 300) {
      String bg = "images/cool_weather.jpg";
      return bg;
    } else if (cond < 400) {
      String bg = "images/cool_weather.jpg";
      return bg;
    } else if (cond < 600) {
      String bg = "images/rainy_weather.jpg";
      return bg;
    } else if (cond < 700) {
      String bg = "images/hot_weather.jpg";
      return bg;
    } else if (cond < 800) {
      String bg = "images/hot_weather.jpg";
      return bg;
    } else if (cond <= 804) {
      String bg = "images/hot_weather.jpg";
      return bg;
    }
  }
}
