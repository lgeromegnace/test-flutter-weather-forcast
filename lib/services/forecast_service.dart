
import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather/features/models/hourly_forecast.dart';

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

  Future<List<HourlyForecast>> fetch() async {

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
      return forecastListJson.map((forecastJson) => HourlyForecast.fromJson(forecastJson)).toList();
    }
    print('error: ${response.reasonPhrase}');
    return [];
  }
}
