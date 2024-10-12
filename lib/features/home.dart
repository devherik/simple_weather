import 'package:flutter/material.dart';
import 'package:simple_weather_app/data/data_sources/remote/weather_api_imp.dart';
import 'package:simple_weather_app/infra/port/input/weather_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String key = '41bdaa6c0895ca108bf29a888bdf885e';
  late WeatherApi? _weatherAPI;

  @override
  void initState() {
    super.initState();
    _weatherAPI = WeatherApiImp(key: key);
    _weatherAPI!.initAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: FutureBuilder(
            future: _weatherAPI!.getWeatherByCity('Timóteo'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Text(snapshot.data.toString()),
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
}
