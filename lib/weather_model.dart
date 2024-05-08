class Weather {
  final int city;
  final int temp;
  final String title;

  const Weather({
    required this.city,
    required this.temp,
    required this.title,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return 
        Weather(
          city: json["city"]["id"],
          temp: json["city"]["id"],
          title: json["city"]["name"],
        );
  }
}