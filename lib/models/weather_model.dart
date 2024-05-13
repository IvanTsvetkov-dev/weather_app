class Weather {
  final String city;
  final double temp;
  final String weather;
  final dynamic windSpeed;
  final dynamic windDirect;

  const Weather({
    required this.city,
    required this.temp,
    required this.weather,
    required this.windSpeed,
    required this.windDirect
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return 
        Weather(
          city: json["name"],
          temp: json["main"]["temp"],
          weather: json["weather"][0]["main"],
          windSpeed: json["wind"]["speed"],
          windDirect: json["wind"]["deg"]
        );
  }
}