import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_weather_app/presentation/controllers/main_controller.dart';
import 'package:simple_weather_app/utils/constant/my_util.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/utils/constant/globals.dart' as global;
import 'package:simple_weather_app/presentation/controllers/weather_controller.dart';

class HomeWidgets {
  HomeWidgets({required classContext, required classController})
      : context = classContext,
        _weatherController = classController;

  final BuildContext context;
  final WeatherController _weatherController;
  final MyUtil util = MyUtil.instance;

  final MainController mainController = MainController.instance;

  Widget modalBottomSheetLocations() {
    return Container(
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
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                          builder: (context) => IconButton(
                                icon: Icon(
                                  Iconsax.moon,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                                onPressed: () {
                                  mainController.changeTheme();
                                },
                              )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
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
                                      context.go('/settings');
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
            global.verySmallBoxSpace,
            Expanded(
              flex: 3,
              child: ListView.builder(
                itemCount: _weatherController.getUserAddresses().length,
                itemExtent: 80,
                itemBuilder: (context, index) {
                  final List<String> list =
                      _weatherController.getUserAddresses();
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
          await _weatherController.changeAddressWeather(weather.cityName!);
        },
        splashColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        color: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              //TODO: icons state aren't working
              _weatherController.getUserAddress() == weather.cityName
                  ? Iconsax.location5
                  : Iconsax.location,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            Text(
              ' ${weather.cityName!}   ${weather.temp!.toStringAsFixed(0)}° ',
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
          await _weatherController.changeAddressWeather(weather.cityName!);
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
      mainAxisAlignment: MainAxisAlignment.center,
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
