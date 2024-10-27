import 'package:flutter/material.dart';
import 'package:simple_weather_app/core/constant/my_util.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/core/constant/globals.dart' as global;
import 'package:simple_weather_app/features/weather_controller.dart';

class HomeWidgets {
  HomeWidgets({required classContext, required classController})
      : context = classContext,
        _weatherController = classController;

  final BuildContext context;
  final WeatherController _weatherController;
  final MyUtil util = MyUtil.instance;

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
        util.withWeatherIcon(weather.condition!),
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
}
