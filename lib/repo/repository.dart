import 'dart:convert';
import 'package:flutter_weather/models/weather_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherRepo {
  static const String url = 'https://api.openweathermap.org/data/2.5/weather?';
  final String apiKey;

  WeatherRepo(this.apiKey);

  Future<Weather> getWeahter(String city) async {
    final response = await http.get(Uri.parse('${url}q=$city&units=metric&appid=$apiKey'));
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
    Position geo =  await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(geo.latitude, geo.longitude);
    return placemarks[0].locality ?? "";
  }
}
