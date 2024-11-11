import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_weather_app/presentation/controllers/main_controller.dart';
import 'package:simple_weather_app/utils/constant/my_util.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/utils/constant/globals.dart' as global;
import 'package:simple_weather_app/presentation/controllers/weather_controller.dart';

class HomeWidgets {
  HomeWidgets({required classContext, required wcontroll, required mcontroll})
      : context = classContext,
        _weatherController = wcontroll,
        _mainController = mcontroll;

  final BuildContext context;
  final WeatherController _weatherController;
  final MainController _mainController;
  final MyUtil util = MyUtil.instance;

  Widget modalBottomSheetLocations() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 30,
              child: Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  thickness: 3),
            ),
            global.smallBoxSpace,
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Builder(
                              builder: (context) => IconButton(
                                    icon: Icon(
                                      Iconsax.search_normal,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                    ),
                                    onPressed: () {},
                                  )),
                          Builder(
                              builder: (context) => IconButton(
                                    icon: Icon(
                                      Iconsax.setting,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                    ),
                                    onPressed: () {
                                      context.push('/settings', extra: {
                                        'weather': _weatherController,
                                        'main': _mainController
                                      });
                                    },
                                  )),
                        ],
                      ),
                    ],
                  ),
                  FutureBuilder(
                      future: _weatherController.getWeatherByLocation(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return currentLocationButton(
                              snapshot.data as WeatherEntity);
                        } else {
                          return util.loaderBoxAnimation(context, 20,
                              MediaQuery.of(context).size.width * .5);
                        }
                      }),
                  SizedBox(
                      width: 300,
                      child: Divider(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        thickness: .5,
                      )),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: ListView.builder(
                itemCount: _weatherController.getUserLocations().length,
                itemExtent: 80,
                itemBuilder: (context, index) {
                  final List<String> list =
                      _weatherController.getUserLocations();
                  if (list[index].isNotEmpty) {
                    return FutureBuilder(
                        future:
                            _weatherController.getWeatherByCity(list[index]),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return changeToCityLocationButton(
                                snapshot.data as WeatherEntity);
                          } else {
                            return util.loaderBoxAnimation(context, 20,
                                MediaQuery.of(context).size.width * .5);
                          }
                        });
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget changeToCityLocationButton(WeatherEntity weather) => MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          await _weatherController.changeMainLocationWeather(weather.cityName!);
          // ignore: use_build_context_synchronously
          context.pop();
        },
        splashColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        color: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _weatherController.getUserMainLocation() == weather.cityName
                  ? Iconsax.location5
                  : Iconsax.location,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            Text(
              ' ${weather.cityName!}   ${weather.temp!.toStringAsFixed(0)}°',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  letterSpacing: 3,
                  fontSize: 16),
            ),
            util.withWeatherIcon(weather.condition!),
          ],
        ),
      );

  Widget currentLocationButton(WeatherEntity weather) => MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          await _weatherController.changeMainLocationWeather(weather.cityName!);
          // ignore: use_build_context_synchronously
          context.pop();
        },
        splashColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        color: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.location_add,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                Text(
                  ' Localização atual   ${weather.temp!.toStringAsFixed(0)}° ',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      letterSpacing: 3,
                      fontSize: 16),
                ),
                util.withWeatherIcon(weather.condition!),
              ],
            ),
            Text(
              weather.cityName!,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  letterSpacing: 3,
                  fontSize: 12),
            )
          ],
        ),
      );

  Widget weatherCard(WeatherEntity weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${weather.temp!.toStringAsFixed(0)}° ',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            util.withWeatherIcon(weather.condition!),
          ],
        ),
        Text(
          '${weather.dateTime!.hour.toString()}:00',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
