import 'package:flutter/material.dart';
import 'package:flutter_weather/repository.dart';
import 'package:flutter_weather/weather_model.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final weatherRep = WeatherRepo("aefa4af1f91b5563898989f6c95f6696");
  Weather? weatherr;

  featchInfo() async {
    //final String city= await weatherRep.getCity();
    // setState(() {
    // });
    try {
      final weather = await weatherRep
          .getWeahter("Ярославль"); //latitude - широта, longitude - долгота
      setState(() {
        weatherr = weather;
        print(weather.city);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    featchInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weatherr?.city ?? "load..",
          ),
          Lottie.asset(weatherAnim(weatherr?.weather.toString())),
          Text('${weatherr?.temp.round()}°C')
        ],
      ),
    ));
  }
  String weatherAnim(String? condition){
    if(condition== null){
      return "assets/load.json";
    }
    switch(condition.toLowerCase()){
      case 'snow':
        return "assets/snow.json";
      case 'sunny':
        return "assets/sunny.json";
      case 'clear':
        return "assets/clear.json";
      default:
        return "assets/load.json";
    }
  }
}
