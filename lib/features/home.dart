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
    var weather = _weatherAPI!.getWeatherByCity(_location);
    return Scaffold(
      appBar: AppBar(
        title: Text(_location),
        titleTextStyle: GoogleFonts.oldStandardTt(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Colors.black,
            fontSize: 24),
        actions: [
          MaterialButton(
            padding: const EdgeInsets.all(8),
            shape: const CircleBorder(
              eccentricity: 0,
            ),
            child: const Icon(Icons.add),
            onPressed: () {},
          ),
          MaterialButton(
            padding: const EdgeInsets.all(8),
            shape: const CircleBorder(
              eccentricity: 0,
            ),
            child: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
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
                                  style: Theme.of(context).textTheme.titleSmall,
                                )
                              ],
                            )),
                        Expanded(flex: 4, child: weatherCard(weather)),
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
