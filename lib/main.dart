import 'package:flutter/material.dart';
import 'package:flutter_weather/repo/repository.dart';
import 'package:flutter_weather/theme/config.dart';
import 'package:flutter_weather/theme/custom_theme.dart';
import 'package:flutter_weather/models/weather_model.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    getPersonPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
      home: const WeatherPage(),
    );
  }

  Future<void> getPersonPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool("theme") ?? false;
    setState(() {
      currentTheme.theme = isDark;
    });
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final weatherRep = WeatherRepo("aefa4af1f91b5563898989f6c95f6696");
  SnackBar snackBar =
      const SnackBar(content: Text("Saved your theme preferences!"));
  Icon iconTheme = const Icon(Icons.brightness_2_rounded);
  Weather? weatherr;

  featchInfo() async {
    //final String city= await weatherRep.getCity();
    // setState(() {
    // });
    try {
      final weather = await weatherRep.getWeahter("Ярославль");
      setState(() {
        weatherr = weather;
      });
    } catch (e) {
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
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  currentTheme.toggleTheme();
                  if (ScaffoldMessenger.of(context).mounted) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  }
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  changeTheme(currentTheme.getIsDarkTheme);
                },
                icon: iconTheme)
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                weatherr?.city ?? "load..",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Lottie.asset(weatherAnim(weatherr?.weather.toString())),
              Text('${weatherr?.temp.round() ?? ''}°C', style: Theme.of(context).textTheme.bodyMedium),
              Text('${weatherr?.windSpeed.round() ?? ''} m/s, ${determineWindDirection(weatherr?.windDirect)}'),
            ],
          ),
        ));
  }

  Future<void> changeTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("theme", isDark);
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
      case 'thunderstorm':
        return "assets/clear.json";
      case 'drizzle':
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

  String determineWindDirection(var deg) {
    if(deg == null){
      return '';
    }
    if (deg >= 0 && deg < 22.5) {
      return 'Nord';
    }
    if (deg >= 22.5 && deg < 45) {
      return 'NNE';
    }
    if (deg >= 45 && deg < 67.5) {
      return 'NE';
    }
    if (deg >= 67.5 && deg < 90) {
      return 'ENE';
    }
    if (deg >= 90 && deg < 112.5) {
      return 'Est';
    }
    if (deg >= 112.5 && deg < 135) {
      return 'ESE';
    }
    if (deg >= 135 && deg < 157.5) {
      return 'SE';
    }
    if (deg >= 157.5 && deg < 180) {
      return 'SSE';
    }
    if (deg >= 180 && deg < 202.5) {
      return 'Sid';
    }
    if (deg >= 202.5 && deg < 225) {
      return 'SSW';
    }
    if (deg >= 225 && deg < 247.5) {
      return 'SW';
    }
    if (deg >= 247.5 && deg < 270) {
      return 'WSW';
    }
    if (deg >= 270 && deg < 292.5) {
      return 'W';
    }
    if (deg >= 292.5 && deg < 315) {
      return 'WNW';
    }
    if (deg >= 315 && deg < 337.5) {
      return 'NW';
    }
    if (deg >= 337.5 && deg <= 360) {
      return 'NNW';
    }
    return '';
  }
}
