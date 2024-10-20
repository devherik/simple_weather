import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/features/controller.dart';
import 'package:simple_weather_app/core/constant/globals.dart' as global;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Controller _controller;
  final minWidht = 320.0, minHeight = 800.0;

  @override
  void initState() {
    super.initState();
    _controller = Controller.instance;
  }

  @override
  Widget build(BuildContext context) {
    final String day = weekDay(DateTime.now().weekday);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: FutureBuilder(
            future: _controller.initController(),
            builder: (context, snapshot) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: max(screenWidth, minWidht),
                      minWidth: minWidht,
                      minHeight: max(screenHeight, minHeight)),
                  child: FutureBuilder(
                    future: _controller.getWeatherByLocation(),
                    builder: (context, weatherSnapshot) {
                      if (weatherSnapshot.hasData) {
                        WeatherEntity weather =
                            weatherSnapshot.data as WeatherEntity;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    Text(
                                      day,
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    )
                                  ],
                                )),
                            Expanded(
                              flex: 4,
                              child: Lottie.asset(
                                  withWeatherAnimation(weather.condition!)),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    weather.cityName!,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  global.verySmallBoxSpace,
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * .2,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.all(8),
                                      itemCount: 5,
                                      itemExtent:
                                          MediaQuery.of(context).size.width *
                                              .17,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          weatherCard(weather.forecast[index]),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              );
            }));
  }

  Widget weatherCard(WeatherEntity weather) {
    return Column(
      children: [
        const Icon(Iconsax.cloud_sunny),
        Text('${weather.temp!.toStringAsFixed(0)}°')
      ],
    );
  }

  String withWeatherAnimation(int code) {
    switch (code) {
      case >= 200 && < 300:
        return 'assets/animations/thunder.json';
      case >= 300 && < 400:
        return 'assets/animations/partly_rain.json';
      case >= 500 && < 600:
        return 'assets/animations/storm.json';
      case >= 600 && < 700:
        return 'assets/animations/snow.json';
      case 701:
        return 'assets/animations/mist.json';
      case 800:
        return 'assets/animations/clear.json';
      case >= 800 && < 900:
        return 'assets/animations/mist.json';
      default:
        return 'assets/animations/clear.json';
    }
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
