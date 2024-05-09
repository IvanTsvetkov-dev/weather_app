class Weather {
  final String city;
  final double temp;
  final String weather;

  const Weather({
    required this.city,
    required this.temp,
    required this.weather
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return 
        Weather(
          city: json["name"],
          temp: json["main"]["temp"],
          weather: json["weather"][0]["main"]
        );
  }
}