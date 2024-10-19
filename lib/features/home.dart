import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_weather_app/data/data_sources/remote/location_api_imp.dart';
import 'package:simple_weather_app/data/data_sources/remote/weather_api_imp.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/infra/port/input/location_api.dart';
import 'package:simple_weather_app/infra/port/input/weather_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String key = '41bdaa6c0895ca108bf29a888bdf885e';
  late WeatherApi? _weatherAPI;
  late LocationApi _locationApi;
  late String _location;
  final minWidht = 320.0, minHeight = 800.0;

  @override
  void initState() {
    super.initState();

    _weatherAPI = WeatherApiImp.instance;
    _weatherAPI!.initAPI(key);
    _locationApi = LocationApiImp();
    _locationApi.initAPI();
    _location = 'Timóteo';
  }

  @override
  Widget build(BuildContext context) {
    final String day = weekDay(DateTime.now().weekday);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    var weather = _weatherAPI!.getWeatherByCity(_location);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: max(screenWidth, minWidht),
              minWidth: minWidht,
              minHeight: max(screenHeight, minHeight)),
          child: FutureBuilder(
            future: weather,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                WeatherEntity weather = snapshot.data as WeatherEntity;
                return SafeArea(
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        weather = _weatherAPI!.getForecastByCity(_location),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${weather.temp!.toStringAsFixed(0)}°',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  day,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )
                              ],
                            )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              weather.cityName!,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .2,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(4),
                                itemCount: 4,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    weatherCard(weather.forecast[index]),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget weatherCard(WeatherEntity weather) {
    return Column(
      children: [
        const Icon(Icons.sunny),
        Text('${weather.temp!.toStringAsFixed(0)}°')
      ],
    );
  }

  String weekDay(int day) {
    switch (day) {
      case 1:
        return 'SEGUNDA';
      case 2:
        return 'TERÇA';
      case 3:
        return 'QUARTA';
      case 4:
        return 'QUINTA';
      case 5:
        return 'SEXTA';
      case 6:
        return 'SÁBADO';
      case 7:
        return 'DOMINGO';
      default:
        return 'não sei';
    }
  }
}
