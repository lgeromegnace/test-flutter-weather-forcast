import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/hourly_forecast.dart';

class ForecastTile extends StatelessWidget {
  const ForecastTile({Key? key, required this.forecast}) : super(key: key);
  final HourlyForecast forecast;
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('HH:mm', 'fr_FR');
    return ListTile(
      leading: Image.network('http://openweathermap.org/img/wn/${forecast.icon}@2x.png'),
      title: Text(dateFormat.format(forecast.dateTime).toString()),
      subtitle: Text(forecast.weatherDescription),
      trailing: Text('${forecast.temperature}°C'),
    );
  }
}