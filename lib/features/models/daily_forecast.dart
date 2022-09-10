import 'package:weather/features/models/hourly_forecast.dart';

class DailyForecast {
  final DateTime dateTime;
  late int minTemperature;
  late int maxTemperature;
  final List<HourlyForecast> hourlyForecast;

  DailyForecast({
    required this.dateTime,
    required this.minTemperature,
    required this.maxTemperature,
    required this.hourlyForecast
  });
}
