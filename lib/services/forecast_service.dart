
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather/features/models/daily_forecast.dart';
import 'package:weather/features/models/hourly_forecast.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return day == other.day && month == other.month
        && year == other.year;
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
  static const String apiKey = 'b677c9ebb7c448fe76654f3627a5ed34';
  static const String baseURL = 'api.openweathermap.org/data/2.5/forecast';
  static const Coordinates parisCoordinates = Coordinates(
      latitude: 48.866667,
      longitude: 2.333333
  );

  static Future<List<HourlyForecast>> fetchHourlyForecast() async {
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

  static Future<List<DailyForecast>> fetchDailyForecast() async {
    List<HourlyForecast> hourlyForecastList = await fetchHourlyForecast();
    return hourlyForecastList.fold(<DailyForecast>[], (previousValue, hourlyForecast) async {
      List<DailyForecast> dailyForecastList = await previousValue;
      Iterable<DailyForecast> filteredDailyForecast = dailyForecastList
          .where((dailyForecast) => dailyForecast.dateTime.isSameDate(hourlyForecast.dateTime));
      if (filteredDailyForecast.isEmpty) {
        DailyForecast dailyForecast = DailyForecast(
            dateTime: hourlyForecast.dateTime,
            minTemperature: hourlyForecast.temperature,
            maxTemperature: hourlyForecast.temperature,
            hourlyForecast: [hourlyForecast]
        );
        dailyForecastList.add(dailyForecast);
      } else {
        DailyForecast dailyForecast = filteredDailyForecast.first;
        dailyForecast.minTemperature = min(dailyForecast.minTemperature, hourlyForecast.temperature);
        dailyForecast.maxTemperature = max(dailyForecast.maxTemperature, hourlyForecast.temperature);
        dailyForecast.hourlyForecast.add(hourlyForecast);
      }
      print(dailyForecastList);
      return dailyForecastList;
    });
  }
}
