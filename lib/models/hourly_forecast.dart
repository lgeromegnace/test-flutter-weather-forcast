class HourlyForecast {
  final DateTime dateTime;
  final int temperature;
  final String weatherDescription;
  final String icon;

  const HourlyForecast({
    required this.dateTime,
    required this.temperature,
    required this.weatherDescription,
    required this.icon
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> mainJson = json['main'];
    List<dynamic> weatherJson = json['weather'];
    return HourlyForecast(
        dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
        temperature: mainJson['temp'].round(),
        weatherDescription: weatherJson.first['description'],
        icon: weatherJson.first['icon']
    );
  }
}