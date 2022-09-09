
import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/date_symbol_data_local.dart';

class Forecast {
  final DateTime dateTime;
  final int temperature;
  final int maxTemperature;
  final int minTemperature;
  final String weatherDescription;
  final String icon;

  const Forecast({
    required this.dateTime,
    required this.temperature,
    required this.maxTemperature,
    required this.minTemperature,
    required this.weatherDescription,
    required this.icon
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> mainJson = json['main'];
    List<dynamic> weatherJson = json['weather'];
    return Forecast(
        dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
        temperature: mainJson['temp'].round(),
        maxTemperature: mainJson['temp_max'].round(),
        minTemperature: mainJson['temp_min'].round(),
        weatherDescription: weatherJson.first['description'],
        icon: weatherJson.first['icon']
    );
  }
}

class Coordinates {
  final double latitude;
  final double longitude;

  const Coordinates({
    required this.latitude,
    required this.longitude
});
}

class ForecastService {
  final String apiKey = 'b677c9ebb7c448fe76654f3627a5ed34';
  final String baseURL = 'api.openweathermap.org/data/2.5/forecast';
  final Coordinates parisCoordinates = const Coordinates(
      latitude: 48.866667,
      longitude: 2.333333
  );

  Future<List<Forecast>> fetch() async {

    await initializeDateFormatting('fr_FR', null);
    double latitude = parisCoordinates.latitude;
    double longitude = parisCoordinates.longitude;
    String url = 'https://$baseURL?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&lang=fr';
    print(url);
    Uri uri = Uri.parse(url);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      Iterable forecastListJson = json['list'];
      return forecastListJson.map((forecastJson) => Forecast.fromJson(forecastJson)).toList();
    }
    print('error: ${response.reasonPhrase}');
    return [];
  }
}
