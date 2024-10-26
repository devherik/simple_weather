import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/features/weather_controller.dart';
import 'package:simple_weather_app/core/constant/globals.dart' as global;
import 'package:weather/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WeatherController _weatherController;
  final minWidht = 320.0, minHeight = 800.0;

  @override
  void initState() {
    super.initState();
    _weatherController = WeatherController.instance;
  }

  @override
  Widget build(BuildContext context) {
    final String day = weekDay(DateTime.now().weekday);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          leading: Builder(
              builder: (context) => IconButton(
                    icon: const Icon(
                      Iconsax.menu_board,
                      color: global.blue,
                    ),
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => modalBottomSheetLocations(),
                    ),
                  )),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(
                  Iconsax.refresh,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                onPressed: () async => _weatherController.updateWeather(),
              ),
            )
          ],
        ),
        body: FutureBuilder(
            future: _weatherController.initController(),
            builder: (context, snapshot) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: max(screenWidth, minWidht),
                    minWidth: minWidht,
                    minHeight: max(screenHeight, minHeight)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                  child: ValueListenableBuilder(
                    valueListenable: _weatherController.weather$,
                    builder: (context, value, child) {
                      if (value.condition == 0) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        );
                      } else {
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
                                      '${value.temp!.toStringAsFixed(0)}°',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    Text(
                                      '$day - ${value.getHour()}',
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    )
                                  ],
                                )),
                            Expanded(
                              flex: 4,
                              child: Lottie.asset(
                                  withWeatherAnimation(value.condition!)),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    value.cityName!,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  global.verySmallBoxSpace,
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .7,
                                      child: Divider(
                                        thickness: .5,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                      )),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .10,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                        padding: const EdgeInsets.all(8),
                                        itemCount: 9,
                                        itemExtent:
                                            MediaQuery.of(context).size.width *
                                                .20,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          try {
                                            return weatherCard(
                                                value.forecast[index]);
                                          } catch (e) {
                                            print(e.toString());
                                          }
                                          return const SizedBox();
                                        }),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      }
                    },
                  ),
                ),
              );
            }));
  }

  Widget modalBottomSheetLocations() {
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 30,
              child: Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  thickness: 3),
            ),
            global.smallBoxSpace,
            Text(
              'Minhas localizações',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            global.smallBoxSpace,
            // TODO: locations must be storage and instanciated with the app initialization
            FutureBuilder(
                future: _weatherController.getWeatherByCity('Timóteo'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return changeToCityLocationButton(
                        snapshot.data as WeatherEntity);
                  } else {
                    return changeToCityLocationButtonLoading();
                  }
                }),
            global.smallBoxSpace,
            FutureBuilder(
                future:
                    _weatherController.getWeatherByCity('Santana do Paraíso'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return changeToCityLocationButton(
                        snapshot.data as WeatherEntity);
                  } else {
                    return changeToCityLocationButtonLoading();
                  }
                }),
            global.smallBoxSpace,
          ],
        ),
      ),
    );
  }

  Widget changeToCityLocationButton(WeatherEntity weather) => MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async => _weatherController.weather$.value =
            await _weatherController.getWeatherByCity(weather.cityName!),
        splashColor: Theme.of(context).colorScheme.secondary,
        elevation: 2,
        color: Theme.of(context).colorScheme.tertiary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Text(
          '${weather.cityName!} - ${weather.temp!.toStringAsFixed(0)}°',
          style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              letterSpacing: 3,
              fontSize: 16),
        ),
      );

  Widget changeToCityLocationButtonLoading() => MaterialButton(
        // TODO: add an animation
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {},
        splashColor: Theme.of(context).colorScheme.secondary,
        elevation: 2,
        color: Theme.of(context).colorScheme.tertiary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Text(
          '',
          style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              letterSpacing: 3,
              fontSize: 16),
        ),
      );

  Widget weatherCard(WeatherEntity weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        withWeatherIcon(weather.condition!),
        Text(
          '${weather.temp!.toStringAsFixed(0)}°',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Text(
          '${weather.dateTime!.hour.toString()}hr',
          style: Theme.of(context).textTheme.labelMedium,
        ),
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

  Icon withWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return const Icon(Iconsax.cloud_lightning, color: global.blue);
      case >= 300 && < 400:
        return const Icon(Iconsax.cloud_minus, color: global.blue);
      case >= 500 && < 600:
        return const Icon(Iconsax.cloud_minus, color: global.blue);
      case >= 600 && < 700:
        return const Icon(Iconsax.cloud_snow, color: Colors.lightBlue);
      case 701:
        return const Icon(Iconsax.cloud_fog, color: Colors.grey);
      case 800:
        return Icon(Iconsax.sun_1, color: Colors.yellow.shade200);
      case >= 800 && < 900:
        return const Icon(Iconsax.cloud_fog, color: Colors.pinkAccent);
      default:
        return Icon(Iconsax.cloud_sunny, color: Colors.yellow.shade200);
    }
  }

  String weekDay(int day) {
    switch (day) {
      case 1:
        return 'Segunda';
      case 2:
        return 'Terça';
      case 3:
        return 'Quarta';
      case 4:
        return 'Quinta';
      case 5:
        return 'Sexta';
      case 6:
        return 'Sábado';
      case 7:
        return 'Domingo';
      default:
        return 'não sei';
    }
  }
}
