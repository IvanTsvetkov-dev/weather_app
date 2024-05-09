import 'package:flutter/material.dart';
import 'package:flutter_weather/repo/repository.dart';
import 'package:flutter_weather/theme/config.dart';
import 'package:flutter_weather/theme/custom_theme.dart';
import 'package:flutter_weather/models/weather_model.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State createState() => _MyAppState();
}

class _MyAppState extends State {
  @override
  
  void initState() {
     currentTheme.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
      home: WeatherPage(),
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
  Icon iconTheme = const Icon(Icons.brightness_2_rounded);
  Weather? weatherr;

  featchInfo() async {
    //final String city= await weatherRep.getCity();
    // setState(() {
    // });
    // try {
    //   final weather = await weatherRep
    //       .getWeahter("Ярославль"); //latitude - широта, longitude - долгота
    //   setState(() {
    //     weatherr = weather;
    //     print(weather.city);
    //   });
    // } catch (e) {
    //   print(e);
    // }
  }
  @override
  void initState() {
    super.initState();
    featchInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {
              currentTheme.toggleTheme();
            }, icon: iconTheme)
          ],
        ),
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

  String weatherAnim(String? condition) {
    if (condition == null) {
      return "assets/load.json";
    }
    switch (condition.toLowerCase()) {
      case 'snow':
        return "assets/snow.json";
      case 'sunny':
        return "assets/sunny.json";
      case 'clear':
        return "assets/clear.json";
      case 'thunderstorm': //гроза
        return "assets/clear.json";
      case 'drizzle': //моросит дождь
        return "assets/drizzle.json";
      case 'rain':
        return "assets/rain.json";
      case 'mist':
        return "assets/mist.json";
      case 'clouds':
        return "assets/clouds.json";
      default:
        return "assets/load.json";
    }
  }
}
