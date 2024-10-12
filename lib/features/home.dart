import 'dart:developer';

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

    _weatherAPI = WeatherApiImp(key: key);
    _weatherAPI!.initAPI();
    _locationApi = LocationApiImp();
    _locationApi.initAPI();
  }

  @override
  Widget build(BuildContext context) {
    final String day = weekDay(DateTime.now().weekday);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder(
            future: _weatherAPI!.getWeatherByCity('Timóteo'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final WeatherEntity weather = snapshot.data as WeatherEntity;
                return Center(
                  child: Column(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            '${weather.cityName}, ${weather.country}\n$day',
                            textAlign: TextAlign.center,
                          )),
                      Expanded(flex: 4, child: weatherCard(weather)),
                    ],
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
    return Text(weather.toString());
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
