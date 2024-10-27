import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_weather_app/core/constant/my_util.dart';
import 'package:simple_weather_app/features/home/home_widgets.dart';
import 'package:simple_weather_app/features/weather_controller.dart';
import 'package:simple_weather_app/core/constant/globals.dart' as global;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final minWidht = 320.0, minHeight = 800.0;
  late WeatherController _weatherController;
  late MyUtil util;
  late HomeWidgets homeWidgets;

  @override
  void initState() {
    super.initState();
    _weatherController = WeatherController.instance;
    util = MyUtil.instance;
    homeWidgets =
        HomeWidgets(classContext: context, classController: _weatherController);
  }

  @override
  Widget build(BuildContext context) {
    final String day = util.weekDay(DateTime.now().weekday);
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
                      builder: (context) =>
                          homeWidgets.modalBottomSheetLocations(),
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
                                  util.withWeatherAnimation(value.condition!)),
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
                                            return homeWidgets.weatherCard(
                                                value.forecast[index]);
                                            // ignore: empty_catches
                                          } catch (e) {}
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
}