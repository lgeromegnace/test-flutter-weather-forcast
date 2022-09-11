import 'package:flutter/material.dart';
import 'package:weather/features/forecast/widgets/hourly_forecast_tile.dart';
import 'package:weather/models/hourly_forecast.dart';

class DailyForecastList extends StatelessWidget {
  const DailyForecastList({Key? key, required this.forecastList}) : super(key: key);
  final List<HourlyForecast> forecastList;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            childCount: forecastList.length,
                (context, index) {
              final HourlyForecast hourlyForecast = forecastList[index];
              return ForecastTile(forecast: hourlyForecast);
            }
        )
    );
  }
}