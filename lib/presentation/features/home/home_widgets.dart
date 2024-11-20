import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_weather_app/utils/constant/my_util.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/utils/constant/globals.dart' as global;
import 'package:simple_weather_app/presentation/controllers/weather_controller.dart';

class HomeWidgets {
  HomeWidgets({required parentContext, required wcontroll})
      : context = parentContext,
        _weatherController = wcontroll;

  final BuildContext context;
  final WeatherController _weatherController;
  final MyUtil util = MyUtil.instance;

  Widget modalBottomSheetLocations() {
    return Expanded(
      flex: 3,
      child: ListView.builder(
        itemCount: _weatherController.getUserLocations().length,
        itemExtent: 80,
        itemBuilder: (context, index) {
          final List<String> list = _weatherController.getUserLocations();
          if (list[index].isNotEmpty) {
            return FutureBuilder(
                future: _weatherController.getWeatherByCity(list[index]),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return openLocationWeatherDetails(
                        snapshot.data as WeatherEntity);
                  } else {
                    return util.loaderBoxAnimation(
                        context, 20, MediaQuery.of(context).size.width * .5);
                  }
                });
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget openLocationWeatherDetails(WeatherEntity weather) => MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          // open a page with details of this location
        },
        splashColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        color: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.location,
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
