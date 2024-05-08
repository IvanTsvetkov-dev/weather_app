import 'dart:convert';
import 'dart:io';

import 'package:flutter_weather/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherRepo {
  static const String url = 'http://api.openweathermap.org/data/2.5/forecast?id=498817&appid=';
  final String apiKey;

  WeatherRepo(this.apiKey);

  Future<Weather> getWeahter() async {
    final response = await http.get(Uri.parse('$url$apiKey'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed');
    }
  }
}
