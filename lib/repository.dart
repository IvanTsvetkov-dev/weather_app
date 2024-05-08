import 'dart:convert';

import 'package:flutter_weather/weather_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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


  Future<String> getCity() async{
    LocationPermission permission = await Geolocator.checkPermission(); //проверили права
    if (permission == LocationPermission.denied){ //если в правах отказано, тогда отправить запрос на получение прав.
      permission = await Geolocator.requestPermission();
    }
    //получили права
    Position geo =  await Geolocator.getCurrentPosition();
    //получаем название геолокации
    List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
    return placemarks[0].locality.toString(); //получаем название

  }
}
