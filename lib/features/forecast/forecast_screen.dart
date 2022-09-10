import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/features/models/hourly_forecast.dart';
import 'package:weather/services/forecast_service.dart';

class ForeCastScreen extends StatefulWidget {
  const ForeCastScreen({Key? key}) : super(key: key);

  @override
  State<ForeCastScreen> createState() => _ForeCastScreenState();
}

class _ForeCastScreenState extends State<ForeCastScreen> {
  final ForecastService service = ForecastService();

  Future<List<HourlyForecast>>? futureForecastList;

  @override
  void initState() {
    super.initState();
    futureForecastList = service.fetch();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenue XXX'),
      ),
      body: FutureBuilder(
        future: futureForecastList,
        builder: (BuildContext context, AsyncSnapshot<List<HourlyForecast>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
            if (snapshot.hasError) {
              print('Error${snapshot.error}');
              return Text('Error${snapshot.error}');
            }
            List<HourlyForecast> forecastList = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: forecastList.length,
                itemBuilder: (context, index) {
                  HourlyForecast forecast = forecastList[index];
                  final dateFormat = DateFormat('E d MMM HH:mm', 'fr_FR');
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.network('http://openweathermap.org/img/wn/${forecast.icon}@2x.png'),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  dateFormat.format(forecast.dateTime).toString(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 2),
                              Text('temperature : ${forecast.temperature}°C'),
                              const SizedBox(height: 2),
                              Text(forecast.weatherDescription)
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
            );
          }
        }
      ),
    );
  }
}