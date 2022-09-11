import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/hourly_forecast.dart';

class HourlyForecastGridItem extends StatelessWidget {
  HourlyForecastGridItem({Key? key, required this.forecast}) : super(key: key);
  final HourlyForecast forecast;
  final _dateFormat = DateFormat('H', 'fr_FR');
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 150,
          width: 100,
          child: Column(
            children: [
              Text(_dateFormat.format(forecast.dateTime),
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 80,
                width: 80,
                child: Stack(
                  children: [
                    DecoratedBox(
                      position: DecorationPosition.foreground,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            Colors.grey[800]!,
                            Colors.transparent,
                          ]
                        )
                      ),
                      child: Image.network(
                          'http://openweathermap.org/img/wn/${forecast.icon}@2x.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Center(
                        child: Text('${forecast.temperature}°',
                          style: Theme.of(context).textTheme.headline4,
                        )
                    ),
                  ],
                ),
              ),
              Text(forecast.weatherDescription,
              style: Theme.of(context).textTheme.subtitle1,),
            ],
          ),
        ),
      ),
    );
  }
}
