import 'package:flutter/material.dart';
import 'package:weather/features/forecast/widgets/hourly_forecast_tile.dart';
import 'package:weather/models/hourly_forecast.dart';

class DailyForecastList extends StatelessWidget {
  const DailyForecastList({Key? key, required this.forecastList}) : super(key: key);
  final List<HourlyForecast> forecastList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: ListView.builder(itemBuilder: (context, index) {
          final HourlyForecast hourlyForecast = forecastList[index];
          return Center(child: HourlyForecastGridItem(forecast: hourlyForecast));
        },
          scrollDirection: Axis.horizontal,
          itemCount: forecastList.length,
        ),
      )
    );
  }
}