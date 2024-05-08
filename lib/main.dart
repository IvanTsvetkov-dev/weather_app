import 'package:flutter/material.dart';
import 'package:flutter_weather/repository.dart';
import 'package:flutter_weather/weather_model.dart';

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
  String? city;


  featchInfo() async {
    final cityy = await weatherRep.getCity();
    setState(() {
      city = cityy;
    });


    final weather = await weatherRep.getWeahter();
    setState(() {
      weatherr = weather;
    });
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
        children: [Text(weatherr!.title)],
      ),
    ));
  }
}
