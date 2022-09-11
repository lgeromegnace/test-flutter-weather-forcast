import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/features/forecast/widgets/daily_forecast_list.dart';
import 'package:weather/features/models/daily_forecast.dart';
import 'package:weather/features/models/hourly_forecast.dart';
import 'package:weather/features/models/session.dart';
import 'package:weather/services/forecast_service.dart';

class ForeCastScreen extends StatefulWidget {
  const ForeCastScreen({Key? key}) : super(key: key);

  @override
  State<ForeCastScreen> createState() => _ForeCastScreenState();
}

class _ForeCastScreenState extends State<ForeCastScreen> {
  final ForecastService service = ForecastService();

  Future<List<HourlyForecast>>? futureForecastList;
  Future<List<DailyForecast>>? futureDailyForecastList;

  @override
  void initState() {
    super.initState();
    futureForecastList = ForecastService.fetchHourlyForecast();
    futureDailyForecastList = ForecastService.fetchDailyForecast();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Session>(
      builder:(context, session, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Bienvenue ${session.user?.name}'),
          ),
          body: FutureBuilder(
              future: futureDailyForecastList,
              builder: (BuildContext context, AsyncSnapshot<List<DailyForecast>> snapshot) {
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
                      return Text('Error${snapshot.error}');
                    }
                    List<DailyForecast> forecastList = snapshot.data!;
                    return CustomScrollView(
                      slivers: dailyForecastSliverList(forecastList),
                    );
                }
              }
          ),
        );
      },
    );
  }
}

List<Widget> dailyForecastSliverList(List<DailyForecast> dailyForecastList) {
  List<Widget> sliverList = <Widget>[];
  final dateFormat = DateFormat('E d MMM', 'fr_FR');
  for(DailyForecast dailyForecast in dailyForecastList) {
    sliverList.add(
        SliverAppBar(
          title: Row(
            children: [
              Text(dateFormat.format(dailyForecast.dateTime).toString()),
              const Spacer(),
              Text('${dailyForecast.minTemperature}° - ${dailyForecast.maxTemperature}°')
            ],
          ),
          pinned: true,
          backgroundColor: Colors.black,
        )
    );
    sliverList.add(DailyForecastList(forecastList: dailyForecast.hourlyForecast));
  }

  return sliverList;
}